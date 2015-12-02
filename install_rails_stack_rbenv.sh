#!/bin/bash


#=================================================================================
# LINUX SYSTEM UPDATE
#=================================================================================
update_ubuntu_system () {
	# Update your system
	sudo apt-get update
}

update_centos_system () {
	# Update your system
	sudo yum update
}


#=================================================================================
# LINUX GIT INSTALLATION
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
# LINUX POSTGRESQL INSTALLATION
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


#=================================================================================
# LINUX RUBY INSTALLATION
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

install_rails_centos () {
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


#=================================================================================
# DETECT OS
#=================================================================================
OS="`uname`"
case $OS in
  'Linux')
    OS='Linux'
    # echo $OS
    # set_up_rails_stack_linux
    LINUX_FLAVOUR = $(python -mplatform | grep Ubuntu | echo ubuntu || echo centos)
    if [ "$LINUX_FLAVOUR" == "linux" ];
    	then
    	if [ "$LINUX_FLAVOUR" == "ubuntu" ];
			then
				set_up_rails_stack_linux
			elif [ "$LINUX_FLAVOUR" == "centos" ];
			then
				set_up_rails_stack_centos
			else
				echo "Unknown OS. Aborting Installation"
			fi
		fi
	fi
    ;;
  'Darwin') 
    OS='Mac'
    echo $OS
    ;;
  *) ;;
esac
