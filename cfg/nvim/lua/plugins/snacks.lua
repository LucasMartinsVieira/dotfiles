return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
    lazygit = { configure = false },
  },
  -- stylua: ignore
  keys = {
    -- Essential keybinds 
    { "<leader>,", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>nn", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },

    { "<leader><leader>", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fc", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

    -- LSP
    { "<leader>fx", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>fX", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },

    -- Others
    { "<leader>fzc", function() Snacks.picker.command_history() end, desc = "Command History" },
    { '<leader>fzs', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>fzb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>fR", function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fm", function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help Pages" },

    -- Git
    { "<leader>fgb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>fgl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>fgL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>fgs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>fgS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>fgd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>fgf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },

    -- Grep
    { "<leader>fw", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>fW", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>fb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>fB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },

    { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    { "<leader>n.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>ns", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>lR", function() Snacks.rename.ename_file() end, desc = "Rename File" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    -- { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gG", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
   { "<c-_>", function() Snacks.terminal() end, desc = "which_key_ignore" },
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    { "<leader>N", desc = "Neovim News", function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>os")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>on")
        Snacks.toggle.diagnostics():map("<leader>od")
        Snacks.toggle.line_number():map("<leader>oN")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>oC")
        Snacks.toggle.treesitter():map("<leader>ot")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ob")
        Snacks.toggle.inlay_hints():map("<leader>lh")
        Snacks.toggle.dim():map("<leader>oD")
        Snacks.toggle.indent():map("<leader>oi")
        Snacks.toggle.scroll():map("<leader>oS")
      end,
    })
  end,
}
