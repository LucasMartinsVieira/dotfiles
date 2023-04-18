return {
  "Bryley/neoai.nvim",
  cmd = {
    "NeoAI",
    "NeoAIOpen",
    "NeoAIClose",
    "NeoAIToggle",
    "NeoAIContext",
    "NeoAIContextOpen",
    "NeoAIContextClose",
    "NeoAIInject",
    "NeoAIInjectCode",
    "NeoAIInjectContext",
    "NeoAIInjectContextCode",
  },
  keys = {
    { "<space>ai", "<CMD>NeoAIToggle<CR>",       desc = "NeoAi Toggle" },
  },
  config = function()
    require("neoai").setup({
      -- Options go here
      ui = {
        output_popup_text = "NeoAI",
        input_popup_text = "Prompt",
        width = 32,               -- As percentage eg. 30%
        output_popup_height = 80, -- As percentage eg. 80%
      },
      shortcuts = {
        {
          name = "textify",
          key = "<space>as",
          desc = "fix text with AI",
          use_context = true,
          prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
          modes = { "v" },
          strip_function = nil,
        },
        {
          name = "gitcommit",
          key = "<space>ag",
          desc = "generate git commit message",
          use_context = false,
          prompt = function()
            return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system("git diff --cached")
          end,
          modes = { "n" },
          strip_function = nil,
        },
      },
    })
  end,
}
