
# Table of Contents

1.  [Starting out](#starting-out)
2.  [Git-ized it](#git-ized-it)
3.  [Initialize `bundler`](#initialize-bundler)
4.  [Edit the `Gemfile`](#edit-the-gemfile)
5.  [Bundle it up](#bundle-it-up)
6.  [Created the `Guardfile`](#created-the-guardfile)
7.  [Built an empty jekyll site](#built-an-empty-jekyll-site)
8.  [Made a `_config.yml` file](#made-a-_config.yml-file)
9.  [And fired up `guard`](#and-fired-up-guard)
10. [Browse to the site](#browse-to-the-site)
11. [Create some content](#create-some-content)
    1.  [In `_layouts/default.html`](#in-_layoutsdefault.html)
    2.  [In `index.html`](#in-index.html)
12. [Watch it reload!](#watch-it-reload)
13. [Conclusion](#conclusion)

**UPDATE:** This scheme described here doesn't actually work all that well. What I'm going to suggest is look at the jekyll plugin [`hawkins`](https://github.com/awood/hawkins) for a really simple and *working* method to get live reloading with everything working in Jekyll.

Recently looking around, and chatting with some folks on the `#jekyll` irc channel on freenode, I started to rethink the work I'd done creating the [drink<sub>up</sub><sub>doctor</sub>](https://github.com/tamouse/drink_up_doctor) gem using [Gulp](http://gulpjs.com) to drive the work cycle.

[Guard](http://guardgem.org/) is a tool for performing continuous testing on your local machine while you're developing code. Some folks have written extensions that let you continuously rebuild and view your work in a browser while you're updating your Jekyll site.

Since the Gulp build system uses a *lot* of node.js modules, and they take up a significant chunk of disk space in relation to most Jekyll sites, it seems prudent to find something that's a little more lightweight.

There are some good [posts](http://dan.doezema.com/2014/01/setting-up-livereload-with-jekyll/) out there on the subject of using Jekyll with Guard. Here's what I discovered and set up, based on Dan's post, and a lot of reading of source code.

-   contents {:toc}


<a id="starting-out"></a>

# Starting out

I first created a new directory for the site.

    $ mkdir ~/Sites/test_jekyll_guard
    $ cd ~/Sites/test_jekyll_guard


<a id="git-ized-it"></a>

# Git-ized it

    $ git init
    $ echo _site/ >> .gitignore
    $ git add .
    $ git commit -m "initial"


<a id="initialize-bundler"></a>

# Initialize `bundler`

    $ bundle init


<a id="edit-the-gemfile"></a>

# Edit the `Gemfile`

    source "https://rubygems.org"
    gem "jekyll"
    gem "guard"
    gem "guard-jekyll-plus"
    gem "guard-livereload"
    gem "rack-livereload"
    gem "thin"


<a id="bundle-it-up"></a>

# Bundle it up

    $ bundle


<a id="created-the-guardfile"></a>

# Created the `Guardfile`

    guard 'livereload' do
      watch /.*/
    end
    
    guard 'jekyll-plus', serve: true do
      watch /.*/
      ignore /^_site/
    end


<a id="built-an-empty-jekyll-site"></a>

# Built an empty jekyll site

    $ bundle exec jekyll new . --force --blank


<a id="made-a-_config.yml-file"></a>

# Made a `_config.yml` file

    title: testing guard-livereload with jekyll
    
    exclude:
      - Gemfile
      - Gemfile.lock
      - Guardfile
      - README.md


<a id="and-fired-up-guard"></a>

# And fired up `guard`

    $ bundle exec guard
    Configuration file: _config.yml
    05:50:10 - INFO - Jekyll building...
    05:50:10 - INFO - LiveReload is waiting for a browser to connect.
    05:50:10 - INFO - Jekyll build completed in 0.01s /Users/tamara/Sites/test_jekyll_guard → _site
    05:50:10 - INFO - Jekyll Using: Rack::Handler::Thin as server
    05:50:10 - INFO - Jekyll watching and serving using rack at 127.0.0.1:4000
    05:50:10 - INFO - Jekyll watching
    05:50:10 - INFO - Guard is now watching at '/Users/tamara/Sites/test_jekyll_guard'
    [1] guard(main)> Thin web server (v1.6.4 codename Gob Bluth)
    Maximum connections set to 1024
    Listening on 127.0.0.1:4000, CTRL+C to stop

This starts up the jekyll server at it's usual place serving `http://127.0.0.1:4000`, but before I could browse there, I needed to add the LiveReload extension to my browser. I use Google Chrome, but there are extensions for Firefox and others. Here I will simply point elsewhere for installing the extension: <http://livereload.com/extensions/>


<a id="browse-to-the-site"></a>

# Browse to the site

Now fire up your browser to point at jekyll's server. I had to initially click the livereload button that was on the toolbar. In other browsers, there might be some other way to start it listening. The output at your terminal will show:

    127.0.0.1 - - [13/Jan/2016:05:50:18 -0600] "GET /index.html HTTP/1.1" 200 - 0.0019
    05:50:19 - INFO - Browser connected.

The page will be blank, because the `index.html` file is empty.


<a id="create-some-content"></a>

# Create some content

Let's create some content and see what happens.


<a id="in-_layoutsdefault.html"></a>

## In `_layouts/default.html`

    {% raw %}<!DOCTYPE html>
    <html>
      <head>
        <meta charset="utf-8">
        <meta name="viewport"
          content="width=device-width,initial-scale=1">
        <title>{{site.title}}</title>
      </head>
      <body>
    {{content}}
      </body>
    </html>
    {% endraw %}


<a id="in-index.html"></a>

## In `index.html`

    {% raw %}---
    layout: default
    ---
    
    <h1>{{ site.title }}</h1>
    <h2>It works!</h2>
    {% endraw %}


<a id="watch-it-reload"></a>

# Watch it reload!

After saving these, your browser should reload a couple times and you should see the site with your content.

When you're done working, you simple enter `quit` to tell Guard to stop. (Note that it might look like it's in the middle of something, but it's actually at a prompt. Just hit enter to see another prompt. This screws me up all the time.)


<a id="conclusion"></a>

# Conclusion

This is a lot more lightweight than using the Gulp build system with BrowserSync, and only really requires manually opening the browser and clicking on the livereload button to connect things (BrowserSync does this automatically.) On this blog, still running the Gulp build system, the `node_modules` directory takes up 105MB while the entire site takes up 161MB, i.e., the node software is taking up **two-thirds** of the space.

