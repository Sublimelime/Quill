--A file that contains the on_event scripting for the mod's gui.

script.on_event({defines.events.on_gui_click},
   function(event)
      local element = event.element
      local player = game.players[event.player_index]

      if element.name == "quill-close-button" then
         element.parent.style.visible = false
      elseif element.name == "quill-open-notes" then
         player.gui.center["quill-notes-list-frame"].style.visible = true
      end

   end
)
