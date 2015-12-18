#!/bin/bash


#=================================================================================
# SYSTEM UPDATE
#=================================================================================
update_ubuntu_system () {
	# Update your system
	sudo apt-get update
	apt-get update
}

update_centos_system () {
	# Update your system
	sudo yum update
	yum -y update
}


#=================================================================================
# GIT INSTALLATION
#=================================================================================
install_ubuntu_git () {
	# Call update_system
	update_ubuntu_system
	# Install git and dependencies
	sudo apt-get install -y git
	sudo apt-get install -y build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
}

install_git_centos () {
	# Update system
	update_centos_system
	sudo yum install -y git
}


#=================================================================================
# POSTGRESQL INSTALLATION
#=================================================================================
install_ubuntu_postgres () {
	# Call update_system
	update_ubuntu_system
	# Install POSTGRESQL and depencies
	sudo apt-get install -y postgresql postgresql-contrib libpq-dev
}

install_centos_postgres () {
	# Update system
	update_centos_system
	sudo yum install -y postgresql94-server
	/usr/pgsql-9.4/bin/postgresql94-setup initdb
	chkconfig postgresql-9.4 on
	service postgresql-9.4 start
}

install_postgres_mac () {
	sudo brew install postgresql

	# To have launchd start postgresql at login:
	ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents

	# Then to load postgresql now:
	launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
}


#=================================================================================
# RUBY INSTALLATION
#=================================================================================
install_ubuntu_rails () {
	# Call update_system
	update_ubuntu_system
	# Install the rbenv and Ruby dependencies
	sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
	cd
	git clone git://github.com/sstephenson/rbenv.git .rbenv
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
	echo 'eval "$(rbenv init -)"' >> ~/.bashrc

	git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
	. ~/.bashrc

	# Install rails and set global version
	# rbenv install -v 2.2.3
	# rbenv global 2.2.3

	# Install bundler gem
	# gem install rails
	# gem install bundler

	# Install Ruby
	if [ $# -gt 0 ] 
	then
		rbenv install $1
		rbenv global $1
	else
		rbenv install 2.2.2
		rbenv global 2.2.2
	fi

	# Install rails
	if [ -z "$2" ] 
	then
		gem install rails -v $2
	else
		gem install rails -v 4.2.4
	fi

}

install_rails_centos () {
	# Update system
	update_centos_system

	sudo yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel
	cd
	git clone git://github.com/sstephenson/rbenv.git .rbenv
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
	echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
	exec $SHELL

	git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
	echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
	exec $SHELL

	rbenv install -v 2.2.2
	rbenv global 2.2.2

	gem install bundler
	gem install rails

	sudo yum -y install epel-release
	sudo yum -y install nodejs
}

install_rails_mac () {
	sudo brew install rbenv ruby-build

	# Add rbenv to bash so that it loads every time you open a terminal
	echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
	source ~/.bash_profile

	# Install Ruby
	if [ $# -gt 0 ] 
	then
		rbenv install $1
		rbenv global $1
	else
		rbenv install 2.2.2
		rbenv global 2.2.2
	fi

	# Install rails
	if [ -z "$2" ] 
	then
		gem install rails -v $2
	else
		gem install rails -v 4.2.4
	fi
}

#=================================================================================
# MAIN INSTALLATION METHODS
#=================================================================================
set_up_rails_stack_linux () {
	install_ubuntu_git
	install_ubuntu_postgres
	install_ubuntu_rails
}

set_up_rails_stack_centos () {
	install_git_centos
	install_centos_postgres
	install_rails_centos
}

set_up_rails_stack_mac () {
	install_postgres_mac
	install_rails_mac
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
  'Darwin') 
    OS='Mac'
    echo $OS
    set_up_rails_stack_mac
    ;;
  *) ;;
esac
