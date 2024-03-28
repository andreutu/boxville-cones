fx_version 'cerulean'
game 'gta5'

author 'andreutu'
dsescription 'A FiveM script that allows the boxville cones to be used, placed and ressuplied.'
version '0.0.1'

lua54 'yes'

client_scripts {
	'client/cl_main.lua',
	'client/cl_animation.lua',
	'client/cl_debug.lua'
}

server_scripts {
	'server/sv_main.lua'
}

shared_script 'config.lua'
