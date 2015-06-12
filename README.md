**jumpstart VVV (jVVV)**
====

jumpstart VVV is an open source configuration that is built to load the [jumpstart theme](https://github.com/elimc/jumpstart) on Vagrant. 

Most Recent: **Version 0.2.1 Beta (June 10, 2015)** -- See [Changelog](./CHANGELOG.md)

Why jumpstart VVV?
----

Imagine you are in a team of WordPress developers. You are want to use the sweet [jumpstart theme](https://github.com/elimc/jumpstart), but you don't want to have to spend five hourse making sure the other developers have the exact same install base as you do. Besides, do you really want to explain the ins and outs of Gulp, SASS, Node, Bourbon, Bower, and Foundation with the other members of your team? Should the other members of your team even have to know this crap, just to get a WordPress install running? Of course not. Enter **jumpstart VVV**.

**jVVV** is a massive install script that sets up WordPress in a Virtual Machine. You can have every member of your team download and run **jVVV**, and you guarantee that everyone will be on the same environment.

jVVV is based on the popular [Varying Vagrant Vagrants (VVV)](https://github.com/Varying-Vagrant-Vagrants/VVV). While VVV is an excellent solution for a Vagrant WordPress stack, it is somewhat bulky, and takes time to download. Also, it doesn't install and configure WordPress and jumpstart in the way that I personally like.

One Man Teams
----
Virtual Machines are great for a team of developers who are interested in having the same development, without a lot of complications, but, they can be a little bulky for one man teams due to the fact that they require their own operating system running on a VM. For those who feel this is overkill, you may be interested in checking out the standalone [jumpstart install script](https://github.com/elimc/jumpstart-install-script). **jVVV** uses the [jumpstart install script](https://github.com/elimc/jumpstart-install-script) to abstract away the complexity of setting up Gulp, SASS, and all associated plugins.

Dependencies
----

**jVVV** requires recent versions of both Vagrant and VirtualBox to be installed. To get cross device testing working, you will have to **TODO...**

Instructions
----
1. **TODO**
1. ...

#### Default jumpstart site
* DB Name: `jumpstart`

#### MySQL Root
* User: `wp`
* Pass: `wp`

TODO
----

* Sooo many things ... Virtual Machines are a very active development area.