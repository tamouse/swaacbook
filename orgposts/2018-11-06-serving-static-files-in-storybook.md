
# Table of Contents

1.  [<span class="timestamp-wrapper"><span class="timestamp">[2018-11-06 Tue 08:40] </span></span> TIL: serving static files in storybook](#org7cf5f17)


<a id="org7cf5f17"></a>

# <span class="timestamp-wrapper"><span class="timestamp">[2018-11-06 Tue 08:40] </span></span> TIL: serving static files in storybook

-   last<sub>update</sub>: Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-06 Tue 08:56&gt;</span></span>
-   capture<sub>date</sub>: <span class="timestamp-wrapper"><span class="timestamp">[2018-11-06 Tue 08:40]</span></span>
-   keywords: storybook, test data, static assets

I wish I'd known about this before taking all that time to munge the test data the first time. It turns out storybook can serve up static assets by providing the `-s` option on the command line:

    start-storybook -p 9009 -s ./path/to/static/assets -c .storybook/config.js

You can have more than one folder as well, separating them by commas

    start-storybook -p 9009 -s ./some/assets,./other/assets,./these/assets/over/here -c .storybook/config.js

This makes them available at the root URL

    http://localhost:9009/

So if you have assets at `./src/components/AttachmentList/__TEST_DATA__/attachments/`, for example, `shasta/32/original/002.jpg`, then the URL would be:

    http://localhost:9009/shasta/32/original/002.jpg

And even more importantly, they can be referred to relatively even without the scheme and host.

