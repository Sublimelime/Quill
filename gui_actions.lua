require("gui_creation")

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
      elseif element.name == "quill-cancel-rename-button" then
         element.parent.destroy()
         player.gui.center["quill-notes-list-frame"].style.visible = true --show list again
      elseif element.name == "quill-save-note-button" then
         if element.parent.parent.name == "quill-existing-note-frame" then
            saveExistingNote(player)
         else
            saveAsNewNote(player)
         end

      elseif element.name == "quill-delete-note-button" then
         if event.control then
            deleteCurrentNote(player)
         else
            player.print("Hold control while clicking to delete note.")
         end
      elseif element.name == "quill-open-note-button" then
         if global.player_notes[player.index][player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"].selected_index] then
            element.parent.parent.style.visible = false
            makeExistingNoteGUI(player.gui.center)
         else
            player.print("There is no note at that position.")
         end
      elseif element.name == "quill-rename-note-button" then
         if global.player_notes[player.index][player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"].selected_index] then
            player.gui.center["quill-notes-list-frame"].style.visible = false
            makeRenameNoteGUI(player.gui.center)
         else
            player.print("Cannot rename a non-existant note.")
         end
      elseif element.name == "quill-confirm-rename-button" then
         renameNote(player)
         player.gui.center["quill-rename-note-frame"].destroy()
         player.gui.center["quill-notes-list-frame"].style.visible = true
      end

   end
)

--Actually does the rename of the current note
function renameNote(player)
   local dropDown = player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"]
   --fix the notes table
   global.player_notes[player.index][dropDown.selected_index].name = player.gui.center["quill-rename-note-frame"]["quill-rename-note-text-field"].text

   --Fix the dropdown
   local itemsList = dropDown.items
   itemsList[dropDown.selected_index] = player.gui.center["quill-rename-note-frame"]["quill-rename-note-text-field"].text
   dropDown.items = itemsList
   dropDown.selected_index = #dropDown.items
end


--Saves the currently open note as a new note.
function saveAsNewNote(player)
   if player.gui.center["quill-new-note-frame"]["quill-note-text-box"] then
      local textBox = player.gui.center["quill-new-note-frame"]["quill-note-text-box"]
      --add the new note to the player's list of notes
      table.insert(global.player_notes[player.index],{name="Untitled",contents=textBox.text})
      --add the new note to the player's note list dropdown
      local dropDown = player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"]
      dropDown.add_item("Untitled")
      dropDown.selected_index = #dropDown.items
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

   local itemsList = dropDown.items
   table.remove(itemsList, dropDown.selected_index)
   dropDown.items = itemsList
   dropDown.selected_index = #dropDown.items

end
