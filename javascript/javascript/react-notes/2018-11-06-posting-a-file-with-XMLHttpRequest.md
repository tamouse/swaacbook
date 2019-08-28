
# Table of Contents

1.  [RESEARCH: Posting a file with XMLHttpRequest](#org4f739bd)
    1.  [Using FormData](#org402168c)
    2.  [Using Event Handlers](#org8045b4e)
    3.  [Progress Indication](#org0152617)


<a id="org4f739bd"></a>

# RESEARCH: Posting a file with XMLHttpRequest

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-06 Tue 14:26&gt;</span></span>
-   published date: <span class="timestamp-wrapper"><span class="timestamp">[2018-11-06 Tue 13:46]</span></span>
-   keywords: XMLHttpRequest, file upload, JavaScript, research, React

See: [Using nothing but XMLHttpRequest](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Using_XMLHttpRequest#Using_nothing_but_XMLHttpRequest) <&#x2013; maybe not

See: [Using FormData objects](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Using_XMLHttpRequest#Using_FormData_objects) <&#x2013; necessary for files, I think

In contrast to [Posting with Fetch API](./2018-11-06-posting-a-file-with-fetch-api.md), this is a bit lower on the food chain in terms of JS stuff, **but** it lets you get access to `progress` events, for doing such things as displaying a progress bar. Yay.


<a id="org402168c"></a>

## Using FormData

MDN makes a special note:

> Note: As we said, FormData objects are not stringifiable objects. If you want to stringify a submitted data, use the previous pure-AJAX example. Note also that, although in this example there are some file <input> fields, when you submit a form through the FormData API you do not need to use the FileReader API also: files are automatically loaded and uploaded.


<a id="org8045b4e"></a>

## Using Event Handlers

From the top of the page, just using / setting event handlers:

    function reqListener () {
      console.log(this.responseText);
    }
    
    var oReq = new XMLHttpRequest();
    
    // this sets the 'load' event handler, which fires when the file is fully loaded.
    // I think this works for POST/PUT as well...
    oReq.addEventListener("load", reqListener);
    
    oReq.open("GET", "http://www.example.org/example.txt");
    oReq.send();

There's a note [somewhere on the page](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/Using_XMLHttpRequest#Monitoring_progress) saying something about `progress` event handlers needing to be set before the `.open` call.

This would load up all the event handlers for XMLHttpRequest:

    let oReq = new XMLHttpRequest();
    
    oReq.addEventListener("progress", updateProgress);
    oReq.addEventListener("load", transferComplete);
    oReq.addEventListener("error", transferFailed);
    oReq.addEventListener("abort", transferCanceled);
    
    oReq.open();


<a id="org0152617"></a>

## Progress Indication

The `progress` event handler takes in the progress event, which is defined at [WhatWG Progress Event specification](https://xhr.spec.whatwg.org/#interface-progressevent). It has 3 attributes:

-   `lengthComputable` [boolean] whether the length of the object is known
-   `loaded` [number] how much has loaded so far
-   `total` [number] how much there is to load

So progress can be calculated by:

    handleProgress = event => {
        let progress = 0
        if (event.total !== 0) {
    	progress = event.loaded / event.total
        }
        const percentCompleted = progress * 100
        this,setState({ progress, percentCompleted })
    }
    
    handleLoaded = event => {
        this.setState({ progress: 1, percentCompleted: 100, loaded: true })
    }
    
    // ...
    
    request = () => {
    
        const req = new XMLHttpRequest()
    
        req.addEventListener('progress', this.handleProgress)
        req.addEventListener('load', this.handleLoaded)
    
        // ... etc
    }

