local M = {}

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, "modified")
  if modified then
    vim.ui.input({
      prompt = "You have unsaved changes. Quit anyway? (y/n) ",
    }, function(input)
      if input == "y" then
        vim.cmd("q!")
      end
    end)
  else
    vim.cmd("q!")
  end
end

function M.toggle_option(option)
  local value = not vim.api.nvim_get_option_value(option, {})
  vim.opt[option] = value
end

function M.get_winbar_information()
  if vim.bo.buftype ~= "" or vim.fn.expand("%") == "" then
    return ""
  end

  local status_ok, devicons = pcall(require, "nvim-web-devicons")
  if not status_ok then
    return
  end

  devicons.setup()

  local filename = vim.fn.expand("%:t")
  local filepath = vim.fn.expand("%:.:h")
  local file_ext = vim.fn.expand("%:e")

  local icon = ""
  if status_ok and devicons then
    local i, _ = devicons.get_icon_color(filename, file_ext, { default = true })
    if i then
      icon = i
    end
  end

  return string.format("%%#WinBar# %s %%#WinBarFile#%s %%#WinBarPath#(%s)", icon, filename, filepath)
end

function _G.WinBar()
  return M.get_winbar_information()
end

function M.get_winbar_setup()
  vim.o.winbar = "%{%v:lua.WinBar()%}"
end

return M
