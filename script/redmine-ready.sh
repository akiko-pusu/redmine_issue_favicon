#!/bin/sh

cd /tmp/
wget http://www.redmine.org/releases/redmine-${REDMINE_VERSION}.tar.gz
tar zxf redmine-${REDMINE_VERSION}.tar.gz


cd /tmp/redmine-${REDMINE_VERSION}

# switch target version of redmine
cat << HERE >> config/database.yml
test:
  adapter: mysql2
  database: redmine_test
  host: 127.0.0.1
  username: root
  password: ""
  encoding: utf8mb4
HERE

# move redmine source to wercker source directory
echo
mkdir -p /tmp/redmine-${REDMINE_VERSION}/plugins/${CIRCLE_PROJECT_REPONAME}

# Move Gemfile.local to Gemfile only for test
mv ~/repo/Gemfile.local ~/repo/Gemfile

mv ~/repo/* /tmp/redmine-${REDMINE_VERSION}/plugins/${CIRCLE_PROJECT_REPONAME}/
mv ~/repo/.* /tmp/redmine-${REDMINE_VERSION}/plugins/${CIRCLE_PROJECT_REPONAME}/
mv /tmp/redmine-${REDMINE_VERSION}/* ~/repo/
mv /tmp/redmine-${REDMINE_VERSION}/.* ~/repo/
ls -la ~/repo/
