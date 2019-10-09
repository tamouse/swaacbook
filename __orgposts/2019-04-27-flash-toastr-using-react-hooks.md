
# Table of Contents

1.  [FlashToastr React Component using React Hooks](#org63ef46c)
    1.  [First mis-direction](#orgf33c188)
    2.  [Enter Context](#org14f36a1)
    3.  [Storybook View](#org7f6f668)
    4.  [Github Repo](#orgd153f14)



<a id="org63ef46c"></a>

# FlashToastr React Component using React Hooks

Today I set out on a learning journey. I'd been looking at React's Hooks implementation for a bit, but haven't really gone out to make anything.

The app I work on, Kickserv, has a Redux-based Flash message component that used in the new React-based client. It's rather large, and totally over-engineered for the need it's fulfilling.

Roll up with Hooks in React 16.8 getting full support, and I figured it's really time to buckle down and learn them.


<a id="orgf33c188"></a>

## First mis-direction

Initially, I thought I would be able to do this using only `useState` in the hook. This led to a few hours of hair-pulling, the wailing of gnashing of teeth, and a few good swears. It turns out I was missing something really important:

> When you use `useState`, **it's actually creating new state**

This is probably obvious, and it shouldn't need stating, but it was breaking me. See, for the flash message thing, it's treated sort of like a modal, but not really. It needs a context to be able to let a component anywhere within the app be able to submit a flash message to it, and have the little toastr overlay alert show up. In this app, there is only one, they don't stack up like notifications do in other systems, they just show up at the top of the page until dismissed by the user, a la Rails' flash messages.


<a id="org14f36a1"></a>

## Enter Context

What I figured out finally was that I needed a context that would keep state across the app and for the flash components themselves. This turned out to be pretty nifty and solved things quite nicely.

The context holds information on what the flash message is, what level of message it is, and whether the message is showing or not. In addition, it has setters for each of these. The context provider .. erm .. provides them, and the hook picks them up with `useContext`, implements 2 convenience functions for setting/showing the flash, and another for closing it.


<a id="org7f6f668"></a>

## Storybook View

The component is illustrated using storybook, and can be seen at <https://flash_toastr.surge.sh/> .


<a id="orgd153f14"></a>

## Github Repo

The repo containing the code is out at <https://github.com/tamouse/flash_toaster> if you want to play around with it or something.

