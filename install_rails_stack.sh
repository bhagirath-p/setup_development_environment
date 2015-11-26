#!/bin/bash

update_system () {
	# Update your system
	sudo apt-get update
}


#=================================================================================
# GIT INSTALLATION
#=================================================================================
install_git () {
	# Call update_system
	update_system
	# Install git and dependencies
	sudo apt-get install -y build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
	sudo apt-get install -y git
}


#=================================================================================
# POSTGRESQL INSTALLATION
#=================================================================================
install_postgres () {
	# Call update_system
	# update_system
	# Install POSTGRESQL and depencies
	sudo apt-get install -y postgresql postgresql-contrib libpq-dev
}


#=================================================================================
# RUBY INSTALLATION
#=================================================================================
install_rails () {
	# Call update_system
	# update_system
	# Install the rbenv and Ruby dependencies
	sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
	cd
	git clone git://github.com/sstephenson/rbenv.git .rbenv
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
	echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

	git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
	source ~/.bash_profile

	# Install rails and set global version
	rbenv install -v 2.2.2
	rbenv global 2.2.2

	# Install bundler gem
	gem install rails
	gem install bundler
}

install_git
install_postgres
install_rails