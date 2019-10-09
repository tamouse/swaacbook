
# Table of Contents

1.  [snippet: getting the end of the month in ruby](#snippet-getting-the-end-of-the-month-in-ruby)


<a id="snippet-getting-the-end-of-the-month-in-ruby"></a>

# snippet: getting the end of the month in ruby

-   published date: 2015-05-22 06:45
-   keywords: ["dates", "ruby", "snippet", "snippets"]
-   source:

You can easily get the end of the month, or end of the year, via sending in a negative 1 to the various date and time constructors:

    # Last day of 2015
    Date.new(2015,12,-1).to_s #=> "2015-12-31"
    
    # Last minute of 2015
    DateTime.new(2015,-1,-1,23,-1).to_s #=> "2015-12-31T23:59:00+00:00"

*Note:* this does not work with `Time.new`.

