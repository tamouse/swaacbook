# TIL: Adding a new HTML tag name when creating a React Portal

* keywords: react, portal, html, tag names
* capture date: Mon Jan 21 16:49:12 2019
* last updated: Time-stamp: &lt;2019-01-21 Mon 17:06&gt;

I was working on a replacement for the `Modal` component in `react-bootstrap` since it is clear the library is moving away from where we want to be with our app.

While doing so, I noticed it was difficult to find the Portal that react creates in the DOM tree, since I was using just a regular old `<div>` element. Given in HTML5 you can invent your own HTML tag names \(which Web Components and CSS Components take advantage of as well\).

So I called the created element `<modal-portal>` and it's quite visible when it shows up in the DOM, and it makes an easy grab handle for testing.

In my `ModalPortal` component, the code looks like this:

```text
constructor(props) {
  super(props)
  this.el = document.createElement("modal-portal")
  this.modalRoot = document.querySelector(this.props.selector || "body")
}
```

In the DOM, the component looks like this:

```text
<modal-portal>
  <div class="modal fade in" style="display: block;">...</div>
</modal-portal>
```

