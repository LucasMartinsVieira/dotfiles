local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_user_command

-- Augroups
augroup("filetype_settings", {})
augroup("general_settings", {})
augroup("mappings", {})
augroup("dir_opened", {})

-- Autocmds
autocmd({ "BufNewFile", "BufRead" }, {
  group = "filetype_settings",
  pattern = { "*.ejs" },
  command = "set filetype=html",
})

autocmd("BufWritePost", {
  group = "filetype_settings",
  pattern = { "*" },
  desc = "Autoformat on save",
  callback = function()
    vim.lsp.buf.format()
  end,
})

autocmd("FileType", {
  group = "filetype_settings",
  pattern = "lir",
  desc = "Disable relative/line numbers in lir windows",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- INFO: Disable mini.indentscope for the following file types:
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "help",
    "alpha",
    "dashboard",
    "neo-tree",
    "NvimTree",
    "Trouble",
    "lazy",
    "mason",
    "notify",
    "toggleterm",
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

autocmd("TextYankPost", {
  pattern = "*",
  group = "general_settings",
  desc = "Highlight text on yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "Search", timeout = 100 })
  end,
})

autocmd("filetype", {
  group = "mappings",
  desc = "Make q close help, man, lir",
  pattern = {
    "qf",
    "help",
    "man",
    "floaterm",
    "lspinfo",
    "lir",
    "lsp-installer",
    "null-ls-info",
    "tsplayground",
    "DressingSelect",
    "Jaq",
  },
  callback = function()
    vim.keymap.set("n", "q", "<CMD>q!<CR>", { buffer = true })
    vim.opt_local.buflisted = false
  end,
})

cmd("OpenCodeRepo", function(_)
  local filePath = vim.fn.expand("<cfile>")
  local isUrl = string.match(filePath, "^https?://")

  if isUrl then
    vim.fn.system({ "xdg-open", filePath })
  else
    local repoUrl = ""
    local platform =
      vim.fn.inputlist({ "Select platform: ", "GitHub", "GitLab" })

    if platform == 1 then
      local ghpath = vim.api.nvim_eval("shellescape(expand('<cfile>'))")
      local formatpath = ghpath:sub(2, #ghpath - 1)
      repoUrl = "https://www.github.com/" .. formatpath
    elseif platform == 2 then
      local glpath = vim.api.nvim_eval("shellescape(expand('<cfile>'))")
      local formatpath = glpath:sub(2, #glpath - 1)
      repoUrl = "https://www.gitlab.com/" .. formatpath
    end

    vim.fn.system({ "xdg-open", repoUrl })
  end
end, {
  desc = "Open code repository",
  force = true,
})
