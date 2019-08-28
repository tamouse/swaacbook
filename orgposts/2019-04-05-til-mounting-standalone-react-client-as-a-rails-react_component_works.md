
# Table of Contents

1.  [TIL: mounting stand-alone react client as a react<sub>component</sub> in react-rails](#orgf234223):rails:react:

\#+COMMENT -**- time-stamp-line-limit: 12; time-stamp-count: 2 -**-


<a id="orgf234223"></a>

# TIL: mounting stand-alone react client as a react<sub>component</sub> in react-rails     :rails:react:

-   last updated: Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-04-05 Fri 00:59&gt;</span></span>
-   capture date: <span class="timestamp-wrapper"><span class="timestamp">[2019-04-05 Fri 00:40]</span></span>
-   keywords: react-rails, rails, react

This should have been obvious, but for some reason seemed like it was the "wrong" way to do this.

We have a product that we're converting slowly to react-based components. One of the central philosophies has been to build towards a standalone react client, and move the rails app to be more strictly an API provider.

I started out using the standard `ReactDom` style of mounting the application to the page. This has worked well so far, until we ran into a strange issue.

The library `styled-components` has been something we've adopted for putting our CSS in JS. However it has a problem: if multiple copies are loaded on the page in different bundles, it gets confused and the styles seem to go missing.

My first reaction was to remove all the `styled-components` and go with inline style objects instead.

However, my colleague pointed out that we could **also** just build one bundle which would keep the issue at bay.

I ran an experiment to do this, and it worked. The essential parts are:

1.  Create a new component, in my case I named it `ReactClient`, in the `app/javascript/components/` directory.
    -   the component essentially just imports the `App` and renders it.
2.  Change the layout where you're loading the app to instead issue and ERB call to `react_component` that calls `ReactClient`, possibly adding props options and HTML options.
3.  Remove the `webpacker` packs the build the client.

This worked really well, with the caveat that the application bundle is rather large since it now contains everything.

