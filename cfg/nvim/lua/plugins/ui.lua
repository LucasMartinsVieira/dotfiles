local icons = require("user.icons")

return {
  {
    "norcalli/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    keys = {
      { "<space>C", "<CMD>ColorizerToggle<CR>", desc = "Colorizer Toggle" },
    },
  },
  {
    "psliwka/vim-smoothie",
  },
  {
    "goolord/alpha-nvim",
    enabled = true,

    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local function button(sc, txt, keybind, keybind_opts)
        local b = dashboard.button(sc, txt, keybind, keybind_opts)
        b.opts.hl_shortcut = "Macro"
        return b
      end

      -- dashboard.section.header.val = {
      -- [[  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
      -- [[  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
      -- [[  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
      -- [[  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
      -- [[  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
      -- [[  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
      -- }

      -- dashboard.section.header.val = {
        -- [[                                                                       ]],
        -- [[  ██████   █████                   █████   █████  ███                  ]],
        -- [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
        -- [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
        -- [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
        -- [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
        -- [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
        -- [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
        -- [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
        -- [[                                                                       ]],
      -- }
      dashboard.section.header.val = {
      	[[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆         ]],
      	[[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
      	[[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷⠄⠄⠄⠄⠻⠿⢿⣿⣧⣄     ]],
      	[[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
      	[[          ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
      	[[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘⠄ ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
      	[[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
      	[[ ⣠⣿⠿⠛⠄⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
      	[[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇⠄⠛⠻⢷⣄ ]],
      	[[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
      	[[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
      }

      dashboard.section.buttons.val = {
        button(
          "f",
          icons.ui.Telescope .. " Find File",
          "<CMD>Telescope find_files<CR>"
        ),
        button(
          "n",
          icons.ui.NewFile .. " New file",
          "<CMD>ene!<BAR>startinsert<CR>"
        ),
        button(
          "r",
          icons.ui.History .. " Recent Files",
          "<CMD>Telescope oldfiles<CR>"
        ),
        button(
          "c",
          icons.ui.Gear .. " Config",
          "<CMD>e ~/.config/nvim/init.lua<CR>"
        ),
        button("u", icons.ui.CloudDownload .. " Update", "<CMD>Lazy sync<CR>"),
        button("q", icons.ui.SignOut .. " Quit", "<CMD>q<CR>"),
      }
      local function footer()
        return "https://github.com/LucasMartinsVieira"
      end

      dashboard.section.footer.val = footer()

      dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Macro"
      dashboard.section.footer.opts.hl = "Type"

      dashboard.opts.opts.noautocmd = true
      return dashboard
    end,

    config = function(_, dashboard)
      require("alpha").setup(dashboard.opts)
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    enabled = true,
    event = "VeryLazy",
    keys = {
      -- { "<space>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin", },
      -- { "<space>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<space>bN", "<Cmd>BufferLineMoveNext<CR>", desc = "Move Buffer Next" },
      { "<space>bP", "<Cmd>BufferLineMovePrev<CR>", desc = "Move Buffer Prev" },
    },
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
          close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
          right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
          left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
          middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
          indicator = {
            icon = icons.ui.Separator,
            style = "icon",
          },
          buffer_close_icon = icons.ui.Close,
          modified_icon = icons.ui.Circle,
          close_icon = icons.ui.Close,
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 30,
          max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
          tab_size = 20,
          diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
          diagnostics_update_in_insert = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "center",
              padding = 1,
            },
          },
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
          separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
          enforce_regular_tabs = true,
          always_show_bufferline = false,
        },
      })
    end,
  },
  {
    {
      "RRethy/vim-illuminate",
      event = { "BufReadPost", "BufNewFile" },
      opts = { delay = 200 },
      config = function(_, opts)
        require("illuminate").configure(opts)

        local function map(key, dir, buffer)
          vim.keymap.set("n", key, function()
            require("illuminate")["goto_" .. dir .. "_reference"](false)
          end, {
            desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference",
            buffer = buffer,
          })
        end

        map("]]", "next")
        map("[[", "prev")

        -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
        vim.api.nvim_create_autocmd("FileType", {
          callback = function()
            local buffer = vim.api.nvim_get_current_buf()
            map("]]", "next", buffer)
            map("[[", "prev", buffer)
          end,
        })
      end,
      keys = {
        { "]]", desc = "Next Reference" },
        { "[[", desc = "Prev Reference" },
      },
    },
  },
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    config = function()
      require("nvim-navic").setup({
        icons = {
          File = icons.kind.File .. " ",
          Module = icons.kind.Module .. " ",
          Namespace = icons.kind.Namespace .. " ",
          Package = icons.kind.Package .. " ",
          Class = icons.kind.Class .. " ",
          Method = icons.kind.Method .. " ",
          Property = icons.kind.Property .. " ",
          Field = icons.kind.Field .. " ",
          Constructor = icons.kind.Constructor .. " ",
          Enum = icons.kind.Enum .. " ",
          Interface = icons.kind.Interface .. " ",
          Function = icons.kind.Function .. " ",
          Variable = icons.kind.Variable .. " ",
          Constant = icons.kind.Constant .. " ",
          String = icons.kind.String .. " ",
          Number = icons.kind.Number .. " ",
          Boolean = icons.kind.Boolean .. " ",
          Array = icons.kind.Array .. " ",
          Object = icons.kind.Object .. " ",
          Key = icons.kind.Keyword .. " ",
          Null = icons.kind.Null .. " ",
          EnumMember = icons.kind.EnumMember .. " ",
          Struct = icons.kind.Struct .. " ",
          Event = icons.kind.Event .. " ",
          Operator = icons.kind.Operator .. " ",
          TypeParameter = icons.kind.TypeParameter .. " ",
        },
        highlight = true,
        separator = " " .. icons.ui.ChevronRight .. " ",
        depth_limit = 0,
        depth_limit_indicator = "..",
        safe_output = true,
      })
    end,
  },
  {
    "folke/noice.nvim",
    event = "VimEnter",
    enabled = true,
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "notify",
          opts = {},
        },
        routes = {
          {
            view = "notify",
            filter = { event = "msg_showmode" },
          },
        },
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        stages = "slide",
        timeout = 1000,
        render = "default",
      })
    end,
  },
  {
    "folke/twilight.nvim",
    keys = {
      { "<space>zt", "<CMD>Twilight<CR>", desc = "Twilight" },
    },
    config = function()
      require("twilight").setup({
        {
          dimming = {
            alpha = 0.25, -- amount of dimming
            -- we try to get the foreground from the highlight groups or fallback color
            color = { "Normal", "#ffffff" },
            term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
            inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
          },
          context = 10, -- amount of lines we will try to show around the current line
          treesitter = true, -- use treesitter when available for the filetype
          -- treesitter is used to automatically expand the visible text,
          -- but you can further control the types of nodes that should always be fully expanded
          expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
            "function",
            "method",
            "table",
            "if_statement",
          },
          exclude = {}, -- exclude these filetypes
        },
      })
    end,
  },
  {
    "folke/zen-mode.nvim",
    enabled = true,
    cmd = "ZenMode",
    keys = {
      { "<space>zz", "<CMD>ZenMode<CR>", desc = "Zen Mode" },
    },
    config = function()
      require("zen-mode").setup({
        window = {
          backdrop = 0.85, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          -- height and width can be:
          -- * an absolute number of cells when > 1
          -- * a percentage of the width / height of the editor when <= 1
          -- * a function that returns the width or the height
          width = 105, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            number = false, -- disable number column
            relativenumber = false, -- disable relative numbers
            cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
          },
          -- twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = false }, -- disables git signs
          tmux = { enabled = false }, -- disables the tmux statusline
          -- this will change the font size on kitty when in zen mode
          -- to make this work, you need to set the following kitty options:
          -- - allow_remote_control socket-only
          -- - listen_on unix:/tmp/kitty
          kitty = {
            enabled = false,
            font = "+4", -- font size increment
          },
          -- this will change the font size on alacritty when in zen mode
          -- requires  Alacritty Version 0.10.0 or higher
          -- uses `alacritty msg` subcommand to change font size
          alacritty = {
            enabled = false,
            font = "14", -- font size
          },
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function(win) end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function() end,
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      local keymaps = {
        mode = { "n", "v" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<space>f"] = { name = "+Find" },
        ["<space>a"] = { name = "+Ai" },
        ["<space>g"] = { name = "+Git" },
        ["<space>t"] = { name = "+Terminal" },
        ["<space>x"] = { name = "+Diagnostics" },
        ["<space>l"] = { name = "+Lsp" },
        ["<space>c"] = { name = "+Crates" },
        ["<space>r"] = { name = "+Rust" },
        ["<space>o"] = { name = "+Options" },
        ["<space>b"] = { name = "+Buffers" },
        ["<space>j"] = { name = "+JavaScript/Typescript" },
        ["<space>s"] = { name = "Substitute Text" },
      }

      wk.register(keymaps)
    end,
  },
}
