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
    { "<C-p>", "<CMD>lua require ('telescope.builtin').git_files()<CR>",      desc = "Find Files" },

    { "<leader>bb", "<CMD>Telescope buffers<CR>",                             desc = "Buffers" },
    { "<leader>ff", "<CMD>Telescope find_files<CR>",                          desc = "Find Files" },
    { "<leader>fx", "<CMD>Telescope diagnostics<CR>",                         desc = "Find Diagnostics" },
    { "<leader>fr", "<CMD>Telescope oldfiles<CR>",                            desc = "Find Recent Files" },
    { "<leader>fb", "<CMD>Telescope buffers<CR>",                             desc = "Find Buffers" },
    { "<leader>fw", "<CMD>Telescope live_grep<CR>",                           desc = "Find Word" },
    { "<leader>fc", "<CMD>Telescope colorscheme<CR>",                         desc = "Find Colorscheme" },
    { "<leader>fk", "<CMD>Telescope Keymaps<CR>",                             desc = "Find Keymaps" },
    { "<leader>fm", "<CMD>Telescope man_pages<CR>",                           desc = "Find Man Pages" },
    { "<leader>fh", "<CMD>Telescope help_tags<CR>",                           desc = "Find Help" },

    -- Git Commands
    -- { "<leader>gs", "<CMD>Telescope git_status<CR>",                          desc = "Telescope Git Status" },
    -- { "<leader>gc", "<CMD>Telescope git_commits<CR>",                         desc = "Telescope Git Commits" },
    -- { "<leader>gf", "<CMD>Telescope git_files<CR>",                           desc = "Telescope Git Files" },
    -- { "<leader>gb", "<CMD>Telescope git_branches<CR>",                        desc = "Telescope Git Branches" },
  },
  config = function()
    local icons = require("user.icons")
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        prompt_prefix = icons.ui.Telescope .. " ",
        selection_caret = icons.ui.Forward .. " ",
        file_ignore_patterns = {
          "node_modules",
          ".git",
        },
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

        git_files = {
          previewer = true,
          theme = "dropdown",
          hidden = "true",
        },

        oldfiles = {
          previewer = true,
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
        },
      },
    })
  end,
}
