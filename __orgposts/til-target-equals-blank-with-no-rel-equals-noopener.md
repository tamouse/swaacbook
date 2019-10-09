
# Table of Contents

1.  [TIL: target="<sub>blank</sub>" with no rel="noopener"](#til-target_blank-with-no-relnoopener)


<a id="til-target_blank-with-no-relnoopener"></a>

# TIL: target="<sub>blank</sub>" with no rel="noopener"

-   published date: 2016-11-26 14:05
-   keywords: ["html", "security"]
-   source: URL

In yesterdays CSS-Tricks column [Random Interesting Facts on HTMLSVG usage CSS-Tricks](https://css-tricks.com/random-interesting-facts-htmlsvg-usage/), Catalin Rosu explains something I'd never heard before, and it can be pretty important:

> target=<sub>blank</sub> w/ or w/o rel=noopener

> 43,924,869 of the anchors we analyzed are using target="<sub>blank</sub>" without a rel="noopener" conjunction. In this case, if rel="noopener" is missing, you are leaving your users open to a phishing attack and it's considered a security vulnerability.

> 
> 
> <p class="verse">
> Anchor/Link | Count|<br />
> </p>
> 
> <table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">
> 
> 
> <colgroup>
> <col  class="org-left" />
> 
> <col  class="org-left" />
> 
> <col  class="org-left" />
> 
> <col  class="org-left" />
> 
> <col  class="org-left" />
> 
> <col  class="org-left" />
> 
> <col  class="org-left" />
> 
> <col  class="org-left" />
> 
> <col  class="org-left" />
> 
> <col  class="org-left" />
> 
> <col  class="org-left" />
> </colgroup>
> <tbody>
> <tr>
> <td class="org-left"><del>-----------</del></td>
> <td class="org-left">&#x2013;&#x2014;+</td>
> <td class="org-left">&#xa0;</td>
> <td class="org-left">[target=<sub>blank</sub>]</td>
> <td class="org-left">43,924,869</td>
> <td class="org-left">&#xa0;</td>
> <td class="org-left">[rel=noopener]</td>
> <td class="org-left">40,756</td>
> <td class="org-left">&#xa0;</td>
> <td class="org-left">[target=<sub>blank</sub>][rel=noopener]</td>
> <td class="org-left">35,604</td>
> </tr>
> </tbody>
> </table>

> MDN:

> 
> 
> \#+BEGIN<sub>QUOTE</sub>
>   When using target you should consider adding rel="noopener noreferrer" to avoid exploitation of the window.opener API.

\#+END<sub>QUOTE</sub>

> [Ben Halpern](https://dev.to/ben/the-targetblank-vulnerability-by-example) and [Mathias Bynens](https://mathiasbynens.github.io/rel-noopener/) also wrote some good articles on this matter and the common advice is: don't use target=<sub>blank</sub>, unless you have good reasons.

I may need to rethink how I often I use `target`"<sub>blank</sub>"`. Lately I've been creating slide presentations using =reveal.js` and I include links in the slide show; I think it's easier for students if I open up a new tab rather than interrupting the flow of the slide show.

I think for those, I'll go ahead an add the recommended `rel`"noopener noreferrer"`. But elsewhere, I'll consider curtailing my use of =target`"<sub>blank</sub>"=

