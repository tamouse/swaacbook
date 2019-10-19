# How to: Creating verse with kramdown

Post date: 2019-05-17

In the past, when I've wanted to create a verse, perhaps in a blockquote I've resorted to using `<br>` on every line, which is tedious:

```text
> Listen, little children, all,<br>
> Listen to our earnest call:<br>
> You are very young, 'tis true,<br>
> But there's much that you can do.<br>
> Even you can plead with men<br>
> That they buy not slaves again,<br>
> And that those they have may be<br>
> Quickly set at liberty.<br>
```

In `kramdown`, the defauflt markdown processor in [Jekyll](https://jekyllrb.com) these days, there's an easier way:

```text
> Listen, little children, all,
> Listen to our earnest call:
> You are very young, 'tis true,
> But there's much that you can do.
> Even you can plead with men
> That they buy not slaves again,
> And that those they have may be
> Quickly set at liberty.
{: style="white-space: pre-line"}
```

See: [https://kramdown.gettalong.org/quickref.html\#block-attributes](https://kramdown.gettalong.org/quickref.html#block-attributes)

Keywords: kramdown, markdown, jekyll, verse

