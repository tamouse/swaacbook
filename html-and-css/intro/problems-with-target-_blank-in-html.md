# Problems with target=\_blank in HTML

There is a security issue in HTML's anchor tags `<a>` where the `target="_blank"` attribute is used.

This opens up the new page to exploits from `window.openner`

See: [https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a\#Security\_and\_privacy\_concerns](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a#Security_and_privacy_concerns) for a quick notice of the problem. That section refers to this article for an explanation: [https://www.jitbit.com/alexblog/256-targetblank---the-most-underestimated-vulnerability-ever/](https://www.jitbit.com/alexblog/256-targetblank---the-most-underestimated-vulnerability-ever/)

So the rule seems to be:

**Always add `rel="noopener noreferrer"` to anchor tags where you also have `target="_blank"`.** 



