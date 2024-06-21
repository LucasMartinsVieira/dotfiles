return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = vim.fn.executable("make") == 1,
    },
  },

  cmd = "Telescope",
  -- stylua: ignore
  keys = {
    { "<leader>bb", require('telescope.builtin').buffers,                     desc = "Buffers" },
    { "<leader>ff", require('telescope.builtin').find_files,                  desc = "Find Files" },
    { "<leader>fx", require('telescope.builtin').diagnostics,                 desc = "Find Diagnostics" },
    { "<leader>fr", require('telescope.builtin').oldfiles,                    desc = "Find Recent Files" },
    { "<leader>fb", require('telescope.builtin').buffers,                     desc = "Find Buffers" },
    { "<leader>fs", require('telescope.builtin').live_grep,                   desc = "Find String" },
    { "<leader>fS", require('telescope.builtin').grep_string,                 desc = "Find String Under Cursor" },
    { "<leader>fc", require('telescope.builtin').colorscheme,                 desc = "Find Colorscheme" },
    { "<leader>fk", require('telescope.builtin').keymaps,                     desc = "Find Keymaps" },
    { "<leader>fm", require('telescope.builtin').man_pages,                   desc = "Find Man Pages" },
    { "<leader>fh", require('telescope.builtin').help_tags,                   desc = "Find Help" },

    { "<leader>xt", require('telescope.builtin').diagnostics,                 desc = "Telescope Diagnostics" },
  },
  config = function()
    local icons = require("user.icons")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    local trouble = require("trouble.sources.telescope")

    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Find Neovim Files" })

    require("telescope").setup({
      defaults = {
        prompt_prefix = icons.ui.Telescope .. " ",
        selection_caret = icons.ui.Forward .. " ",
        path_display = { "smart" },
        -- file_ignore_patterns = {
        --   "node_modules",
        --   ".git",
        -- },
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
            ["<C-h>"] = actions.which_key,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<esc>"] = actions.close,
            ["<C-t>"] = trouble.open,
            ["<C-y>"] = actions.select_default,
          },

          n = {
            ["<esc>"] = actions.close,
            ["q"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["dd"] = actions.delete_buffer,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,
            ["?"] = actions.which_key,
            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,
            ["<C-t>"] = trouble.open,
          },
        },
      },
      pickers = {
        buffers = {
          previewer = true,
          initial_mode = "insert",
          theme = "dropdown",
        },

        find_files = {
          previewer = true,
          -- theme = "dropdown",
          hidden = "true",
        },

        git_files = {
          previewer = true,
          -- theme = "dropdown",
          hidden = "true",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })
  end,
}
