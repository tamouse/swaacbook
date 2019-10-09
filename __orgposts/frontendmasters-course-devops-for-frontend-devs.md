
# Table of Contents

1.  [FrontendMasters Course: DevOps for Frontend Devs](#frontendmasters-course-devops-for-frontend-devs)
    1.  [create an ssh key pair](#create-an-ssh-key-pair)
    2.  [create a new server](#create-a-new-server)
    3.  [on the new server, as root](#on-the-new-server-as-root)
    4.  [create users with sudo](#create-users-with-sudo)
    5.  [back on the home machine](#back-on-the-home-machine)
    6.  [on new server, regular user (from now on)](#on-new-server-regular-user-from-now-on)
    7.  [get a domain name](#get-a-domain-name)
    8.  [set up the web server](#set-up-the-web-server)
    9.  [setting up the application](#setting-up-the-application)
    10. [build and deploy an app](#build-and-deploy-an-app)


<a id="frontendmasters-course-devops-for-frontend-devs"></a>

# FrontendMasters Course: DevOps for Frontend Devs

-   published date: 2016-11-13 12:52
-   keywords: ["class", "devops", "frontendmasters", "jemyoung"]
-   source: URL

On November 11, 2016, I attended the [FrontendMasters](https://frontendmasters.com){:target="<sub>blank</sub>"} course"DevOps for Frontend Devs" taught by [Jem Young](https://jemyoung.com/about/){:target="<sub>blank</sub>"} from Netflix.

It was a great class. Here's the checklist I built for bringing up a basic droplet on [Digital Ocean](https://digitalocean.com){:target="<sub>blank</sub>"}


<a id="create-an-ssh-key-pair"></a>

## create an ssh key pair

You can reuse one you already have, or create a new one. Make sure it's on DigitalOcean and create the droplet with it.

-   [ ] upload the PUBLIC key you created or are reusing to DigitalOcean.


<a id="create-a-new-server"></a>

## create a new server

-   [ ] create a droplet on DO
-   [ ] copy and save the new droplet's IP address
    -   [ ] add to /etc/hosts to make it easy
    -   [ ] also create an entry for it in `~/.ssh/config`

    Host <DROPLET NAME>
      User tamara
      IdentityFile ~/.ssh/id_rsa
      AddkeysToAgent yes
      ForwardAgent yes
      HostName <DROPLET IP>

-   [ ] log into the new droplet


<a id="on-the-new-server-as-root"></a>

## on the new server, as root

-   [ ] Change root password to something you know (DO set's it to something randome and never tells you what it is.)
    -   [ ] `passwd`

-   [ ] `apt-get update` to refresh DPKG indexes
-   [ ] `apt-get install -y build-essential git curl wget emacs zip unzip zlibc zlib1g-dev` My tools of choice
-   [ ] `apt-get install -y htop` nice top() replacement


<a id="create-users-with-sudo"></a>

## create users with sudo

-   [ ] add user `tamara`:
    -   [ ] `adduser tamara`
    -   [ ] `usermod -aG sudo tamara`
    -   [ ] `mkdir -p ~tamara/.ssh`
    -   [ ] `cp ~/.ssh/authorized_keys ~tamara/.ssh/`
    -   [ ] `chown -R tamara:tamara ~tamara/.ssh/`

-   [ ] add new user `git`
    -   [ ] `adduser git`
    -   [ ] `usermod -aG sudo git`
    -   [ ] `mkdir -p ~git/.ssh`
    -   [ ] `cp ~/.ssh/authorized_keys ~git/.ssh/`
    -   [ ] `chown -R git:git ~git/.ssh`


<a id="back-on-the-home-machine"></a>

## back on the home machine

If you copied the authorized keys file in the above steps, the following is not needed.

-   [ ] move public key to users
    -   Users: [tamara, git]
        
            cat ~/.ssh/is_rsa.pub | ssh $USERa@$NEW_SERVER 'mkdir -p .ssh && cat >> .ssh/authorized_keys


<a id="on-new-server-regular-user-from-now-on"></a>

## on new server, regular user (from now on)

-   Disable access via `ssh` for `root`
    -   [ ] `sudo vi /etc/ssh/sshd_config`
    -   [ ] Set `PermitRootLogin: no`
    -   [ ] restart: `sudo service sshd restart`


<a id="get-a-domain-name"></a>

## get a domain name

(optional, but kind of nice for easy referral from everywhere.)

-   [ ] buy a domain name from some place
-   [ ] for the domain, create 2 "A" records
    -   [ ] "@" point to new server's IP
    -   [ ] "www" point to new server's IP

-   [ ] 


<a id="set-up-the-web-server"></a>

## set up the web server

-   [ ] install nginx
-   [ ] install nodejs and npm: following instructions on [nodesource/distributions](https://github.com/nodesource/distributions#installation-instructions)

    curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
    sudo apt-get install -y nodejs

-   [ ] symlink node -> nodejs Not necessary with the above

-   [ ] install ruby using [Brightbox.Com](https://www.brightbox.com/docs/ruby/ubuntu/#adding-the-repository):

    sudo apt-get install software-properties-common
    sudo apt-add-repository ppa:brightbox/ruby-ng
    sudo apt-get update
    sudo apt-get install ruby2.4
    sudo gem install bundler rake
    sudo gem install rails


<a id="setting-up-the-application"></a>

## setting up the application

-   [ ] clone the app
-   [ ] cd into the app dir
-   [ ] `npm install`
-   [ ] `node app.js`
-   [ ] `nohup node app.js &` to make it run forever in the background


<a id="build-and-deploy-an-app"></a>

## build and deploy an app

-   using Gulp

