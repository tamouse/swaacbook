
# Table of Contents

1.  [TIL: GraphQL](#til-graphql)
    1.  [GraphQL](#graphql)
        1.  [Types](#types)
        2.  [Queries](#queries)
        3.  [Schema](#schema)
        4.  [Mutations](#mutations)
    2.  [Apollo Client](#apollo-client)
    3.  [Rails Server](#rails-server)
    4.  [GraphQL-Ruby](#graphql-ruby)
    5.  [Learning](#learning)
        1.  [PostType](#posttype)
        2.  [QueryType](#querytype)
        3.  [But, how do I get multiple Posts?](#but-how-do-i-get-multiple-posts)
    6.  [Conclusion](#conclusion)



<a id="til-graphql"></a>

# TIL: GraphQL

-   keywords: graphql, apollo client, rails, react, webpack, webdev

Although today was a workday, I spent it in blissful exploration on a technology we're going to be using in our application: GraphQL.

The setup:

-   Rails application, running 4.2.8
-   Webpack 2x, upgraded in existing the `webpack-rails` environment
-   React client without any sprockets support
-   ApolloClient

I set up a toy application based on the above constraints, at [graphql<sub>sample</sub>](https://github.com/tamouse/graphql_sample) to practice and dig into learning how GraphQL works.


<a id="graphql"></a>

## GraphQL

A little intro, although it's best to head over to the main [GraphQL](https://graphql.org) website if you want to know more about it.

GraphQL is a new sort of query language for APIs that gives your client applications a very different experience of data than the familiar RESTful APIs. It's centered around data objects in a way that's both similar to JSON-API, but still quite different form that.

It's a descriptive (declarative) language, where you define your data's types, fields, functions, queries, and schemas.


<a id="types"></a>

### Types

Let's look at an example. Supposed you had a data model that looked something like this, from ActiveRecord in Rails:

    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :published, null: false, default: false
      t.datetime :published_at
    
      t.timestamps
    end

An example of a GraphQL type that describes a post looks like:

    type Post {
      id: ID
      title: String
      body: String
      published: Boolean
      published_at: String
      created_at: String
      updated_at: String
    }


<a id="queries"></a>

### Queries

Based on that Post type, you can construct a Query that retrieves posts:

    type Query {
      post: Post
    }

(Indeed, queries are also types.)


<a id="schema"></a>

### Schema

The schema is the top level part of the whole bit that brings the data types and query types together, and forms the API itself.


<a id="mutations"></a>

### Mutations

Mutations are the flip-side of queries, where you can create, update, and remove data, i.e. "mutate" it. I didn't get that far at all today.


<a id="apollo-client"></a>

## Apollo Client

[Apollo client](http://dev.apollodata.com/) is a client that implements the GraphQL client-side of the API really well. They have dev kits for React, Angular, IOS, Android, and even Vanilla JS. Since my interest right now is in React, I delved into the [Apollo React Client](http://dev.apollodata.com/react/) (Note that this works with both web and native react.)

The morning was spent with the first two tutorials, building out the React Apollo client and an Express GraphQL server. They were great tutorials, and went smoothly.

1.  [Full Stack React + GraphQL Tutorial](https://dev-blog.apollodata.com/full-stack-react-graphql-tutorial-582ac8d24e3b)
2.  [React + GraphQL Tutorial - The Server](https://dev-blog.apollodata.com/react-graphql-tutorial-part-2-server-99d0528c7928)

My version, based on the tutorial, is over at [graphql-tutorial](https://github.com/tamouse/graphql-tutorial)

This was enough to get me chomping at the bit to do it in Rails.


<a id="rails-server"></a>

## Rails Server

A while back, I did write a pretty simple GraphQL Rails API using both the `graphql-ruby` and `graphql-api` gems. The latter makes the implementation pretty easy based on introspecting the apps models, but I wasn't quite sure it's ready for prime-time yet.

Today, I started over, creating a server app within the constraints listed above, and added the `webpack-rails` and `graphql` gems. The interesting thing is that installing the `graphql` in rails loaded up further gems, including a Graph/i/QL interface that let's you introspect the API while in development.

There was a lot of back-and-forth with `webpack-rails`. In the end, I probably should have just configured the thing directly with webpack 2x and all the needful.

I did try going the `create-react-app` way at first, and ended up keeping a lot of it after ejecting the build, but finally relying on my own understands of webpack configuration and knowing the current way our application works to be the final arbiters.


<a id="graphql-ruby"></a>

## GraphQL-Ruby

The [`graphql-ruby`](https://github.com/rmosolgo/graphql-ruby) is pretty interesting, in that it sets up a route for the GraphQL API directly, `/graphql`, which is somewhat of a default / convention. It mounts the GraphiQL engine on `/graphiql` at the same time, which is a nice way to work, as you can progressively test out your types, queries, and schemas as you work.

The gem creates a new folder under `app/graphql/` with a default schema and query type. Types are under the `app/graphql/types/` directory, and so get name-spaced `Type::NameType`. The DSL (domain-specific language) used to define things is quite similar to the GraphQL syntax, although of course fit to Ruby.

For example, the default query created looks like this:

    Types::QueryType = GraphQL::ObjectType.define do
      name "Query"
      # Add root-level fields here.
      # They will be entry points for queries on your schema.
    
      # TODO: remove me
      field :testField, types.String do
        description "An example field added by the generator"
        resolve ->(obj, args, ctx) {
          "Hello World!"
        }
      end
    end


<a id="learning"></a>

## Learning

Here's where the real learning and experimenting started. Up to now, things have been pretty simple and straight-forward.

I created the Post model described above, populated it with a few entries.


<a id="posttype"></a>

### PostType

I wrote the following as the data type for the Post model:

    Types::PostType = GraphQL::ObjectType.define do
      name "Post"
      description "A short post of content with a title, may be draft or published."
      field :id, types.ID do
        description "internal ID"
      end
      field :title, types.String do
        description "title of the post"
      end
      field :body, types.String do
        description "the post content"
      end
      field :published, types.Boolean do
        description "true if the post has been published"
      end
      field :published_at, types.String do
        description "the date the post was published"
      end
      field :created_at, types.String do
        description "date the post entry was created"
      end
      field :updated_at, types.String do
        description "date the post entry was last updated"
      end
    
    end


<a id="querytype"></a>

### QueryType

Then modified the sample query to produce a query that would find a post by it's ID:

    Types::QueryType = GraphQL::ObjectType.define do
      name "Query"
      # Add root-level fields here.
      # They will be entry points for queries on your schema.
    
      field :post, Types::PostType do
        argument :id, !types.ID
        description "find a post by id"
        resolve ->(obj, args, ctx) { Post.find_by(id: args["id"]) }
      end
    end

Without changing anything else, I was able to successfully query the API to get a post.


<a id="but-how-do-i-get-multiple-posts"></a>

### But, how do I get multiple Posts?

Here's where I spent the last two hours or so of the day, trying to figure out how this works. Clearly, it's possible, and I think I have some ideas to go forward, but I was really stuck at this point.

[This](https://github.com/rmosolgo/graphql-ruby/issues/166) looks like it might provide some insight when I work on this next.

The concept is also explored in Jake Trent's blog post: [return an array in graphql](https://jaketrent.com/post/return-array-graphql/) although I'll still need to translate to `graphql-ruby`.


<a id="conclusion"></a>

## Conclusion

All-in-all, a productive, happy day learning something completely new. Frustrations go along with learning; as one of my teachers says "That banging your head on the desk, that's called growth" (Hi, Scott!)

