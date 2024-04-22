fx_version 'cerulean'
game 'gta5'

author 'andreutu'
dsescription 'A FiveM script that allows the boxville cones to be used, placed and ressuplied.'
version '0.0.1'

lua54 'yes'

client_scripts {
	'client/cl_main.lua',
	'client/cl_animation.lua',
	'client/cl_resupplies.lua',
	'client/cl_handlers.lua'
}

server_scripts {
	'server/sv_main.lua',
	'server/sv_debug.lua'
}

shared_scripts {
	'config.lua',
	'@qb-core/shared/locale.lua',
	'lang/*.lua'
}

data_file 'DLC_ITYP_REQUEST' 'stream/box_cones_ytyp.ytyp'
