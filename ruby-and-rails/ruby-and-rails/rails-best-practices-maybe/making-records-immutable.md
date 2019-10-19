# Making records immutable

{% hint style="danger" %}
The failing in both of these examples happens when methods that don't invoke callbacks are used.
{% endhint %}

based upon [http://stackoverflow.com/a/1198286/742446](http://stackoverflow.com/a/1198286/742446)

use the Dirty module to find out if particular attributes have changes before saving the record.

```ruby
class Order < ActiveRecord::Base
  IMMUTABLE = %w{po_number}

  before_save do |record|
    false if IMMUTABLE.any? { |attr| record.changed.has_key?(attr) }
  end
end
```

Or, making the whole record immutable:

```ruby
class Transaction < ActiveRecord::Base
  before_save do |record|
    false if record.changed? && record.persisted?
  end
end
```

#### Using a validation hook instead of a callback

```ruby
class Order < ActiveRecord::Base
  IMMUTABLE = %w{po_number}

  validate :force_immutable

  # ...

  private

  def force_immutable
    if self.persisted?
      IMMUTABLE.any? do |attr|
        errors.add(attr, :immutable)
        self.changed.include?(attr)
        #
        # Optional: restore pristine state for the attribute
        #
        self[attr] = self.changed_attributes[attr]
      end
    end
  end
end
```

and if the whole record should be immutable:

```ruby
class Transaction < ActiveRecord::Base

  validate :force_immutable

  # ....

  private

  def force_immutable
    if self.changed? && self.persisted?
      self.reload # to keep the local copy of the record unchanged
      errors.add(:base, 'Payment Transactions are immutable')
    end
  end
end
```



