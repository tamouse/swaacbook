
# Table of Contents

1.  [How to reset iOS simulator](#org4582822)



<a id="org4582822"></a>

# How to reset iOS simulator

I ran into an issue recently where I was trying to debug a problem in a project, but had a problem accessing the right data server since I was logged into a local development server, and really needed to get back to the "new app" state.

I searched for "reset xcode simulator" via DDG and first hit came up with <https://stackoverflow.com/questions/16195859/reset-ios-simulator-application-data-to-run-app-for-first-time#16195931> which gave me an answer.

The command line versions work, but it can be a pain to get the UDID for the simulator. Doing it from the running simulator was easier, but of course the menu options are different than discussed in the stackoverflow answer.

I found it on the Simulator (Version 10.0 (SimulatorApp-835.2.1) seen in the following screen shot:

![img](../../../images/reset-ios-simulator.png "Reset IOS Simulator Screenshot")

