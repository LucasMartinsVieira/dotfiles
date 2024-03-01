return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  init = function()
    local wk = require("which-key")
    wk.register({
      ["<leader>ms"] = { ":Silicon<CR>", "Screenshot Code" },
    }, { mode = "v" })
  end,
  config = function()
    require("silicon").setup({
      -- Configuration here, or leave empty to use defaults
      font = "JetBrainsMono NF=34;Noto Color Emoji=34",
      theme = "Visual Studio Dark+",
      -- the background color outside the rendered os window
      background = "#94e2d5",
      -- whether to turn off the line numbers
      no_line_number = true,
      -- a string or function that defines the path to the output image
      output = function()
        local screenshot_foler = os.getenv("HOME") .. "/Pictures/Screenshot/code/"
        return screenshot_foler .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
      end,
      -- whether to put the image onto the clipboard, may produce an error if run on WSL2
      to_clipboard = false,
      -- a string or function returning a string that defines the title showing in the image
      -- only works in silicon versions greater than v0.5.1
      window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
      end,
    })
  end,
}
