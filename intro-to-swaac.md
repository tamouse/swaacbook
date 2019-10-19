---
description: My devblog takes another turn. How will this one turn out?
---

# Introduction to this edition of my dev blog swaac.dev

Over the years, I've been keeping notes and writing things down about stuff I've learned, stuff I want to share, and so on. In the never-ending quest to learn new things, I've also re-organized and repurposed this collection so many times.

**A caveat**: this collection of notes is largely personal learning; it is by no means authoritative, canonical, complete, or even necessarily accurate. These are notes that represent the best of my understanding and my own understanding at the time I captured them. If you find something wrong, confusing, or want to ask a question, leave a comment, please!



## colophon

Hat tip for the idea to use [Gitbook](https://gitbook.com) to [https://dev.to/maxwell\_dev](https://dev.to/maxwell_dev) [Max Antolucci](https://dev.to/maxwell_dev) over at [https://dev.to](https://dev.to) with their article [How To Take Notes on Everything](https://dev.to/maxwell_dev/how-to-take-notes-on-everything-32fc)!

It takes a bit to get the rhythm of using gitbook from a standard editor \(such as emacs\) and using the standard git dance to update the site. The way that gitbook expects things to be structured takes some getting used to. The hardest part for me also was just understanding how certain things work differently in gitbook's online editor and my usual use of markdown. Finally, keeping the summary file \(really the site map\) up to date with all the additions and changes has been hard. I think I have the hang of things, now, and it like it very much!

## Adding a new top-level section to the book

Here's what I've figured out:

* make the segment directory, then make a duplicate of that below it, then put the README in the lowest level. E.g.: `databases/databases/README.md`
* add it to the `SUMMARY.md` file:

  ```text
    ## databases ##

    * [Notes on databases](databases/databases/README.md)
      * [First article on databases](databases/databases/rigamarole.md)
  ```

* Only put the first level header in the `README.md` file, so it will show the articles in the new section.

