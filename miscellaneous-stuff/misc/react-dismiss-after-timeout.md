
# Table of Contents

1.  [React concept: dismiss after timeout](#org1fc0b23)


<a id="org1fc0b23"></a>

# React concept: dismiss after timeout

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-04 Sun 08:17&gt;</span></span>
-   published date: 2018-10-11
-   keywords: react, dismiss, alert, idea

Over at the [react-bootstrap repo](https://github.com/react-bootstrap/react-bootstrap), there is a pull request to deprecate the `dismissAfter` prop on `Alert` components, and in [this issue](https://github.com/react-bootstrap/react-bootstrap/pull/1636#issuecomment-429085552) the author discusses a workaround if user's still need the capability.

I think generalizing that concept would be a pretty cool thing, and possibly a bit simplification for, say, the debouncer I wrote for work.

