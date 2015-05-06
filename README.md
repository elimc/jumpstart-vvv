# jumpstart VVV (JVVV)

jumpstart VVV is an open source configuration that is built to load the [jumpstart theme](https://github.com/elimc/jumpstart) for WordPress. For those who feel a VM is overkill for setting up the jumpstart theme, you may be interested in checking out the [jumpstart install script](https://github.com/elimc/jumpstart-install-script).

## Overview
#### Why jumpstart VVV?

Imagine you are in a team of WordPress developers. You are want to use the sweet [jumpstart theme](https://github.com/elimc/jumpstart), but you don't want to have to spend five hourse making sure the other developers have the exact same install base as you do. Besides, do you really want to explain the ins and outs of Gulp, SASS, Node, Bourbon, and Foundation with the other members of your team? Should the other members of your team even have to know this crap, just to get a WordPress install running? Of course not. Enter jumpstart VVV.

**JVVV** is a massive install script that sets up WordPress in a Virtual Machine. You can have every member of your team download and run **JVVV**, and you guarantee that everyone will be on the same environment.

#### Birth of jumpstart VVV

**JVVV** is based on the excellent [Varying Vagrant Vagrants](https://github.com/Varying-Vagrant-Vagrants/VVV)(or VVV). It has been streamlined to load faster, because it is specifically built for [jumpstart theme](https://github.com/elimc/jumpstart), with all other coding cruft removed.

#### Software Requirements

**JVVV** requires recent versions of both Vagrant and VirtualBox to be installed.

[Vagrant](http://www.vagrantup.com) is a "tool for building and distributing development environments". It works with [virtualization](https://en.wikipedia.org/wiki/X86_virtualization) software such as [VirtualBox](https://www.virtualbox.org/) to provide a virtual machine sandboxed from your local environment.

#### The First Vagrant Up

1. Start with any local operating system such as Mac OS X, Linux, or Windows.
1. Install [VirtualBox 4.3.x](https://www.virtualbox.org/wiki/Downloads)
1. Install [Vagrant 1.6.x](http://www.vagrantup.com/downloads.html)
    * `vagrant` will now be available as a command in your terminal, try it out.
    * ***Note:*** If Vagrant is already installed, use `vagrant -v` to check the version. You may want to consider upgrading if a much older version is in use.
1. Install the [vagrant-hostsupdater](https://github.com/cogitatio/vagrant-hostsupdater) plugin with `vagrant plugin install vagrant-hostsupdater`
    * Note: This step is not a requirement, though it does make the process of starting up a virtual machine nicer by automating the entries needed in your local machine's `hosts` file to access the provisioned VVV domains in your browser.
    * If you choose not to install this plugin, a manual entry should be added to your local `hosts` file that looks like this: `192.168.50.4  vvv.dev local.wordpress.dev local.wordpress-trunk.dev src.wordpress-develop.dev build.wordpress-develop.dev`
1. Install the [vagrant-triggers](https://github.com/emyl/vagrant-triggers) plugin with `vagrant plugin install vagrant-triggers`
    * Note: This step is not a requirement. When installed, it allows for various scripts to fire when issuing commands such as `vagrant halt` and `vagrant destroy`.
    * By default, if vagrant-triggers is installed, a `db_backup` script will run on halt, suspend, and destroy that backs up each database to a `dbname.sql` file in the `{vvv}/database/backups/` directory. These will then be imported automatically if starting from scratch. Custom scripts can be added to override this default behavior.
    * If vagrant-triggers is not installed, VVV will not provide automated database backups.
1. Clone or extract the Varying Vagrant Vagrants project into a local directory
    * `git clone git://github.com/Varying-Vagrant-Vagrants/VVV.git vagrant-local`
    * OR download and extract the repository master [zip file](https://github.com/varying-vagrant-vagrants/vvv/archive/master.zip) to a `vagrant-local` directory on your computer.
    * OR download and extract a [stable release](https://github.com/varying-vagrant-vagrants/vvv/releases) zip file if you'd like some extra comfort.
1. In a command prompt, change into the new directory with `cd vagrant-local`
1. Start the Vagrant environment with `vagrant up`
    * Be patient as the magic happens. This could take a while on the first run as your local machine downloads the required files.
    * Watch as the script ends, as an administrator or `su` ***password may be required*** to properly modify the hosts file on your local machine.
1. Visit the following default sites in your browser:
    * [http://local.wordpress.dev/](http://local.wordpress.dev/) for WordPress stable
    * [http://vvv.dev/](http://vvv.dev/) for a default dashboard containing several useful tools

#### What Did That Do?

The first time you run `vagrant up`, a packaged box containing a basic virtual machine is downloaded to your local machine and cached for future use. The file used by Varying Vagrant Vagrants contains an installation of Ubuntu 14.04 and is about 332MB.

After this box is downloaded, it begins to boot as a sandboxed virtual machine using VirtualBox. Once booted, it runs the provisioning script included with **JVVV**. This initiates the download and installation of around 100MB of packages on the new virtual machine.

The time for all of this to happen depends a lot on the speed of your Internet connection. If you are on a fast cable connection, it will likely only take several minutes.

On future runs of `vagrant up`, the packaged box will be cached on your local machine and Vagrant will only need to apply the requested provisioning.

* ***Preferred:*** If the virtual machine has been powered off with `vagrant halt`, `vagrant up` will quickly power on the machine without provisioning.
* ***Rare:*** If you would like to reapply the provisioning scripts with `vagrant up --provision` or `vagrant provision`, some time will be taken to check for updates and packages that have not been installed.
* ***Very Rare:*** If the virtual machine has been destroyed with `vagrant destroy`, it will need to download the full 100MB of package data on the next `vagrant up`.

#### Now What?

Now that you're up and running, start poking around and modifying things.

1. Access the server via the command line with `vagrant ssh` from your `vagrant-local` directory. You can do almost anything you would do with a standard Ubuntu installation on a full server.
1. Power off the box with `vagrant halt` and turn it back on with `vagrant up`.
1. Suspend the box's state in memory with `vagrant suspend` and bring it right back with `vagrant resume`.
1. Reapply provisioning to a running box with `vagrant provision`.
1. Destroy the box with `vagrant destroy`. Files added in the `www` directory will persist on the next `vagrant up`.

#### Caveats

The network configuration picks an IP of 192.168.50.4. It could cause conflicts on your existing network if you *are* on a 192.168.50.x subnet already. You can configure any IP address in the `Vagrantfile` and it will be used on the next `vagrant up`

VVV relies on the stability of both Vagrant and Virtualbox. These caveats are common to Vagrant environments and are worth noting:
* If the directory VVV is inside of is moved once provisioned (`vagrant-local`), it may break.
    * If `vagrant destroy` is used before moving, this should be fine.
* If Virtualbox is uninstalled, VVV will break.
* If Vagrant is uninstalled, VVV will break.

The default memory allotment for the VVV virtual machine is 1024MB. If you would like to raise or lower this value to better match your system requirements, a [guide to changing memory size](https://github.com/Varying-Vagrant-Vagrants/VVV/wiki/Customising-your-Vagrant's-attributes-and-parameters) is in the wiki.

### Credentials and Such

All database usernames and passwords for WordPress installations included by default are `wp` and `wp`.

All WordPress admin usernames and passwords for WordPress installations included by default are `admin` and `password`.

#### WordPress Stable
* LOCAL PATH: vagrant-local/www/wordpress-default
* VM PATH: /srv/www/wordpress-default
* URL: `http://local.wordpress.dev`
* DB Name: `wordpress_default`

#### MySQL Root
* User: `root`
* Pass: `root`
* See: [Connecting to MySQL](https://github.com/varying-vagrant-vagrants/vvv/wiki/Connecting-to-MySQL) from your local machine

### What do you get?

A bunch of stuff!

1. [Ubuntu](http://www.ubuntu.com/) 14.04 LTS (Trusty Tahr)
1. [WordPress Stable](https://wordpress.org/)
1. [WP-CLI](http://wp-cli.org/)
1. [nginx](http://nginx.org/) 1.6.x
1. [mysql](https://www.mysql.com/) 5.5.x
1. [php-fpm](http://php-fpm.org/) 5.5.x
1. [memcached](http://memcached.org/) 1.4.13
1. PHP [memcache extension](https://pecl.php.net/package/memcache/3.0.8/) 3.0.8
1. PHP [xdebug extension](https://pecl.php.net/package/xdebug/2.2.5/) 2.2.5
1. PHP [imagick extension](https://pecl.php.net/package/imagick/3.1.2/) 3.1.2
1. [PHPUnit](https://phpunit.de/) 4.0.x
1. [ack-grep](http://beyondgrep.com/) 2.04
1. [git](http://git-scm.com/) 1.9.x
1. [subversion](https://subversion.apache.org/) 1.8.x
1. [ngrep](http://ngrep.sourceforge.net/usage.html)
1. [dos2unix](http://dos2unix.sourceforge.net/)
1. [Composer](https://github.com/composer/composer)
1. [phpMemcachedAdmin](https://code.google.com/p/phpmemcacheadmin/)
1. [phpMyAdmin](http://www.phpmyadmin.net/) 4.1.14 (multi-language)
1. [Opcache Status](https://github.com/rlerdorf/opcache-status)
1. [Webgrind](https://github.com/jokkedk/webgrind)
1. [NodeJs](https://nodejs.org/) Current Stable Version

### The Future of jumpstart VVV

Sooo many things ... Virtual Machines are a very active development area.
