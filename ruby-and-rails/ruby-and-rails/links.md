# Links

## Ruby Stuff

A deep-dive into [`Forwardable`](https://www.saturnflyer.com/blog/ruby-forwardable-deep-dive) by Jim Gay from [January 20, 2015](https://www.saturnflyer.com/blog/ruby-forwardable-deep-dive)

[Pre-build Ruby Installations for Ubuntu](https://www.brightbox.com/docs/ruby/ubuntu/) captured link on 2017-06-06 

* Brightbox.com provides pre-built versions of ruby for apt-get so you don't have to compile ruby when you provision a system

[New Methods in Ruby 2.2](http://www.sitepoint.com/new-methods-ruby-2-2/) from 2015-02-05

* Discussion of:
  * Binding\#local\_variables
  * Binding\#recevier
  * Dir\#fileno
  * Enumerable\#slice\_after
  * Enumerable\#slice\_when
  * Float\#next\_float
  * Float\#prev\_float
  * File\#birthtime, File.birthtime, File::Stat\#birthtime
  * Kernel\#itself
  * Method\#curry
  * Method\#super\_method
  * String\#unicode\_normalize \(plus ! and ? variants\)

[Just use double quoted strings](http://viget.com/extend/just-use-double-quoted-ruby-strings?utm_source=rubyweekly&utm_medium=email) by [Lawson Kurtz](https://twitter.com/LawsonKurtz) on 2015-01-22

* tl;dr: there is no significant performance difference, compared the human problems of misunderstanding or forgetting to change from single to double when you do decide to interpolate.

Blog post: [Adam Niedzeilski: 10 easy-to-fix Ruby / Ruby on Rails mistakes](http://adamniedzielski.github.io/blog/2015/01/31/11-easy-to-fix-ruby-slash-ruby-on-rails-mistakes/) on 2015-02-02

* In a nutshell:
  * complex conditionals, double negatives. Create good predicates for what your logic means.
  * not checking true / false on operations that don't raise an exception e.g.: Rails .save vs. .save!
  * using self when it isn't needed
  * N+1 queries
  * tri-state "booleans" – when nil is a possible value besides true and false
  * orphaned records
  * making database schema migrations dependent on a specific version of the source code  


    Most folks thing that as migrations are stored with the code and managed in the same way, that somehow state of the database and code must remain locked together. This could not be further from the truth.  


    If you need code changes with a migration, make a separate one-time rake task instead, and delete it when done.

  * not using map
  * not using Hash\#fetch



