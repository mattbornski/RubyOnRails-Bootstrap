#!/bin/bash

cd $(dirname $0)

heroku create
git push heroku master
heroku ps:scale web=1
heroku open
