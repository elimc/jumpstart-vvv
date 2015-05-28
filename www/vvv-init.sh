##
# Init script for JVVV Auto Site Setup.
#
# Sets up WordPress with the jumpstart theme. If you want to install your own theme, simply change the variables to your settings.
##



# Our site variables.
js_dbname="jumpstart"
js_dbuser="wp"
js_dbpass="wp"
js_url="jumpstart.dev"
js_site_title="jumpstart dev site"
js_user="admin"
js_pass="password"
js_email="admin@local.dev"
js_pages="home" # Comma separated list of pages to be displayed on the site.
js_github_theme="https://github.com/elimc/jumpstart/archive/master.zip"
js_theme_folder="jumpstart-master"



echo "Commencing Default Site Setup"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS jumpstart"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON jumpstart.* TO wp@localhost IDENTIFIED BY 'wp';"

# Download WordPress
if [ ! -d htdocs ]; then
	echo "Installing WordPress using WP CLI"
	mkdir htdocs
	cd htdocs
	wp core download 

# create the wp-config file with our standard setup
# We cannot have a \t in front of any heredoc.
wp core config --dbname="$js_dbname" --dbuser="$js_dbuser" --dbpass="$js_dbpass" --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'DISALLOW_FILE_EDIT', true );
PHP

    # Install WordPres...
    wp core install --url="$js_url" --title="$js_site_title" --admin_user="$js_user" --admin_password="$js_pass" --admin_email="$js_email"

    # discourage search engines.
    wp option update blog_public 0

    # delete sample page, and create homepage.
    wp post delete $(wp post list --post_type=page --posts_per_page=1 --post_status=publish --pagename="sample-page" --field=ID --format=ids)
    wp post create --post_type=page --post_title=Home --post_status=publish --post_author=$(wp user get $js_user --field=ID --format=ids)

    # set homepage as front page.
    wp option update show_on_front 'page'

    # set homepage to be the new page.
    wp option update page_on_front $(wp post list --post_type=page --post_status=publish --posts_per_page=1 --pagename=home --field=ID --format=ids)

    # create all of the pages.
    export IFS=","
    for page in $js_pages; do
        wp post create --post_type=page --post_status=publish --post_author=$(wp user get $js_user --field=ID --format=ids) --post_title="$(echo $page | sed -e 's/^ *//' -e 's/ *$//')"
    done

    # Delete sample post.
    wp post delete 1 --force

    # set pretty urls.
    wp rewrite structure '/%postname%/'
    wp rewrite flush

    # delete hello dolly.
    wp plugin delete hello

    # Install jetpack. Install plugins as needed.
    wp plugin install jetpack

    # Install jumpstart theme from a remote zip file.
    wp theme install $js_github_theme --activate

    # create a navigation bar
    wp menu create "Main Navigation"

    # add pages to navigation
    export IFS=" "
    for pageid in $(wp post list --order="ASC" --orderby="date" --post_type=page --post_status=publish --posts_per_page=-1 --field=ID --format=ids); do
        wp menu item add-post main-navigation $pageid
    done

    # Install gulp globally. Makes sure "gulp" is available on CLI.
    sudo npm install gulp -g

    # Change to the theme that contains gulpfile.js
    cd wp-content/themes/$js_theme_folder
    echo "Changing directories to:"
    pwd

    # Install npm dependencies.
    npm install
    echo "Finished npm install :)"

    # Set up path for Browsersync.
    # Search and replace inside gulpfile.js for the correct URL
    # The sed -i ".bak" option (where we edit files in place), doesn't seem to work on Ubuntu, so we use a an uglier method.
    echo "Changing URL path to http://jumpstart.dev"
    sed "s#127.0.0.1/jump_start#jumpstart.dev#" gulpfile.js > gulpfile2.js
    rm gulpfile.js
    mv gulpfile2.js gulpfile.js
fi

# The Vagrant site setup script will restart Nginx for us.

echo "Default site is now installed";
