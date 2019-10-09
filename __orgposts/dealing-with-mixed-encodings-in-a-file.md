
# Table of Contents

1.  [Dealing with mixed encodings in a file](#dealing-with-mixed-encodings-in-a-file)
    1.  [The Problem](#the-problem)
    2.  [Ruby solution](#ruby-solution)


<a id="dealing-with-mixed-encodings-in-a-file"></a>

# Dealing with mixed encodings in a file

-   published date: 2014-11-02 15:12
-   keywords: ["character-sets", "encoding", "ruby", "swaac"]
-   source:

What can you do when a file contains strings with mixed character set encodings?

I recently was working on a Rails application and had to deal with a data file that contained strings with different encodings. Each line was internally consistent, however, one line might be in ISO-8859-1, while another might be in UTF-8. This is how I solved the problem in Ruby and PHP.


<a id="the-problem"></a>

## The Problem

The data file was a collection of quotes that were submitted by patrons of an IRC channel. The person who implemented the quote collector decided to use the Pilcrow, "¶", as the internal line separator for multi-line quotes. This sounded like a good idea; the pilcrow being the international mark for a paragraph and all.

The problem is that pilcrow occupies different codebases on different character sets. For several people submitting quotes, from an older windows-based irc client, the character set used is ISO-8859-1. For other people, using more recent clients, UTF-8 is the standard.

The result was that the pilcrow would appear in the file in two ways:

-   0xB6 - a single byte character as per ISO-8859-1
-   0x00B6 - a two-byte character as per UTF-8

<div class="HTML">
<table width="80%" cellspacing="2px" cellpadding="5px" border="1" style="border-collapse: collapse;">

</div>

<div class="HTML">
<thead>

</div>

<div class="HTML">
<tr>

</div>

<div class="HTML">
<th width="20%">

</div>

Charset

<div class="HTML">
</th>

</div>

<div class="HTML">
<th>

</div>

Example

<div class="HTML">
</th>

</div>

<div class="HTML">
</tr>

</div>

<div class="HTML">
</thead>

</div>

<div class="HTML">
<tfoot>

</div>

<div class="HTML">
</tfoot>

</div>

<div class="HTML">
<tbody>

</div>

<div class="HTML">
<tr>

</div>

<div class="HTML">
<td>

</div>

ISO-8859-1:

<div class="HTML">
</td>

</div>

<div class="HTML">
<td>

</div>

"<orangejuice> Clive Anderson was nervous as hell.\xB6<kbeetl> No, he was British.\xB6<kbeetl> It's subtle, but there's a difference.\n"

<div class="HTML">
</td>

</div>

<div class="HTML">
</tr>

</div>

<div class="HTML">
<tr>

</div>

<div class="HTML">
<td>

</div>

UTF-8:

<div class="HTML">
</td>

</div>

<div class="HTML">
<td>

</div>

"<MildBill> What's odd?¶<FreeTrav> About half of the natural numbers.\n"

<div class="HTML">
</td>

</div>

<div class="HTML">
</tr>

</div>

<div class="HTML">
</tbody>

</div>

<div class="HTML">
</table>

</div>


<a id="ruby-solution"></a>

## Ruby solution

Ruby by default reads files in UTF-8. The resulting array of strings in the file, thus, will have different encodings. To test what a particular string is encoded as, you need to do the following construction:

    s.force_encoding(encoding).valid_encoding?

where encoding is the name of the character set you are testing.

So we end up with this sort of thing:

    # get the source file
    quotes.collect! do |q|
      if q.force_encoding("UTF-8").valid_encoding?
        q.gsub!(/¶/, "\n")
      else
        q = q.force_encoding("ISO-8859-1").
          gsub(/#{0xb6.chr.force_encoding("ISO-8859-1")}/, "\n")
      end
      q
    end

