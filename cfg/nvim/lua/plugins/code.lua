return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        ---Add a space b/w comment and the line
        padding = true,
        ---Whether the cursor should stay at its position
        sticky = true,
        ---Lines to be ignored while (un)comment
        ignore = nil,
        ---LHS of toggle mappings in NORMAL mode
        toggler = {
          ---Line-comment toggle keymap
          line = "gcc",
          ---Block-comment toggle keymap
          block = "gbc",
        },
        ---LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          ---Line-comment keymap
          line = "gc",
          ---Block-comment keymap
          block = "gb",
        },
        ---LHS of extra mappings
        extra = {
          ---Add comment on the line above
          above = "gcO",
          ---Add comment on the line below
          below = "gco",
          ---Add comment at the end of line
          eol = "gcA",
        },
        ---Enable keybindings
        ---NOTE: If given `false` then the plugin won't create any mappings
        mappings = {
          ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          ---Extra mapping; `gco`, `gcO`, `gcA`
          extra = true,
        },
        ---Function to call before (un)comment
        pre_hook = nil,
        ---Function to call after (un)comment
        post_hook = nil,
      })
    end,
  },
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
    end,
  },
  {
    {
      "echasnovski/mini.surround",
      event = "VeryLazy",
      version = "*",
      opts = {
        -- No need to copy this inside `setup()`. Will be used automatically.
        {
          -- Add custom surroundings to be used on top of builtin ones. For more
          -- information with examples, see `:h MiniSurround.config`.
          custom_surroundings = nil,
          -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
          highlight_duration = 500,
          -- Module mappings. Use `''` (empty string) to disable one.
          mappings = {
            add = "sa", -- Add surrounding in Normal and Visual modes
            delete = "sd", -- Delete surrounding
            find = "sf", -- Find surrounding (to the right)
            find_left = "sF", -- Find surrounding (to the left)
            highlight = "sh", -- Highlight surrounding
            replace = "sr", -- Replace surrounding
            update_n_lines = "sn", -- Update `n_lines`
            suffix_last = "l", -- Suffix to search with "prev" method
            suffix_next = "n", -- Suffix to search with "next" method
          },
          -- Number of lines within which surrounding is searched
          n_lines = 20,
          -- How to search for surrounding (first inside current line, then inside
          -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
          -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
          -- see `:h MiniSurround.config`.
          search_method = "cover",
        },
      },
      config = function(_, opts)
        require("mini.surround").setup(opts)
      end,
    },
  },
  {
    {
      "echasnovski/mini.pairs",
      event = "VeryLazy",
      version = "*",
      opts = {
        -- No need to copy this inside `setup()`. Will be used automatically.
        {
          -- In which modes mappings from this `config` should be created
          modes = { insert = true, command = false, terminal = false },

          -- Global mappings. Each right hand side should be a pair information, a
          -- table with at least these fields (see more in |MiniPairs.map|):
          -- - <action> - one of 'open', 'close', 'closeopen'.
          -- - <pair> - two character string for pair to be used.
          -- By default pair is not inserted after `\`, quotes are not recognized by
          -- `<CR>`, `'` does not insert pair after a letter.
          -- Only parts of tables can be tweaked (others will use these defaults).
          mappings = {
            ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
            ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
            ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

            [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
            ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
            ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

            ['"'] = {
              action = "closeopen",
              pair = '""',
              neigh_pattern = "[^\\].",
              register = { cr = false },
            },
            ["'"] = {
              action = "closeopen",
              pair = "''",
              neigh_pattern = "[^%a\\].",
              register = { cr = false },
            },
            ["`"] = {
              action = "closeopen",
              pair = "``",
              neigh_pattern = "[^\\].",
              register = { cr = false },
            },
          },
        },
      },

      config = function(_, opts)
        require("mini.pairs").setup(opts)
      end,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    keys = {
      {
        "<c-t>",
        "<CMD>ToggleTerm<CR>",
        desc = "Terminal",
      },
      {
        "<space>tt",
        "<CMD>ToggleTerm direction=horizontal<CR>",
        desc = "Terminal Horizontal",
      },
      {
        "<space>tf",
        "<CMD>ToggleTerm direction=float<CR>",
        desc = "Terminal Float",
      },
      {
        "<space>tv",
        "<CMD>ToggleTerm size=40 direction=vertical<CR>",
        desc = "Terminal Vertical",
      },
      {
        "<space>tl",
        "<cmd>lua require 'user.functions'.lua_terminal()<cr>",
        desc = "Lua",
      },
      {
        "<space>tn",
        "<cmd>lua require 'user.functions'.node_terminal()<cr>",
        desc = "Node",
      },
      {
        "<space>td",
        "<cmd>lua require 'user.functions'.deno_terminal()<cr>",
        desc = "Deno",
      },
      {
        "<space>tp",
        "<cmd>lua require 'user.functions'.python_terminal()<cr>",
        desc = "Python",
      },
      {
        "<space>tb",
        "<cmd>lua require 'user.functions'.btop_terminal()<cr>",
        desc = "Btop",
      },
      {
        "<space>gg",
        "<cmd>lua require 'user.functions'.lazygit_toggle()<cr>",
        desc = "LazyGit",
      },
    },
    config = function()
      require("toggleterm").setup({
        size = 16,
        open_mapping = [[<c-t>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",

    cmd = { "TroubleToggle" },
    keys = {
      {
        "<space>xx",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Document Diagnostics (Trouble)",
      },
      {
        "<space>xX",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics (Trouble)",
      },
      {
        "<space>xL",
        "<cmd>TroubleToggle loclist<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<space>xQ",
        "<cmd>TroubleToggle quickfix<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },

    config = function()
      local icons = require("user.icons")
      require("trouble").setup({
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 7, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = {
          -- key mappings for actions in the trouble list
          -- map to {} to remove a mapping, for example:
          -- close = {},
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" }, -- open buffer in new split
          open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
          open_tab = { "<c-t>" }, -- open buffer in new tab
          jump_close = { "o" }, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" }, -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k", -- previous item
          next = "j", -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
        signs = {
          -- icons / text used for a diagnostic
          error = icons.diagnostics.error,
          warning = icons.diagnostics.warning,
          hint = icons.diagnostics.hint,
          information = icons.diagnostics.information,
          other = icons.diagnostics.other,
        },
        use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
      })
    end,
  },
  {
    "folke/todo-comments.nvim",

    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<space>ft", "<CMD>TodoTelescope<CR>", desc = "Telescope Todo" },
    },

    config = function()
      local icons = require("user.icons")
      require("todo-comments").setup({
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = icons.ui.Check, color = "info" },
          HACK = { icon = icons.ui.Fire, color = "warning" },
          WARN = {
            icon = icons.diagnostics.warning,
            color = "warning",
            alt = { "WARNING", "XXX" },
          },
          PERF = {
            icon = icons.ui.Dashboard,
            alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
          },
          NOTE = { icon = icons.ui.Note, color = "hint", alt = { "INFO" } },
          TEST = {
            icon = icons.ui.Clock,
            color = "test",
            alt = { "TESTING", "PASSED", "FAILED" },
          },
        },
        gui_style = {
          fg = "NONE", -- The gui style to use for the fg highlight group.
          bg = "BOLD", -- The gui style to use for the bg highlight group.
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          before = "", -- "fg" or "bg" or empty
          keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
          after = "fg", -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of highlight groups or use the hex color if hl not found as a fallback
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
      })
    end,
  },
}
