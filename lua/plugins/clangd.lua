return {
  {
    'p00f/clangd_extensions.nvim', -- clangd extension, some good stuff
    config = function()
      local icons = require 'libs.icons'

      require('clangd_extensions').setup {
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
          inline = vim.fn.has 'nvim-0.10' == 1,
          -- Only show inlay hints for the current line
          only_current_line = true,
          -- Event which triggers a refersh of the inlay hints.
          -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
          -- not that this may cause  higher CPU usage.
          -- This option is only respected when only_current_line and
          -- autoSetHints both are true.
          only_current_line_autocmd = 'CursorHold',
          -- whether to show parameter hints with the inlay hints or not
          show_parameter_hints = true,
          -- prefix for parameter hints
          parameter_hints_prefix = '<- ',
          -- prefix for all the other hints (type, chaining)
          other_hints_prefix = '=> ',
          -- whether to align to the length of the longest line in the file
          max_len_align = false,
          -- padding from the left if max_len_align is true
          max_len_align_padding = 1,
          -- whether to align to the extreme right or not
          right_align = false,
          -- padding from the right if right_align is true
          right_align_padding = 7,
          -- The color of the hints
          highlight = 'Comment',
          -- The highlight group priority for extmark
          priority = 100,
        },
        ast = {
          -- These require codicons (https://github.com/microsoft/vscode-codicons)
          role_icons = {
            type = '',
            declaration = icons.kind.Method,
            expression = icons.ui.Circle,
            specifier = icons.kind.Specifier,
            statement = icons.kind.Statement,
            ['template argument'] = icons.type.Template,
          },

          kind_icons = {
            Compound = icons.type.Object,
            Recovery = icons.kind.Recovery,
            TranslationUnit = icons.kind.TranslationUnit,
            PackExpansion = icons.kind.PackExpansion,
            TemplateTypeParm = icons.type.Template,
            TemplateTemplateParm = icons.type.Template,
            TemplateParamObject = icons.type.Template,
          },

          highlights = {
            detail = 'Comment',
          },
        },
        memory_usage = {
          border = 'single',
        },
        symbol_info = {
          border = 'single',
        },
      }
    end,
  },
  -- {
  --   -- dir = "~/.local/share/nvim/personal/cmake-tools.nvim",
  --   "Civitasv/cmake-tools.nvim",
  --   dependencies = {
  --     "stevearc/overseer.nvim",
  --   },
  --   lazy = true,
  --   config = function()
  --     require("overseer").setup({
  --       task_list = {
  --         direction = "right",
  --         bindings = {
  --           ["?"] = "ShowHelp",
  --           ["g?"] = "ShowHelp",
  --           ["<CR>"] = "RunAction",
  --           ["<C-e>"] = "Edit",
  --           ["o"] = "Open",
  --           ["<C-v>"] = "OpenVsplit",
  --           ["<C-s>"] = "OpenSplit",
  --           ["<C-f>"] = "OpenFloat",
  --           ["<C-q>"] = "OpenQuickFix",
  --           ["p"] = "TogglePreview",
  --           ["<C-l>"] = false,
  --           ["<C-h>"] = false,
  --           ["<A-l>"] = "IncreaseDetail",
  --           ["<A-h>"] = "DecreaseDetail",
  --           ["L"] = "IncreaseAllDetail",
  --           ["H"] = "DecreaseAllDetail",
  --           ["["] = "DecreaseWidth",
  --           ["]"] = "IncreaseWidth",
  --           ["{"] = "PrevTask",
  --           ["}"] = "NextTask",
  --           ["<C-k>"] = false,
  --           ["<C-j>"] = false,
  --           ["<A-k>"] = "ScrollOutputUp",
  --           ["<A-j>"] = "ScrollOutputDown",
  --           ["q"] = "Close",
  --         },
  --       }
  --     })
  --     require("cmake-tools").setup({
  --       cmake_command = "cmake",                                          -- this is used to specify cmake command path
  --       ctest_command = "ctest",
  --       cmake_regenerate_on_save = true,                                  -- auto generate when save CMakeLists.txt
  --       cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
  --       cmake_build_options = { "-j4" },                                  -- this will be passed when invoke `CMakeBuild`
  --       cmake_build_directory = "out/${variant:buildType}",               -- this is used to specify generate directory for cmake
  --       cmake_compile_commands_options = {
  --         action = "soft_link",                                           -- available options: soft_link, copy, lsp, none
  --         -- soft_link: this will automatically make a soft link from compile commands file to target
  --         -- copy:      this will automatically copy compile commands file to target
  --         -- lsp:       this will automatically set compile commands file location using lsp
  --         -- none:      this will make this option ignored
  --         target = vim.loop.cwd()                                                          -- path to directory, this is used only if action == "soft_link" or action == "copy"
  --       },
  --       cmake_kits_path = "/Users/civitasv/.local/share/CMakeTools/cmake-tools-kits.json", -- this is used to specify global cmake kits path, see CMakeKits for detailed usage
  --       cmake_variants_message = {
  --         short = { show = true },                                                         -- whether to show short message
  --         long = { show = true, max_length = 40 },                                         -- whether to show long message
  --       },
  --       cmake_dap_configuration = {                                                        -- debug settings for cmake
  --         name = "cpp",
  --         type = "codelldb",
  --         request = "launch",
  --         stopOnEntry = false,
  --         runInTerminal = true,
  --         console = "integratedTerminal",
  --       },
  --       cmake_executor = {                    -- executor to use
  --         name = "quickfix",                  -- name of the executor
  --         opts = {},                          -- the options the executor will get, possible values depend on the executor type. See `default_opts` for possible values.
  --         default_opts = {                    -- a list of default and possible values for executors
  --           quickfix = {
  --             show = "always",                -- "always", "only_on_error"
  --             position = "belowright",        -- "bottom", "top"
  --             size = 10,
  --             auto_close_when_success = true, -- typically, you can use it with the true option; it will auto-close the quickfix buffer if the execution is successful.
  --           },
  --           toggleterm = {
  --             direction = "float",   -- 'vertical' | 'horizontal' | 'tab' | 'float'
  --             close_on_exit = false, -- whether close the terminal when exit
  --             auto_scroll = true,    -- whether auto scroll to the bottom
  --           },
  --           overseer = {
  --             new_task_opts = {
  --               strategy = {
  --                 "toggleterm",
  --                 direction = "horizontal",
  --                 autos_croll = true,
  --                 quit_on_exit = "success"
  --               }
  --             },   -- options to pass into the `overseer.new_task` command
  --             on_new_task = function(_)
  --             end, -- a function that gets overseer.Task when it is created, before calling `task:start`
  --           },
  --           terminal = {
  --             name = "Main Terminal",
  --             prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
  --             split_direction = "horizontal", -- "horizontal", "vertical"
  --             split_size = 10,

  --             -- Window handling
  --             single_terminal_per_instance = true,  -- Single instance, multiple windows
  --             single_terminal_per_tab = true,       -- Single instance per tab
  --             keep_terminal_static_location = true, -- Static location of the viewport if avialable

  --             -- Running Tasks
  --             start_insert = false,       -- If you want to enter terminal with :startinsert
  --             focus = false,              -- Focus on cmake terminal when cmake task is launched.
  --             do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
  --           },                            -- terminal executor uses the values in cmake_terminal
  --         },
  --       },
  --       cmake_runner = {               -- runner to use
  --         name = "toggleterm",         -- name of the runner
  --         opts = {},                   -- the options the runner will get, possible values depend on the runner type. See `default_opts` for possible values.
  --         default_opts = {             -- a list of default and possible values for runners
  --           quickfix = {
  --             show = "always",         -- "always", "only_on_error"
  --             position = "belowright", -- "bottom", "top"
  --             size = 10,
  --             encoding = "utf-8",
  --             auto_close_when_success = false, -- typically, you can use it with the true option; it will auto-close the quickfix buffer if the execution is successful.
  --           },
  --           toggleterm = {
  --             direction = "float",   -- 'vertical' | 'horizontal' | 'tab' | 'float'
  --             close_on_exit = false, -- whether close the terminal when exit
  --             auto_scroll = true,    -- whether auto scroll to the bottom
  --           },
  --           overseer = {
  --             new_task_opts = {
  --               strategy = {
  --                 "toggleterm",
  --                 direction = "float",
  --                 autos_croll = true
  --               }
  --             },                             -- options to pass into the `overseer.new_task` command
  --             on_new_task = function(_) end, -- a function that gets overseer.Task when it is created, before calling `task:start`
  --           },
  --           terminal = {
  --             name = "Runner Terminal",
  --             prefix_name = "[CMakeTools]: ", -- This must be included and must be unique, otherwise the terminals will not work. Do not use a simple spacebar " ", or any generic name
  --             split_direction = "horizontal", -- "horizontal", "vertical"
  --             split_size = 10,

  --             -- Window handling
  --             single_terminal_per_instance = true,  -- Single instance, multiple windows
  --             single_terminal_per_tab = true,       -- Single instance per tab
  --             keep_terminal_static_location = true, -- Static location of the viewport if avialable

  --             -- Running Tasks
  --             start_insert = true,        -- If you want to enter terminal with :startinsert
  --             focus = true,               -- Focus on cmake terminal when cmake task is launched.
  --             do_not_add_newline = false, -- Do not hit enter on the command inserted when using :CMakeRun, allowing a chance to review or modify the command before hitting enter.
  --           },
  --         },
  --       },
  --       cmake_notifications = {
  --         runner = { enabled = false },
  --         executor = { enabled = true },
  --         spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }, -- icons used for progress display
  --         refresh_rate_ms = 100, -- how often to iterate icons
  --       },
  --       cmake_virtual_text_support = true, -- Show the target related to current file using virtual text (at right corner)
  --       cmake_use_scratch_buffer = true,
  --     })
  --   end
  -- },
  -- {
  --   "nvim-neotest/neotest",
  --   dependencies = {
  --     "nvim-neotest/nvim-nio",
  --     "nvim-lua/plenary.nvim",
  --     "antoinemadec/FixCursorHold.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "orjangj/neotest-ctest",
  --   },
  --   keys = function()
  --     local neotest = require("neotest")

  --     return {
  --       { "<leader>nf", function() neotest.run.run(vim.fn.expand("%")) end, desc = "Run File" },
  --       { "<leader>nt", function() neotest.run.run() end,                   desc = "Run Nearest" },
  --       { "<leader>nw", function() neotest.run.run(vim.loop.cwd()) end,     desc = "Run Workspace" },
  --       {
  --         "<leader>nr",
  --         function()
  --           -- This will only show the output from the test framework
  --           neotest.output.open({ short = true, auto_close = true })
  --         end,
  --         desc = "Results (short)",
  --       },
  --       {
  --         "<leader>nR",
  --         function()
  --           -- This will show the classic CTest log output.
  --           -- The output usually spans more than can fit the neotest floating window,
  --           -- so using 'enter = true' to enable normal navigation within the window
  --           -- is recommended.
  --           neotest.output.open({ enter = true })
  --         end,
  --         desc = "Results (full)",
  --       },
  --       -- Other keybindings
  --     }
  --   end,
  --   config = function()
  --     -- Optional, but recommended, if you have enabled neotest's diagnostic option
  --     local neotest_ns = vim.api.nvim_create_namespace("neotest")
  --     vim.diagnostic.config({
  --       virtual_text = {
  --         format = function(diagnostic)
  --           -- Convert newlines, tabs and whitespaces into a single whitespace
  --           -- for improved virtual text readability
  --           local message = diagnostic.message:gsub("[\r\n\t%s]+", " ")
  --           return message
  --         end,
  --       },
  --     }, neotest_ns)

  --     require("neotest").setup({
  --       adapters = {
  --         -- Load with default config
  --         require("neotest-ctest"),
  --       }
  --     })

  --     require("neotest-ctest").setup({
  --       -- fun(string) -> string: Find the project root directory given a current directory
  --       -- to work from.
  --       root = function(dir)
  --         -- by default, it will use neotest.lib.files.match_root_pattern with the following entries
  --         return require("neotest.lib").files.match_root_pattern(
  --         -- NOTE: CMakeLists.txt is not a good candidate as it can be found in
  --         -- more than one directory
  --           "CMakePresets.json",
  --           "compile_commands.json",
  --           ".clangd",
  --           ".clang-format",
  --           ".clang-tidy",
  --           "build",
  --           "out",
  --           ".git"
  --         )(dir)
  --       end,
  --       -- fun(string) -> bool: Takes a file path as string and returns true if it contains tests.
  --       -- This function is called often by neotest, so make sure you don't do any heavy duty work.
  --       is_test_file = function(file)
  --         -- by default, returns true if the file stem ends with _test and the file extension is
  --         -- one of cpp/cc/cxx.
  --       end,
  --       -- fun(string, string, string) -> bool: Filter directories when searching for test files.
  --       -- Best to keep this as-is and set per-project settings in neotest instead.
  --       -- See :h neotest.Config.discovery.
  --       filter_dir = function(name, rel_path, root)
  --         -- If you don't configure filter_dir through neotest, and you leave it as-is,
  --         -- it will filter the following directories by default: build, cmake, doc,
  --         -- docs, examples, out, scripts, tools, venv.
  --       end,
  --       -- What frameworks to consider when performing auto-detection of test files.
  --       -- Priority can be configured by ordering/removing list items to your needs.
  --       -- By default, each test file will be queried with the given frameworks in the
  --       -- following order.
  --       frameworks = { "gtest", "catch2", "doctest" },
  --       -- What extra args should ALWAYS be sent to CTest? Note that most of CTest arguments
  --       -- are not expected to be used (or work) with this plugin, but some might be useful
  --       -- depending on your needs. For instance:
  --       --   extra_args = {
  --       --     "--stop-on-failure",
  --       --     "--schedule-random",
  --       --     "--timeout",
  --       --     "<seconds>",
  --       --   }
  --       -- If you want to send extra_args for one given invocation only, send them to
  --       -- `neotest.run.run({extra_args = ...})` instead. see :h neotest.RunArgs for details.
  --       extra_args = {},
  --     })
  --   end
  -- }
}
