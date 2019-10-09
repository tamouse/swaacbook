
# Table of Contents

1.  [TIL: Kernel#gets is different from IO#gets](#til-kernelgets-is-different-from-iogets)
        1.  [From the ruby docs:](#from-the-ruby-docs)
        2.  [Examples](#examples)


<a id="til-kernelgets-is-different-from-iogets"></a>

# TIL: Kernel#gets is different from IO#gets

-   published date: 2015-04-15 21:33
-   keywords: ["argv", "gets", "learning", "ruby", "til"]
-   source:

*Today I Learned*: `Kernel#gets` does more than `IO#gets` does, it is not simply a shorthand way of reading from `STDIN`.

This was from a question on `irc://freenode.net/#ruby`.

`Kernel#gets` reads more than just stdin. It uses `ARGV*` unless it's empty, in which case it uses `STDIN`.


<a id="from-the-ruby-docs"></a>

### From the ruby docs:

At [`Kernel#gets`](http://ruby-doc.org/core-2.2.1/Kernel.html#method-i-gets):

> Returns (and assigns to `$_`) the next line from the list of files in `ARGV` (or `$*`), or from standard input if no files are present on the command line.

This will read from stdin:

    $ ruby gets_loop.rb

This looks for the files "these", "are", "some", and "words" and read from them sequentially:

    $ ruby gets_loop.rb these are some words


<a id="examples"></a>

### Examples

    puts "just a loop. ^C to exit"
    
    loop do
      print "> "
    
      # This will read from ARGF a line at a time
      command = gets.chomp
    
      # To make it read *only* from stdin when there are command line
      # arguments, you have to use STDIN explicitly:
      # command = STDIN.gets.chomp
    
      puts "Command: >>#{command.inspect}<<"
    end

    
    $ ruby gets_loop.rb
    just a loop. ^C to exit
    > hello, world
    Command: >>"hello, world"<<
    > ^Cgets_loop.rb:23:in `gets': Interrupt
        from gets_loop.rb:23:in `gets'
        from gets_loop.rb:23:in `block in <main>'
        from gets_loop.rb:19:in `loop'
        from gets_loop.rb:19:in `<main>'
    
    
    
    $ ruby gets_loop.rb these are some words
    just a loop. ^C to exit
    > gets_loop.rb:23:in `gets': No such file or directory @ rb_sysopen - these (Errno::ENOENT)
        from gets_loop.rb:23:in `gets'
        from gets_loop.rb:23:in `block in <main>'
        from gets_loop.rb:19:in `loop'
        from gets_loop.rb:19:in `<main>'

Let's change it to `STDIN.gets`:

    puts "just a loop. ^C to exit"
    
    loop do
      print "> "
    
      # This will read from ARGF a line at a time
      # command = gets.chomp
    
      # To make it read *only* from stdin when there are command line
      # arguments, you have to use STDIN explicitly:
      command = STDIN.gets.chomp
    
      puts "Command: >>#{command.inspect}<<"
    end

    
    $ ruby gets_loop.rb
    just a loop. ^C to exit
    > hello, world
    Command: >>"hello, world"<<
    > ^Cgets_loop.rb:27:in `gets': Interrupt
        from gets_loop.rb:27:in `block in <main>'
        from gets_loop.rb:19:in `loop'
        from gets_loop.rb:19:in `<main>'
    
    
    $ ruby gets_loop.rb these are some words
    just a loop. ^C to exit
    > hello again, you world you
    Command: >>"hello again, you world you"<<
    > ^Cgets_loop.rb:27:in `gets': Interrupt
        from gets_loop.rb:27:in `block in <main>'
        from gets_loop.rb:19:in `loop'
        from gets_loop.rb:19:in `<main>'

You can see it now works the same way with and without command line arguments.

