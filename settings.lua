Settings = {}

Settings.permission_check_callback = "ndl_admin:hasperms" -- Callback to check if the player has the permission to open the admin duty menu
Settings.no_permission_triggerevent = "" -- Trigger event to show a message if the player doesn't have the permission to open the admin duty menu
Settings.Ace_Permission = "ndl_admin" -- Ace permission to check if the player has the permission to open the admin duty menu only if you use ndl_admin:hasperms for the callback!

Settings.key = "HOME" -- Key to open the admin duty menu

Settings.duty_triggerevent = "ndl_admin:toggleDuty" -- Trigger event to toggle the admin duty status
Settings.extra_triggerevent = "ndl_admin:toggleLogs" -- Trigger event to toggle the logs