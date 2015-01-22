#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.holdcommandQ 1
/bin/echo -n .
$cli set option.mousekeys_mode_commandR2rightclick 1
/bin/echo -n .
$cli set option.mousekeys_mode_move_mouse_cursor_uio 1
/bin/echo -n .
$cli set option.emacsmode_controlLeftbracket 1
/bin/echo -n .
$cli set option.mousekeys_mode_space2middleclick 1
/bin/echo -n .
$cli set option.mousekeys_mode_commandL2leftclick 1
/bin/echo -n .
$cli set remap.simultaneouskeypresses_mouse_keys_mode_shiftSD 1
/bin/echo -n .
/bin/echo
