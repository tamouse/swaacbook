
# Table of Contents

1.  [TIL: Removing all Docker Containers and Images](#org6ace6d3)


<a id="org6ace6d3"></a>

# TIL: Removing all Docker Containers and Images

-   Time-stamp: <span class="timestamp-wrapper"><span class="timestamp">&lt;2018-11-04 Sun 08:20&gt;</span></span>
-   date: 2018-06-04 11:51
-   keywords: [docker, containers, images, removing]

I needed to do a reset on my work machine of the Docker stuff I was using, so needed to know how to do this.

    $ docker rm $(docker ps -aq)
    $ docker rmi $(docker images -q)

`docker ps -aq` gives a list of all the container hashes, which is given the `docker rm` command.

Similarly, `docker images -q` lists all the docker image hashes, which is given to docker's "remove images" `rmi` command.

