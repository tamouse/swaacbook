
# Table of Contents

1.  [FrontendMasters: JavaScript: The Hard Parts, Will Sentance](#org5c92d76)
    1.  [Callbacks and Higher-Order Functions](#org80e3c58)
        1.  [Warm ups](#orgbe6d188)
        2.  [map](#org9639a9b)
        3.  [forEach](#orgb6558a2)
        4.  [mapWith](#org634b817)
    2.  [(To be continued)](#org08ee52a)


<a id="org5c92d76"></a>

# FrontendMasters: JavaScript: The Hard Parts, Will Sentance

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-04 Sun 08:20&gt;</span></span>
-   date: 2018-07-11 05:35
-   keywords: ["javascript", "class", "notes"]
-   source: [video](https://frontendmasters.com/courses/javascript-hard-parts/)

Recently watching [this video](https://frontendmasters.com/courses/javascript-hard-parts/) with a study group, and working through a few of the coding challenges.


<a id="org80e3c58"></a>

## Callbacks and Higher-Order Functions

The reference link for this section is [csbin.io/callbacks](https://csbin.io/callbacks) where the examples and instructions are given. I'm not going to repeat all that here, but I'm going to track here my own work in developing the answers, and my own thoughts and notes.

The first handful of challenges weren't for me, to the point I didn't have to think how these would be implemented. For someone new to this, though, the can be quite challenging, and we had some good discussion amongst my study buddies.


<a id="orgbe6d188"></a>

### Warm ups

    function addTwo(n) { return n + 2 }
    function addS(s) { return s + "s" }


<a id="org9639a9b"></a>

### map

Map returns a new array, where each item is the result of running the callback on each element of the orginal array

    function map(arr, cb) {
      // Declare and initialize the return array.
      // Need some place to put our work
      let mapped = []
    
      // Using a standard for loop to process each element of the array
      for (let i = 0; i < arr.length; i++) {
        // assigning the current element of the array here, although not necessary,
        // illustrates the point that the rest of the body of the for loop *after*
        // this point is acting on the current element.
        let item = arr[i]
    
        // The current item of the original array gets passed
        // to the callback function, and the result is added
        // to the end of the new array
        mapped.push(cb(item))
      }
    
      // The result of the map is the new array with the processed elements
      return mapped
    }

Let's check it: pass in an array of integers, and a function to add 2 to each element

    console.log(map([1, 2, 3, 4], addTwo))
    // => [ 3, 4, 5, 6 ]

Note the declaration and assignment of the current array item to the intermediate variable `item` in the `for` loop. This is not necesary by any means, but I put it in to illustrate the distinction between the item, and what's acting on the item. This might become more useful in understanding when we begin to use `forEach` in `mapWith` and others below.


<a id="orgb6558a2"></a>

### forEach

The standard for loop used above in the `map` function is great and all, and I'll be using it again here implementing this `forEach` function. The `forEach` function will then become the building block for the next set of of functions.

The `forEach` function is an *impure* function, returning nothing and only performing side-effects for each element of the array.

    function forEach(arr, cb) {
      for (let i = 0; i < arr.length; i++) {
        let item = arr[i] // to hold the current item
        cb(item) // act on the current item
      }
    }
    // Check the forEach
    forEach([1, 2, 3, 4], console.log) // can pass in functions!
    // =>
    // 1
    // 2
    // 3
    // 4

This also illustrates the fact we can pass functions and methods as regular parameters. This is the building block of functional programming.

The callback function `cb` in the `forEach` function has a particular signature:

    function cb(item) {
      // ... do something with item
      return someResult // may be optional
    }

It is passed the current element of the array in the `item` parameter, and performs some action upon it. The callback may return a value, but it doesn't necessarily have to. The next subsection requires the callback to return a value, so it's is highly dependent on the specific use. Sometimes the only thing that you may want to have happen to the array elements is run a side effect, perhaps if your array is a set of hooks or other callback functions.

To illustrate the latter, suppose the array was a collection of line items on an order, and you wanted to calculate the line price based on the unit price and quantity of items. Since each line item is a self-contained object, updating that line price is a side-effect on that object, instead of creating new objects. This might be how it could be written:

    function calcLineCosts(lineItems) {
      forEach(lineItems,
        function (lineItem) {
          lineItem.linePrice = lineItem.quantity * lineItem.unitPrice
        }
      }
    )


<a id="org634b817"></a>

### mapWith

Reimplement `map` from above, this time using our `forEach` method. This was a head-scratcher for some of the study buddies, so I'll walk through it a little more slowly.

The main structure will still be the same:

1.  declare and initialize a space to build the new array
2.  inside the "loop" (which is implemented by the `forEach`), I'll push the result of the callback on the array item onto the new array variable
3.  return the new array

    function mapWith(arr, cb) {
        let mapped = [] // step 1
    
        // forEach providing our loop
        // ... mapped.push(cb(item)) // step 2
    
        return mapped // step 3
    }

The key is to figure out how to provide the `forEach` call. The parameters to `forEach` are `arr` - the input array, and `cb` the function to run on each. So inside, I need to create a function that will perform the `mapped.push` call:

    forEach(array, function (item) {
        mapped.push(cb(item))
    })

The anonymous function in the `forEach` call takes in the current array item and performs the push onto the new array after calling the callback on the item. Here is the entire contstruction, redone with ES6 syntax for the anonymous function:

    function mapWith(arr, cb) {
        let mapped = []
        forEach(arr, item => {
    	mapped.push(cb(item))
        })
        return mapped
    }

This works with `forEach`'s side-effect-only behaviour because `mapped` is declared outside the `forEach` call. It is still *within* the scope of `mapWith`, however, so it won't leak anything, and `mapWith` is itself a **pure function**.

The `forEach` function body for `mapWith` is the same as the original `map` function, from *after* the `item` declaration.

The result is the same as for `map`:

    console.log("mapWith: ", mapWith([1, 2, 3, 4], addTwo))
    // => mapWith:  [ 3, 4, 5, 6 ]

Continuing the discussion about whether our callbacks should return a value, in the case of the `mapWith` (or even `map`) functions, the callback **must** return a value, otherwise the new array will contain a collection of `undefined`'s instead.


<a id="org08ee52a"></a>

## (To be continued)

As the study group gets further, I'll add more to this post.

