#!/bin/bash

cd $(dirname $0)

heroku apps:info
if [ "$?" != "0" ] ; then
	git remote rm heroku
	heroku apps:create $(basename $PWD | tr '[A-Z]' '[a-z]')
fi
git push heroku master
heroku ps:scale web=1
heroku open
