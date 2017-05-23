global.notes = global.notes or {}


function makeGui(player)
   local frame = player.gui.center.add{type="frame",name="quill-frame",caption="Notes"}
   frame.style.minimal_width = 800
   frame.style.maximal_width = 800
   frame.style.minimal_height = 800
   frame.style.maximal_height = 800


   local text = frame.add{type="textfield",name="quill-textfield"}

   text.style.minimal_height = 750
   text.style.minimal_width = 750
   text.style.maximal_height = 750
   text.style.maximal_width = 750


end

function toggleGui(player)
   local guiEle = player.gui.center["quill-frame"]

   if guiEle.valid and guiEle.style.visible == true then
      guiEle.style.visible = false
   else
      guiEle.style.visible = true
   end

end


script.on_event({defines.events.on_player_created},
   function(e)
      local player = game.players[e.player_index]
      table.insert(global.notes,{player=player,note=""})

      player.gui.left.add{type="button",name="quill-button",caption="Notes"}.tooltip = "Click to open notes."

   end
)

script.on_event({defines.events.on_gui_click},
   function(e)
      if e.element.name == "quill-button" then

         local player = game.players[e.player_index]

         makeGui(player)
         game.print("opened notes.")
      end
   end
)
