# Stop Compiling Ruby For Provisioning!

* sometime around 2016 maybe? maybe before that
* keywords: devops, provisioning, brightbox, ruby

**Stop! Don’t compile that ruby installation!**

Next time you are setting out to provision a box with Ruby on it, instead of downloading the source and libraries and compiling it, and waiting for 15 minutes, use the pre-built binaries at the [Brightbox](http://www.brightbox.com/):

* Ubuntu: [https://www.brightbox.com/docs/ruby/ubuntu/](https://www.brightbox.com/docs/ruby/ubuntu/)

### In a nutshell:

```text
apt-get install build-essential software-properties-common
apt-add-repository ppa:brightbox.com/ruby-ng
apt-get update && apt-get install ruby2.4 ruby2.4-dev
apt-get install ruby-switch
```

