return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  enabled = false,
  keys = {
    { "<leader>ee", "<CMD>NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
    { "<leader>er", "<CMD>NvimTreeRefresh<CR>", desc = "Refresh File Explorer" },
    { "<leader>ec", "<CMD>NvimTreeCollapse<CR>", desc = "Collapse File Explorer" },
    { "<leader>ef", "<CMD>NvimTreeFindFileToggle<CR>", desc = "Toggle File Explorer on current file" },
  },
  config = function()
    local function on_attach(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- Custom Keymaps
      vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
      vim.keymap.set("n", "<BS>", api.node.navigate.parent_close, opts("Close Directory"))
      vim.keymap.set("n", "<C-k>", api.node.show_info_popup, opts("Info"))
      vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
      vim.keymap.set("n", "a", api.fs.create, opts("Create"))
      vim.keymap.set("n", "q", api.tree.close, opts("Close"))
      vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
      vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
      vim.keymap.set("n", "y", api.fs.copy.node, opts("Copy"))
      vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
      vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
      vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Split"))
      vim.keymap.set("n", "/", api.tree.search_node, opts("Search"))
      vim.keymap.set("n", "[g", api.node.navigate.git.prev, opts("Prev Git"))
      vim.keymap.set("n", "]g", api.node.navigate.git.next, opts("Next Git"))
      vim.keymap.set("n", "]d", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
      vim.keymap.set("n", "[d", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
    end
    local icons = require("user.icons")
    require("nvim-tree").setup({
      on_attach = on_attach,
      disable_netrw = true,
      hijack_netrw = true,
      auto_reload_on_write = true,
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = true,
      hijack_unnamed_buffer_when_opening = false,
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      diagnostics = {
        enable = true,
        icons = {
          hint = icons.diagnostics.Hint,
          info = icons.diagnostics.Information,
          warning = icons.diagnostics.Warning,
          error = icons.diagnostics.Error,
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      system_open = {
        cmd = nil,
        args = {},
      },
      filters = {
        dotfiles = false,
        custom = {},
      },
      git = {
        enable = true,
        ignore = true,
        timeout = 500,
      },
      view = {
        width = 38,
        -- hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = true,
        signcolumn = "yes",
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      actions = {
        change_dir = {
          enable = true,
          global = false,
        },
        open_file = {
          quit_on_open = true,
          resize_window = true,
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = {
                "notify",
                "lazy",
                "qf",
                "diff",
                "fugitive",
                "fugitiveblame",
              },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
      },
      renderer = {
        root_folder_modifier = ":t",
        icons = {
          webdev_colors = true,
          git_placement = "before",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            git = {
              unstaged = icons.git.Unstaged,
              staged = icons.git.Staged,
              unmerged = icons.git.Unmerged,
              renamed = icons.git.Renamed,
              deleted = icons.git.Deleted,
              untracked = icons.git.Untracked,
              ignored = icons.git.Ignored,
            },
            folder = {
              default = icons.documents.Default,
              open = icons.documents.Open,
              empty = icons.documents.Empty,
              empty_open = icons.documents.Empty_open,
              symlink = icons.documents.Symlink,
            },
          },
        },
      },
    })
  end,
}
