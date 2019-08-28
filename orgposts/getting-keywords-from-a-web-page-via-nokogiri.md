
# Table of Contents

1.  [Getting keywords from a web page via Nokogiri](#getting-keywords-from-a-web-page-via-nokogiri)
    1.  [Script](#script)
    2.  [Output](#output)


<a id="getting-keywords-from-a-web-page-via-nokogiri"></a>

# Getting keywords from a web page via Nokogiri

-   published date: 2013-08-29 20:15
-   keywords: ["nokogiri", "ruby", "scraping", "swaac"]
-   source:

A snippet.

<div class="HTML">
<!&#x2013;more&#x2013;>

</div>

In order to scrape the keywords from a web page using Nokigiri (to, for example, add to categories of a Jekyll page) is straight-forward, it turns out.


<a id="script"></a>

## Script

    require 'open-uri'
    require 'nokogiri'
    
    url="http://wiki.tamaratemple.com/"
    content=Nokogiri::HTML(open(url))
    keywords=content.search('//meta[@name="keywords"]').attr('content').value
    puts keywords


<a id="output"></a>

## Output

    $ ruby keywords-from-url.rb 
    Tamara Temple, Wiki, TamWiki

