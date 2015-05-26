# Init script for JVVV Auto Bootstrap Demo 1

echo "Commencing Default Site Setup"

# Make a database, if we don't already have one
echo "Creating database (if it's not already there)"
mysql -u root --password=root -e "CREATE DATABASE IF NOT EXISTS jumpstart"
mysql -u root --password=root -e "GRANT ALL PRIVILEGES ON jumpstart.* TO wp@localhost IDENTIFIED BY 'wp';"

# Download WordPress
if [ ! -d htdocs ]
then
	echo "Installing WordPress using WP CLI"
	mkdir htdocs
	cd htdocs
	wp core download 
	wp core config --dbname="jumpstart" --dbuser=wp --dbpass=wp --dbhost="localhost"
	wp core install --url=jumpstart.dev --title="jumpstart" --admin_user=admin --admin_password=password --admin_email=demo@example.com
	cd ..
fi

# The Vagrant site setup script will restart Nginx for us

echo "Default site is now installed";
