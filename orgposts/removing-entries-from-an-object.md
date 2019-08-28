
# Table of Contents

1.  [Removing entries from an object](#org03e6d8b)
    1.  [reduce syntax](#orgc6685ae)
    2.  [the filter](#org746e898)
    3.  [putting it all together](#orged3ece7)


<a id="org03e6d8b"></a>

# Removing entries from an object

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-04 Sun 08:21&gt;</span></span>
-   date: 2018-05-15 00:38
-   keywords: javascript, lodash, reduce, snippets

I was casting about for a simple way to remove specific keys from an object before returning it to a consumer function. In this particular case, I wanted to remove all the entries that began with an underscore (`"_"`).

There's nothing like Ruby's Hash Enumerbles, but there is a library of such functions for JavaScript, [lodash](https://lodash.com) that fills in rather well.

For this exercise, I used the [`reduce`](https://lodash.com/docs/4.17.10#reduce) function in the `Collections` set of functions.


<a id="orgc6685ae"></a>

## reduce syntax

The syntax for lodash's `reduce` is:

    result = _.reduce(collection, filter, initialValue)


<a id="org746e898"></a>

## the filter

In the `reduce` function, you need to provide it with an `iteratee` &#x2013; something that acts on the current thing in the collection and returns the updated accumulator.

The function signature for the filter (iteratee) is:

    function filter(accumulator, value, key, collection)

If the collection is an `Object`, the key is the current key. If the collection is an `Array`, it's the current index.

In my case, I want to dump all keys that start with underscore, so the filter function is:

    function no_(acc, value, key) {
      if (!key.startsWith("_")) {
        acc[key] = value
      }
      return acc
    }


<a id="orged3ece7"></a>

## putting it all together

In a simple example, I have `obj1` that has a bad key: `_bad` that I want removed:

    let obj1 = {
      _bad: 1,
      good: 2
    }
    
    function no_(accumulator, value, key) {
      if (!key.startsWith("_")) {
        accumulator[key] = value
      }
      return accumulator
    }
    
    let obj2 = _.reduce(obj1, no_, {})

The end result in `obj2` is:

    { good: 2 }

which is just what I wanted.

There's a `jsfiddle` at <https://jsfiddle.net/tamouse/5f3L5dbz/>

