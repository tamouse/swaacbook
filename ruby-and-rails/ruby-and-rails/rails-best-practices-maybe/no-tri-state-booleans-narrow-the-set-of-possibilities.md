# no "tri-state" booleans: narrow the set of possibilities

## no "tri-state" booleans: narrow the set of possibilities

When declaring a boolean field in a rails db schema migration, set it to `not null` and a default of `false`:

in a new table declaration:

```ruby
create_table :members do |t|
  t.references :club, foreign_key: true
  t.text :name
  t.boolean :active, null: false, default: false

  t.timestamps
end
```

when adding a column:

```ruby
add_column :table, :field, :boolean, null: false, default: false
```

This ensures that the `field?` predicates always end up being what you expect them to be: `true` \(TrueClass\) or `false` \(FalseClass\) as opposed to `nil`, `true`, or `false`.





