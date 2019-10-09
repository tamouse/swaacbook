
# Table of Contents

1.  [TIL: jQuery .attr() vs .prop()](#org8fa7d07)
    1.  [Intro](#org6bbfd85)
    2.  [Radio Button example](#org636797d)

\#+COMMENT -**- time-stamp-line-limit: 20; time-stamp-count: 2 -**-


<a id="org8fa7d07"></a>

# TIL: jQuery .attr() vs .prop()

-   last update: Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2019-05-02 Thu 08:14&gt;</span></span>


<a id="org6bbfd85"></a>

## Intro

Sometime in the past, jQuery only had an `.attr()` method for looking at and setting an element's attributes. More recently, it acquired the `.prop()` method for setting a node's properties.


<a id="org636797d"></a>

## Radio Button example

The problem I ran into this with was old code that dealt with toggling radio buttons on a form:

    $('#customer_which_billing_address_service').attr('checked', true);

This would set the sense of the attribute in the source, but it wouldn't change the property, so the radio button remained unchecked visually; in addition, when the form was submitted the radio buttons set didn't get posted correctly.

Changing this to the `.prop()` method fixed both problems:

    $('#customer_which_billing_address_parent').prop('checked', false);
    $('#customer_which_billing_address_service').prop('checked', true);

This visually set the proper radio button, and when the form was submitted the correct radio button value was posted.

