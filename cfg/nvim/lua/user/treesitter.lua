local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

configs.setup {
  ensure_installed = { "lua", "rust", "c", "javascript", "bash" },
  sync_install = false,
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
