local treesitter_parsers = {
  'bash',
  'c',
  'cpp',
  'gitcommit',
  'html',
  'json',
  'just',
  'lua',
  'markdown',
  'markdown_inline', -- markdown code blocks
  'meson',
  'python',
  'rust',
  'vim',
  'vimdoc',
  'yaml',
}

-- Text objects configuration
local textobjects = {
  select = {
    enable = true,
    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
      ['af'] = '@function.outer',
      ['if'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
      ['al'] = '@loop.outer',
      ['il'] = '@loop.inner',
      ['ab'] = '@block.outer',
      ['ib'] = '@block.inner',
      ['as'] = '@statement.outer',
      ['is'] = '@statement.inner',
      ['ad'] = '@conditional.outer',
      ['id'] = '@conditional.inner',
      ['am'] = '@call.outer',
      ['im'] = '@call.inner',
    },
    -- You can choose the select mode (default is charwise 'v')
    selection_modes = {
      ['@parameter.outer'] = 'v', -- charwise
      ['@function.outer'] = 'V', -- linewise
      ['@class.outer'] = '<c-v>', -- blockwise
    },
    -- If you set this to `true` (default is `false`) then any textobject is
    -- extended to include preceding or succeeding whitespace. Succeeding
    -- whitespace has priority in order to act similar to eg the built-in
    -- `ap` and `ip` mappings.
    include_surrounding_whitespace = true,
  },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_next_start = {
      [']f'] = '@function.outer',
      [']c'] = '@class.outer',
      [']a'] = '@parameter.inner',
      [']m'] = '@call.outer',
    },
    goto_next_end = {
      [']F'] = '@function.outer',
      [']C'] = '@class.outer',
      [']A'] = '@parameter.inner',
      [']M'] = '@call.outer',
    },
    goto_previous_start = {
      ['[f'] = '@function.outer',
      ['[c'] = '@class.outer',
      ['[a'] = '@parameter.inner',
      ['[m'] = '@call.outer',
    },
    goto_previous_end = {
      ['[F'] = '@function.outer',
      ['[C'] = '@class.outer',
      ['[A'] = '@parameter.inner',
      ['[M'] = '@call.outer',
    },
  },
  swap = {
    enable = true,
    swap_next = {
      ['<leader>ca'] = '@parameter.inner',
      ['<leader>cf'] = '@function.outer',
      ['<leader>cm'] = '@call.outer',
    },
    swap_previous = {
      ['<leader>cA'] = '@parameter.inner',
      ['<leader>cF'] = '@function.outer',
      ['<leader>cM'] = '@call.outer',
    },
  },
  lsp_interop = {
    enable = true,
    border = 'none',
    floating_preview_opts = {},
    peek_definition_code = {
      ['<leader>pd'] = '@function.outer',
      ['<leader>pD'] = '@class.outer',
    },
  },
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-refactor',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
      'RRethy/nvim-treesitter-textsubjects',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = treesitter_parsers,
        sync_install = false,
        ignore_install = {},
        auto_install = true,

        -- Core highlighting
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },

        -- Code indentation
        indent = { enable = true },

        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
            scope_incremental = '<TAB>',
          },
        },

        -- Text objects (from nvim-treesitter-textobjects)
        textobjects = textobjects,

        -- Text subjects (from nvim-treesitter-textsubjects)
        textsubjects = {
          enable = true,
          prev_selection = ',',
          keymaps = {
            ['.'] = { 'textsubjects-smart', desc = 'Select the current text subject' },
            ['a;'] = {
              'textsubjects-container-outer',
              desc = 'Select outer container (class, function, etc.)',
            },
            ['i;'] = {
              'textsubjects-container-inner',
              desc = 'Select inside containers (classes, functions, etc.)',
            },
          },
        },

        -- Refactor module (from nvim-treesitter-refactor)
        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true,
          },
          highlight_current_scope = { enable = false },
          smart_rename = {
            enable = true,
            keymaps = {
              smart_rename = '<leader>rr',
            },
          },
          navigation = {
            enable = true,
            keymaps = {
              goto_definition = '<leader>jd',
              list_definitions = '<leader>jl',
              list_definitions_toc = '<leader>jh',
              goto_next_usage = '<leader>jj',
              goto_previous_usage = '<leader>jk',
            },
          },
        },

        -- Matchup integration
        matchup = { enable = true },

        -- Context commentstring
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      enable = true,
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
      trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  },
}
