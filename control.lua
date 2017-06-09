--[[
   Quill mod by Gangsir. This mod adds a gui for taking several notes,
   allowing for players to keep track of things they need to remember,
   resources they need for their next setup, etc.
   To submit an issue for this mod, please visit the Bitbucket repository
   denoted in the homepage of the mod.

   The below comments are mostly for the author's memory, but may help
   some understand the gui scripting better.

   GUI NAME DEFINITIONS ----------
   PLAYER.LEFT
   quill-open-notes : The small button that opens up the mod's UI.

   PLAYER.CENTER
   quill-notes-list-frame : The frame that holds a dropdown, and a few buttons. Used for selecting the note to edit/display.
   quill-close-button : Generic close button, closes it's parent frame
   quill-note-frame : A frame with a text field, rename button, delete button, text box, etc. Used for actually writing notes.

   ELEMENTS
   quill-delete-button : Deletes the note that it's pressed on.
   quill-rename-text-field : Text field used for renaming the current note.
   quill-note-text-box : A text box used for actually writing the note.

--]]
