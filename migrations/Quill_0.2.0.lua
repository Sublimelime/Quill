if global.notes ~= nil then --name change migration
   global.notes1 = global.notes
end

global.notes2 = {}
global.notes3 = {}
global.note_number = {}

for index, player in pairs(game.players) do
   global.notes2[index] = "Page 2 of notes."
   global.notes3[index] = "Page 3 of notes."
   global.note_number[index] = 1
   player.gui.center["quill-frame"].destroy()
   makeGui(player)
end

game.print("[Quill] migration for 0.2.0 applied successfully.")
