data:extend{
   {
      type="sprite",
      name="quill-notes-sprite",
      filename = "__Quill__/graphics/quill.png",
      priority = "extra-high",
      width = 32,
      height = 32,
   },
   {
      type="sprite",
      name="quill-add-note-sprite",
      filename = "__core__/graphics/add-icon.png",
      priority = "extra-high",
      width = 32,
      height = 32,
   },
   {
      type="sprite",
      name="quill-cancel-sprite",
      filename = "__core__/graphics/cancel.png",
      priority = "extra-high",
      width = 64,
      height = 64,
   },
   {
      type="sprite",
      name="quill-confirm-sprite",
      filename = "__core__/graphics/confirm.png",
      priority = "extra-high",
      width = 64,
      height = 64,
   },
   {
      type="sprite",
      name="quill-delete-sprite",
      filename = "__core__/graphics/remove-icon.png",
      priority = "extra-high",
      width = 64,
      height = 64,
   },
   {
      type="sprite",
      name="quill-open-note-sprite",
      filename = "__Quill__/graphics/open.png",
      priority = "extra-high",
      width = 32,
      height = 32,
   },
   {
      type="sprite",
      name="quill-rename-note-sprite",
      filename = "__core__/graphics/rename-normal.png",
      priority = "extra-high",
      width = 32,
      height = 32,
   },
}

data.raw["gui-style"].default.quill_buttons = {
   type="button_style",
   parent="button_style",
   maximal_height = 65,
   minimal_height = 65,
   maximal_width = 65,
   minimal_width = 65,
   top_padding = 0,
   bottom_padding = 0,
   right_padding = 0,
   left_padding = 0,
   left_click_sound = {
      {
         filename = "__core__/sound/gui-click.ogg",
         volume = 1
      }
   },
   right_click_sound = {
      {
         filename = "__core__/sound/gui-click.ogg",
         volume = 1
      }
   }
}

data.raw["gui-style"].default.quill_small_buttons = {
   type="button_style",
   parent="button_style",
   maximal_height = 33,
   minimal_height = 33,
   maximal_width = 33,
   minimal_width = 33,
   top_padding = 0,
   bottom_padding = 0,
   right_padding = 0,
   left_padding = 0,
   left_click_sound = {
      {
         filename = "__core__/sound/gui-click.ogg",
         volume = 1
      }
   },
   right_click_sound = {
      {
         filename = "__core__/sound/gui-click.ogg",
         volume = 1
      }
   }
}
