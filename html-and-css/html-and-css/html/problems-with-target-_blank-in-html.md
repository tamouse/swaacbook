# Explain: Problems with target=\_blank in HTML

There is a security issue in HTML's anchor tags `<a>` where the `target="_blank"` attribute is used.

This opens up the new page to exploits from `window.openner`

See: [https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a\#Security\_and\_privacy\_concerns](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#Security_and_privacy_concerns) for a quick notice of the problem. That section refers to this article for an explanation: [https://www.jitbit.com/alexblog/256-targetblank---the-most-underestimated-vulnerability-ever/](https://www.jitbit.com/alexblog/256-targetblank---the-most-underestimated-vulnerability-ever/)

So the rule seems to be:

**Always add `rel="noopener noreferrer"` to anchor tags where you also have `target="_blank"`.** 

## TIL: target="\_blank" with no rel="noopener"

* published date: 2016-11-26 14:05
* keywords: \["html", "security"\]

In yesterday's CSS-Tricks column [Random Interesting Facts on HTMLSVG usage CSS-Tricks](https://css-tricks.com/random-interesting-facts-htmlsvg-usage/), Catalin Rosu explains something I'd never heard before, and it can be pretty important:

> target=\_blank w/ or w/o rel=noopener

> 43,924,869 of the anchors we analyzed are using target="\_blank" without a rel="noopener" conjunction. In this case, if rel="noopener" is missing, you are leaving your users open to a phishing attack and it's considered a security vulnerability.

> MDN:

> > When using target you should consider adding rel="noopener noreferrer" to avoid exploitation of the window.opener API.

> [Ben Halpern](https://dev.to/ben/the-targetblank-vulnerability-by-example) and [Mathias Bynens](https://mathiasbynens.github.io/rel-noopener/) also wrote some good articles on this matter and the common advice is: don’t use target=\_blank, unless you have good reasons.

I may need to rethink how I often I use `target="_blank"`. Lately I've been creating slide presentations using `reveal.js` and I include links in the slide show; I think it's easier for students if I open up a new tab rather than interrupting the flow of the slide show.

I think for those, I'll go ahead an add the recommended `rel="noopener noreferrer"`. But elsewhere, I'll consider curtailing my use of `target="_blank"`

