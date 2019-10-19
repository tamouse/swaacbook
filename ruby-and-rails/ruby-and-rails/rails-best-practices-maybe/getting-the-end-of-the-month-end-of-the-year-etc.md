# getting the end of the month, end of the year, etc

You can easily get the end of the month, or end of the year in Rails' Date extensions via sending in a negative 1:

```ruby
# Last day of 2015
Date.new(2015,-1,-1) #=> 2015-12-31

# Last second of 2019:
DateTime.new 2019, -1, -1, -1, -1, -1 #=> Tue, 31 Dec 2019 23:59:59 +0000

# Last hour of September, 2019:
DateTime.new 2019, 9, -1, -1 #=> Mon, 30 Sep 2019 23:00:00 +0000
```

