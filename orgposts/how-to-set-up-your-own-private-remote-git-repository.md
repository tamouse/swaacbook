
# Table of Contents

1.  [How to set up your own private git repository on a remote server](#how-to-set-up-your-own-private-git-repository-on-a-remote-server)
    1.  [Have a local repo](#have-a-local-repo)
    2.  [Set up the server](#set-up-the-server)
    3.  [Add your repositories](#add-your-repositories)
    4.  [Configure your development machine](#configure-your-development-machine)
    5.  [Resources](#resources)


<a id="how-to-set-up-your-own-private-git-repository-on-a-remote-server"></a>

# How to set up your own private git repository on a remote server

-   published date: 2016-10-08 00:22
-   keywords: ["git", "howto", "private", "remote", "server", "tools", "tutorial"]
-   source:

This is an old article from my ancient wiki. I thought it was good to bring forward. Some of the git SaaS providers allow you to create private repositories, which are probably a better idea for collaboration, but this is a useful alternative when you don't want to go the SaaS route.


<a id="have-a-local-repo"></a>

## Have a local repo

Let's just create a simple local repo to work with.

    $ git init my_project
    $ cd my_project
    $ echo 'My Project' > README.md
    $ git add .
    $ git commit -m 'initial'

Great, now let's get on with the remote stuff.


<a id="set-up-the-server"></a>

## Set up the server

First, if you haven't done so already, add your public key to the server:

*(Don't do this if you've already uploaded your public ssh key!)*

    $ ssh myuser@server.com 'mkdir -p .ssh'
    $ cat .ssh/id_rsa.pub | ssh myuser@server.com 'cat >> .ssh/authorized_keys'

This will let you use git push without having to supply your password every time.


<a id="add-your-repositories"></a>

## Add your repositories

Login to the server:

    $ ssh myuser@server.com

Create a directory to keep all your remote repos in one place

    $ mkdir Repos
    $ cd Repos

Now we can create our remote repository:

    $ git init --bare my_project.git

Note that I've chosen to mirror the local project directory name. This is a pretty good practice, less confusion, less decision making. In addition, I've appended `.git` to the remote repo directory name, which helps inform those things that care that this is a git repository.

If you have a look in the directory just created, it looks just like the `.git` directory in your local project. Hence the extension.

With all that done, you can log out of the server.


<a id="configure-your-development-machine"></a>

## Configure your development machine

To use the remote repository, we have to add it to the remotes available in the local repository.

    $ git remote add origin myuser@server.com:Repos/my_project.git
    $ git push origin master

You'll probably also want to make sure you add a default merge and remote:

    $ git config branch.master.remote origin
    $ git config branch.master.merge refs/heads/master

And that's it!


<a id="resources"></a>

## Resources

1.  [git `init` command](https://git-scm.com/docs/git-init) to find out about the `--bare` option.

