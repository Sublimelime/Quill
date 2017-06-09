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
         player.gui.center["quill-notes-list-frame"].style.visible = true --show list again
      elseif element.name == "quill-save-note-button" then
         if element.parent.parent.name == "quill-existing-note-frame" then
            saveExistingNote(player)
         else
            saveAsNewNote(player)
         end

      elseif element.name == "quill-delete-note-button" then
         deleteCurrentNote(player)
      elseif element.name == "quill-open-note-button" then
         if global.player_notes[player.index][player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"].selected_index] then
            element.parent.parent.style.visible = false
            makeExistingNoteGUI(player.gui.center)
         else
            player.print("There is no note at that position.")
         end
      end

   end
)

function makeExistingNoteGUI(gui)

   local player = game.players[gui.player_index]
   local existingNoteFrame= gui.add{
      type="frame",
      direction="vertical",
      name="quill-existing-note-frame",
      caption=global.player_notes[gui.player_index][gui["quill-notes-list-frame"]["quill-notes-list-drop-down"].selected_index].name
   }

   existingNoteFrame.style.minimal_width = 500
   existingNoteFrame.style.maximal_height= 600
   existingNoteFrame.style.minimal_height = 600
   existingNoteFrame.style.maximal_width = 500

   local textBox= existingNoteFrame.add{
      type="text-box",
      name="quill-note-text-box",
   }

   textBox.word_wrap = true
   textBox.style.minimal_width = 400
   textBox.style.maximal_height= 400
   textBox.style.minimal_height = 400
   textBox.style.maximal_width = 400
   textBox.text = global.player_notes[gui.player_index][gui["quill-notes-list-frame"]["quill-notes-list-drop-down"].selected_index].contents

   local saveCancelFlow= existingNoteFrame.add{
      type="flow",
      direction="horizontal",
      name="quill-save-cancel-flow"
   }
   saveCancelFlow.add{
      type="button",
      caption="Save",
      tooltip="Save note.",
      name="quill-save-note-button"
   }
   saveCancelFlow.add{
      type="button",
      caption="Cancel",
      tooltip="Exit without saving note.",
      name="quill-cancel-note-button"
   }

   gui["quill-notes-list-frame"].style.visible = false --hide note list

   return existingNoteFrame
end


--Creates a gui for a new note.
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

   gui["quill-notes-list-frame"].style.visible = false --hide note list

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
      player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"].selected_index = 1
      player.gui.center["quill-new-note-frame"].destroy() --close the new note screen
      player.gui.center["quill-notes-list-frame"].style.visible = true --show list again
   end
end

--Saves the existing note, after being modified
function saveExistingNote(player)
   if player.gui.center["quill-existing-note-frame"]["quill-note-text-box"] then
      local textBox = player.gui.center["quill-existing-note-frame"]["quill-note-text-box"]

      global.player_notes[player.index][player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"].selected_index].contents = textBox.text

      player.gui.center["quill-existing-note-frame"].destroy()
      player.gui.center["quill-notes-list-frame"].style.visible = true --show list again
   end
end


--Deletes the currently selected note.
function deleteCurrentNote(player)
   local dropDown = player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"]
   if not global.player_notes[player.index][dropDown.selected_index] then
      player.print("There is no note to delete at that position.")
      return
   end


   --remove the note from the table
   table.remove(global.player_notes[player.index],dropDown.selected_index)


end
