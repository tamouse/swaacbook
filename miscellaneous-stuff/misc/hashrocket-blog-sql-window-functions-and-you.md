
# Table of Contents

1.  [Hashrocket Blog - SQL Window Functions and You](#hashrocket-blog---sql-window-functions-and-you)


<a id="hashrocket-blog---sql-window-functions-and-you"></a>

# Hashrocket Blog - SQL Window Functions and You

-   published date: 2013-11-11 06:13
-   keywords: ["activerecord", "rails", "sql", "swaac"]
-   source: <http://hashrocket.com/blog/posts/sql-window-functions>

> -   SQL Window Functions and You
>     
>     :CUSTOM<sub>ID</sub>: sql-window-functions-and-you
> 
> posted on May 22, 2012 and written by [Joshua Davey](http://hashrocket.com/blog/rocketeers/josh-davey) in [PostgreSQL](http://hashrocket.com/blog/categories/postgresql) and [Ruby](http://hashrocket.com/blog/categories/ruby)
> 
> Suppose you have a storefront application that sells pictures of cats. These cat pictures are categorized in meaningful ways. For example, there are LOLcats pictures and "Classic" cat pictures. Now, on the landing page of the store, you'd like to feature one picture from each category. It can't be a random picture from each. You need to feature the cheapest picture from each category, displaying its name and price.
> 
> Also, it turns out that some "low" prices are very common. For example, $9.99 is a common sale price for LOLcats pictures. However, we should only ever feature one picture per category. When there are multiple pictures with the same low price, we fallback to the name, and show the first one alphabetically. How can we solve this problem, while also remaining performant?
> 
> As an aside, adding a cat to a Rennaisance painting amplifies its appeal ninefold.
> 
> ![img](https://s3.amazonaws.com/hashrocket-blog-production/catpictures.com.jpg "catpictures.biz")
> 
> Let's look at some of the ways that we can approach this problem, displaying a list of cat pictures that are the cheapest for their respective category.
> 
> \*\* Approach 1: Ruby
> 
> :CUSTOM<sub>ID</sub>: approach-1-ruby
> 
> Implementing the solution in Ruby is fairly straightforward. <del>ActiveSupport</del> Enumerable provides the `group_by` and `sort_by` methods on collections, and we can use those to help us cut down on some typing.
> 
>     class CatPicture < ActiveRecord::Base
>       attr_accessible :category_id, :description, :name, :price
>       belongs_to :category
>     
>       def self.cheapest_per_category
>         all.group_by(&:category_id).map do |category_id, subset|
>           subset.sort_by { |pic| [pic.price, pic.name] }.first
>         end
>       end
>     end
> 
> First, we group all of the cat pictures by their category. Then, for each set of pictures, we sort them by their price and name, and take only the first one.
> 
> Perhaps you are wondering if inverting the responsibility would improve the implementation, putting the mapping and reduction impetus in the Category model instead. Although it would be possible to go through the Category model to find its cheapest picture, that would lead to an "n+1", as each category would subsequently need fetch its cat pictures. Alternatively, eager-loading all categories with their cat pictures would be expensive, and would essentially duplicate what we've done above with the `group_by`.
> 
> Either way, as you can probably imagine, the above method would become more expensive as the data set continued to grow. Additionally, we lose the ability to continue to chain ActiveRecord scopes to filter the set further: as soon as we fetch the collection from the database, all filtering has to be done in Ruby.
> 
> Pros:
> 
> -   Easy to grok
> -   All domain logic stays in application
> 
> Cons:
> 
> -   Expensive (all objects loaded into memory)
> -   No scope chaining
> -   Once you go Ruby, you don't go back
> 
> \*\* Approach 2: SQL subselects
> 
> :CUSTOM<sub>ID</sub>: approach-2-sql-subselects
> 
> We can improve performance by doing the filtering at the database level, rather than loading all cat pictures into memory each time.
> 
>     class CatPicture < ActiveRecord::Base
>       attr_accessible :category_id, :description, :name, :price
>       belongs_to :category
>     
>       def self.cheapest_per_category
>         find_by_sql <<-SQL
>           SELECT DISTINCT ON(category_id) cat_pictures.*
>           FROM cat_pictures
>           WHERE ((category_id, price) IN (
>     	SELECT category_id, min(price)
>     	FROM cat_pictures
>     	GROUP BY category_id
>           ))
>           ORDER BY category_id ASC, cat_pictures.name ASC
>         SQL
>       end
>     end
> 
> Here, we use a subselect to filter the initial set down to only those that have the cheapest price per category. In this inner query, each row will contain a `category_id` and its lowest `price`. In the outer query, we choose all cat pictures whose `price` and `category_id` match a row from this inner query, using the `IN` syntax.
> 
> We would be done here, except that there still exists the possibility that there could be more than one that have that low price for a given category. So, depending on the database vendor, we can here find "distinct" rows, according the columns of interest. In Postgresql, the syntax for this is `DISTINCT ON([column,...])`, which will omit duplicates of the listed columns. For our purposes, we don't want more than one per category, so we distinct on `category_id`.
> 
> It is worth noting that without an `ORDER BY` clause, `DISTINCT ON` is nondeterministic: we are not guaranteed to get the same result each time. Thus, we order by `category_id` and `name`, so that only the first cat picture alphabetically will show up.
> 
> We can improve the implementation above by making it a true chainable scope. Whereas `find_by_sql` returns an array of objects, we can refactor this to return an ActiveRelation instead.
> 
>     class CatPicture < ActiveRecord::Base
>       attr_accessible :category_id, :description, :name, :price
>       belongs_to :category
>     
>       def self.cheapest_per_category
>         where("(category_id, price) IN (#{category_id_and_lowest_price_sql})").select("DISTINCT ON(category_id) #{table_name}.*").order("category_id ASC, #{table_name}.name ASC")
>       end
>     
>       private
>       def self.category_id_and_lowest_price_sql
>         scoped.select("category_id, min(price)").group(:category_id).to_sql
>       end
>     end
> 
> Functionally, this generates the exact same query as before, but allows further chaining. Using ActiveRelation's `to_sql` method, we're able to build up our inner query without actually executing it. We then interpolate that query into what was the outer query, which we've reduced to calls to `where`, `select` and `order`.
> 
> Pros:
> 
> -   More performant than Ruby method
> -   Scope chaining still possible
> 
> Cons:
> 
> -   Nested subselects
> -   Very difficult to read in application code
> -   The use of `DISTINCT ON` - only some RDBMS' have such functionality
> 
> \*\* Approach 3: Window functions
> 
> :CUSTOM<sub>ID</sub>: approach-3-window-functions
> 
> But there is still another option. The SQL standard defines a concept called window functions, which act a lot like aggregates, but don't change the result set. From the Postgresql documentation's [excellent introduction to window functions](http://www.postgresql.org/docs/9.1/static/tutorial-window.html):
> 
> \#+BEGIN<sub>QUOTE</sub>
>   A window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. But unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row - the rows retain their separate identities.

Let's see how this would work with our dataset. First of all, let's assume the following cat pictures:

    # SELECT id, name, category_id, price FROM cat_pictures ORDER BY category_id, price;
    
     id |         name         | category_id | price
    ----+----------------------+-------------+-------
      7 | Triple LOL           |           1 |  9.99
      5 | Hugs not Drugs       |           1 |  9.99
      2 | Puss in Boots        |           1 | 14.99
      3 | Cats Gone By         |           1 | 19.99
      6 | Cats in it for me    |           1 | 22.99
      4 | Turkleton's Folly    |           2 | 11.99
      1 | Meowna Lisa          |           2 | 19.99
      8 | Lady Caterly's Lover |           2 | 22.99

Given this data, our goal is to select "Hugs not Drugs" and "Turkleton's Folly", which are the cheapest pictures from their categories.

Whereas a normal aggregate function with `GROUP BY` would collapse the results, a window function retains the original row. Let's consider how this would affect the inner query from the subselect approach above:

    SELECT category_id, min(price) FROM cat_pictures GROUP BY category_id;
    
     category_id |  min
    -------------+-------
    	   1 |  9.99
    	   2 | 11.99

    SELECT category_id, min(price) OVER (PARTITION BY category_id) FROM cat_pictures;
    
     category_id |  min
    -------------+-------
    	   1 |  9.99
    	   1 |  9.99
    	   1 |  9.99
    	   1 |  9.99
    	   1 |  9.99
    	   2 | 11.99
    	   2 | 11.99
    	   2 | 11.99

Above, we've replaced the `GROUP BY` clause with an `OVER` clause. We have the original rows with an additional column for this aggregate data. This is useful in its own right, but the real power of window functions comes from this concept of window framing. The use of `PARTITION BY` creates a frame for each group. In our case, we have two frames, one for each `category_id`. Then, all aggregate and window functions before the `OVER` clause operate against this frame. Each window frame effectively has its own result set, according to the defined partition.

When a window frame is ordered, using an `ORDER BY` clause, even more options are possible. For example, consider the following:

    SELECT id, name, category_id, price, rank() OVER (PARTITION BY category_id ORDER BY price) FROM cat_pictures;
    
     id |         name         | category_id | price | rank
    ----+----------------------+-------------+-------+------
      7 | Triple LOL           |           1 |  9.99 |    1
      5 | Hugs not Drugs       |           1 |  9.99 |    1
      2 | Puss in Boots        |           1 | 14.99 |    3
      3 | Cats Gone By         |           1 | 19.99 |    4
      6 | Cats in it for me    |           1 | 22.99 |    5
      4 | Turkleton's Folly    |           2 | 11.99 |    1
      1 | Meowna Lisa          |           2 | 19.99 |    2
      8 | Lady Caterly's Lover |           2 | 22.99 |    3

Look familiar? This is essentially the original , except we've added a new column: its price rank within a window partitioned by `category_id`. It's a mouthful to describe, but we're very close to our original goal of finding the cheapest cat picture per category. All we need to do now is select rows that have a rank of 1.

Not so fast. Can you spot the issue with the above? The `rank()` window function assigns the same rank to ties, but we need the first one alphabetically in the case of "ties". We can remedy that by using a different window function, `row_number()`, which guarantees different numbers.

    SELECT id, name, category_id, price, row_number() OVER (PARTITION BY category_id ORDER BY price, name) FROM cat_pictures;
    
     id |         name         | category_id | price | row_number
    ----+----------------------+-------------+-------+------------
      5 | Hugs not Drugs       |           1 |  9.99 |          1
      7 | Triple LOL           |           1 |  9.99 |          2
      2 | Puss in Boots        |           1 | 14.99 |          3
      3 | Cats Gone By         |           1 | 19.99 |          4
      6 | Cats in it for me    |           1 | 22.99 |          5
      4 | Turkleton's Folly    |           2 | 11.99 |          1
      1 | Meowna Lisa          |           2 | 19.99 |          2
      8 | Lady Caterly's Lover |           2 | 22.99 |          3

Perfect! Looking at the rows with "1" as their "row<sub>number</sub>", we see what we expect, "Hugs not Drugs" and "Turkleton's Folly", which are the cheapest pictures from their categories. We can use an `IN` clause for filtering, similar to the previous approach:

    SELECT id, category_id, name, price
    FROM cat_pictures
    WHERE (id, 1) IN (
      SELECT id, row_number() OVER (PARTITION BY category_id ORDER BY price, name)
      FROM cat_pictures
    );

     id | category_id |         name         | price
    ----+-------------+----------------------+-------
      5 |           1 | Hugs not Drugs       |  9.99
      4 |           2 | Turkleton's Folly    | 11.99

The where clause above filters records that both have an id that appears in the subquery next to a rank of 1. Now that we have the SQL down, let's convert our Ruby model to take advantage of this window function technique:

    class CatPicture < ActiveRecord::Base
      attr_accessible :category_id, :description, :name, :price
        belongs_to :category
    
      def self.cheapest_per_category
        where("(#{table_name}.id, 1) IN (#{price_rank_sql})")
      end
    
      private
      def self.price_rank_sql
        scoped.select("id, row_number() OVER (PARTITION BY category_id ORDER BY price ASC, name ASC)").to_sql
      end
    end

Groovy. Just like before, we can use to the power of ActiveRelation to build up our subselect, which then gets interpolated into the `where` clause. I've also prepended `id` in the `where` clause with `table_name`, to avoid potential ambiguous column problems.

There is one potential issue with using window functions: limited vendor support. While most of the big boys implement window functions (Oracle, Postgresql, and SQLServer, to name a few), MySQL and SQLite users are out of luck.

Pros:

-   Very performant (consistently twice as fast as Approach 2 on my laptop)
-   Much less noise than SQL subselect stuff
-   Easy to understand, assuming a basic knowledge of SQL window functions

Cons:

-   Not portable (window functions are not available in MySQL or SQLite)

\*\* Conclusion

:CUSTOM<sub>ID</sub>: conclusion

While they may not be appropriate for every situation, window functions are a great tool for your toolbelt. They excel at filtering down rows based on aggregate data, or adding aggregate data to the rows you'd already like to select.

For more information about window functions, the Postgres documentation is an excellent resource, both for its [introduction](http://www.postgresql.org/docs/9.1/static/tutorial-window.html), and its [list of window functions](http://www.postgresql.org/docs/9.1/static/functions-window.html).

\*\* Example app

:CUSTOM<sub>ID</sub>: example-app

While writing this post, I created a [sample Rails app](https://github.com/jgdavey/windowing-example/) to iterate quickly. I used TDD to write the pure-ruby approach, and reused the specs while I "refactored" the implementation to the subsequent approaches. Of particular note is [the history of the CatPicture model](https://github.com/jgdavey/windowing-example/commits/master/app/models/cat_picture.rb), which mirrors the code above.

Please enable JavaScript to view the [comments powered by Disqus.](http://disqus.com/?ref_noscript)

-   Who We Are
    
    :CUSTOM<sub>ID</sub>: who-we-are

Hashrocket is a Ruby on Rails design & development shop based in Jacksonville Beach, FL and Chicago.

We practice pair programming, test-driven development, user-centric design, and Agile.

  The Hashrocket Blog is a collection of things we've learned, places we're going, and general goings-on in our world.
\#+END<sub>QUOTE</sub>

