local conditions = {
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
}

return conditions
