
# Table of Contents

1.  [TIL: Fixing a Capybara Problem Scrolling the Submit Button Into View on a Modal Form Test](#orga0889a0)
    1.  [Background](#org6d1c5a5)
    2.  [Problem](#orgde01f96)
    3.  [Solution](#org6ad1c31)
    4.  [Caveats](#org393c30b)

\#+COMMENT -**- time-stamp-line-limit: 12; time-stamp-count: 2 -**-


<a id="orga0889a0"></a>

# TIL: Fixing a Capybara Problem Scrolling the Submit Button Into View on a Modal Form Test

-   last<sub>update</sub>: Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-03-06 Wed 18:44&gt;</span></span>
-   capture<sub>date</sub>: <span class="timestamp-wrapper"><span class="timestamp">[2019-03-06 Wed]</span></span>
-   keywords: testing, capybara, scrolling, modal


<a id="org6d1c5a5"></a>

## Background

In [the product I work on](https://www.kickserv.com/), we have a form to let a user create a new customer during the editing of a job. This form is quite long. In the test, the only required field, the Customer's name, is filled in, and the new customer modal form is submitted.


<a id="orgde01f96"></a>

## Problem

Since the form is so long, the submit button is not visible on the page, so [Capybara](http://teamcapybara.github.io/capybara/) cannot find it to click on it.


<a id="org6ad1c31"></a>

## Solution

Scroll the modal so the submit button comes into view.

If you execute the following line in a Capybara test:

    page.execute_script "window.scrollBy(0,10000)"

it will scroll the window down, however, the modal isn't really sitting inside the window. It's definitely part of the DOM, but we need to scroll the modal itself.

So we grab the **modal DOM element** and tell it to scroll down:

    page.execute_script "document.getElementById('new-customer-modal').scroll(0, 10000)"

which makes the submit button come into view, and then the Capybara `.click` method works.


<a id="org393c30b"></a>

## Caveats

This works when you're using Chrome (visible or headless). It does **not** work in IE11 or lower, nor does it work in Safari mobile.

The same issue can arise when using [NightWatch.js](http://nightwatchjs.org/), with a similar solution to scroll the modal rather than the window.

