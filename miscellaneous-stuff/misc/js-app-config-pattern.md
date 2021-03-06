
# Table of Contents

1.  [JS App Config Pattern](#js-app-config-pattern)
    1.  [Concept](#concept)
    2.  [Use Case](#use-case)
    3.  [Creating the configuration module](#creating-the-configuration-module)
    4.  [Creating the environment configurations](#creating-the-environment-configurations)
    5.  [Deep merging](#deep-merging)
    6.  [Using the configuration](#using-the-configuration)


<a id="js-app-config-pattern"></a>

# JS App Config Pattern

-   published date: 2016-12-26 09:06
-   keywords: ["application", "config", "configuration", "javascript", "patterns", "webdev"]
-   source:

Nothing really new here, just writing down this pattern I've noticed in various JavaScript apps (notably [Express](http://expressjs.com/) apps). First seen in [Scott Moss's](https://twitter.com/scotups) ['API Design' course](https://frontendmasters.com/courses/api-design-nodejs/) at [FrontendMasters](https://frontendmasters.com).


<a id="concept"></a>

## Concept

The basic concept is to collect all application configuration in one place so you don't have to litter it all over the application. Use a "standard" JS component idea, as one does with Angular and React to put it all into a single location.


<a id="use-case"></a>

## Use Case

My use case will be a rather generic Express API application. Using a service- or resource-oriented structure, I have an folder structures like so:

    app/
      posts/
        index.js
        postModel.js
        postsController.js
        postsRoutes.js
      users/
        index.js
        userModel.js
        usersContoller.js
        usersRoutes.js
      index.js
    config/
      development.js
      index.js
      production.js
      test.js
    public/
      images/
      javascripts/
      stylesheets/
      index.html
    index.js
    package.json

I'm taking advantage of the convention of using an `index.js` at the root of the components (and app) to make requiring the module as simple as providing the directory name.


<a id="creating-the-configuration-module"></a>

## Creating the configuration module

In `./config/index.js`, I have the following:

    
    var baseConfig = {
      env: process.env.NODE_ENV || 'development',
      logging: false,
      jwtSecret: process.env.JWT_SECRET
    };
    
    var envConfig = require('./' + baseConfig.env);
    
    module.exports = Object.assign({}, baseConfig, envConfig);

A **HUGE** caveat, of course, is to **NEVER** save secrets and credentials in git (or Github, Gitlab, BitBucket, etc.) since they will be there forever, even if you later remove them.

**Always use environment variables to configure secret values.**


<a id="creating-the-environment-configurations"></a>

## Creating the environment configurations

The environment configurations would be the same as the environment names with '.js' added, so:

-   `development.js`
-   `testing.js`
-   `production.js`

Each of these can be empty, but the files need to exist.

As an example, I always want logging during development, but not during production or testing.

In `./config/development.js`:

    module.exports = {
      logging: true
    };

This would be merged during the `Object.assign` step in `./config/index.js`.


<a id="deep-merging"></a>

## Deep merging

The main limitation to the above is if the configuration has a deeper structure. The above works great when everything is in the top level of the configuration object, but as soon as you go deeper (objects within objects, etc), you need to do a deep merge.

The [Lodash](https://lodash.com) library has a few different methods that can be used here. The one I like to use is `_.merge` since it works like `Object.assign` in merging the members from left to right. (See [stackoverflow](http://stackoverflow.com/questions/19965844/lodash-difference-between-extend-assign-and-merge#19966511) for a more thorough explanation and comparison.)


<a id="using-the-configuration"></a>

## Using the configuration

Now, with my per-environment configuration set, I use it in my application. In `./index.js` (the root of the app), I put:

    var config = require('./config');

Deeper down, in a server component, for example, I need to use the appropriate path lift to find it. Getting the configuration into the posts controller:

File `./app/posts/postsController.js`

    var config = require('../../../config'); // might need more '../' to get to the right level

When you need a configuration value, it's right there on the `config` object:

    if(config.env === 'development'){
       // ... do something you only do in development
    }

