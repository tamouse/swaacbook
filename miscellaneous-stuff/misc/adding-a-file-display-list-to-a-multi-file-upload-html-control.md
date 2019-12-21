
# Table of Contents

1.  [Adding a file display list to a multi-file upload HTML control](#org9790998)
    1.  [TL;DR: when you want to upload multiple files](#orgce1a594)
        1.  [For example](#orgd218dd2)
        2.  [Funging the display](#org9923436)



<a id="org9790998"></a>

# Adding a file display list to a multi-file upload HTML control

-   published date: 2013-10-22 11:08
-   keywords: ["code", "display", "file-uploads", "javascript", "swaac", "user-experience", "user-feedback", "ux"]
-   source: <https://www.raymondcamden.com/2013/09/10/Adding-a-file-display-list-to-a-multifile-upload-HTML-control>


<a id="orgce1a594"></a>

## TL;DR: when you want to upload multiple files

&#x2026; add a `multiple` attribute to the `input type="file"` element.


<a id="orgd218dd2"></a>

### For example

    <input type="file" name="uploads" id="uploads" multiple />


<a id="org9923436"></a>

### Funging the display

The post further disusses the usability hit with the lack of indication what files have been selected and how to fix it up with some CSS and JavaScript.

