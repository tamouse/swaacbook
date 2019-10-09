
# Table of Contents

1.  [ScrollStick: a JavaScript module to make scrolling headers sticky](#orgcaf0dfa)
    1.  [Things I had to figure out.](#org2998b19)
        1.  [cloning the header](#org931b2fb)
        2.  [Adding the cloned element to the document](#org7a4cac9)
        3.  [determining the header's offset in the document](#org95d533a)
        4.  [performing the action during scrolling](#org6dddc09)
        5.  [using display instead of visibility property](#orgd42e7bd)
    2.  [Demo](#org06ef489)



<a id="orgcaf0dfa"></a>

# ScrollStick: a JavaScript module to make scrolling headers sticky

-   keywords: scripts, javascript, sticky headers, persistent headers
-   source: [scroll-stick](https://github.com/tamouse/scroll-stick)

I like the way sticky headers work on various web sites I've seen. There are some really interesting implementations where the header changes when it gets to the top of the page, which is fun. I wrote up a JS module called `ScrollSticky` which is out on my GitHub at [scroll-stick](https://github.com/tamouse/scroll-stick)

This is a very simple implementation. The other examples I've looked at tend to all use jQuery, which is great, but I wanted one in plain old JavaScript. It's not really any harder, but there's a lot of stuff that jQuery makes simpler by having the methods defined.


<a id="org2998b19"></a>

## Things I had to figure out.


<a id="org931b2fb"></a>

### cloning the header

This was just a little harder than I thought it would be, and required a lot of playing around to figure out what to do. The result is in the `StickyScroll.cloneTarget` function. Cloning the header was pretty easy, but then I needed to ensure the clone didn't have the same `id` attribute, and needed to acquire some style properties that might not be on the original. To make to actually stick to the top, the top has to be set to zero, positioning needed to be fixed.

    var cln = tgt.cloneNode(true);
    cln.id = '';
    cln.style.top = 0;
    cln.style.position = 'fixed';

The cute part, when you set a block element's position to fixed, it no longer takes up the same width (the width gets calculated to the content box). So I *also* had to set the width property.

Figuring out the actual width took some digging and I found the `offsetWidth` property, but to make it actually work for the style, I needed to specify the measurement, "px".

    cln.style.width = tgt.offsetWidth + "px";


<a id="org7a4cac9"></a>

### Adding the cloned element to the document

I wanted the cloned element to come right after the header element. After a tour through stackoverflow, I found the answer at <http://stackoverflow.com/questions/7258185/javascript-append-child-after-element#7258301> which gave me the nice one-liner:

    tgt.parentNode.insertBefore(cln, tgt.nextSibling);

I made a [jsfiddle to try it out](https://jsfiddle.net/tamouse/m74nx2e5/).


<a id="org95d533a"></a>

### determining the header's offset in the document

In jQuery, there's a nice `.offset` function that gives this, but in POJS, you have to do a bit more. The MDN [explains how to do this](https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect), but doesn't offer code. The resulting code ended up easier than I thought it would be. (Answers from SO were varying.)

    function(el) {
      var rect = el.getBoundingClientRect();
      return rect.top + window.scrollY;
    }


<a id="org6dddc09"></a>

### performing the action during scrolling

I had to play around a lot with this to get it right. I'm not sure all the different things I tried, but eventually figured it out.

    if (document.body.scrollTop > self.fromTop ) {
      self.stickyEl.style.display = self.targetEl.style.display;
    } else {
      self.stickyEl.style.display = 'none';
    }


<a id="orgd42e7bd"></a>

### using display instead of visibility property

One thing I did not figure out, the jQuery versions used the `visibility` CSS property for the sticky header, but what I found happening was the the "roll-under" fix I put it the CSS was not working as I'd want. The invisible sticky header clone would push the anchored element down too far. I ended up switching to use the `display` property instead.


<a id="org06ef489"></a>

## Demo

Here's the demo page:

<div class="HTML">
<iframe src="<https://tamouse.github.io/scroll-stick/>" width="100%" height="300px">
</iframe>

</div>

