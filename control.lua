require("gui_actions")
require("gui_creation")

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
   quill-new-note-frame : A frame with a text field, text box, etc. Used for making a new note.

   ELEMENTS
   quill-delete-button : Deletes the note that it's pressed on.
   quill-rename-text-field : Text field used for renaming the current note.
   quill-note-text-box : A text box used for actually writing the note.
   quill-notes-list-drop-down : The dropdown that lists all the notes for a player

   GLOBAL SETUP'
   The mod's data is held in a table, inside global.player_notes.
   global.player_notes is indexed by the player number used for
   game.players, for example the notes of the first player on the save
   is at global.player_notes[1]. At each position, there is a series of tables
   indexed by number, each note is a table, that looks like
   {name="note 1",contents="Note contents..."}

   The name and contents are used to construct the note gui when it's loaded.
--]]

script.on_init(
   function()
      global.player_notes = {}
      for index,player in pairs(game.players) do --in case the mod was added to a save.
         nukeAndRegenUI(player)
      end
   end
)

script.on_event({defines.events.on_player_created},
   function(e)
      global.player_notes[e.player_index] = {}
      nukeAndRegenUI(game.players[e.player_index])
   end
)

script.on_configuration_changed(
   function()
      global.player_notes = global.player_notes or {}
      for index,player in pairs(game.players) do --in case the mod was added to a save.
         global.player_notes[index] = global.player_notes[index] or {}
         nukeAndRegenUI(player)
      end
   end
)
