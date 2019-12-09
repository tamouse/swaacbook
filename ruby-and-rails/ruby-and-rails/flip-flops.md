---
description: An interesting code feature borrowed from Perl
---

# Flip Flops

The flip-flop is an interesting animal in Ruby, as well as it's fore-bearer, Perl.

In essence, it uses a pair of Regexps as a range to deliver all _lines_ from the first line that matches the first regexp to either the line before \(exclusive\) or the line of \(inclusive\) that matches the second regexp.

### Ruby Flip Flop

Here's the ruby version:

```text
lines = [" - Foo",
         "01 - Bar",
         "1 - Baz",
         " - Quux"];

puts "Source:"
puts lines

puts
puts "Exclusive, double-dot:"
lines.each do |l|
  if (l.match(/0/) .. l.match(/1/))
    puts "#{l}\n";
  end
end

puts
puts "Inclusive, triple-dot:"
lines.each do |l|
  if (l.match(/0/) ... l.match(/1/))
    puts "#{l}\n";
  end
end

```

and its output:

```text
$ ruby rubyflipflop.rb 
Source:
 - Foo
01 - Bar
1 - Baz
 - Quux

Exclusive, double-dot:
01 - Bar

Inclusive, triple-dot:
01 - Bar
1 - Baz

```

### Perl Flip Flop

and for contrast, the Perl version:

```text
@lines = (" - Foo",
	  "01 - Bar",
	  "1 - Baz",
	  " - Quux");

print "The source:\n";
print join("\n",@lines)."\n";

print "\nExclusive, double-dot:\n";
foreach (@lines) {
    if (/0/ .. /1/) {
	print "$_\n";
    }
}

print "\nInclusive, triple-dot:\n";
foreach (@lines) {
    if (/0/ ... /1/) {
	print "$_\n";
    }
}

```

and it's output:

```text
$ perl perlflipflop.pl 
The source:
 - Foo
01 - Bar
1 - Baz
 - Quux

Exclusive, double-dot:
01 - Bar

Inclusive, triple-dot:
01 - Bar
1 - Baz

```

### Okay, but Why?

What practical use is the flip flop? It may not have many obvious implementations, but one such are swaths of text lines with distinct `BEGIN` and `END` markers, something like the following filter:

```text
#!/usr/bin/env ruby

def extractBeginEndBlock(s)
  s.split("\n").map do |line|
    next unless line.match(/^BEGIN$/) ... line.match(/^END$/)
    line
  end.compact.join("\n")
end

ARGV.each do |file|
  puts "File #{file}:"
  puts extractBeginEndBlock(File.read(file))
end

```

Let's give it some data:

```text
This would be skipped.

BEGIN
   Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
   Nulla posuere.
   Donec hendrerit tempor tellus.
   Nunc eleifend leo vitae magna.
END

This is skipped information.

So is this.

BEGIN
  * Donec vitae dolor.
  * Phasellus neque orci, porta a, aliquet quis, semper a, massa.
  * Cras placerat accumsan nulla.
  * Donec posuere augue in quam.
END

Not going to see this...

BEGIN
Pellentesque dapibus suscipit ligula.  Donec posuere augue in quam.  Etiam vel tortor sodales tellus ultricies commodo.  Suspendisse potenti.  Aenean in sem ac leo mollis blandit.  Donec neque quam, dignissim in, mollis nec, sagittis eu, wisi.  Phasellus lacus.  Etiam laoreet quam sed arcu.  Phasellus at dui in ligula mollis ultricies.  Integer placerat tristique nisl.  Praesent augue.  Fusce commodo.  Vestibulum convallis, lorem a tempus semper, dui dui euismod elit, vitae placerat urna tortor vitae lacus.  Nullam libero mauris, consequat quis, varius et, dictum id, arcu.  Mauris mollis tincidunt felis.  Aliquam feugiat tellus ut neque.  Nulla facilisis, risus a rhoncus fermentum, tellus tellus lacinia purus, et dictum nunc justo sit amet elit.

END

nothing
nothing

BEGIN
* Curabitur lacinia pulvinar nibh.
* Donec pretium posuere tellus.
* Suspendisse potenti.
* Nullam eu ante vel est convallis dignissim.
* Nulla posuere.
* Aliquam feugiat tellus ut neque.
* Vestibulum convallis, lorem a tempus semper, dui dui euismod elit, vitae placerat urna tortor vitae lacus.
* Phasellus at dui in ligula mollis ultricies.
* Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus.
* Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus.
* Vivamus id enim.
* Fusce suscipit, wisi nec facilisis facilisis, est dui fermentum leo, quis tempor ligula erat quis odio.
* Proin neque massa, cursus ut, gravida ut, lobortis eget, lacus.
* Curabitur vulputate vestibulum lorem.
* Nam euismod tellus id erat.
* Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
END

```

Which produces the following output:

```text
File big_example.data:
BEGIN
   Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
   Nulla posuere.
   Donec hendrerit tempor tellus.
   Nunc eleifend leo vitae magna.
END
BEGIN
  * Donec vitae dolor.
  * Phasellus neque orci, porta a, aliquet quis, semper a, massa.
  * Cras placerat accumsan nulla.
  * Donec posuere augue in quam.
END
BEGIN
Pellentesque dapibus suscipit ligula.  Donec posuere augue in quam.  Etiam vel tortor sodales tellus ultricies commodo.  Suspendisse potenti.  Aenean in sem ac leo mollis blandit.  Donec neque quam, dignissim in, mollis nec, sagittis eu, wisi.  Phasellus lacus.  Etiam laoreet quam sed arcu.  Phasellus at dui in ligula mollis ultricies.  Integer placerat tristique nisl.  Praesent augue.  Fusce commodo.  Vestibulum convallis, lorem a tempus semper, dui dui euismod elit, vitae placerat urna tortor vitae lacus.  Nullam libero mauris, consequat quis, varius et, dictum id, arcu.  Mauris mollis tincidunt felis.  Aliquam feugiat tellus ut neque.  Nulla facilisis, risus a rhoncus fermentum, tellus tellus lacinia purus, et dictum nunc justo sit amet elit.

END
BEGIN
* Curabitur lacinia pulvinar nibh.
* Donec pretium posuere tellus.
* Suspendisse potenti.
* Nullam eu ante vel est convallis dignissim.
* Nulla posuere.
* Aliquam feugiat tellus ut neque.
* Vestibulum convallis, lorem a tempus semper, dui dui euismod elit, vitae placerat urna tortor vitae lacus.
* Phasellus at dui in ligula mollis ultricies.
* Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus.
* Proin quam nisl, tincidunt et, mattis eget, convallis nec, purus.
* Vivamus id enim.
* Fusce suscipit, wisi nec facilisis facilisis, est dui fermentum leo, quis tempor ligula erat quis odio.
* Proin neque massa, cursus ut, gravida ut, lobortis eget, lacus.
* Curabitur vulputate vestibulum lorem.
* Nam euismod tellus id erat.
* Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
END

```

Rather than printing them off, the blocks of text could be filtered in some other way, such as converting from markdown to HTML, or extracting code from a mingled file like an org-babel file in emacs.



