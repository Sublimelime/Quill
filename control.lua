--Makes the gui for the notepad.
function makeGui(player)
   player.gui.left.add{type="button",name="quill-button",caption="Notes"}.tooltip = "Click to open/close notes."

   --make the initial frame, that holds the text box
   local frame = player.gui.center.add{type="frame",name="quill-frame",caption="Notes"}
   frame.style.minimal_width = 850
   frame.style.maximal_width = 850
   frame.style.minimal_height = 800
   frame.style.maximal_height = 800

   frame.style.visible = false --turn it off initially

   local text = frame.add{type="text-box",name="quill-textbox"} --the actual place to write the notes

   text.style.minimal_height = 700
   text.style.minimal_width = 750
   text.style.maximal_height = 700
   text.style.maximal_width = 750

   text.text = global.notes1[player.index] or "Take notes here. Notes are saved between sessions, and are private. The box will scroll if text exceeds the boundaries."

   local buttonFlow= frame.add{type="flow", name="quill-button-flow"}

   buttonFlow.direction = "vertical"
   buttonFlow.style.minimal_height = 700
   buttonFlow.style.minimal_width = 70
   buttonFlow.style.maximal_height = 700
   buttonFlow.style.maximal_width = 70

   buttonFlow.add{type="button",name="quill-close",caption="Close",tooltip="Close this window."}
   buttonFlow.add{type="button",name="quill-previous",caption="<<<",tooltip="Previous page of notes"}
   buttonFlow.add{type="button",name="quill-next",caption=">>>",tooltip="Next page of notes"}


end

--saves the text the player wrote into the global table.
function saveText(player)
   if global["notes" .. global.note_number[player.index]][player.index] then
      global["notes" .. global.note_number[player.index]][player.index] = player.gui.center["quill-frame"]["quill-textbox"].text
   end
end


function toggleGui(player)
   local guiEle = player.gui.center["quill-frame"]

   --[[
      game.print(serpent.block(global.notes1))
      game.print(serpent.block(global.notes2))
      game.print(serpent.block(global.notes3))
   --]]

   if guiEle.valid and guiEle.style.visible == true then
      saveText(player)
      global.note_number[player.index] = 1
      player.gui.center["quill-frame"]["quill-textbox"].text = global.notes1[player.index]
      guiEle.style.visible = false
   else
      guiEle.style.visible = true
   end

end


script.on_event({defines.events.on_player_created},
   function(e)
      local player = game.players[e.player_index]
      if not player.gui.center["quill-frame"] then
         global.notes1[player.index] = "Take notes here. Notes are saved between sessions, and are private. The box will scroll if text exceeds the boundaries."
         global.notes2[player.index] = "Second page of notes."
         global.notes3[player.index] = "Third page of notes."
         global.note_number[e.player_index] = 1
         makeGui(player)
      end
   end
)

script.on_event({defines.events.on_gui_click},
   function(e)
      if e.element.name == "quill-button" or e.element.name == "quill-close" then
         local player = game.players[e.player_index]
         toggleGui(player)
      elseif e.element.name == "quill-next" then
         saveText(game.players[e.player_index])
         --game.print("Next was pressed, number is currently: " .. global.note_number[e.player_index])
         global.note_number[e.player_index] = global.note_number[e.player_index] +1
         if global.note_number[e.player_index] > 3 then
            global.note_number[e.player_index] = 1
         end

         game.players[e.player_index].gui.center["quill-frame"]["quill-textbox"].text = global["notes" .. global.note_number[e.player_index]][e.player_index] or ""
         game.players[e.player_index].gui.center["quill-frame"].caption = "Notes - " .. global.note_number[e.player_index]
      elseif e.element.name == "quill-previous" then
         saveText(game.players[e.player_index])
         --game.print("Previous was pressed, number is currently: " .. global.note_number[e.player_index])
         global.note_number[e.player_index] = global.note_number[e.player_index] - 1
         if global.note_number[e.player_index] < 1 then
            global.note_number[e.player_index] = 3
         end

         game.players[e.player_index].gui.center["quill-frame"]["quill-textbox"].text = global["notes" .. global.note_number[e.player_index]][e.player_index] or ""
         game.players[e.player_index].gui.center["quill-frame"].caption = "Notes - " .. global.note_number[e.player_index]
      end
   end
)

script.on_init(
   function()
      global.notes1 = global.notes1 or {}
      global.notes2 = global.notes2 or {}
      global.notes3 = global.notes3 or {}
      global.note_number = global.note_number or {}

      for index,player in pairs(game.players) do
         if not player.gui.center["quill-frame"] then
            global.notes1[player.index] = "Take notes here. Notes are saved between sessions, and are private. The box will scroll if text exceeds the boundaries."
            global.notes2[player.index] = "Second page of notes."
            global.notes3[player.index] = "Third page of notes."
            global.note_number = 1
            makeGui(player)
         end
      end
   end
)

script.on_configuration_changed(
   function()
      for index,player in pairs(game.players) do --reset guis
         player.gui.center["quill-frame"].destroy()
         player.gui.left["quill-button"].destroy()
         global.note_number[index] = 1
         makeGui(player)
      end
   end
)
