
# Table of Contents

1.  [Link: Decorating ActiveRecord](#link-decorating-activerecord)


<a id="link-decorating-activerecord"></a>

# Link: Decorating ActiveRecord

-   published date: 2017-04-06 23:01
-   keywords: ["activerecord", "decorators", "links", "rails", "tl-dr"]
-   source: <https://robots.thoughtbot.com/decorating-activerecord>

This came across my path this week: [Joël Quenneville](https://robots.thoughtbot.com/authors/joel-quenneville)'s article, [Decorating ActiveRecord](https://robots.thoughtbot.com/decorating-activerecord), which outlines some hazards when you go about decorating ActiveRecord models.

Do read the article, it's good.

---

Here's the tl;dr for my memory:

> If you're decorating an ActiveRecord or ActiveModel object in Rails, you probably want to define the following to ensure the decorator works the way you expect instead of silently delegating to the underlying object:

<div class="HTML">
<blockquote>

</div>

\`\`\`ruby linenos class Profile < SimpleDelegator extend ActiveModel::Naming

def to<sub>model</sub> self end end \`\`\`

<div class="HTML">
</blockquote>

</div>

