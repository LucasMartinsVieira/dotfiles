local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
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
