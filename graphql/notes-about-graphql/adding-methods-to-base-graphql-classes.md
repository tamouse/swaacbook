# Adding methods to base GraphQL classes

* Time-stamp: &lt;2018-12-20 Thu 09:04&gt;
* keywords: graphql

Sometime in the past year I started looking into using the class-based interface with `graphql-ruby`. Here's an example to provide millisecond precision time as integer:

```text
module Types
  class BaseObject < GraphQL::Schema::Object

    def created_at_ms
      time_to_ms(object.created_at)
    end

    def updated_at_ms
      time_to_ms(object.updated_at)
    end

    def time_to_ms(time)
      (time.to_f * 1000).to_i
    end

  end
end
```

With that in place, another object that inherits from the base object will automatically get use of these:

```text
module Types
  class AuthorType < Types::BaseObject
    field :name, String, null: false
    field :url, String, null: true
    field :created_at_ms, Integer, null: false
    field :updated_at_ms, Integer, null: false
  end
end
```

If there are other datetime fields, you can still use the `time_to_ms` method:

```text
module Types
  class BookType < Types::BaseObject
    field :title, String, null: false
    field :isbn, String, null: true
    field :purchased_on_ms, Integer, null: true
    def purchased_on_ms
      time_to_ms(object.purchased_on)
    end
    field :finished_reading_on_ms, Integer, null: true
    def finished_reading_on_ms
      time_to_ms(object.finished_reading_on)
    end
    field :rating, Integer, null: true
    field :private, Boolean, null: true
    field :created_at_ms, Integer, null: true
    field :updated_at_ms, Integer, null: true
  end
end
```

These are from my [rails react graphql template example](https://github.com/tamouse/rails_react_graphql_template_example) repo.

