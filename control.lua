require('util')

require('tms')

script.on_event(defines.events.on_player_selected_area, tms_selectiontool)
script.on_event("tms-toggle", tms_toggle)