
# Table of Contents

1.  [Mass inserting data in Rails without killing your performance &#x2013; Coffeepowered](#mass-inserting-data-in-rails-without-killing-your-performance-coffeepowered)


<a id="mass-inserting-data-in-rails-without-killing-your-performance-coffeepowered"></a>

# Mass inserting data in Rails without killing your performance &#x2013; Coffeepowered

-   published date: 2013-09-03 10:22
-   keywords: ["activerecord", "howtos", "mass-insertion", "performance", "rails", "swaac", "tutorials"]
-   source: <https://www.coffeepowered.net/2009/01/23/mass-inserting-data-in-rails-without-killing-your-performance/>

Clipped on 2013-09-03 10:22:52 -0500

<div class="HTML">
<!&#x2013;more&#x2013;>

</div>

> **\*\*** Chris Heald
> 
> :CUSTOM<sub>ID</sub>: chris-heald
> 
> Chief Architect for [Mashable](http://mashable.com). Rubyist, husband, father, and all around tall guy.
> 
> -   Mass inserting data in Rails without killing your performance
>     
>     :CUSTOM<sub>ID</sub>: mass-inserting-data-in-rails-without-killing-your-performance
> 
> Mass inserting is one of those operations that isn't really well-supported by ActiveRecord, but which has to be done nonethless. You might say, "Well hey, I'll just run a loop and create a bunch of AR objects, no sweat".
> 
> That'll work, but if speed is a factor, it might not be your best option.
> 
> ActiveRecord makes interface to the DB very easy, but it doesn't necessarily make it fast. Instantiating an ActiveRecord object is costly, and if you do a lot of 'em, that's going to cause you to bump up against the garbage collector, which will significantly hinder performance. There are several options, though, depending on how much speed you need.
> 
> There are benchmarks at the bottom of the post, so if you're just interested in those, scroll down.
> 
> \*\* Option 1: Use transactions
> 
> :CUSTOM<sub>ID</sub>: option-1-use-transactions
> 
> This is definitely the easiest method, and while you'll realize gains from it, you aren't going to be breaking any speed records using only this method. However, it's well worth it if you are doing mass inserts via ActiveRecord.
> 
> Instead of
> 
>     1000.times { Model.create(options) }
> 
> You want:
> 
>     ActiveRecord::Base.transaction do
>       1000.times { Model.create(options) }
>     end
> 
> The net effect is that the database performs all of your inserts in a single transaction, rather than starting and committing a new transaction for every request.
> 
> \*\* Options 2: Get down and dirty with the raw SQL
> 
> :CUSTOM<sub>ID</sub>: options-2-get-down-and-dirty-with-the-raw-sql
> 
> If you know that your data is valid and can afford to skip validations, you can save a **lot** of time by just jumping directly to raw SQL.
> 
> Imagine, for example, that you're running the following:
> 
>     1000.times {|i| Foo.create(:counter => i) }
> 
> That's going to create 1000 ActiveRecord objects, run validations, generate the insert SQL, and dump it into the database. You can realize large performance gains by just jumping directly to the generated SQL.
> 
>     1000.times do |i|
>       Foo.connection.execute "INSERT INTO foos (counter) values (#{i})"
>     end
> 
> You should use `sanitize_sql` and such as necessary to sanitize input values if they are not already sanitized, but with this technique you can realize extremely large performance gains. Of course, wrapping all those inserts in a single transaction, as in Option 1 gets you even more performance.
> 
>     Foo.transaction do
>       1000.times do |i|
>         Foo.connection.execute "INSERT INTO foos (counter) values (#{i})"
>       end
>     end
> 
> -   Option 3: A single mass insert
>     
>     :CUSTOM<sub>ID</sub>: option-3-a-single-mass-insert
> 
> Many databases support mass inserts of data in a single insert statement. They are able to significantly optimize this operation under the hood, and if you're comfortable using it, will be your fastest option by far.
> 
>     inserts = []
>     TIMES.times do
>       inserts.push "(3.0, '2009-01-23 20:21:13', 2, 1)"
>     end
>     sql = "INSERT INTO user_node_scores (`score`, `updated_at`, `node_id`, `user_id`) VALUES #{inserts.join(", ")}"
> 
> No transaction block is necessary here, since it's just a single statement, and the DB will wrap it in a transaction. We build an array of value sets to include, then just join them into the `INSERT` statement. We don't use string concatenation, since it will result in significantly more string garbage generated, which could potentially get us into the GC, which we're trying to avoid (and hey, memory savings are always good).
> 
> \*\* Option 4: ActiveRecord::Extensions
> 
> :CUSTOM<sub>ID</sub>: option-4-activerecordextensions
> 
> njero in `#rubyonrails` pointed me at [this nifty little gem](http://www.continuousthinking.com/tags/arext/rdoc/index.html) and I decided to include it. It seems to try to intelligently do mass inserts of data. I wasn't able to get it to emulate the single mass insert for a MySQL database, but it does provide a significant speed increase without much additional work, and can preserve your validations and such.
> 
> There's the obvious added benefit that you stay in pure Ruby, and don't have to get into the raw SQL.
> 
>     columns = [:score, :node_id, :user_id]
>     values = []
>     TIMES.times do
>         values.push [3, 2, 1]
>     end
>     
>     UserNodeScore.import columns, values
> 
> \*\* Benchmarks
> 
> :CUSTOM<sub>ID</sub>: benchmarks
> 
> I used a simple script to test each of the methods described here.
> 
>     require "ar-extensions"
>     
>     CONN = ActiveRecord::Base.connection
>     TIMES = 10000
>     
>     def do_inserts
>         TIMES.times { UserNodeScore.create(:user_id => 1, :node_id => 2, :score => 3) }
>     end
>     
>     def raw_sql
>         TIMES.times { CONN.execute "INSERT INTO `user_node_scores` (`score`, `updated_at`, `node_id`, `user_id`) VALUES(3.0, '2009-01-23 20:21:13', 2, 1)" }
>     end
>     
>     def mass_insert
>         inserts = []
>         TIMES.times do
>             inserts.push "(3.0, '2009-01-23 20:21:13', 2, 1)"
>         end
>         sql = "INSERT INTO user_node_scores (`score`, `updated_at`, `node_id`, `user_id`) VALUES #{inserts.join(", ")}"
>         CONN.execute sql
>     end
>     
>     def activerecord_extensions_mass_insert(validate = true)
>         columns = [:score, :node_id, :user_id]
>         values = []
>         TIMES.times do
>             values.push [3, 2, 1]
>         end
>     
>         UserNodeScore.import columns, values, {:validate => validate}
>     end
>     
>     puts "Testing various insert methods for #{TIMES} inserts\n"
>     puts "ActiveRecord without transaction:"
>     puts base = Benchmark.measure { do_inserts }
>     
>     puts "ActiveRecord with transaction:"
>     puts bench = Benchmark.measure { ActiveRecord::Base.transaction { do_inserts } }
>     puts sprintf("  %2.2fx faster than base", base.real / bench.real)
>     
>     puts "Raw SQL without transaction:"
>     puts bench = Benchmark.measure { raw_sql }
>     puts sprintf("  %2.2fx faster than base", base.real / bench.real)
>     
>     puts "Raw SQL with transaction:"
>     puts bench = Benchmark.measure { ActiveRecord::Base.transaction { raw_sql } }
>     puts sprintf("  %2.2fx faster than base", base.real / bench.real)
>     
>     puts "Single mass insert:"
>     puts bench = Benchmark.measure { mass_insert }
>     puts sprintf("  %2.2fx faster than base", base.real / bench.real)
>     
>     puts "ActiveRecord::Extensions mass insert:"
>     puts bench = Benchmark.measure { activerecord_extensions_mass_insert }
>     puts sprintf("  %2.2fx faster than base", base.real / bench.real)
>     
>     puts "ActiveRecord::Extensions mass insert without validations:"
>     puts bench = Benchmark.measure { activerecord_extensions_mass_insert(true)  }
>     puts sprintf("  %2.2fx faster than base", base.real / bench.real)
> 
> And the results:
> 
>     Testing various insert methods for 10000 inserts
>     ActiveRecord without transaction:
>      14.930000   0.640000  15.570000 ( 18.898352)
>     ActiveRecord with transaction:
>      13.420000   0.310000  13.730000 ( 14.619136)
>       1.29x faster than base
>     Raw SQL without transaction:
>       0.920000   0.170000   1.090000 (  3.731032)
>       5.07x faster than base
>     Raw SQL with transaction:
>       0.870000   0.150000   1.020000 (  1.648834)
>       11.46x faster than base
>     Single mass insert:
>       0.000000   0.000000   0.000000 (  0.268634)
>       70.35x faster than base
>     ActiveRecord::Extensions mass insert:
>       6.580000   0.280000   6.860000 (  9.409169)
>       2.01x faster than base
>     ActiveRecord::Extensions mass insert without validations:
>       6.550000   0.240000   6.790000 (  9.446273)
>       2.00x faster than base
> 
> The results are fairly self-explainatory, but of particular note is the specific single INSERT statement. At 70x faster than the non-transactional ActiveRecord insert, if you need speed, it's hard to beat.
> 
> \*\* Conclusions
> 
> :CUSTOM<sub>ID</sub>: conclusions
> 
> ActiveRecord is great, but sometimes it'll hold you back. Finding the balance between ease of use (full ActiveRecord) and performance (bare metal mass inserts) can have a profound effect on the performance of your app.

