
# Table of Contents

1.  [How I Set Up my Local WordPress Development Environment Using Vagrant and Ansible](#how-i-set-up-my-local-wordpress-development-environment-using-vagrant-and-ansible)
    1.  [Starting Point](#starting-point)
    2.  [Prerequisites](#prerequisites)
        1.  [Available Software](#available-software)
    3.  [Steps to Get Things Set Up](#steps-to-get-things-set-up)
        1.  [Create a project folder and initialize it](#create-a-project-folder-and-initialize-it)
        2.  [Run `vagrant init`](#run-vagrant-init)
        3.  [Modify `Vagrantfile` for my needs](#modify-vagrantfile-for-my-needs)
        4.  [Make a git savepoint](#make-a-git-savepoint)
        5.  [Create the Anisble Playbook](#create-the-anisble-playbook)
        6.  [Top level playbook](#top-level-playbook)


<a id="how-i-set-up-my-local-wordpress-development-environment-using-vagrant-and-ansible"></a>

# How I Set Up my Local WordPress Development Environment Using Vagrant and Ansible

-   published date: 2017-02-11 22:17
-   keywords: ["ansible", "local", "sandbox", "vagrant", "wordpress"]
-   source: <https://github.com/tamouse/sandbox.wp.local>

As part of my volunteering with [GDI Minneapolis](https://gdiminneapolis.com), I've been getting back into WordPress development (child themes, custom themes, etc.), while TAing, teaching, and helping develop some classes. One of the key things we want to show students is how to develop their sites safely and learn the trade of software development in the WordPress environment.

There are several ways one can do this. There are some really *excellent* tools out there now that make this a snap for people not versed in setting things up themselves.

-   [Local by Flywheel](https://local.getflywheel.com)
-   [DesktopServer from ServerPress](https://serverpress.com/get-desktopserver/)

There are also traditional ways of installing [MAMP](https://www.mamp.info/en/) on MacOSx, or using a [Turnkey Linux WordPress Appliance](https://www.turnkeylinux.org/wordpress), and so many other ways.

This is how I set up my local environment using two tools I use heavily in other areas of web development:

-   [Vagrant](https://www.vagrantup.com/)
-   [Ansible](https://www.ansible.com/)

---

First off, this is going to be less of a tutorial and more a description of what I'm doing. I'm definitely not holding this out as a definitive way to set up your local WordPress development environment, but *my* way that works for me. If you're brand new to all this, and don't want to learn all about systems and devops, then I recommend using one of the first two options above. (I've played a bit with [Local](https://local.getflywheel.com), and find it amazingly intuitive and simple, so that's my latest recommendation.)

Secondly, the sandbox setup is available on GitHub at [github.com/tamouse/sandbox.wp.local](https://github.com/tamouse/sandbox.wp.local) so feel free to fork it, and do what you want with it. I'll happily take PRs if you find bugs, too.

---


<a id="starting-point"></a>

## Starting Point

My working system:

-   Macbook Pro 13"
-   8 GiB RAM
-   4 CPU Cores
-   about 50 GiB free disk space (I didn't need anywhere near this, it's just what was there when I started.)


<a id="prerequisites"></a>

## Prerequisites


<a id="available-software"></a>

### Available Software

This is stuff I already had on my system because of other development I do.

-   HomeBrew
-   VirtualBox
-   Vagrant
-   Ansible


<a id="steps-to-get-things-set-up"></a>

## Steps to Get Things Set Up


<a id="create-a-project-folder-and-initialize-it"></a>

### Create a project folder and initialize it

I always start my projects the same way:

    mkdir -p ~/Projects/wordpress-stuff/sandbox.wp.local
    cd ~/Projects/wordpress-stuff/sandbox.wp.local
    git init
    echo 'Local WordPress Development Sandbox running in Vagrant with Ansible Provisioning' | tee README.md > .git/description
    hub create -d "$(cat .git/description)"
    git add -Av
    git commit -m 'initial commit'
    git push -u origin master

(Truth be told, this is one of my bash functions, so it really looked like this:

    new_proj sandbox.wp.local 'Local WordPress Development Sandbox running in Vagrant with Ansible Provisioning' 'initial commit'

)


<a id="run-vagrant-init"></a>

### Run `vagrant init`

I typically use one of the later Ubuntu server variants; mostly I've been using 'trusty':

    vagrant init 'ubuntu/trusty64'

This writes out a default `Vagrantfile` (which is written in Ruby).


<a id="modify-vagrantfile-for-my-needs"></a>

### Modify `Vagrantfile` for my needs

I modify the file so it looks like so:

\`\`\`ruby linenos BOX<sub>NAME</sub>="sandbox.wp.local" DEFAULT<sub>IP</sub>="192.168.33.35"

require "resolv"

def my<sub>ip</sub> @my<sub>ip</sub> ||= Resolv::Hosts.new.getaddress(BOX<sub>NAME</sub>) || DEFAULT<sub>IP</sub> rescue @my<sub>ip</sub> ||= DEFAULT<sub>IP</sub> end Vagrant.configure(2) do |config|

config.ssh.forward<sub>agent</sub> = true

config.vm.define :sandbox<sub>wp</sub> do |sb| sb.vm.box = "ubuntu/trusty64" sb.vm.network "private<sub>network</sub>", ip: my<sub>ip</sub> sb.vm.network "forwarded<sub>port</sub>", guest: 80, host: 8088 sb.vm.hostname = BOX<sub>NAME</sub>

    sb.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      # vb.gui = true
    
      # Customize the amount of memory on the VM:
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.customize ["modifyvm", :id, "--vram", "18"]
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

end

config.vm.provision :ansible do |a| a.playbook = 'ansible/sandbox.yml' # a.verbose = 'vvvv' end end \`\`\`

Some explanation about the various settings:

    BOX_NAME="sandbox.wp.local"
    DEFAULT_IP="192.168.33.35"

These define two constants that get used later in the `Vagrantfile`. I edited my machine's `/etc/hosts` file, which maps IP addresses to hostnames locally. The line I added to `/etc/hosts` looks like so:

    192.168.33.35   sandbox.wp.local sandbox

This lets me type 'http://sandbox/' or 'http://sandbox.wp.local' in the browser address bar to access the web server that will be running in the Vagrant Virtual Machine (aka "VM").

(Note: when I used [Local](https://local.getflywheel.com), it did something similar.)

Then I'm bringing in ruby's `resolv` standard library, which gives the ability to use that mapping given in the `/etc/hosts` file; the `DEFAULT_IP` constant provides a fallback in case it can't find `BOX_NAME` in `/etc/hosts`.

The `my_ip` method defined sets and returns the IP address to be used for my WordPress sandbox.

With all that handled, vagrant can begin it's configuration. Most everything from here out can be found in vagrant's documentation, if you want.

    config.ssh.forward_agent = true

I set this to true so when I'm logged into the vagrant box, it will use my ssh keys from my development machine; this is especially helpful when using git commands that talk to GitHub, etc.

    sb.vm.network  "private_network", ip: my_ip

Here is where that calculation for figuring out what IP address to use that matches the name 'sandbox.wp.local' I set up is made.

    sb.vm.hostname = BOX_NAME

This sets the VM host name, so it will match 'sandbox.wp.local' when I'm logged in.

    vb.customize ["modifyvm", :id, "--memory", "2048"]

This reserves 2GiB of RAM for the VM.

    vb.customize ["modifyvm", :id, "--vram", "18"]

This reserves 18MB of RAM for the video buffer.

    vb.customize ["modifyvm", :id, "--cpus", "2"]

This allows up to 2 CPU Cores to be used by the VM.

    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

This does some magic to use the host machine's DNS resolver to find IP address, which pulls in the magic of mapping 'sandbox.wp.local'.

    config.vm.provision :ansible do |a|

Tells vagrant I'm using Ansible provisioning.

    a.playbook = 'ansible/sandbox.yml'

Specifies the Ansible 'playbook'

    # a.verbose  = 'vvvv'

Leaving this commented out, but usually it's uncommented for me to be able to debug things during provisioning.


<a id="make-a-git-savepoint"></a>

### Make a git savepoint

Committing the current changes at this point to create a "save point" to get back to if I end up mucking things up.

    git add -Av && git commit -m 'Vagrantfile updated' && git push

(And this is also a bash function:

    gacp 'Vagrantfile updated'

)

At this point, I decided I would make a branch to work on Ansible stuff, too:

    git checkout -b ansible-playbook


<a id="create-the-anisble-playbook"></a>

### Create the Anisble Playbook

Ansible playbooks are build as YAML files, which is just a way of specifying structured data. It's akin to JSON and XML.

I made the ansible playbook in the `ansible` subdirectory, the structure is:

    ansible/
      group_vars/
        all.yml
      roles/
        external/
          .keep
        internal/
          cleanup/
            tasks/
              main.yml
          common/
            tasks/
              install.yml
              main.yml
        requirements.yml
      sandbox.yml
      sudo_roles.yml


<a id="top-level-playbook"></a>

### Top level playbook

[`sandbox.yml`](https://github.com/tamouse/sandbox.wp.local/blob/master/ansible/sandbox.yml) is the top-level playbook that sets the whole provisioning activity off. It is simple and just contains:

\`\`\`yaml

