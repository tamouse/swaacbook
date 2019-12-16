# Making records immutable

{% hint style="info" %}
This is an update based on capabilities in Rails for marking records and attributes immutable
{% endhint %}

Rails has an ActiveRecord method `.readonly?` that is called before updating a record. If this returns `true` the record is left unchanged. A way to implement this for a model that you never what the records to be changed after they're created would be to override the method in your model:

```ruby
class MyImmutableModel < ApplicationRecord

    def readonly?
        persisted?
    end
    
end
```

For individual attributes of a model, use the `readonly_attributes` directive in the class:

```ruby
class MyOtherModel < ApplicationRecord
    
    belongs_to :created_by, class: 'User'
    readonly_attributes :created_by_id
    
end

```

