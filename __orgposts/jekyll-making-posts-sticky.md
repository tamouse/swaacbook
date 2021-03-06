
# Table of Contents

1.  [Jekyll: Making Posts Sticky](#jekyll-making-posts-sticky)
2.  [Proposed solutions](#proposed-solutions)
3.  [Using a sticky category](#using-a-sticky-category)


<a id="jekyll-making-posts-sticky"></a>

# Jekyll: Making Posts Sticky

-   published date: 2013-09-28 17:13
-   keywords: ["blogging", "jekyll", "swaac"]
-   source:
-   redirect<sub>from</sub>: ["*blog/2013/09/28/jekyll-making-posts-sticky*"]

A recent visitor to the IRC channel #octopress was wondering how they could have both regular pagination and sticky posts that always show up on the first page.

**Update:** The solution proposed here is pretty old and not that great. Have a look at [Jekyll: Making Posts Sticky Redux](%7B%%20link%20_posts/2017-09-04-jekyll-making-posts-sticky-redux.markdown%20%%7D) for a better way to do it (or two better ways!)

Seemingly simple, the proffered solutions did not seem to fit the bill. This is the way I've solved this.

---


<a id="proposed-solutions"></a>

# Proposed solutions

The ideas proposed included doing something to keep the post far in the future, thus sorting out first always in the paginator. This seemed a bit too hacky.

Another offered adding a sticky page variable in the front matter. This has a lot of promise, and could work, but gathering up the posts which are sticky would probably require writing a plugin.

Yet another was to add a sticky category to the post in the front matter. This can work as well, and has the advantage of not needing a new plugin.


<a id="using-a-sticky-category"></a>

# Using a sticky category

This seems simplest and most accessible, although requiring more alteration of the `index.html` file in the `source` directory.

The implementation is shown in the following gist:

<div class="HTML">
<script src="<https://gist.github.com/tamouse/a160be1cb467f611c9ba.js>"></script>

</div>

The post itself gets a `sticky` category and the `index.html` file is changed to display sticky posts on the first page.

