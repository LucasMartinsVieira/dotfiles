local M = {}

M.common_capabilities = function()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },

    -- Markdown-oxide
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  }

  return capabilities
end

---@diagnostic disable-next-line: unused-local
M.on_attach = function(client, bufnr)
  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format({ async = true })
  end, { desc = "Format current buffer with LSP" })

  M.toggle_lsp_inlayhints()

  -- Markdown_oxide

  vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave", "CursorHold", "LspAttach", "BufEnter" }, {
    buffer = bufnr,
    callback = function()
      if M.check_codelens_support() then
        vim.lsp.codelens.refresh({ bufnr = 0 })
      end
    end,
  })
  -- trigger codelens refresh
  vim.api.nvim_exec_autocmds("User", { pattern = "LspAttached" })
end

M.check_codelens_support = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  for _, c in ipairs(clients) do
    if c.server_capabilities.codeLensProvider then
      return true
    end
  end
  return false
end

M.toggle_lsp_inlayhints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  -- vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled())
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

return M
