

function makeGui(player)
   --make the initial frame, that holds the text box
   local frame = player.gui.center.add{type="frame",name="quill-frame",caption="Notes"}
   frame.style.minimal_width = 850
   frame.style.maximal_width = 850
   frame.style.minimal_height = 800
   frame.style.maximal_height = 800

   frame.style.visible = false --turn it off initially

   local text = frame.add{type="text-box",name="quill-textfield"} --the actual place to write the notes

   text.style.minimal_height = 700
   text.style.minimal_width = 750
   text.style.maximal_height = 700
   text.style.maximal_width = 750

   text.text = global.notes[player.index] or ""

   frame.add{type="button",name="quill-close",caption="Close",tooltip="Close this window."}

end

--saves the text the player wrote into the global table.
function saveText(player)
   if global.notes[player.index] then
      global.notes[player.index] = player.gui.center["quill-frame"]["quill-textfield"].text
   end
end


function toggleGui(player)
   local guiEle = player.gui.center["quill-frame"]

   if guiEle.valid and guiEle.style.visible == true then
      saveText(player)
      guiEle.style.visible = false
   else
      guiEle.style.visible = true
   end

end


script.on_event({defines.events.on_player_created},
   function(e)
      local player = game.players[e.player_index]
      if not player.gui.center["quill-frame"] then
         global.notes[e.player_index] = ""
         player.gui.left.add{type="button",name="quill-button",caption="Notes"}.tooltip = "Click to open/close notes."
         makeGui(player)
      end
   end
)

script.on_event({defines.events.on_gui_click},
   function(e)
      if e.element.name == "quill-button" or e.element.name == "quill-close" then
         local player = game.players[e.player_index]
         toggleGui(player)
      end
   end
)

script.on_init(
   function()
      global.notes = global.notes or {}
      for index,player in pairs(game.players) do
         if not player.gui.center["quill-frame"] then
            global.notes[player.index] = ""
            player.gui.left.add{type="button",name="quill-button",caption="Notes"}.tooltip = "Click to open/close notes."
            makeGui(player)
         end
      end
   end
)
