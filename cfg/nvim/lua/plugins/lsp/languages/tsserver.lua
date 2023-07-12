-- return {
--   settings = {
--     typescript = {
--       inlayHints = {
--         includeInlayEnumMemberValueHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
--         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayVariableTypeHints = true,
--       },
--     },
--   },
-- }

return {
  require("typescript").setup({
    -- disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    go_to_source_definition = {
      fallback = true, -- fall back to standard LSP definition on failure
    },
    server = {
      -- pass options to lspconfig's setup method
      settings = {
        -- javascript = {
        --   inlayHints = {
        --     includeInlayConstantValueHints = true,
        --     includeInlayEnumMemberValueHints = true,
        --     includeInlayFunctionLikeReturnTypeHints = true,
        --     includeInlayFunctionParameterTypeHints = false,
        --     includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        --     includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        --     includeInlayPropertyDeclarationTypeHints = true,
        --     includeInlayVariableTypeHints = true,
        --   },
        -- },
        typescript = {
          inlayHints = {
            includeInlayConstantValueHints = true,
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      },
    },
    -- require("null_ls").setup({
    --   sources = {
    --     require("typescript.extensions.null-ls.code-actions"),
    --   },
    -- }),
  }),
}
