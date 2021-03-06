
# Table of Contents

1.  [Multi-File Uploads and Multiple Selects](#multi-file-uploads-and-multiple-selects)


<a id="multi-file-uploads-and-multiple-selects"></a>

# Multi-File Uploads and Multiple Selects

-   published date: 2013-10-22 10:45
-   keywords: ["code", "javascript", "multi-file-uploads", "swaac", "user-experience", "user-feedback", "ux"]
-   source: <http://www.raymondcamden.com/index.cfm/2013/10/1/MultiFile-Uploads-and-Multiple-Selects>

> \*\* [Multi-File Uploads and Multiple Selects](http://www.raymondcamden.com/index.cfm/2013/10/1/MultiFile-Uploads-and-Multiple-Selects)
> 
> :CUSTOM<sub>ID</sub>: multi-file-uploads-and-multiple-selects-1
> 
> **\* 10-01-2013 \***
> 
> A few weeks back I wrote a [blog post](http://www.raymondcamden.com/index.cfm/2013/9/10/Adding-a-file-display-list-to-a-multifile-upload-HTML-control) about adding image previews for multi-file upload controls. I didn't mention it at the time but I had an ulterior motive. A reader wrote to me a few weeks before with an interesting question.
> 
> \#+BEGIN<sub>QUOTE</sub>
>   Is it possible to use a mult-file input control and let the user select multiple times?

To be clear, what we mean here is that the user selects some files and closes the file picker dialog. She then realizes she forgot a few files and clicks to select them next.

What happens in this situation is pretty simple. Like the multiple select field, if you pick something else then the previous selection is removed. Your only option is similar to what you do for the drop down. Use ctrl/cmd to select multiple files in multiple folders all at once - *and don't screw it up!* Obviously most users won't be able to grok this and **will** screw it up, even if they know it is possible.

  But my experiment had given me an idea. Remember that we can use an event handler to detect changes to the input field and get access to the file data beneath. Here is a code snippet showing this:
\#+END<sub>QUOTE</sub>

1.  using an event handler to detect changes in the files input field

        function handleFileSelect(e) {
          if(!e.target.files) return;
          selDiv.innerHTML = "";
          var files = e.target.files;
        
          for(var i=0; i...) {
          }
        }
    
    > Based on this, my [final demo](http://www.raymondcamden.com/demos/2013/sep/10/test0.html) uses this code to create image thumbnails based on pictures you select. My demo has a bug though that meshes well with today's blog post. If you select images twice, the list of thumbnails grow, but the actual files associated with the control are only based on the **last** selection. But what if we could take those files and store them?
    > 
    > Before I went down this route, I updated my demo code to use AJAX to post the form. Part of the benefits of XHR2 is the ability to send file data over the wire. Let's look at a simple example of this.

2.  demo for multiple file select handling

        <!doctype html>
        <html>
          <head>
            <title>Proper Title</title>
            <style>
              #selectedFiles img {
              max-width: 200px;
              max-height: 200px;
              float: left;
              margin-bottom:10px;
              }
            </style>
          </head>
        
          <body>
        
            <form id="myForm" method="post">
        
              Files: <input type="file" id="files" name="files" multiple><br/>
        
              <div id="selectedFiles"></div>
        
              <input type="submit">
            </form>
        
            <script>
        var selDiv = "";
        
        document.addEventListener("DOMContentLoaded", init, false);
        
        function init() {
          document.querySelector('#files').addEventListener('change', handleFileSelect, false);
          selDiv = document.querySelector("#selectedFiles");
          document.querySelector('#myForm').addEventListener('submit', handleForm, false);
        }
        
        function handleFileSelect(e) {
          var files = e.target.files;
          for(var i=0; i<files.length; i++) {
            var f = files[i];
            if(!f.type.match("image.*")) {
              continue;
            }
        
            var reader = new FileReader();
            reader.onload = function (e) {
              var html = "<img src=\"" + e.target.result + "\">" + f.name + "<br clear=\"left\"/>";
              selDiv.innerHTML += html;
        
            }
        
            reader.readAsDataURL(f);
          }
        
        }
        
        function handleForm(e) {
          e.preventDefault();
          console.log('handleForm');
          var data = new FormData(document.querySelector('#myForm'));
        
          var xhr = new XMLHttpRequest();
          xhr.open('POST', 'handler.cfm', true);
        
          xhr.onload = function(e) {
            if(this.status == 200) {
              console.log('onload called');
              console.log(e.currentTarget.responseText);
        
            }
          }
        
          xhr.send(data);
        }
        
            </script>
        
          </body>
        </html>
    
    > If we focus on the changes, the only real difference is that we have a submit handler for the form. We use a FormData object to package up our form and then post it to a server-side handler. The server-side code isn't terribly important. It doesn't see this as anything "special" or "Ajax-y" (my word), it is just a form post. But now the entire process runs through Ajax and not a traditional page reload. (And as a note, I'm not providing **any** user feedback here. In a real application I'd disable the submit button, tell the user something, etc etc.)
    
    > That parts done, now let's try storing a copy of the files. Here is my updated version with this in action.

3.  storing the files

        <!doctype html>
        <html>
          <head>
            <title>Proper Title</title>
            <style>
              #selectedFiles img {
              max-width: 200px;
              max-height: 200px;
              float: left;
              margin-bottom:10px;
              }
            </style>
          </head>
        
          <body>
        
            <form id="myForm" method="post">
        
              Files: <input type="file" id="files" name="files" multiple><br/>
        
              <div id="selectedFiles"></div>
        
              <input type="submit">
            </form>
        
            <script>
        var selDiv = "";
        var storedFiles = [];
        
        document.addEventListener("DOMContentLoaded", init, false);
        
        function init() {
          document.querySelector('#files').addEventListener('change', handleFileSelect, false);
          selDiv = document.querySelector("#selectedFiles");
          document.querySelector('#myForm').addEventListener('submit', handleForm, false);
        }
        
        function handleFileSelect(e) {
          var files = e.target.files;
          for(var i=0; i<files.length; i++) {
            var f = files[i];
            if(!f.type.match("image.*")) {
              continue;
            }
            storedFiles.push(f);
        
            var reader = new FileReader();
            reader.onload = function (e) {
              var html = "<img src=\"" + e.target.result + "\">" + f.name + "<br clear=\"left\"/>";
              selDiv.innerHTML += html;
        
            }
            reader.readAsDataURL(f);
          }
        
        }
        
        function handleForm(e) {
          e.preventDefault();
          var data = new FormData();
        
          for(var i=0, len=storedFiles.length; i<len; i++) {
            data.append('files', storedFiles[i]);
          }
        
          var xhr = new XMLHttpRequest();
          xhr.open('POST', 'handler.cfm', true);
        
          xhr.onload = function(e) {
            if(this.status == 200) {
              console.log(e.currentTarget.responseText);
              alert(e.currentTarget.responseText + ' items uploaded.');
            }
          }
        
          xhr.send(data);
        }
            </script>
        
          </body>
        </html>
    
    > The changes are pretty simple. I've got a new global variable called storedFiles. When I detect a change on the input field, I now push them into this array. Finally, when the form is submitted, instead of pre-populating the FormData object we create it empty and then simply append our files. Note the append call uses the same name, files, so that when the server processes it the name is consistent.
    > 
    > And&#x2026; believe it or not - this worked. This smells like it may be a slight security concern. I have to imagine that if browser vendors allow for this then it must be safe, but if I used this in production, I'd be **real** sure to let the end user know what is going on. As I said my previous demo actually *implied* it was doing this anyway. (I should have been clearing out my thumbnails when you selected files.) I think in that case the user would have expected it.
    > 
    > \*\* Related Blog Entries
    > 
    > :CUSTOM<sub>ID</sub>: related-blog-entries
    > 
    > -   [Adding a file display list to a multi-file upload HTML control](http://www.raymondcamden.com/index.cfm/2013/9/10/Adding-a-file-display-list-to-a-multifile-upload-HTML-control) (September 10, 2013)

