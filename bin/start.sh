#!/bin/bash

cd `dirname $BASH_SOURCE`/..

make build

./node_modules/.bin/supervisor -g -w lib ./lib/app.js

# ./node_modules/.bin/supervisor \
#   -g -w lib -ejs,coffee -x ./node_modules/.bin/coffee -- \
#   ./lib/app.coffee