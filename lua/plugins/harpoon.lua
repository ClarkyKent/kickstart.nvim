return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    {'nvim-telescope/telescope.nvim'},
  },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    -- We may want to change the "harpoon" leader to something different than
    -- the leader key
    local our_leader = '<leader>h'
    local function keymap_set(mode, key, fn, desc)
      vim.keymap.set(mode, our_leader .. key, fn, { desc = desc })
    end

    keymap_set('n', 'a', function()
      harpoon:list():add()
    end, '[A]dd Harpoon')

    keymap_set('n', 'l', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, '[l] Harpoon list all buffers')

    -- Harpoon to targets
    keymap_set('n', 'q', function()
      harpoon:list():select(1)
    end, '[q] Harpoon to 1')
    keymap_set('n', 'w', function()
      harpoon:list():select(2)
    end, '[w] Harpoon to 2')
    keymap_set('n', 'e', function()
      harpoon:list():select(3)
    end, '[e] Harpoon to 3')
    keymap_set('n', 'r', function()
      harpoon:list():select(4)
    end, '[r] Harpoon to 4')
    keymap_set('n', 't', function()
      harpoon:list():select(5)
    end, '[t] Harpoon to 5')

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next()
    end)

    -- basic telescope configuration
    local conf = require('telescope.config').values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = require('telescope.finders').new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    vim.keymap.set('n', '<C-e>', function()
      toggle_telescope(harpoon:list())
    end, { desc = 'Open harpoon window' })
  end,
}
