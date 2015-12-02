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
	sudo apt-get install -y git
	sudo apt-get install -y build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
}


#=================================================================================
# POSTGRESQL INSTALLATION
#=================================================================================
install_postgres () {
	# Call update_system
	update_system
	# Install POSTGRESQL and depencies
	sudo apt-get install -y postgresql postgresql-contrib libpq-dev
}

#=================================================================================
# RUBY INSTALLATION
#=================================================================================
install_rails () {
	# Call update_system
	update_system

	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	\curl -sSL https://get.rvm.io | bash -s stable --rails

	source ~/.rvm/scripts/rvm

	# Specify your required version
	rvm install 2.2.2 
}

install_git
install_postgres
install_rails