
# Table of Contents

1.  [Fascinating article pushing the boundaries on CSS design](#fascinating-article-pushing-the-boundaries-on-css-design)


<a id="fascinating-article-pushing-the-boundaries-on-css-design"></a>

# Fascinating article pushing the boundaries on CSS design

-   published date: 2013-11-13 18:54
-   keywords: ["css", "howtos", "swaac", "web-design"]
-   source:
-   redirect<sub>from</sub>: ["*blog/2013/11/13/fascinating-article-pushing-the-boundaries-on-css-design*"]

Over on her blog, [Sara Soueidan](http://sarasoueidan.com/blog/css-shapes/) writes about creating non-rectangular (!!) layouts using **CSS Shapes**.

> \*\* Declaring Shapes
> 
> :CUSTOM<sub>ID</sub>: declaring-shapes
> 
> All HTML elements have a rectangular box model which governs the flow of content inside and around it. In order to give an element a custom non-rectangular shape, the shape-inside and shape-outside properties are used. At the time of writing of this article, the shape-outside property can be applied to floating elements only, and the shape-inside property isn't completely implemented, so you may still find bugs when u use it. The `shape-*` properties can also only be applied to block-level elements. Non-block-level elements should be forced to block if you want to use a shape property on them.
> 
> `Shape-*` properties take one of three values: `auto`, a basic shape, or an image URI. If the value is set to auto, the element's float area uses the margin box as normal. (If you're not familiar with the CSS box model, make sure you read up on it because you should know how it works).

> If the value is set to a shape function, then the shape is computed based on the values of one of 'rectangle', 'inset-rectangle', 'circle', 'ellipse' or 'polygon'. You can learn more about each of these functions in this article by the Adobe Platform team.

