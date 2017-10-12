#!/bin/sh

apt-get install subversion
cd /tmp/
svn checkout http://svn.redmine.org/redmine/branches/${REDMINE_VERSION} redmine

cd /tmp/redmine

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
mkdir -p /tmp/redmine/plugins/${CIRCLE_PROJECT_REPONAME}

# Move Gemfile.local to Gemfile only for test
mv ~/repo/Gemfile.local ~/repo/Gemfile

mv ~/repo/* /tmp/redmine/plugins/${CIRCLE_PROJECT_REPONAME}/
mv ~/repo/.* /tmp/redmine/plugins/${CIRCLE_PROJECT_REPONAME}/
mv /tmp/redmine/* ~/repo/
mv /tmp/redmine/.* ~/repo/
ls -la ~/repo/
