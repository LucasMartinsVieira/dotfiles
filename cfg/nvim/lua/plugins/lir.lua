return {
  {
    "tamago324/lir.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    -- event = "VeryLazy",
    enabled = false,
    config = function()
      local actions = require("lir.actions")
      local mark_actions = require("lir.mark.actions")
      local clipboard_actions = require("lir.clipboard.actions")
      require("lir").setup({
        show_hidden_files = true,
        ignore = {}, -- { ".DS_Store", "node_modules" } etc.
        devicons = {
          enable = true,
          highlight_dirname = true,
        },
        mappings = {
          ["l"] = actions.edit,
          ["<C-s>"] = actions.split,
          ["<C-v>"] = actions.vsplit,
          ["<C-t>"] = actions.tabedit,

          ["h"] = actions.up,
          ["q"] = actions.quit,

          ["K"] = actions.mkdir,
          ["N"] = actions.newfile,
          ["R"] = actions.rename,
          ["@"] = actions.cd,
          ["Y"] = actions.yank_path,
          ["."] = actions.toggle_show_hidden,
          ["D"] = actions.delete,

          ["J"] = function()
            mark_actions.toggle_mark()
            vim.cmd("normal! j")
          end,
          ["C"] = clipboard_actions.copy,
          ["X"] = clipboard_actions.cut,
          ["P"] = clipboard_actions.paste,
        },
        float = {
          winblend = 0,
          curdir_window = {
            enable = false,
            highlight_dirname = true,
          },

          win_opts = function()
            local width = math.floor(vim.o.columns * 0.7)
            local height = math.floor(vim.o.lines * 0.7)
            return {
              border = "rounded",
              width = width,
              height = height,
            }
          end,
          -- -- You can define a function that returns a table to be passed as the third
          -- -- argument of nvim_open_win().
        },
        hide_cursor = false,
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = { "lir" },
        callback = function()
          -- use visual mode
          vim.api.nvim_buf_set_keymap(
            0,
            "x",
            "J",
            ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
            { noremap = true, silent = true }
          )

          -- echo cwd
          vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
        end,
      })

      -- custom folder icon
      require("nvim-web-devicons").set_icon({
        lir_folder_icon = {
          icon = "",
          color = "#7ebae4",
          name = "LirFolderNode",
        },
      })
    end,
  },
}

