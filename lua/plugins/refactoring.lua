return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  lazy = false,
  opts = {},
  keys = {
    -- Remaps for the refactoring operations currently offered by the plugin
    {
      '<leader>cre',
      function()
        require('refactoring').refactor 'Extract Function'
      end,
      desc = 'Extract function',
      mode = 'v',
      silent = true,
      expr = false,
    },
    {
      '<leader>crf',
      function()
        require('refactoring').refactor 'Extract Function To File'
      end,
      desc = 'Extract function to file',
      mode = 'v',
      silent = true,
      expr = false,
    },
    {
      '<leader>crv',
      function()
        require('refactoring').refactor 'Extract Variable'
      end,
      desc = 'Extract variable',
      mode = 'v',
      silent = true,
      expr = false,
    },
    {
      '<leader>cri',
      function()
        require('refactoring').refactor 'Inline Variable'
      end,
      desc = 'Inline variable',
      mode = 'v',
      silent = true,
      expr = false,
    },
    -- Extract block doesn't need visual mode
    {
      '<leader>crb',
      function()
        require('refactoring').refactor 'Extract Block'
      end,
      desc = 'Extract block',
      mode = 'n',
      silent = true,
      expr = false,
    },
    {
      '<leader>crbf',
      function()
        require('refactoring').refactor 'Extract Block To File'
      end,
      desc = 'Extract block to file',
      mode = 'n',
      silent = true,
      expr = false,
    },
    -- Inline variable can also pick up the identifier currently under the cursor without visual mode
    {
      '<leader>cri',
      function()
        require('refactoring').refactor 'Inline Variable'
      end,
      desc = 'Inline variable',
      mode = 'n',
      silent = true,
      expr = false,
    },
  },
}
