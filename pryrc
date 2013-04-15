# Aliases
Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
Pry.commands.alias_command 'f', 'finish'

# Views
require "awesome_print"
AwesomePrint.pry!

require "hirb"
Hirb.enable
# Make "table" and "view" commands available
extend Hirb::Console
