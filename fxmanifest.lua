fx_version 'cerulean'
game 'gta5'

author 'andreutu'
dsescription 'A FiveM script that allows the boxville cones to be used, placed and ressuplied.'
version '0.0.1'

lua54 'yes'

client_scripts {
	'client/cl_main.lua',
	'client/cl_animation.lua',
	'client/cl_resupplies.lua'
}

server_scripts {
	'server/sv_main.lua',
	'server/sv_debug.lua'

}

shared_script 'config.lua'
