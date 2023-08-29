fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
author 'Zaps6000'

local uniformFile = 'outfits.json'

file(uniformFile)
uniform_file(uniformFile)

client_script "menu.lua"

shared_scripts {
    '@ox_lib/init.lua',
}
