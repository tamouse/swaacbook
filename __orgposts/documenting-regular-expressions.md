
# Table of Contents

1.  [Documenting Regular Expressions](#documenting-regular-expressions)
    1.  [PCRE modifiers](#pcre-modifiers)
    2.  [Enter the **x** modifier](#enter-the-x-modifier)
    3.  [Language Implementations](#language-implementations)


<a id="documenting-regular-expressions"></a>

# Documenting Regular Expressions

-   published date: 2014-11-02 15:35
-   keywords: ["documentation", "regexp", "swaac"]
-   source:
-   subtitle: Utilizing the x modifier in order to enable well-documented regular expressions

Regular Expressions (commonly referred to as 'regexes') can be highly opaque voodunesque constructions that often are difficult to decipher and thus modify when the time comes. Regexes seem to be a black art to many people, and something that takes a while to understand and master. Documenting regexes is something practically no one does, yet could be so helpful for many people.


<a id="pcre-modifiers"></a>

## PCRE modifiers

[PCRE](http://pcre.org) (Perl Compatible Regular Expressions) has several modifiers that do various things to the action of the regex. These are the ones defined for PCRE:

-   **i:** make the match case insensitive
-   **m:** multiline
-   **s:** dot matches newlines
-   **x:** ignore white spaces in specification


<a id="enter-the-x-modifier"></a>

## Enter the **x** modifier

The **x** modifier is where we can take advantage of the regex ignoring white space between pattern elements to beautify the regex and insert comments.

    $is_blank_re = qr{^\s*$};

The above regex is quite simple, most people should understand it well enough. But for illustration, let's break this up a bit, beautify it, and add some comments:

    $is_blank_re =
        qr{
           ^                    # match the beginning of the string
           \s*                  # match zero or more white spaces
           $                    # match the end of the string
          }x;

This at least makes it clearer what each element of the regex *is* and what it *does*. Using the regex defined is the same in either case:

In `perl`:

    while ($line = <STDIN>) {
        next if ( $line =~ m{$is_blank_re} );
        # process the line
    }

Similarly, in `ruby`:

    is_blank = %r{
      ^       # matches beginning of line
      \s*     # match zero or more white spaces
      $       # match end of the line
    }x
    
    STDIN.each_line do |line|
      next if line.match is_blank
      # ... process the line
    end


<a id="language-implementations"></a>

## Language Implementations

-   [PCRE](http://pcre.org)
-   [Perl](http://perldoc.perl.org/perlre.html)
-   [PHP](http://us3.php.net/manual/en/reference.pcre.pattern.modifiers.php)
-   [Ruby](http://ruby-doc.org/core-2.1.4/Regexp.html#class-Regexp-label-Options)

