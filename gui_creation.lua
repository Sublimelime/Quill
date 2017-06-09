--[[
   A file that holds all the functions this mod uses for gui creation.
--]]

--Displays a gui for renaming a note
function makeRenameNoteGUI(gui)
   local player = game.players[gui.player_index]
   local dropDown = gui["quill-notes-list-frame"]["quill-notes-list-drop-down"]
   local renameNoteFrame= gui.add{
      type="frame",
      direction="horizontal",
      name="quill-rename-note-frame",
      caption="Rename " .. dropDown.items[dropDown.selected_index]
   }
   renameNoteFrame.add{
      type="label",
      caption="Rename note to: ",
      name="quill-rename-note-label"
   }
   renameNoteFrame.add{
      type="textfield",
      name="quill-rename-note-text-field"
   }
   renameNoteFrame.add{
      type="button",
      caption="Rename",
      tooltip="Rename this note.",
      name="quill-confirm-rename-button"
   }

   renameNoteFrame.add{
      type="button",
      caption="Cancel",
      name="quill-cancel-rename-button"
   }
   return renameNoteFrame
end


--Makes a gui for displaying an existing note
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
   saveCancelFlow.add{
      type="button",
      caption="Chat",
      tooltip="Print this entire note to chat, for sharing. If you are not an admin, your max print length depends on your time played on this save.",
      name="quill-print-note-to-chat-button"
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

   newNoteFrame.style.minimal_width = 450
   newNoteFrame.style.maximal_height= 550
   newNoteFrame.style.minimal_height = 550
   newNoteFrame.style.maximal_width = 450

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


--Regenerates the UI of the mod completely, in the event of init or a new player.
function nukeAndRegenUI(player)
   local lGui = player.gui.left
   local cGui = player.gui.center

   --Clear the existing mod's GUI
   if lGui["quill-open-notes"] then
      lGui["quill-open-notes"].destroy()
   end
   if cGui["quill-notes-list-frame"] then
      cGui["quill-notes-list-frame"].destroy()
   end
   if cGui["quill-note-frame"] then
      cGui["quill-note-frame"].destroy()
   end

   lGui.add{ --add the open notes button
      type="button",
      caption="Notes",
      tooltip="Click to open notes.",
      name="quill-open-notes"
   }

   local noteListFrame =  constructNotesList(cGui)
end

function constructNotesList(gui)
   local noteListFrame= gui.add{
      type="frame",
      caption="Notes",
      name="quill-notes-list-frame",
      direction="vertical"
   }
   noteListFrame.style.visible = false --set to hide initially

   noteListFrame.add{
      type="drop-down",
      name="quill-notes-list-drop-down",
   }
   -- Add operation buttons, for stuff like new notes, deleting notes, etc.
   local operationsFlow = noteListFrame.add{
      type="flow",
      direction="horizontal",
      name="quill-note-operations-flow",
   }

   operationsFlow.add{
      type="button",
      name="quill-open-note-button",
      caption="Open note",
      tooltip="Opens the selected note."
   }

   operationsFlow.add{
      type="button",
      name="quill-new-note-button",
      caption="New note",
      tooltip="Create a new note."
   }
   operationsFlow.add{
      type="button",
      name="quill-delete-note-button",
      caption="Delete note",
      tooltip="Deletes the currently selected note. Must hold control to use."
   }
   operationsFlow.add{
      type="button",
      name="quill-rename-note-button",
      caption="Rename note",
      tooltip="Renames the currently selected note."
   }
   noteListFrame.add{
      type="button",
      name="quill-close-button",
      caption="Close",
      tooltip="Closes this gui."
   }

   return noteListFrame
end
