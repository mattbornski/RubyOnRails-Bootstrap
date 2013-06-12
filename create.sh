#!/bin/bash --login

cd $(dirname $0)

# We want to use rvm to manage our Ruby versions and gems
rvm -v >/dev/null 2>&1
if [ "$?" != 0 ] ; then
	# This command should install Ruby, Rails, and RVM if they do not exist.
	curl -L https://get.rvm.io | bash -s stable --rails --autolibs=enable
fi

# Rails has handy templates that make lots of the boilerplate structure for you.
rails new .

# Our .rvmrc file in the project directory will instruct rvm as to which Ruby version it should use with this project.
# This syntax will create a .ruby-version file and a .ruby-gemset file which, when you cd into the directory and have
# a Ruby environment switcher (like rvm) properly installed, will switch your Ruby command and your gemfiles
# directory over to be project-specific versions.  
# rvm --ruby-version --create version@gemset
# Where version is the Ruby version string and gemset is the name of the gemset you want to use for this project.
# Note that .rvmrc files can also be used for this purpose but are deprecated and are locked to only the RVM tool.
rvm --ruby-version --create 1.9.3@${APP_NAME}

# We'll be running locally and on Heroku; Heroku provides a postgresql database.
echo -e "\ngem 'pg'\n" >> Gemfile

# Heroku recommends using unicorn as production web server
echo -e "\ngem 'unicorn'\n" >> Gemfile

bundle install
