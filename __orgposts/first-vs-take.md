
# Table of Contents

1.  [first vs. take](#org6e3d03b)


<a id="org6e3d03b"></a>

# first vs. take

-   published date: 2015-02-03 03:37
-   keywords: ["avdi", "enumerators", "lazy", "lazy-enumerators", "ruby", "rubytapas"]
-   source: <http://rubytapas.dpdcart.com/subscriber/post?id=677>

The difference between `first` and `take` is subtle.

As [Avdi](http://about.avdi.org) shows in [RubyTapas #278](http://rubytapas.dpdcart.com/subscriber/post?id=677)<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>, the `take` and `first` method on `Enumerators` do something quite different.

`take` by itself will return another enumerator in the chain, including a lazy enumerator if that's what it's chained to.

`first` on the other hand, will collapse the chain and return the array at that point in the chain.

**For example:**

    [3] pry(main)> lazy_power = 1.step.lazy.map{|n| n**n}
    => #<Enumerator::Lazy: ...>
    [4] pry(main)> lazy_power.take(5)
    => #<Enumerator::Lazy: ...>
    [5] pry(main)> lazy_power.first(5)
    => [1, 4, 27, 256, 3125]
    [6] pry(main)> lazy_power_enum = lazy_power.take(5)
    => #<Enumerator::Lazy: ...>
    [7] pry(main)> lazy_power_enum
    => #<Enumerator::Lazy: ...>
    [8] pry(main)> lazy_power_enum.next
    => 1
    [9] pry(main)> lazy_power_enum.next
    => 4
    [10] pry(main)> lazy_power_enum.next
    => 27
    [11] pry(main)> lazy_power_enum.next
    => 256
    [12] pry(main)> lazy_power_enum.next
    => 3125
    [13] pry(main)> lazy_power_enum.next
    StopIteration: iteration reached an end
    from (pry):13:in `next'


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> [RubyTapas](http://www.rubytapas.com) is a few-times-a-week videocast series put out by [Avdi](http://about.avdi.org). At 9USD$ a month, well worth the price.
