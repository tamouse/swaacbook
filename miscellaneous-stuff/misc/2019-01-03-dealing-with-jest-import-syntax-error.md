
# Table of Contents

1.  [TIL: Dealing with a jest `import` SyntaxError](#org291709e)


<a id="org291709e"></a>

# TIL: Dealing with a jest `import` SyntaxError

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-01-03 Thu 14:54&gt;</span></span>
-   capture-date: <span class="timestamp-wrapper"><span class="timestamp">[2019-01-03 Thu]</span></span>
-   keywords: jest, import, SyntaxError, transformIgnorePatterns

Today, I kept getting an error while running jest tests from within a module down in `/node_modules/`:

    ● Test suite failed to run
    
      /Users/tamara/Work/master/kickserv/node_modules/promise-polyfill/src/polyfill.js:1
      ({"Object.<anonymous>":function(module,exports,require,__dirname,__filename,global,jest){import Promise from './index';
    											   ^^^^^^
    
      SyntaxError: Unexpected token import

I tried numerous options, but finally landed on this: [Comment from @Izhaki](https://github.com/facebook/jest/issues/3202#issuecomment-387899346) describing their use of jest's `transformIgnorePatterns` setting. It turns out, all that was required was to actually **remove** the promise-polyfill npm module from the ignore patterns:

    {
        "jest": {
    	"transformIgnorePatterns": [
    	    "node_modules/(?!(promise-polyfill)/)"
    	]
        }
    }

The funky expresson, `"node_modules/(?!(promise-polyfill)/)"` is indicating that the matching path should **not** be ignored, and be transpiled by jest.

The other options in that comment thread and other places were about changing the \`.babelrc\` file and specifying different `NODE_ENV` values, which I just could not make work. With this setting, the jest tests all run, and the promise polyfill works in the code running in the browser.

