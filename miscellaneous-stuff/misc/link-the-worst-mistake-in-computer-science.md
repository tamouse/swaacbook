
# Table of Contents

1.  [Link: The Worst Mistake In Computer Science](#link-the-worst-mistake-in-computer-science)


<a id="link-the-worst-mistake-in-computer-science"></a>

# Link: The Worst Mistake In Computer Science

-   published date: 2015-09-02 10:07
-   keywords: ["null", "programming"]
-   source: <https://www.lucidchart.com/techblog/2015/08/31/the-worst-mistake-of-computer-science/>

Using Ruby on Rails, I am constantly frustrated by things which might be nil, and having to construct such awful sequences as:

    @order.try(:user).try(:name) || "anonymous"

Here's an article explaning the origin of the debacle.

-   [The worst mistake of computer science - Lucidchart](https://www.lucidchart.com/techblog/2015/08/31/the-worst-mistake-of-computer-science/)

<div class="HTML">
<blockquote>

</div>

I call it my billion-dollar mistake&#x2026;At that time, I was designing the first comprehensive type system for references in an object-oriented language. My goal was to ensure that all use of references should be absolutely safe, with checking performed automatically by the compiler. But I couldn't resist the temptation to put in a null reference, simply because it was so easy to implement. This has led to innumerable errors, vulnerabilities, and system crashes, which have probably caused a billion dollars of pain and damage in the last forty years.

<div class="HTML">
<footer>

</div>

Tony Hoare, inventor of ALGOL W.

<div class="HTML">
</footer>

</div>

<div class="HTML">
</blockquote>

</div>

