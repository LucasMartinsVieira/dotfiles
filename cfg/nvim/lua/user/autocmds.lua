vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.ejs" },
  command = "set filetype=html",
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.html", "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    vim.lsp.buf.format()
  end,
})
