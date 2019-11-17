# Link: A new release of Jekyllpress

* published date: 2015-03-08 21:14
* keywords: \[“jekyll”, “jekyllpress”\]
* link: [https://github._com_/tamouse/jekyllpress/releases/tag/v1.0.0](https://github.com/tamouse/jekyllpress/releases/tag/v1.0.0)

I’ve put out a new release of `Jekyllpress`, my Thor script to help create new jekyll posts and pages.

### To Install

Command line install:

```text
$ gem install jekyllpress
```

### New features

* –url switch, lets you specify a url to be placed into the template. ERB variable `@url`.
* –layout switch, lets you specify a different layout.
* –template switch, lets you specify a different document template.
* `@filename` variable that can be used in the ERB part of a template.

### Example used to generate this post:

#### Command line

```text
$ jekyllpress new_post 'A new release of Jekyllpress' -c jekyll \
-t jekyllpress jekyll --layout=link --template=new_link.markdown \
--url=https://github.com/tamouse/jekyllpress/releases/tag/v1.0.0
```

#### new\_link.markdown template

It’s just frontmatter.

“\`yaml

