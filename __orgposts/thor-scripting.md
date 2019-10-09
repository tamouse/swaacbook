
# Table of Contents

1.  [Thor Scripting](#org8fc9618)
    1.  [Making "unix-like" options available for commands](#org5e02b21)
    2.  [Testing thor scripts](#org820eb3b)
    3.  [What if your action prints output instead of returning a value?](#orgc9172cb)


<a id="org8fc9618"></a>

# Thor Scripting

So I've been playing around with thor for a whlie, and have a couple of interesting things I've learned.


<a id="org5e02b21"></a>

## Making "unix-like" options available for commands

A typical unix command (both short and long options) typically doesn't have a subcommand associated with it.

To get `thor` to emulate this, you use the `map` method:

    class MyScript < Thor
      VERSION = "0.1.0"
      include Thor::Actions
      map "-V" => :version
      map "--version" => :version
    
      desc "version", "display the version string"
      def version
        say "MyScript version: #{MyScript::VERSION}"
      end
    end
    
    MyScript.start(ARGV)

Then you can call the script with

    $ myscript -V
    MyScript version: 0.1.0

And you'll see the version string!


<a id="org820eb3b"></a>

## Testing thor scripts

I set up a thor script development arena with the standard bundler `gem` command:

    $ bundle gem jekyllpress -b -t spec

which creates an executable in `bin/jekyllpress` that just requires `lib/jekyllpress.rb` and that's it. I put my thor application inside the `Jekyllpress` module like so:

    module Jekyllpress
      class App < Thor
        #...
      end
    end

and added the autoinvocation into the `bin` script:

    #... initializing thingies
    require 'jekyllpress'
    Jekyllpress::App.start(ARGV)

so the library module would be clean for the purposes of testing; I could pass in things from the specs without having to worry about the application running every time it got included.

Now, a typical spec will be:

    it "returns a version string" do
      result = Jekyllpress::App.start(%w[version])
      expect(result).to include(Jekyllpress::VERSION)
    end


<a id="orgc9172cb"></a>

## What if your action prints output instead of returning a value?

Have it do both: do the printing or whatever, but return the value(s) you want to test for:

    def version
      say "Jekyllpress version: #{Jekyllpress::VERSION}"
      Jekyllpress::VERSION
    end

