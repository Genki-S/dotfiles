# Helper

MyRailsDir=~/dotfiles/finetune/rails
ApplicationName=
vared -p "Application Name: " ApplicationName

# Project directory setup

ln -s $MyRailsDir/Gemfile.local Gemfile.local

# Bundle setup

bundle
guard init

# Inject my environment file

cp $MyRailsDir/env_genki.rb config/environments/genki.rb
sed -i "" -e "s/<REPLACEME:ApplicationName>/$ApplicationName/g" config/environments/genki.rb
# git filter
echo "config/application.rb filter=rails_genki_env" >> .git/info/attributes

# Mongoid settings
# Basically, follow the instructions at http://mongoid.org/en/mongoid/docs/installation.html
# This is also useful http://d.hatena.ne.jp/babie/20100809/1281316972
rails generate mongoid:config
rm config/database.yml
