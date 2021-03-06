
# Table of Contents

1.  [Fix: Make Mac key repeat work](#fix-make-mac-key-repeat-work)


<a id="fix-make-mac-key-repeat-work"></a>

# Fix: Make Mac key repeat work

-   published date: 2017-09-26T18:42
-   keywords: osx, keyrepeat

This is a quick one, but I'm adding it because I couldn't remember it.

On Macs, the standard way holding down a key on the keyboard works in a text area is to pop up a little menu for selecting international characters.

While this is cool, it's also something that I never really use, while I *do* want to hold down the key to repeat characters.

The System Preferences have all sorts of settings for the keyboard, including setting up repeat-rates, and such things, *however*, there is nothing to turn off the pop-up-on-hold feature, nor is there any indication that it's turned on (or off).

So it turns out to be something you need to run on the command line.

The post at <https://superuser.com/questions/363252/how-to-enable-keyboard-repeat-on-a-mac#363266> holds the info. I'll repeat it here briefly, you can visit the page to see more context and comments.

At the terminal type:

    defaults write -g ApplePressAndHoldEnabled -bool false

You'll have to stop and start any apps you have open in order to see the effect of this. You may as well log out and log back in if you have a lot of them open. (You do *not* need to restart your computer as someone suggests, though of course that will work, too.)

It seems like this value gets reset to Apple's choice of `true` after updates from time to time, so you may need to do this more than once.

