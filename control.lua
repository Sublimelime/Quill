global.notes = global.notes or {}

script.on_event({defines.events.on_player_created},
   function(e)
      local player = game.players[e.player_index]
      table.insert(global.notes,{player=player,note=""})

      player.gui.left.add{type="button",name="quill-button",caption="Notes"}

   end
)

script.on_event({defines.events.on_gui_click},
   function(e)


   end
)
