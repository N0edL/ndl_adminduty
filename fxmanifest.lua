fx_version      "cerulean"
game            "gta5"
lua54           "yes"
use_fxv2_oal    "yes"

author          "NoedL"
version         "1.0.2"
license         "MIT"
repository      "https://github.com/N0edL/ndl_adminduty"

shared_scripts {
    '@es_extended/imports.lua'
}

client_script   "client.lua"
server_script   "server.lua"
ui_page         "html/index.html"
files {
    "html/index.html",
    "html/script.js",
    "html/style.css"
}