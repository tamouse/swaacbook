
# Table of Contents

1.  [Emacs Org Mode](#org7e7de41)
    1.  [Today's Explorations](#org9e626bd)
        1.  [Capture mode](#orgd4ad886)
        2.  [Other places visited today in the hunt :)](#org3ac2f6b)
    2.  [Future Plans](#org331a777)


<a id="org7e7de41"></a>

# Emacs Org Mode

-   published date: 2015-01-24 20:24
-   keywords: ["emacs", "org-mode", "swaac"]

[Emacs](http://www.emacswiki.org) is my favourite editor, having imprinted on it way back in 1984 as my first editor on a Unix system. Emacs's [Org mode](http://www.orgmode.org) is something I've heard of, but have never gotten around to learning and using. I'm taking some time now to delve into it, after upgrading my system to version 24.4 of emacs, and using the [emacs starter kit](https://github.com/eschulte/emacs24-starter-kit) to initialize my emacs introduced me to `settings.org` in the `.emacs.d/<user>` directory for doing local initialization (that used to get handled with `~/.emacs`).

Within the `settings.org` file, snippets of *ELisp* code are written, then extracted into `settings.el` to execute at startup. I found it the most delicious of programming experiences, intermingling a nice outline and documentation with executable code.

Delving further, I've discovered [Sacha Chua](http://sachachua.org)'s blog, and the [Org mode](http://www.orgmode.org) website, and all sorts of information on using `org-mode` in *so* many areas.


<a id="org9e626bd"></a>

## Today's Explorations


<a id="orgd4ad886"></a>

### Capture mode

Capture mode is part of `org-mode` that lets you specify templates for things to capture, a bit different than using [yasnippets], but it's really useful for capturing todo items, links, snippets of text, and so on. It's inordinately powerful, and I've barely scraped the surface.

With capture templates, you have a whole range of options and things you capture along with what ever you're capturing, or even just use as a trigger to log an event, which is pretty awesome. Your triggers can be used to send captured things and bits to different files, even, so I have one that records new to do items to a generic GTD inbox file, another that records links in my general notes file, and another to capture a quote into a quotes file.


<a id="org3ac2f6b"></a>

### Other places visited today in the hunt :)

-   [Source Code Blocks: Uses](http://orgmode.org/worg/org-contrib/babel/uses.html)
-   [Org Mode: Data Collection and Analysis](http://orgmode.org/worg/org-contrib/babel/examples/data-collection-analysis.html)
-   [Source Code Blocks: Uses](http://orgmode.org/worg/org-contrib/babel/uses.html)
-   [Emacs + org-mode + python in reproducible research; SciPy 2013 Presentation - YouTube](https://www.youtube.com/watch?v=1-dUkyn_fZA)
-   [An Emacs Starter Kit for the Social Sciences](http://kieranhealy.org/resources/emacs-starter-kit/)
-   [Emacs Chat: Avdi Grimm (Org-mode, Ruby, etc.)](http://emacslife.com/emacs-chats/chat-avdi-grimm.html#sec-1)
-   **[[<http://sachachua.com/blog/2014/12/emacs-chat-karl-voit-2/>][Emacs Chat: Karl Voit - sacha chua:** living an awesome life]]
-   **[[<http://sachachua.com/blog/2007/12/clocking-time-with-emacs-org/>][Clocking Time with Emacs Org - sacha chua:** living an awesome life]]
-   [Using dates and times in Emacs org-mode](http://members.optusnet.com.au/~charles57/GTD/org_dates/)
-   [Get Organized with Emacs Org-mode - Linux Journal](http://www.linuxjournal.com/article/9116)
-   [Hello Worg, the Org-Mode Community!](http://orgmode.org/worg/)


<a id="org331a777"></a>

## Future Plans

-   Integrating Org-mode with blogging (jekyll)
-   Using literate programming
-   Tracking things like glucose readings, insulin dosages, medications, meals/calories, etc.
-   Getting Things Done ™ &#x2013; to do / task list management
-   General writing
-   Taking notes
-   Capturing things
-   Linking to other parts of my computer life

