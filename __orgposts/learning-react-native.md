
# Table of Contents

1.  [What is ReactNative?](#what-is-reactnative)
2.  [Create a new app](#create-a-new-app)
3.  [A few chores](#a-few-chores)
4.  [Watchman](#watchman)
5.  [Json-Server](#json-server)
    1.  [Initialize the data file](#initialize-the-data-file)
6.  [Redux](#redux)
    1.  [`.fetch()`](#fetch)
7.  [Testing](#testing)

Notes and reflections on learning [ReactNative](https://facebook.github.io/react-native/), from a workshop by [Scott Moss](https://github.com/hendrixer) at [FrontendMasters](https://frontendmasters.com/).


<a id="what-is-reactnative"></a>

# What is ReactNative?

A version of [React](https://facebook.github.io/react/) that builds native applications on [iOS] and [Android].


<a id="create-a-new-app"></a>

# Create a new app

{% highlight bash %} $ react-native init {% endhighlight %}

Afterwards, the instructions are pretty simple:

> To run your app on iOS:

{% highlight bash %} cd your<sub>app</sub> react-native run-ios {% endhighlight %}

> -   or -

> Open your<sub>app</sub>/ios/my<sub>react</sub><sub>native</sub><sub>todo</sub><sub>app.xcodeproj</sub> in Xcode Hit the Run button

> To run your app on Android: Have an Android emulator running (quickest way to get started), or a device connected

{% highlight bash %} cd your<sub>app</sub> react-native run-android {% endhighlight %}


<a id="a-few-chores"></a>

# A few chores

{% highlight bash %} git init echo 'description of your app' | tee README.md > .git/description hub create -d "$(cat README.md)" npm init # fill in missing info {% endhighlight %}


<a id="watchman"></a>

# Watchman

[Watchman](https://facebook.github.io/watchman/) is a utility that is used by [ReactNative](https://facebook.github.io/react-native/) in development mode to notify the system to rebuild when a file changes. I don't particularly like it, and it seems problematic. It's also a resource hog. For instance, I can't run Spotify at the same time I'm working (sux).

Make to shut down the watchman server when switching projects.

{% highlight bash %} watchman shutdown-server {% endhighlight %}


<a id="json-server"></a>

# Json-Server

In order to have a nice server store, I'm using the [json-server](https://www.npmjs.com/package/json-server) module. It provides a nice RESTful server endpoint for the data you want to serve up.


<a id="initialize-the-data-file"></a>

## Initialize the data file

Create the `db.json` file with the following content:

{% highlight json %} { "todos": [] } {% endhighlight %}

Make sure the key is in quotes &#x2013; it's **JSON** not JavaScript.

**Caveat:** if you decide to pre-populate the database, make **sure** that you have an `id` field for each record.


<a id="redux"></a>

# Redux

[Redux](http://redux.js.org/) is the predictable state container for JavaScript. React has been associated strongly the Redux, although it's not the only option on the block (see [RxJs](http://reactivex.io/) too).


<a id="fetch"></a>

## `.fetch()`

The [`.fetch()`](https://developer.mozilla.org/en-US/docs/Web/API/GlobalFetch/fetch) function is the new, modern replacement for doing AJAX-y things with XmlHttpRequest. It's a cleaner interface and built right in. Using [isomorphic-fetch](https://www.npmjs.com/package/isomorphic-fetch) lets you use it browser or server side to perform [async actions](http://redux.js.org/docs/advanced/AsyncActions.html). It's a bit odd for a name, though, since you can use any of the HTTP verbs with it, not just GET.

**NOTE:** remember that `.json()` on the `Response` object is a *function*.

{% highlight javascript linenos %} export function fetchTodos() { return dispatch => { dispatch(requestTodos()) return fetch(ENDPOINT) .then(response => response.json()) .then(json => dispatch(receivedTodos(json))) } } {% endhighlight %}


<a id="testing"></a>

# Testing

I'm testing with [Mocha](http://mochajs.org/) and [Chai](http://chaijs.com/) modules

<div class="HTML">
<del>

</div>

Because I'm using `babel` in the tests, I also needed to install `bable-preset-react` to get the `run-ios` to work.

<div class="HTML">
</del>

</div>

In fact, using Mocha like this causes `react-native` to have conniptions, so I'm taking out the `.babelrc` file until I can figure out how to have both tests and native. :(

