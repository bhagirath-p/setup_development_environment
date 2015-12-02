#!/bin/bash


#=================================================================================
# UBUNTU SYSTEM UPDATE
#=================================================================================
update_ubuntu_system () {
	# Update your system
	sudo apt-get update
}


#=================================================================================
# UBUNTU GIT INSTALLATION
#=================================================================================
install_ubuntu_git () {
	# Call update_system
	update_ubuntu_system
	# Install git and dependencies
	sudo apt-get install -y git
	sudo apt-get install -y build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
}


#=================================================================================
# UBUNTU POSTGRESQL INSTALLATION
#=================================================================================
install_ubuntu_postgres () {
	# Call update_system
	update_ubuntu_system
	# Install POSTGRESQL and depencies
	sudo apt-get install -y postgresql postgresql-contrib libpq-dev
}


#=================================================================================
# UBUNTU RUBY INSTALLATION
#=================================================================================
install_ubuntu_rails () {
	# Call update_system
	update_ubuntu_system
	# Install the rbenv and Ruby dependencies
	sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
	cd
	git clone git://github.com/sstephenson/rbenv.git .rbenv
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
	echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

	git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
	. ~/.bash_profile

	# Install rails and set global version
	rbenv install -v 2.2.3
	rbenv global 2.2.3

	# Install bundler gem
	gem install rails
	gem install bundler
}


set_up_rails_stack_linux () {
	install_ubuntu_git
	install_ubuntu_postgres
	install_ubuntu_rails
}


#=================================================================================
# DETECT OS
#=================================================================================
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    echo $OS
    set_up_rails_stack_linux
    ;;
  'FreeBSD')
    OS='FreeBSD'
    echo $OS
    ;;
  'WindowsNT')
    OS='Windows'
    echo $OS
    ;;
  'Darwin') 
    OS='Mac'
    echo $OS
    ;;
  'SunOS')
    OS='Solaris'
    echo $OS
    ;;
  *) ;;
esac
