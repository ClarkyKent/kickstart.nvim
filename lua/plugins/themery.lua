return {
  -- THEMERY PLUGIN
  {
    'zaldih/themery.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('themery').setup {
        themes = {
          {
            name = 'Tokyonight - Night',
            colorscheme = 'tokyonight-night',
          },
          {
            name = 'Tokyonight - Moon',
            colorscheme = 'tokyonight-moon',
          },
          {
            name = 'Tokyonight - Storm',
            colorscheme = 'tokyonight-storm',
          },
          {
            name = 'Kanagawa - Dragon',
            colorscheme = 'kanagawa-dragon',
          },
          {
            name = 'Kanagawa - Wave',
            colorscheme = 'kanagawa-wave',
          },
          {
            name = 'gruvbox',
            colorscheme = 'gruvbox',
          },
          {
            name = 'Rosepine',
            colorscheme = 'rose-pine-main',
          },
          {
            name = 'Rosepine Moon',
            colorscheme = 'rose-pine-moon',
          },
          {
            name = 'Catppuccin',
            colorscheme = 'catppuccin',
          },
          {
            name = 'Nord',
            colorscheme = 'nord',
          },
          {
            name = 'Nightfox',
            colorscheme = 'nightfox',
          },
          {
            name = 'Github - Dark',
            colorscheme = 'github_dark',
          },
          {
            name = 'Edge - Dark',
            colorscheme = 'edge',
          },
          {
            name = 'Gruvbox Material - Dark',
            colorscheme = 'gruvbox-material',
          },
          {
            name = 'Everforest',
            colorscheme = 'everforest',
          },
          {
            name = 'Ayu',
            colorscheme = 'ayu',
          },
          {
            name = 'gruber-darker',
            colorscheme = 'gruber-darker',
          },
          {
            name = 'nightfox',
            colorscheme = 'nightfox',
          },
          {
            name = 'dayfox',
            colorscheme = 'dayfox',
          },
          {
            name = 'kanso-ink',
            colorscheme = 'kanso-ink',
          },
          {
            name = 'kanso-zen',
            colorscheme = 'kanso-zen',
          },
          {
            name = 'yorumi',
            colorscheme = 'yorumi',
          },
          {
            name = 'nightfly',
            colorscheme = 'nightfly',
          },
          {
            name = 'ayu-dark',
            colorscheme = 'ayu-dark',
          },
          {
            name = 'ayu-mirage',
            colorscheme = 'ayu-mirage',
          },
          {
            name = 'ayu-light',
            colorscheme = 'ayu-light',
          },
          {
            name = 'onenord-light',
            colorscheme = 'onenord-light',
          },
          {
            name = 'moonfly',
            colorscheme = 'moonfly',
          },
        },
        livePreview = true,
      }
      vim.keymap.set('n', '<c-t>', ':Themery<CR>', { desc = 'Open Theme Switcher' })
    end,
  },

  -- Themes
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    lazy = true,
    opts = { style = 'moon', transparent = true },
    config = function(_, opts)
      require('tokyonight').setup(opts)
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    opts = { flavour = 'mocha', transparent_background = true },
    config = function(_, opts)
      require('catppuccin').setup(opts)
    end,
  },
  {
    'ellisonleao/gruvbox.nvim',
    name = 'gruvbox',
    lazy = true,
    opts = {},
    config = function(_, opts)
      require('gruvbox').setup(opts)
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    opts = { variant = 'main', disable_background = true },
    config = function(_, opts)
      require('rose-pine').setup(opts)
    end,
  },
  {
    'blazkowolf/gruber-darker.nvim',
    name = 'gruber-darker',
    opts = {
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },
    },
    config = function(_, opts)
      require('gruber-darker').setup(opts)
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    name = 'nightfox',
    opts = {},
    config = function(_, opts)
      require('nightfox').setup(opts)
    end,
  },
  {
    'webhooked/kanso.nvim',
    name = 'kanso',
    opts = {
      italics = false,
    },
    config = function(_, opts)
      require('kanso').setup(opts)
    end,
  },
  {
    'folke/tokyonight.nvim',
    'rebelot/kanagawa.nvim',
    {
      'rose-pine/neovim',
      name = 'rose-pine',
    },
    {
      'catppuccin/nvim',
      name = 'catppuccin',
    },
    'shaunsingh/nord.nvim',
    'EdenEast/nightfox.nvim',
    'projekt0n/github-nvim-theme',
    'sainnhe/edge',
    'sainnhe/gruvbox-material',
    'sainnhe/everforest',
    'ayu-theme/ayu-vim',
  },
  {
    'bluz71/vim-nightfly-guicolors',
    priority = 1000,
    config = function()
      vim.g.nightflyItalics = true
      vim.g.nightflyCursorColor = true
      vim.g.nightflyNormalFloat = true
      vim.g.nightflyWinSeparator = 2
    end,
  },
  {
    'yorumicolors/yorumi.nvim',
  },
  {
    'bluz71/vim-moonfly-colors',
  },
  {
    'Shatur/neovim-ayu',
  },
  {
    'rmehri01/onenord.nvim',
  },
}
