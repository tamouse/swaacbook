
# Table of Contents

1.  [Use a Page Variable](#use-a-page-variable)
2.  [Use a Collection](#use-a-collection)

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-09-16 Sun 14:06&gt; </span></span> - conversion to `org-mode`
-   original date: 2017-09-04 19:00
-   keywords: jekyll

[Last time](./2013-09-28-jekyll-making-posts-sticky.markdown), I talked about using categories to make a post sticky. This eats up a category, though, and can make the post's permalink look silly.


<a id="use-a-page-variable"></a>

# Use a Page Variable

This time, we're just going to use a page variable to do it.

In your posts that you want to be sticky, add a page variable to the front matter:

    ---
    layout: post
    sticky: true
    # ...
    ---

Then in your page where you want the sticky posts to appear first, use the following template:

    {% for post in site.posts %}{% if post.sticky %}
    * [{{post.title}}]({{post.url}}) {{post.date|date_to_string}}
    {% endif %}{% endfor %}
    
    {% for post in site.posts %}{% unless post.sticky %}
    * [{{post.title}}]({{post.url}}) {{post.date|date_to_string}}
    {% endunless %}{% endfor %}
    {% endraw %}

If you wanted the sticky posts to show up again in the lower section, just remove the `unless-endunless` condition in the second loop.

---


<a id="use-a-collection"></a>

# Use a Collection

The above solution is still a bit crude, and doesn't really lend itself to pagination.

Perhaps a better solution to try for is set up a collection of sticky posts and deal with them completely separately from your regular posts.

In `_config.yml`

    collections:
      - important

Create the sticky posts in the `_important` folder like regular posts.

The file you want to show the sticky and regular post then can have the following construction:

    {% for post in site.important %}
    * [{{post.title}}]({{post.url}}) {{post.date|date_to_string}}
    {% endfor %}
    
    {% for post in site.posts %}
    * [{{post.title}}]({{post.url}}) {{post.date|date_to_string}}
    {% endfor %}
    {% endraw %}

---

Works with Jekyl 3.5.2. YMMV.

