---
description: >-
  this is just a stub for an article; this is a topic I need to write and talk
  about
---

# Setting up Rails + React

> _\(From \[an edited\] conversation on Slack\):_
>
> There are three general ways of doing this:
>
> 1. Rails app is only an API, no front-end support for a standalone React Single Page App
> 2. Rails app includes support for loading a single page react app using the standard Rails view \(sprockets\) convention
> 3. Rails app allows React components to be sprinkled on a standard Rails view

> In \#1, it's possible to either separate the rails api and the client into separate repos, or keep them in one, but in separate subdirectories.
>
> In \#2, you'll essentially have the root route produce an index.html page that loads up the React App
>
> in \#3, you'll generate the standard set of Rails views for controllers, and have as much or as little React components on each view as you'd like
>
> This is my example of doing \#1: [https://github.com/tamouse/r5\_graphql\_react](https://github.com/tamouse/r5_graphql_react) \(toy app\)
>
> This one kinda shows both \#2 and \#3: [https://github.com/tamouse/r5react-rails](https://github.com/tamouse/r5react-rails)
>
> With the first one, too, I added GraphQL, but you can just as easily do a regular Rails RESTful API, just responding with JSON only. I followed this tutorial initially, I think it's pretty good: [https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one](https://github.com/tamouse/r5react-rails) \(it's a couple years old, 2017, but a lot is still quite applicable to Rails 6, even\) \(edited\)

{% hint style="info" %}
The above are all geared at a brand new Rails + React project. I _really_ want to also write about how you add React to an existing Rails project.
{% endhint %}



