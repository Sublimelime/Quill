
--returns a char array, given a string
function toCharArray(str)
   local t = {}
   str:gsub(".",function(c) table.insert(t,c) end)
   return t
end


-- Function used for alphabetical sorting
function sortingFunction(one, two)
   local oneNameTable = nil
   local twoNameTable = nil
   --determine if we're sorting a table of notes, or a table of strings

   if type(one) == "table" then
      oneNameTable = toCharArray(one.name)
      twoNameTable = toCharArray(two.name)
   elseif type(one) == "string" then
      oneNameTable = toCharArray(one)
      twoNameTable = toCharArray(two)
   end

   local counter = 1

   while oneNameTable[counter] and twoNameTable[counter] do
      if oneNameTable[counter]:byte() < twoNameTable[counter]:byte() then
         return true
      elseif oneNameTable[counter]:byte() > twoNameTable[counter]:byte() then
         return false
      else
         counter = counter +1
      end
   end
   return true
end

--sorts a player's notes alphabetically by title.
function sortNotes(player)
   --game.print("Before: " .. serpent.block(global.player_notes[player.index]))

   --sort the global table
   local notes = global.player_notes[player.index]
   table.sort(notes, sortingFunction)
   global.player_notes[player.index] = notes

   --sort the dropdown
   local dropDown = player.gui.center["quill-notes-list-frame"]["quill-notes-list-drop-down"]
   notes = dropDown.items
   table.sort(notes, sortingFunction)
   dropDown.items = notes
   dropDown.selected_index = #dropDown.items

   --game.print("After: " .. serpent.block(global.player_notes[player.index]))
end
