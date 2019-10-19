# Ruby One-liners

Count the number of duplicated items in an array:

```ruby
$ ruby -e 'a=[1,2,3,4,4,5,6,6,6];b=Hash[a.group_by {|e| e}.map {|k,v| next if v.size ==1;[k,v.size]}.compact];p b'
{4=>2, 6=>3}
$ ruby -e 'a=[7,6,4,5,4,7,6,8,8,1,2,3,1,2,3];b=Hash[a.group_by {|e| e}.map {|k,v| next if v.size ==1;[k,v.size]}.compact];p b'
{7=>2, 6=>2, 4=>2, 8=>2, 1=>2, 2=>2, 3=>2}

```







