
# Table of Contents

1.  [My First Proxy/Adapter for an Express.js app](#my-first-proxyadapter-for-an-express.js-app)
    1.  [Which HTTP package?](#which-http-package)
    2.  [The Giphy API](#the-giphy-api)
    3.  [TIL: calling `done` to fire async mocha tests](#til-calling-done-to-fire-async-mocha-tests)
    4.  [Follow-on thoughts](#follow-on-thoughts)


<a id="my-first-proxyadapter-for-an-express.js-app"></a>

# My First Proxy/Adapter for an Express.js app

-   published date: 2017-01-16 01:32
-   keywords: ["express.js", "javascript", "node.js", "using-apis-from-javascript"]
-   source:

Recently, I attended [HackTheGap 2017](https://hackthegap.com), which is an all-women hack-a-thon in the Twin Cities. (Huge fun!) Our team built a web app using Node.js, Express.js, and MongoDB, mixing in a little Python nltk for good measure: [BrainDump/ShrinkBot](https://github.com/BrainDumpShrinkBot/brain_dump_shrink_bot). This is the first serious Express app I've done from scratch, although not too strenuous.

One of the things we wanted was to be able to pull some content from other sites based on some keywords ("tags") that were extracted from a diary / journal entry using nltk.

One of those sources is [Giphy](https://giphy.com) with has an API in Beta. The [Giphy API](https://github.com/Giphy/GiphyAPI) (github) is a free for all way of accessing the fun animated GIFs stored on that site.


<a id="which-http-package"></a>

## Which HTTP package?

I tried a few different HTTP packages, including [superagent](https://www.npmjs.com/package/superagent), [request](https://www.npmjs.com/package/request), and finally settling on [node-fetch](https://www.npmjs.com/package/node-fetch). I went with this latter because it is most familiar to me from working in client-side JavaScript.


<a id="the-giphy-api"></a>

## The Giphy API

The api is really very simple:

The search URL is `http://api.giphy.com/v1/gifs/search`

Parameters are:

-   `api_key` - public beta api<sub>key</sub> is 'dc6zaTOxFJmzC' (everyone gets the same one)
-   `q` - search terms or phrase
-   `limit` - number of hits to return
-   `offset` - skip this many hits before returning `limit`
-   `rating` - "y", "g", "pg", "pg-13", "r"
-   `lang` - 2-letter language code, e.g. 'en'
-   `fmt` - 'json' or 'html'

Only `api_key` and `q` are required.

It returns by default a JSON structure with a whole pile of info. See the repo's README for actual information.

The proxy/adapter I wrote was really quite simple. I created a module with an IIFE that configured adapter and returned a method to call the API.

I wanted to be able to pass in configuration values for the various pieces of the API. For this first pass, I kept things a bit locked down.

The consumer provides an array of tag strings to search for, and a callback to process the return from the API.

\`\`\`javascript linenos *\*\* \* Getting a gif from Giphy: <https://github.com/giphy/Giphyapi#search-endpoint> \**

const config = require('./../config'); const fetch = require('node-fetch');

module.exports = (function (config) {

function fetch<sub>giphy</sub>(tags, cb) { var url = config.services.giphy.url; url += '?api<sub>key</sub>=' + config.services.giphy.api<sub>key</sub>; url += '&q=' + encodeURI(tags.join(' ')); url +='&limit=1'; url += '&rating=g'; fetch(url) .then(function (res) { return res.json(); }, function (err) { console.error("ERROR!!!" + err); }) .then(function (data) { return cb(data); }); }

return { fetch<sub>giphy</sub>: fetch<sub>giphy</sub> }

})(config); \`\`\`

I wrote a mocha test for this as well, although I could probably do a lot more in terms of verification:

\`\`\`javascript linenos const expect = require('expect.js');

const config = require('./../../config'); const get<sub>giphy</sub> = require('./../../services/get<sub>giphy</sub>');

describe('get<sub>giphy</sub> tests', function () {

it('returns a json data block', function (done) { get<sub>giphy.fetch</sub><sub>giphy</sub>(['funny', 'cat'], function (data) { console.log("data:",JSON.stringify(data, null, 2)); expect(data).to.be.ok(); done(); }); }); });

\`\`\`


<a id="til-calling-done-to-fire-async-mocha-tests"></a>

## TIL: calling `done` to fire async mocha tests

This particular thing was driving me nuts: I was running the test over and over and could not figure out why it was just running to completion instead of performing the call.

Mocha has an added bit where it passes in a callback to tell it when the asynchronous tests finish. This had completely eluded me, but one of the HackTheGap mentors told me about it, and everything started to work.


<a id="follow-on-thoughts"></a>

## Follow-on thoughts

Although I'm specifying the API settings in a configuration object that gets passed in, I'm not really allowing that to be injected. It would be more helpful, maybe to export just the outer function itself, and let the consumer pass in the configuration, thus allowing injection per environment / use.

I might also roll back to using `superagent` as I like it's way of dealing with building query strings rather nice (just passing in an Object) vs. presently with `fetch` where I'm basically hard-coding strings.

