
# Table of Contents

1.  [TIL: Setting \`window.location\` during Jest testing](#orge7e373e)


<a id="orge7e373e"></a>

# TIL: Setting \`window.location\` during Jest testing

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-23 Fri 16:44&gt;</span></span>
-   capture<sub>date</sub>: <span class="timestamp-wrapper"><span class="timestamp">[2018-11-23 Fri]</span></span>
-   keywords: jest, window.location, testing

By default, the \`window.location\` properties are read-only. But for some tests, I need these to be specific, set values.

In [Jest issue 890](https://github.com/facebook/jest/issues/890) over on github, there is a long discussion about this, and ways people have solved this issue for themselves.

The first one I happened upon is one used by Facebook engineers:

I needed to modify \`pathname\` property only for my test:

    Object.defineProperties(window.location, 'pathname', {
        writeable: true,
        value: defaultPathname
    })

Here's a more universal one:

    const setURL = (url) => {
      const parser = document.createElement('a');
      parser.href = url;
      ['href', 'protocol', 'host', 'hostname', 'origin', 'port', 'pathname', 'search', 'hash'].forEach(prop => {
        Object.defineProperty(window.location, prop, {
          value: parser[prop],
          writable: true,
        });
      });
    };

The sneaky trick of creating a wee little parser out of a document anchor element is pretty dang cool, too.

Later in the issue page, there's some discussion about how this might break in future versions of \`jsdom\`, and another way to set the location property, by modifying the history on \`window\`:

    {
        "testUrl": "https://somehost.com/some/path/test.html"
    }

And in your test setup:

    window.history.pushState({}, 'Test Title', '/another/path/test.html?query=true');

This is from the [Jest and URL testing](https://www.ryandoll.com/post/2018/3/29/jest-and-url-mocking) by Ryan Doll.

