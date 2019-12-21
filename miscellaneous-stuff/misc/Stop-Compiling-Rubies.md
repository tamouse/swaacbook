
# Table of Contents

1.  [Stop Compiling Ruby For Provisioning!](#org1479862)
    1.  [In a nutshell:](#org8f4d89c)



<a id="org1479862"></a>

# Stop Compiling Ruby For Provisioning!

-   keywords: devops, provisioning, brightbox, ruby

**Stop! Don't compile that ruby installation!**

Next time you are setting out to provision a box with Ruby on it, instead of downloading the source and libraries and compiling it, and waiting for 15 minutes, use the pre-built binaries at the [Brightbox](http://www.brightbox.com):

-   Ubuntu: <https://www.brightbox.com/docs/ruby/ubuntu/>


<a id="org8f4d89c"></a>

## In a nutshell:

    apt-get install build-essential software-properties-common
    apt-add-repository ppa:brightbox.com/ruby-ng
    apt-get update && apt-get install ruby2.4 ruby2.4-dev
    apt-get install ruby-switch

