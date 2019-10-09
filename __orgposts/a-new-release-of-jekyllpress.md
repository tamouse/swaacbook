
# Table of Contents

1.  [Link: A new release of Jekyllpress](#link-a-new-release-of-jekyllpress)
    1.  [To Install](#to-install)
    2.  [New features](#new-features)
    3.  [Example used to generate this post:](#example-used-to-generate-this-post)
        1.  [Command line](#command-line)
        2.  [new<sub>link.markdown</sub> template](#new_link.markdown-template)


<a id="link-a-new-release-of-jekyllpress"></a>

# Link: A new release of Jekyllpress

-   published date: 2015-03-08 21:14
-   keywords: ["jekyll", "jekyllpress"]
-   source:
-   link: {"href"=>"<https://github.com/tamouse/jekyllpress/releases/tag/v1.0.0>", "title"=>"A new release of Jekyllpress", "date"=>"2015/03/08", "author"=>{"name"=>"Tamara Temple", "url"=>"<https://github.com/tamouse>"}}

I've put out a new release of `Jekyllpress`, my Thor script to help create new jekyll posts and pages.


<a id="to-install"></a>

## To Install

Command line install:

    $ gem install jekyllpress


<a id="new-features"></a>

## New features

-   *&#x2013;url* switch, lets you specify a url to be placed into the template. ERB variable `@url`.

-   *&#x2013;layout* switch, lets you specify a different layout.

-   *&#x2013;template* switch, lets you specify a different document template.

-   `@filename` variable that can be used in the ERB part of a template.


<a id="example-used-to-generate-this-post"></a>

## Example used to generate this post:


<a id="command-line"></a>

### Command line

    $ jekyllpress new_post 'A new release of Jekyllpress' -c jekyll \
    -t jekyllpress jekyll --layout=link --template=new_link.markdown \
    --url=https://github.com/tamouse/jekyllpress/releases/tag/v1.0.0


<a id="new_link.markdown-template"></a>

### new<sub>link.markdown</sub> template

It's just frontmatter.

\`\`\`yaml

