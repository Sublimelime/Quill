for index, player in pairs(game.players) do
   if player.gui.left["quill-button"] then
      player.gui.left["quill-button"].destroy()
   end
   if player.gui.left["quill-frame"] then
      player.gui.left["quill-frame"].destroy()
   end
end

game.print("[Quill] Migration for 0.2.0 applied sucessfully.")
