return {
  settings = {
    Lua = {
      format = {
        enable = false,
      },
      diagnostics = {
        globals = { "vim" },
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          --[vim.fn.expand("config") .. "/lua"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      hint = {
        enable = false,
        arrayIndex = "Disable", -- "Enable" | "Auto" | "Disable"
        await = true,
        paramName = "All", -- "All" | "SameLine" | "Disable"
        semicolon = "All", -- "All" | "SameLine" | "Disable"
        setType = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
