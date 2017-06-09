--A file that contains the on_event scripting for the mod's gui.

script.on_event({defines.events.on_gui_click},
   function(event)
      local element = event.element
      local player = game.players[event.player_index]

      if not string.find(element.name,"quill") then --has nothing to do with this mod
         return
      end

      if element.name == "quill-close-button" then --used only for the note list gui
         element.parent.style.visible = false
      elseif element.name == "quill-open-notes" then
         player.gui.center["quill-notes-list-frame"].style.visible = true
      elseif element.name == "quill-new-note-button" then
         makeNewNoteGUI(player.gui.center)
      elseif element.name == "quill-cancel-button" then --used for making and editing notes
         element.parent.destroy()
      elseif element.name == "quill-cancel-note-button" then
         element.parent.parent.destroy()
      elseif element.name == "quill-save-note-button" then
         saveAsNewNote(player)
      end
   end
)

function makeNewNoteGUI(gui)
   local newNoteFrame= gui.add{
      type="frame",
      direction="vertical",
      name="quill-new-note-frame",
      caption="New untitled note"
   }

   newNoteFrame.style.minimal_width = 500
   newNoteFrame.style.maximal_height= 600
   newNoteFrame.style.minimal_height = 600
   newNoteFrame.style.maximal_width = 500

   local textBox= newNoteFrame.add{
      type="text-box",
      name="quill-note-text-box",
   }
   textBox.text = "Type your note here. Notes are saved when you hit save."
   textBox.word_wrap = true
   textBox.style.minimal_width = 400
   textBox.style.maximal_height= 400
   textBox.style.minimal_height = 400
   textBox.style.maximal_width = 400

   local saveCancelFlow= newNoteFrame.add{
      type="flow",
      direction="horizontal",
      name="quill-save-cancel-flow"
   }
   saveCancelFlow.add{
      type="button",
      caption="Save",
      tooltip="Save as a new note.",
      name="quill-save-note-button"
   }
   saveCancelFlow.add{
      type="button",
      caption="Cancel",
      tooltip="Exit without saving note.",
      name="quill-cancel-note-button"
   }

   return newNoteFrame
end

--Saves the currently open note as a new note.
function saveAsNewNote(player)
   if player.gui.center["quill-new-note-frame"]["quill-note-text-box"] then
      local textBox = player.gui.center["quill-new-note-frame"]["quill-note-text-box"]
      --add the new note to the player's list of notes
      table.insert(global.player_notes[player.index],{name="Untitled",contents=textBox.text})
      --add the new note to the player's note list dropdown
      player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"].add_item("Untitled")
   end
end