
# Table of Contents



-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-09-16 Sun 14:29&gt; </span></span> - convert to org mode
-   original date: 2017-08-08 15:32
-   keywords: hacks, package.json, comments

You know how you can't have JavaScript comments in a .JSON file? Sometimes you want them, thus this hack for `package.json`.

I'm probably not the first person to think of this, but no one's ever suggested it to me.<sup><a id="fnr.1" class="footref" href="#fn.1">1</a></sup>

JSON files cannot have comments. But many of our configuration files are in JSON, and could benefit from some commentary. For example, why did you nail that particular version of `webpack-dev-server` ? (A true story that happened today.)

Comments are a sometimes good, sometimes bad thing. I like comments that give explanations for why things are the way they are, not so much what things are, or how things are done.

In this case, I wanted to leave a breadcrumb where my project mates (now and future) would be able to find some reason for a particular version being nailed instead of being allowed to increase with minor version changes.

The `package.json` file has a set of required keys (see <https://docs.npmjs.com/files/package.json> for details). It doesn't seem to mind if there are other keys, in fact several other things utilize keys to configure themselves (e.g. Jest).

There isn't a "comments" key, however.

So I decided to make use of it in our `package.json` file by creating an array of comments offering that "wth were you thinking" commentary for future devs.

Here's the top fragment of the file:

    {
        "comments" : [
    	"There is a bug in webpack-dev-server v2.7.0: https://github.com/webpack/webpack-dev-server/issues/1025",
    	"Nailing redux to v3.5.2 because v3.7.1 is breaking the dispatch maps"
        ],
        "name": "Example"
    }

and the regular parts of the file continue after that.

I think I'll improve on that by adding the branch / commit where those comments come into play.


# Footnotes

<sup><a id="fn.1" href="#fnr.1">1</a></sup> Remember that? Someone else *did* think of it, and it might be even better:

    {
        "//": "another way of putting comments in",
        "name": "Example"
    }
