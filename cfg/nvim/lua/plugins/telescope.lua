return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require("telescope").load_extension("neoclip")
        require("neoclip").setup({
          preview = true,
        })
      end
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = vim.fn.executable("make") == 1,
    },
  },
  cmd = "Telescope",
  keys = {
    { "<space>b", "<CMD>Telescope buffers<CR>",      desc = "[B]uffers" },
    { "<space>ff", "<CMD>Telescope find_files<CR>",   desc = "Find Files" },
    { "<space>fb", "<CMD>Telescope buffers<CR>",      desc = "Find Buffers" },
    { "<space>fg", "<CMD>Telescope live_grep<CR>",    desc = "Find Words" },
    { "<space>fc", "<CMD>Telescope colorscheme<CR>",  desc = "Find Colorscheme", },
    { "<space>fk", "<CMD>Telescope find_files<CR>",   desc = "Find Keymaps" },
    { "<space>fm", "<CMD>Telescope find_files<CR>",   desc = "Find Man Pages" },
    { "<space>fC", "<CMD>Telescope neoclip<CR>",      desc = "Find Clip Board" },

    -- Git Commands
    { "<space>gs", "<CMD>Telescope git_status<CR>",   desc = "Telescope Git Status" },
    { "<space>gc", "<CMD>Telescope git_commits<CR>",  desc = "Telescope Git Commits" },
    { "<space>gf", "<CMD>Telescope git_files<CR>",    desc = "Telescope Git Files" },
    { "<space>gb", "<CMD>Telescope git_branches<CR>", desc = "Telescope Git Branches" },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            ["<c-d>"] = actions.delete_buffer,
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
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      },
    })
  end,
}
