
# Table of Contents

1.  [Polyfills for find() and findIndex() in JavaScript](#orgacc99c4)
    1.  [the starting point](#org9ae2da1)
    2.  [using find](#org7675853)
    3.  [using forEach](#org71db617)
    4.  [enter the functional programming](#org0ad419a)
    5.  [discussion](#org019e6f4)
    6.  [so what?](#org37c4842)


<a id="orgacc99c4"></a>

# Polyfills for find() and findIndex() in JavaScript

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-04 Sun 08:25&gt;</span></span>
-   published date: 2018-02-10
-   keywords: javascript, polyfills, find, findIndex, missing IE9, reduce, functional programming

The [MDN Array documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global\_Objects/Array) `find()` and `findIndez()` methods are available on all browsers now **except** IE9. Interestingly, the `map()`, `filter()`, and `reduce()` methods *are* in IE9.


<a id="org9ae2da1"></a>

## the starting point

The impetus for this little post is recently seeing a passage of code like this:

    let stateIndex = state.index
    const routes = state.routes
    const activateTab = routes.filter((tab, index) => {
      if (tab.routeName == action.routeName) {
        stateIndex = index
      }
    })
    return { ...state, index: stateIndex }

The code, as written, will return the index for the *last* match. Since I'm refactoring, I'm not going to change that behavior.

There are a few things wrong with this, IMHO:

1.  the `activeTab` variable is never used
2.  the `filter()` method is being used to perform a side effect
3.  setting several intermediate variables


<a id="org7675853"></a>

## using find

If `find()` or `findIndex()` were available everywhere, I could write this as:

    const routes = state.routes
    let stateIndex = routes.findIndex(tab => tab.routeName === action.routeName)
    stateInddex = stateIndex === -1 ? state.index : stateIndex
    return { ...state, index: stateIndex }

Except that finds the *first* match, not the last, so I couldn't really use them anyway.


<a id="org71db617"></a>

## using forEach

But since IE9 doesn't have `find()` or `findIndex()`, I'm going write it with `forEach()`, which is *intended* for looping *with* side effects:

    let stateIndex = state.index
    state.routes.forEach((tab, index) => {
      if (tab.routeName == action.routeName) {
        stateIndex = index
      }
    })
    return { ...state, index: stateIndex }

I also got rid of the `routes` intermediate variable.

This is okay and I could leave it there, except it's still using intermediate variables.


<a id="org0ad419a"></a>

## enter the functional programming

Writing it with `reduce()` to get rid of the intermediate variables:

    return {
      ...state,
      index: state.routes.reduce(
        (acc, cur, idx) => {
          return cur.routeName === action.routeName ?
    	idx :
    	acc
        },
        state.index
      )
    }


<a id="org019e6f4"></a>

## discussion

Let's walk through what's going on with the `reduce()` call.

[Array's `reduce()` function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce#Syntax) takes two arguments:

-   `callback` - a function that is passed 4 arguments:
    -   `accumulator` - collects the value returned from each iteration
    -   `currentValue` - holds the current value of the array for this iteration
    -   `index` - the index of the current value of the array (indexed by 0)
    -   `array` - the original array being reduced

-   `initialValue` - the initial value given to the `accumulator`. If omitted or "undefined" the first element of the array is used.

The callback function in our code is returning the result from the ternary expression:

    cur.routeName === action.routeName ? idx : acc

The first part of the ternary evaluates whether the route names from the current route (`cur`) and the one passed in with `action` are the same.

If so, the function returns the current index in the array. Otherwise, it returns the current accumulator.

When the reduce begines, the accumulator is set to the `initialValue`, which in this case is the index from the current state, which is handled outside this bit of code.

As the reducer rolls through the array, if the ternary comes true, the accumulator will get the value of the index at that point.

If the reducer goes all through the array and the ternary never comes true, the final accumulator value will still be the same as when set initially.


<a id="org37c4842"></a>

## so what?

When I was first learning programming, and even now that I'm more experienced, but don't necessarily know exactly what I need to do to implement a passage of code, using *intermediate variables* can be very helpful in understanding and debugging my code.

There are some passages of code that are more idiomatic and repetitious, and these are things I practice on and reduce the amount of code.

Arrays in particular are high-value targets for practicing on reducing the number of intermediate variables and beginning to use functional programming techniques.

There was nothing wrong with the original code: it did what it's supposed to do, it's not that difficult to see what's going on. However, because it uses a method not intended for performing side effects, it can open up the possibility for injecting an error during maintenance or enhancemnt.

Having the unused variable creates confusion for later maintainers as well, since we're left with a question about whether it should be there, and some intended functionality went missing.

The reducer may look complicated at first, but that's primarily due to unfamiliarity. Starting to learn bits of functional programming can improve the understandability of code for yourself.

