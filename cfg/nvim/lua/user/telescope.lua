local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require("telescope.actions")

telescope.load_extension("project")

telescope.setup({
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        ["<c-d>"] = require("telescope.actions").delete_buffer,
        ["<C-h>"] = actions.which_key,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["dd"] = actions.delete_buffer,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,
        ["?"] = actions.which_key,
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
      },
    },
  },
  pickers = {
    buffers = {
      previewer = false,
      initial_mode = "normal",
      theme = "dropdown",
    },

    find_files = {
      previewer = false,
      theme = "dropdown",
      hidden = "true",
    },

    oldfiles = {
      previewer = false,
      theme = "dropdown",
      initial_mode = "normal",
    },

    live_grep = {
      theme = "dropdown",
    },

    colorscheme = {
      theme = "dropdown",
    },
  },
  extensions = {

  },
})
