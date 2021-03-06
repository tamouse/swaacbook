
# Table of Contents

1.  [Multiple vagrant rails development box setup times](#multiple-vagrant-rails-development-box-setup-times)
    1.  [Building different vagrant boxes](#building-different-vagrant-boxes)
    2.  [Vagrantfiles](#vagrantfiles)
    3.  [Downloading Times](#downloading-times)
        1.  [Debian Jessie 8](#debian-jessie-8)
        2.  [Jason Hsu Debian Wheezy + RVM](#jason-hsu-debian-wheezy-rvm)
        3.  [Ubuntu Trusty](#ubuntu-trusty)
    4.  [Provisioning](#provisioning)
        1.  [Debian Jessie 8](#debian-jessie-8-1)
        2.  [Jason Hsu Debian Wheezy + RVM](#jason-hsu-debian-wheezy-rvm-1)
        3.  [Jason Hsu Debian Wheezy + RVM &#x2013; REDO](#jason-hsu-debian-wheezy-rvm-redo)
        4.  [Ubuntu Trusty with Ansible](#ubuntu-trusty-with-ansible)
        5.  [Debian Jessie 8 with Ansible](#debian-jessie-8-with-ansible)
    5.  [New Rails App](#new-rails-app)
        1.  [Debian Jessie 8](#debian-jessie-8-2)
        2.  [Jason Hsu Debian Wheezy + RVM](#jason-hsu-debian-wheezy-rvm-2)
        3.  [Jason Hsu Debian Wheezy + RVM &#x2013; REDO](#jason-hsu-debian-wheezy-rvm-redo-1)
        4.  [Ubuntu Trusty with Ansible](#ubuntu-trusty-with-ansible-1)
        5.  [Debian Jessie 8 with Ansible](#debian-jessie-8-with-ansible-1)
2.  [FIFTEEN SECONDS ?!?!?](#fifteen-seconds)
3.  [Conclusions](#conclusions)
4.  [Going Forward](#going-forward)


<a id="multiple-vagrant-rails-development-box-setup-times"></a>

# Multiple vagrant rails development box setup times

-   published date: 2015-05-09 21:12
-   keywords: ["development", "rails", "vagrant"]
-   source:

I've recently been looking at the [Rails.MN Installation](http://http://www.rails.mn/installation/) setup, and our recommendation to use a Vagrant setup. This seems to work for most people. [Jason Hsu](https://github.com/jhsu802701) put together a really nice set of videos to pair along with his Vagrant setup. I had also been working on a kit to get Ubuntu Trusty provisioned with Ansible working for some work-related projects.

With the new version of Debian Jessie out, I also wanted to see what it took to get that up and running.

The results rather suprised me, in the end. While they are all pretty comparable given download, provisioning, and creating a minimal rails application, the last combination of using Jessie and Ansible got a very surprising result in getting the rails app up in under a minute. The only thing I saw differently was using IO.js instead of installing the nodejs package from apt-get.

-   contents {:toc}


<a id="building-different-vagrant-boxes"></a>

## Building different vagrant boxes

-   Debian Jessie 8 with manual provisioning
-   Jason Hsu's Debian Wheezy + RVM <https://github.com/jhsu802701/vagrant_debian_wheezy_rvm>
-   Ubuntu 14.04 + Ansible provisioning <https://github.com/tamouse/vagrant-ubu14.04-emacs24-ruby-2.2.0-development>
-   Debian Jessie 8 + Ansible provisioning (same as above with some tweaks for jessie 8: Postgresql 9.4 instead of 9.3)


<a id="vagrantfiles"></a>

## Vagrantfiles

All the `Vagrantfiles` were similar, normalizing the following values:

-   RAM: 2048MB
-   CPUs: 2 cores
-   VRAM: 12MB


<a id="downloading-times"></a>

## Downloading Times

I'm downloading the three source boxes and creating them on my system.


<a id="debian-jessie-8"></a>

### Debian Jessie 8

    $ vagrant box add deb8 https://github.com/holms/vagrant-jessie-box/releases/download/Jessie-v0.1/Debian-jessie-amd64-netboot.box
    ==> box: Adding box 'deb8' (v0) for provider:
        box: Downloading: https://github.com/holms/vagrant-jessie-box/releases/download/Jessie-v0.1/Debian-jessie-amd64-netboot.box
    ==> box: Successfully added box 'deb8' (v0) for 'virtualbox'!

Elapsed time: approximately 12 minutes.

One thing to note: this box uses the UK Debian mirror. Changing the `/etc/apt/sources.list` file to use a closer mirror can make a huge difference in the provisioning times (though not always).


<a id="jason-hsu-debian-wheezy-rvm"></a>

### Jason Hsu Debian Wheezy + RVM

    $ vagrant box add deb7hsu 'http://downloads.sourceforge.net/project/vagrant-debian-wheezy-rvm/debian-wheezy-rvm-2015_03_07.box?r=&ts=1425788198&use_mirror=master'
    ==> box: Adding box 'deb7hsu' (v0) for provider:
        box: Downloading: http://downloads.sourceforge.net/project/vagrant-debian-wheezy-rvm/debian-wheezy-rvm-2015_03_07.box?r=&ts=1425788198&use_mirror=master
    ==> box: Successfully added box 'deb7hsu' (v0) for 'virtualbox'!

Elapsed time: approximately 22 minutes.


<a id="ubuntu-trusty"></a>

### Ubuntu Trusty

    $ vagrant box add ubu1404daily 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'
    ==> box: Adding box 'ubu1404daily' (v0) for provider:
        box: Downloading: https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
    ==> box: Successfully added box 'ubu1404daily' (v0) for 'virtualbox'!

Elapsed time: approximately 16 minutes.


<a id="provisioning"></a>

## Provisioning


<a id="debian-jessie-8-1"></a>

### Debian Jessie 8

1.  Vagrant up

        real    0m31.201s
        user    0m3.744s
        sys 0m1.748s

2.  Manual Provisioning

    1.  System stuff
    
            sudo apt-get update
            sudo apt-get install -yqq build-essential
            sudo apt-get install -yqq git curl python-psycopg2 postgresql-9.4 postgresql-client libpq-dev sqlite3 libsqlite3-dev libyaml-dev libgdbm-dev libreadline-dev libncurses5-dev libxml2-dev libxslt-dev imagemagick libmagickwand-dev libmagickcore-dev xvfb nodejs
            sudo su - postgres -c 'createuser -s vagrant'
            createdb vagrant
    
    2.  RVM, Ruby, Rails, fun
    
            /usr/bin/curl -sSL https://rvm.io/mpapis.asc | gpg --import -
            /usr/bin/curl -sSL https://get.rvm.io | bash -s stable
            source /home/vagrant/.rvm/scripts/rvm
            echo 'gem: --no-document' >> /home/vagrant/.gemrc
            rvm install 2.2.1
            rvm @global do gem install bundler
            rvm @global do gem install pry
            rvm @global do gem install pry-byebug
            rvm @global do gem install rails
        
        -   started at: 2015-05-09@04:30:12
        -   ended at: 2015-05-09@05:07:23
        
        Elapsed time: approximately 35 minutes clock time.
        
        This took so long *primarily* because of manual mistakes; typos, incorrect package names, misfires, and so on. The commands above represent the final versions *that worked*. If this was all in a couple scripts, it would likely have taken less time. Good reason not to do things manually!


<a id="jason-hsu-debian-wheezy-rvm-1"></a>

### Jason Hsu Debian Wheezy + RVM

    vagrant up
    real    1m14.191s
    user    0m4.777s
    sys 0m2.763s

This is all that should be needed.

Elapsed time: about 2 minutes.


<a id="jason-hsu-debian-wheezy-rvm-redo"></a>

### Jason Hsu Debian Wheezy + RVM &#x2013; REDO

Since I need to make changes in the Postgres setup to make a standard `rails new` work, I'm redoing this provisioning step to make the changes manually here.

    $ time vagrant up
    real    1m11.181s
    user    0m4.436s
    sys 0m2.269s

Fxing Postgres permissions, establishing `vagrant` user for Postgres:

    $ time vagrant ssh
    vagrant@vagrant-rvm:~$ sudo -i
    root@vagrant-rvm:~# vi /etc/postgresql/9.1/main/pg_hba.conf
    root@vagrant-rvm:~# service postgresql restart
    [ ok ] Restarting PostgreSQL 9.1 database server: main.
    root@vagrant-rvm:~# su - postgres
    postgres@vagrant-rvm:~$ createuser -s vagrant
    postgres@vagrant-rvm:~$ exit
    logout
    root@vagrant-rvm:~# exit
    logout
    vagrant@vagrant-rvm:~$ createdb vagrant
    vagrant@vagrant-rvm:~$ psql
    psql (9.1.15)
    Type "help" for help.
    vagrant=# \q
    vagrant@vagrant-rvm:~$ exit
    logout
    Connection to 127.0.0.1 closed.
    real    1m13.240s
    user    0m1.314s
    sys 0m0.397s

Elapsed time: appoximately 3 minutes (for both steps).


<a id="ubuntu-trusty-with-ansible"></a>

### Ubuntu Trusty with Ansible

    vagrant up --provision
    real    11m32.594s
    user    0m5.733s
    sys 0m3.362s

    rvm @global do gem install rails
    real    1m27.209s
    user    0m29.696s
    sys 0m25.426s

Also had to do a couple housekeepting things with `nvm`:

    nvm use iojs
    nvm alias default iojs

I didn't bother timing those.

Elapsed time: approximately 12 minutes.


<a id="debian-jessie-8-with-ansible"></a>

### Debian Jessie 8 with Ansible

    vagrant up --provision
    real    9m32.044s
    user    0m5.751s
    sys 0m3.076s

In this case, I added the rails gem installation and nvm housekeeping to the provisioning package.

Elapsed time: approximately 10 minutes.


<a id="new-rails-app"></a>

## New Rails App


<a id="debian-jessie-8-2"></a>

### Debian Jessie 8

    $ time (rails new myApp -d postgresql --skip-spring --skip-turbolinks && cd myApp && bin/rake db:create && bin/rails g scaffold Post title body:text published:boolean && bin/rake db:migrate)
    real    0m56.383s
    user    0m14.604s
    sys 0m1.540s

Elapsed time: approximately 1 minute.


<a id="jason-hsu-debian-wheezy-rvm-2"></a>

### Jason Hsu Debian Wheezy + RVM

    rails new myApp -d postgresql --skip-spring --skip-turbolinks
    real    1m4.808s
    user    0m12.629s
    sys 0m2.036s

Cannot just run `rake db:create`.

Must now spend time to make simple use of vagrant user in postgresql automatically.

Required setting `/etc/postgresql/9.1/main/pg_hba.conf` to allow peer connection on all local users.

Now, these work:

    rake db:create
    rails generate scaffold Post title body:text published:boolean
    rake db:migrate
    rails server -b 0.0.0.0

*However*, could not connect from host machine to VM. Needed to provide a `private_network` ip address that would work. Utilized the `resolv` stdlib package and set up local host `/etc/hosts` file.

Connecting to `http://jhsu.local:3000` works as expected now, and can manipulate posts at `http://jhsu.local:3000/posts` just fine.

Started at: 2015-05-09@05:22:51 Ended at: 2015-05-09@05:47:03

Total elapsed time to make things work: approximately 25 minutes.

However, this is an unfair comparison since most of that 25 minutes was really spent trying to figure things out to make them work in the way I'm used to. Once I had that all figured out, I redid the provisioning and new app steps.


<a id="jason-hsu-debian-wheezy-rvm-redo-1"></a>

### Jason Hsu Debian Wheezy + RVM &#x2013; REDO

After fixing the postgres configuration in the provisioning step, building the new rails app ran so much faster:

    $ time (rails new myApp -d postgresql --skip-spring --skip-turbolinks && cd myApp && bin/rake db:create && bin/rails g scaffold Post title body:text published:boolean && bin/rake db:migrate)
    real    1m28.536s
    user    0m15.681s
    sys 0m4.680s

Elapsed time: approximately 1.5 minutes


<a id="ubuntu-trusty-with-ansible-1"></a>

### Ubuntu Trusty with Ansible

    $ time (rails new myApp -d postgresql --skip-spring --skip-turbolinks && cd myApp && bin/rake db:create && bin/rails g scaffold Post title body:text published:boolean && bin/rake db:migrate)
    real    0m54.673s
    user    0m15.867s
    sys 0m4.743s

Elapsed time: approximately 1 minute


<a id="debian-jessie-8-with-ansible-1"></a>

### Debian Jessie 8 with Ansible

    $ time rails new myApp -d postgresql --skip-spring --skip-turbolinks
    real    0m37.400s
    user    0m11.376s
    sys 0m1.204s

    $ time bin/rake db:create
    real    0m1.823s
    user    0m0.964s
    sys 0m0.160s

    $ time bin/rails g scaffold Post title body:text published:boolean
    real    0m3.965s
    user    0m2.100s
    sys 0m0.872s

    $ time bin/rake db:migrate
    real    0m3.212s
    user    0m1.864s
    sys 0m0.592s

Wow that was fast.

Trying that again from scratch.

    $ time (rails new myApp -d postgresql --skip-spring --skip-turbolinks && cd myApp && bin/rake db:create && bin/rails g scaffold Post title body:text published:boolean && bin/rake db:migrate)
    real    0m15.154s
    user    0m6.088s
    sys 0m2.088s

Elapsed time: approximately 15 seconds.

**FIFTEEN SECONDS**


<a id="fifteen-seconds"></a>

# FIFTEEN SECONDS ?!?!?

{:.no<sub>toc</sub>}

---


<a id="conclusions"></a>

# Conclusions

From scratch to a running Rails app, times are in approximate minutes:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">package</th>
<th scope="col" class="org-right">download</th>
<th scope="col" class="org-right">provision</th>
<th scope="col" class="org-right">create app</th>
<th scope="col" class="org-right">total</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">debian jessie 8 + manual</td>
<td class="org-right">12</td>
<td class="org-right">35</td>
<td class="org-right">1</td>
<td class="org-right">48</td>
</tr>


<tr>
<td class="org-left">Jason Hsu debian wheezy 7 + rvm</td>
<td class="org-right">22</td>
<td class="org-right">2</td>
<td class="org-right">25</td>
<td class="org-right">49</td>
</tr>


<tr>
<td class="org-left">Jason Hsu debian wheezy 7 + rvm &#x2013; REDO</td>
<td class="org-right">22</td>
<td class="org-right">3</td>
<td class="org-right">2</td>
<td class="org-right">27</td>
</tr>


<tr>
<td class="org-left">ubuntu trusty + ansible</td>
<td class="org-right">16</td>
<td class="org-right">12</td>
<td class="org-right">1</td>
<td class="org-right">29</td>
</tr>


<tr>
<td class="org-left">debian jessie 8 + ansible</td>
<td class="org-right">12</td>
<td class="org-right">10</td>
<td class="org-right">1</td>
<td class="org-right">23</td>
</tr>


<tr>
<td class="org-left">:------------------------------------------</td>
<td class="org-right">----&#x2013;&#x2014;:</td>
<td class="org-right">-----&#x2013;&#x2014;:</td>
<td class="org-right">------&#x2013;&#x2014;:</td>
<td class="org-right">-&#x2013;&#x2014;:</td>
</tr>
</tbody>
</table>

{:.table}

Your mileage will vary, of course, but if you are going the vagrant route, plan on about a half-hour to be fully up and running with a development-ready rails kit. Using a pre-built package such as Jason's is a great idea, provided you also understand the underlying assumptions that package is making. This is true also of using things like my starter kit, as well.


<a id="going-forward"></a>

# Going Forward

Whatever means you choose to arrive at your development box, you should take steps to preserve it as well. Repackage the VM and save the box file somewhere you can retrieve it, with all your personal customizations and so on. I'll write a future blog post on that.

