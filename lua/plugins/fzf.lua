return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional for file icons
  },
  config = function()
    local fzf = require("fzf-lua")
    
    fzf.setup({
      -- Global settings
      global_resume = true,
      global_resume_query = true,
      
      -- Window settings
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = "rounded",
        preview = {
          default = "bat",
          border = "border",
          wrap = "nowrap",
          hidden = "nohidden",
          vertical = "down:45%",
          horizontal = "right:60%",
          layout = "flex",
          flip_columns = 120,
        },
      },
      
      -- Key mappings within fzf
      keymap = {
        builtin = {
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          ["<F5>"] = "toggle-preview-ccw",
          ["<F6>"] = "toggle-preview-cw",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "select-all",
          ["alt-d"] = "deselect-all",
        },
      },
      
      -- File finder settings
      files = {
        prompt = "Files❯ ",
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      },
      
      -- Git files
      git = {
        files = {
          prompt = "GitFiles❯ ",
          cmd = "git ls-files --exclude-standard",
          multiprocess = true,
          git_icons = true,
          file_icons = true,
          color_icons = true,
        },
        status = {
          prompt = "GitStatus❯ ",
          cmd = "git status --porcelain=v1",
          previewer = "git_diff",
          file_icons = true,
          git_icons = true,
          color_icons = true,
        },
        commits = {
          prompt = "Commits❯ ",
          cmd = "git log --color=always --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %C(green)%an%C(reset) %s' --date=short",
          preview = "git show --color=always {1}",
        },
        bcommits = {
          prompt = "BCommits❯ ",
          cmd = "git log --color=always --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %C(green)%an%C(reset) %s' --date=short",
          preview = "git show --color=always {1}",
        },
        branches = {
          prompt = "Branches❯ ",
          cmd = "git branch --all --color=always",
          preview = "git log --graph --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %C(green)%an%C(reset) %s' --date=short {1}",
        },
      },
      
      -- Grep settings
      grep = {
        prompt = "Rg❯ ",
        input_prompt = "Grep For❯ ",
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
        grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
        RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
      },
      
      -- LSP settings
      lsp = {
        prompt_postfix = "❯ ",
        cwd_only = false,
        async_or_timeout = 5000,
        file_icons = true,
        git_icons = false,
        color_icons = true,
        includeDeclaration = true,
        symbols = {
          async_or_timeout = true,
          symbol_style = 1,
          symbol_icons = {
            File = "󰈙",
            Module = "",
            Namespace = "󰌗",
            Package = "",
            Class = "󰌗",
            Method = "󰆧",
            Property = "",
            Field = "",
            Constructor = "",
            Enum = "󰕘",
            Interface = "󰕘",
            Function = "󰊕",
            Variable = "󰆧",
            Constant = "󰏿",
            String = "󰀬",
            Number = "󰎠",
            Boolean = "◩",
            Array = "󰅪",
            Object = "󰅩",
            Key = "󰌋",
            Null = "󰟢",
            EnumMember = "",
            Struct = "󰌗",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰊄",
          },
        },
      },
      
      -- Buffer settings
      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true,
        color_icons = true,
        sort_lastused = true,
        show_unloaded = true,
      },
      
      -- Tags settings
      tags = {
        prompt = "Tags❯ ",
        ctags_file = "tags",
        multiprocess = true,
      },
      
      -- Lines settings
      lines = {
        previewer = "builtin",
        prompt = "Lines❯ ",
        show_unlisted = false,
        no_term_buffers = true,
        fzf_opts = {
          ["--delimiter"] = ":",
          ["--nth"] = "2..",
          ["--tiebreak"] = "index",
        },
      },
      
      -- Oldfiles settings
      oldfiles = {
        prompt = "History❯ ",
        cwd_only = false,
        stat_file = true,
        include_current_session = false,
      },
      
      -- Quickfix/Loclist
      quickfix = {
        file_icons = true,
        git_icons = false,
      },
    })

    -- Key mappings with descriptions
    local opts = { silent = true }
    
    -- File finders
    vim.keymap.set("n", "<leader>ff", fzf.files, vim.tbl_extend("force", opts, { desc = "Find files" }))
    vim.keymap.set("n", "<leader>fgg", fzf.git_files, vim.tbl_extend("force", opts, { desc = "Find git files" }))
    vim.keymap.set("n", "<leader>fb", fzf.buffers, vim.tbl_extend("force", opts, { desc = "Find buffers" }))
    vim.keymap.set("n", "<leader>fo", fzf.oldfiles, vim.tbl_extend("force", opts, { desc = "Find recent files" }))
    
    -- Search
    vim.keymap.set("n", "<leader>flg", fzf.live_grep, vim.tbl_extend("force", opts, { desc = "Live grep search" }))
    vim.keymap.set("n", "<leader>fcw", fzf.grep_cword, vim.tbl_extend("force", opts, { desc = "Search word under cursor" }))
    vim.keymap.set("v", "<leader>fcw", fzf.grep_visual, vim.tbl_extend("force", opts, { desc = "Search visual selection" }))
    vim.keymap.set("n", "<leader>fsp", fzf.grep_project, vim.tbl_extend("force", opts, { desc = "Search project" }))
    vim.keymap.set("n", "<leader>fsb", fzf.lgrep_curbuf, vim.tbl_extend("force", opts, { desc = "Search current buffer" }))
    vim.keymap.set("n", "<leader>fsl", fzf.lines, vim.tbl_extend("force", opts, { desc = "Search lines in all buffers" }))
    vim.keymap.set("n", "<leader>fsL", fzf.blines, vim.tbl_extend("force", opts, { desc = "Search lines in current buffer" }))
    
    -- LSP
    vim.keymap.set("n", "<leader>flr", fzf.lsp_references, vim.tbl_extend("force", opts, { desc = "LSP references" }))
    vim.keymap.set("n", "<leader>fld", fzf.lsp_definitions, vim.tbl_extend("force", opts, { desc = "LSP definitions" }))
    vim.keymap.set("n", "<leader>flD", fzf.lsp_declarations, vim.tbl_extend("force", opts, { desc = "LSP declarations" }))
    vim.keymap.set("n", "<leader>flt", fzf.lsp_typedefs, vim.tbl_extend("force", opts, { desc = "LSP type definitions" }))
    vim.keymap.set("n", "<leader>fli", fzf.lsp_implementations, vim.tbl_extend("force", opts, { desc = "LSP implementations" }))
    vim.keymap.set("n", "<leader>fls", fzf.lsp_document_symbols, vim.tbl_extend("force", opts, { desc = "LSP document symbols" }))
    vim.keymap.set("n", "<leader>flS", fzf.lsp_workspace_symbols, vim.tbl_extend("force", opts, { desc = "LSP workspace symbols" }))
    vim.keymap.set("n", "<leader>fla", fzf.lsp_code_actions, vim.tbl_extend("force", opts, { desc = "LSP code actions" }))
    vim.keymap.set("n", "<leader>fle", fzf.diagnostics_document, vim.tbl_extend("force", opts, { desc = "LSP document diagnostics" }))
    vim.keymap.set("n", "<leader>flE", fzf.diagnostics_workspace, vim.tbl_extend("force", opts, { desc = "LSP workspace diagnostics" }))
    
    -- Git
    vim.keymap.set("n", "<leader>fgs", fzf.git_status, vim.tbl_extend("force", opts, { desc = "Git status" }))
    vim.keymap.set("n", "<leader>fgc", fzf.git_commits, vim.tbl_extend("force", opts, { desc = "Git commits" }))
    vim.keymap.set("n", "<leader>fgC", fzf.git_bcommits, vim.tbl_extend("force", opts, { desc = "Git buffer commits" }))
    vim.keymap.set("n", "<leader>fgb", fzf.git_branches, vim.tbl_extend("force", opts, { desc = "Git branches" }))
    vim.keymap.set("n", "<leader>fgt", fzf.git_tags, vim.tbl_extend("force", opts, { desc = "Git tags" }))
    vim.keymap.set("n", "<leader>fgh", fzf.git_stash, vim.tbl_extend("force", opts, { desc = "Git stash" }))
    
    -- Misc
    vim.keymap.set("n", "<leader>fh", fzf.help_tags, vim.tbl_extend("force", opts, { desc = "Help tags" }))
    vim.keymap.set("n", "<leader>fm", fzf.man_pages, vim.tbl_extend("force", opts, { desc = "Man pages" }))
    vim.keymap.set("n", "<leader>fc", fzf.colorschemes, vim.tbl_extend("force", opts, { desc = "Colorschemes" }))
    vim.keymap.set("n", "<leader>fk", fzf.keymaps, vim.tbl_extend("force", opts, { desc = "Keymaps" }))
    vim.keymap.set("n", "<leader>fq", fzf.quickfix, vim.tbl_extend("force", opts, { desc = "Quickfix list" }))
    vim.keymap.set("n", "<leader>fl", fzf.loclist, vim.tbl_extend("force", opts, { desc = "Location list" }))
    vim.keymap.set("n", "<leader>fj", fzf.jumps, vim.tbl_extend("force", opts, { desc = "Jump list" }))
    vim.keymap.set("n", "<leader>ft", fzf.tags, vim.tbl_extend("force", opts, { desc = "Tags" }))
    vim.keymap.set("n", "<leader>f:", fzf.command_history, vim.tbl_extend("force", opts, { desc = "Command history" }))
    vim.keymap.set("n", "<leader>f/", fzf.search_history, vim.tbl_extend("force", opts, { desc = "Search history" }))
    
    -- Resume last search
    vim.keymap.set("n", "<leader>fr", fzf.resume, vim.tbl_extend("force", opts, { desc = "Resume last search" }))
    
    -- Register search
    vim.keymap.set("n", '<leader>f"', fzf.registers, vim.tbl_extend("force", opts, { desc = "Registers" }))
    
    -- Spell suggestions
    vim.keymap.set("n", "<leader>fz", fzf.spell_suggest, vim.tbl_extend("force", opts, { desc = "Spell suggestions" }))
  end,
}