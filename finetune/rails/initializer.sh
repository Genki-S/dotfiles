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

