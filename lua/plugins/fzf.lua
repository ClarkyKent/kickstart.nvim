return {
  'ibhagwan/fzf-lua',
  lazy = true,
  cmd = 'FzfLua',
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function(_, opts)
    require('fzf-lua').setup {
      fzf_opts = { ['--wrap'] = true },
      fzf_colors = {
        ['pointer'] = { 'fg', { 'Red' } },
        ['hl'] = { 'fg', { 'Red' } },
        ['hl+'] = { 'fg', { 'Red' } },
        ['fg+'] = { 'fg', { 'White' } },
        ['prompt'] = { 'fg', { 'Blue' } },
        ['query'] = { 'fg', { 'Yellow' } },
      },
      winopts = {
        preview = {
          wrap = 'wrap',
        },
        formatter = 'path.filename_first',
      },
      --           winopts = { ...  },     -- UI Options
      -- keymap = { ...  },      -- Neovim keymaps / fzf binds
      -- actions = { ...  },     -- Fzf 'accept" binds
      -- fzf_opts = { ...  },    -- Fzf CLI flags
      -- fzf_colors = { ...  },  -- Fzf `--color` specification
      -- hls = { ...  },         -- Highlights
      -- previewers = { ...  },  -- Previewers options
      -- -- SPECIFIC COMMAND/PICKER OPTIONS, SEE BELOW
      -- -- files = { ... },
    }

    local function fzf_directories(opts)
      local fzf_lua = require 'fzf-lua'
      local fzf_path = require 'fzf-lua.path'
      opts = opts or {}

      local cwd = vim.fn.getcwd()
      opts.prompt = fzf_path.shorten(cwd) .. '> '
      opts.cwd = cwd

      fzf_lua.fzf_exec('fd --type d', opts)
    end

    vim.api.nvim_create_user_command('FzfDirectories', function()
      fzf_directories {}
    end, {})
  end,
  keys = {
    { '<leader>ff', '<cmd>FzfLua files<CR>', desc = '[F]iles' },
    { '<leader>ca', '<cmd>FzfLua lsp_code_actions<CR>', desc = '[C]ode [A]ctions' },
    { '<leader>fr', '<cmd>FzfLua oldfiles<CR>', desc = '[R]ecent files' },
    -- { '<leader>fb', '<cmd>FzfLua buffers<CR>', desc = '[B]uffers' },
    { '<leader>fh', '<cmd>FzfLua help_tags<CR>', desc = 'Help tags' },
    { '<leader>fc', '<cmd>FzfLua commands<CR>', desc = 'Commands' },
    { '<leader>fC', '<cmd>FzfLua colorschemes<CR>', desc = 'Colorscheme' },
    { '<leader>gr', '<cmd>FzfLua lsp_references<CR>', desc = 'Go to references' },
    { '<leader>fq', '<cmd>FzfLua quickfix<CR>', desc = 'Open Quickfix list' },
    { '<leader>rr', '<cmd>FzfLua registers<CR>', desc = 'Find registers list' },
    { '<leader>fh', '<cmd>FzfLua helptags<CR>', desc = '[F]ind [H]elp' },
    { '<leader>fk', '<cmd>FzfLua keymaps<CR>', desc = '[F]ind [K]eymaps' },
    -- mapcmd('n', "<leader>fp", "FzfDirectories", { desc = "[F]ind [P]aths' },
    { '<leader>fb', '<cmd>FzfLua builtin<CR>', desc = '[F]ind [B]uiltin FZF' },
    { '<leader>fw', '<cmd>FzfLua grep_cword<CR>', desc = '[F]ind current [W]ord' },
    { '<leader>fW', '<cmd>FzfLua grep_cWORD<CR>', desc = '[F]ind current [W]ORD' },
    { '<leader>fG', '<cmd>FzfLua live_grep<CR>', desc = '[F]ind by Live [G]rep' },
    { '<leader>fg', '<cmd>FzfLua grep_project<CR>', desc = '[F]ind by [G]rep' },
    { '<leader>fd', '<cmd>FzfLua diagnostics_document<CR>', desc = '[F]ind [D]iagnostics' },
    { '<leader>fr', '<cmd>FzfLua resume<CR>', desc = '[F]ind [R]esume' },
    { '<leader><leader>', '<cmd>FzfLua buffers<CR>', desc = '[,] Find existing buffers' },
    { '<leader>/', '<cmd>FzfLua lgrep_curbuf<CR>', desc = '[/] Live grep the current buffer' },
    { '<leader>fS', '<cmd>FzfLua lsp_workspace_symbols<CR>', desc = '[F]ind Workspace [S]ymbols' },
    { '<leader>fs', '<cmd>FzfLua lsp_document_symbols<CR>', desc = '[F]ind Document [S]ymbols' },

    -- Search in neovim config
    {
      '<leader>fn',
      '<cmd>FzfLua files<CR>',
      { cwd = vim.fn.stdpath 'config' },
      desc = '[F]ind Neovim [C]onfig files',
    },
    -- Search in my dotfiles config
    {
      '<leader>fD',
      '<cmd>FzfLua files<CR>',
      { cwd = os.getenv 'HOME' .. '/dotfiles' },
      desc = '[F]ind [D]otfiles',
    },
  },
}
