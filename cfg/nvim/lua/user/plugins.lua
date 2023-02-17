vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup(function(use)
  --Plugins to support other plugins
  use({ "nvim-lua/popup.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "wbthomason/packer.nvim" })
  use({ "kyazdani42/nvim-web-devicons" })

  -- Colorschemes
  use({ "Mofiqul/dracula.nvim" })
  use({ "bluz71/vim-nightfly-guicolors" })
  use({ "romgrk/doom-one.vim" })
  use({ "lunarvim/horizon.nvim" })

  -- Telescope
  use({ "nvim-telescope/telescope.nvim" })
  use({ "nvim-telescope/telescope-project.nvim" })

  -- Bufferline
  use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' })

  -- ToggleTerm
  use({ "akinsho/toggleterm.nvim" })

  -- Neoscroll
  use({ "karb94/neoscroll.nvim" })

  -- Navic
  use({ "SmiteshP/nvim-navic" })

  -- AutoPairs
  use({ "jiangmiao/auto-pairs" })

  -- indent Blankline
  use("lukas-reineke/indent-blankline.nvim")

  -- Dashboard (Alpha)
  use({
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  })

  -- Illuminate
  use({ "RRethy/vim-illuminate" })

  -- Fidget
  use({"j-hui/fidget.nvim"})

  -- Markdown preview
  use({
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  })

  -- Auto complete
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
  })

  -- Snippets
  use({ "L3MON4D3/LuaSnip" })
  use({ "rafamadriz/friendly-snippets" })
  use({ "honza/vim-snippets" })

  -- LSP
  use({ "neovim/nvim-lspconfig" })
  use({ "williamboman/mason.nvim" })
  use({ "williamboman/mason-lspconfig.nvim" })

  -- Better lights on syntax
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "p00f/nvim-ts-rainbow" })

  -- Comments
  use({ "JoosepAlviste/nvim-ts-context-commentstring" })
  use({ "numToStr/Comment.nvim" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })

  -- Null-ls
  use({ "jose-elias-alvarez/null-ls.nvim" })

  -- Lualine
  use({ "nvim-lualine/lualine.nvim" })

  -- Nvim-tree
  use({ "kyazdani42/nvim-tree.lua" })

  -- Errors
  use({ "folke/trouble.nvim" })

  -- Todo Comments
  use({ "folke/todo-comments.nvim" })

  -- Color Highlighter
  use({ "norcalli/nvim-colorizer.lua" })
end)
