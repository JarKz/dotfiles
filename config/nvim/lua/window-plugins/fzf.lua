local actions = require "fzf-lua.actions"
local fzf = require("fzf-lua")

fzf.setup {
  -- fzf_bin         = 'sk',            -- use skim instead of fzf?
                                        -- https://github.com/lotabout/skim
                                        -- can also be set to 'fzf-tmux'
  winopts = {
    -- split         = "belowright new",-- open in a split instead?
                                        -- "belowright new"  : split below
                                        -- "aboveleft new"   : split above
                                        -- "belowright vnew" : split right
                                        -- "aboveleft vnew   : split left
    -- Only valid when using a float window
    -- (i.e. when 'split' is not defined, default)
    height           = 0.85,
    width            = 0.80,
    row              = 0.35,
    col              = 0.50,
    border           = require("window-plugins.window-config").border,
    title         = "Title",
    title_pos     = "center",    -- 'left', 'center' or 'right'
    fullscreen       = false,           -- start fullscreen?
    preview = {
      default     = 'bat',           -- override the default previewer?
                                        -- default uses the 'builtin' previewer
      border         = 'border',        -- border|noborder, applies only to
                                        -- native fzf previewers (bat/cat/git/etc)
      wrap           = 'nowrap',        -- wrap|nowrap
      hidden         = 'nohidden',      -- hidden|nohidden
      vertical       = 'down:45%',      -- up|down:size
      horizontal     = 'right:60%',     -- right|left:size
      layout         = 'flex',          -- horizontal|vertical|flex
      flip_columns   = 120,             -- #cols to switch to horizontal on flex
      -- Only used with the builtin previewer:
      title          = true,            -- preview border title (file/buf)?
      title_align    = "left",          -- left|center|right, title alignment
      scrollbar      = 'float',         -- `false` or string:'float|border'
                                        -- float:  in-window floating border
                                        -- border: in-border chars (see below)
      scrolloff      = '-2',            -- float scrollbar offset from right
                                        -- applies only when scrollbar = 'float'
      scrollchars    = {'█', '' },      -- scrollbar chars ({ <full>, <empty> }
                                        -- applies only when scrollbar = 'border'
      delay          = 100,             -- delay(ms) displaying the preview
                                        -- prevents lag on fast scrolling
      winopts = {                       -- builtin previewer window options
        number            = true,
        relativenumber    = false,
        cursorline        = true,
        cursorlineopt     = 'both',
        cursorcolumn      = false,
        signcolumn        = 'no',
        list              = false,
        foldenable        = false,
        foldmethod        = 'manual',
      },
    },
    on_create = function()
      -- called once upon creation of the fzf main window
      -- can be used to add custom fzf-lua mappings, e.g:
      --   vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
    end,
  },
  keymap = {
    -- These override the default tables completely
    -- no need to set to `false` to disable a bind
    -- delete or modify is sufficient
    builtin = {
      -- neovim `:tmap` mappings for the fzf win
      ["<C-/>"]        = "toggle-help",
      ["<F2>"]        = "toggle-fullscreen",
      -- Rotate preview clockwise/counter-clockwise
      ["<F5>"]        = "toggle-preview-ccw",
      ["ctrl-r"]        = "toggle-preview-cw",
      ["<C-d>"]    = "preview-page-down",
      ["<C-u>"]      = "preview-page-up",
      ["<S-left>"]    = "preview-page-reset",
    },
    fzf = {
      -- fzf '--bind=' options
      ["ctrl-z"]      = "abort",
      ["shift-down"]      = "unix-line-discard",
      ["ctrl-f"]      = "half-page-down",
      ["ctrl-b"]      = "half-page-up",
      ["ctrl-a"]      = "beginning-of-line",
      ["ctrl-e"]      = "end-of-line",
      ["alt-a"]       = "toggle-all",
      -- Only valid with fzf previewers (bat/cat/git/etc)
      ["ctrl-w"]          = "toggle-preview-wrap",
      ["ctrl-t"]          = "toggle-preview",
      ["ctrl-d"]  = "preview-page-down",
      ["ctrl-u"]    = "preview-page-up",
    },
  },
  actions = {
    files = {
      ["default"]     = actions.file_edit_or_qf,
      ["ctrl-s"]      = actions.file_split,
      ["ctrl-v"]      = actions.file_vsplit,
      ["ctrl-t"]      = actions.file_tabedit,
      ["alt-q"]       = actions.file_sel_to_qf,
      ["alt-l"]       = actions.file_sel_to_ll,
    },
    buffers = {
      ["default"]     = actions.buf_edit,
      ["ctrl-s"]      = actions.buf_split,
      ["ctrl-v"]      = actions.buf_vsplit,
      ["ctrl-t"]      = actions.buf_tabedit,
    }
  },
  fzf_opts = {
    -- options are sent as `<left>=<right>`
    -- set to `false` to remove a flag
    -- set to '' for a non-value flag
    -- for raw args use `fzf_args` instead
    ['--ansi']        = '',
    ['--info']        = 'inline',
    ['--height']      = '100%',
    ['--layout']      = 'reverse',
    ['--border']      = 'none',
  },
  previewers = {
    cat = {
      cmd             = "cat",
      args            = "--number",
    },
    bat = {
      cmd             = "bat",
      args            = "--style=numbers,changes --color always",
      theme           = 'Monokai Extended Origin', -- bat preview theme (bat --list-themes)
      config          = nil,            -- nil uses $BAT_CONFIG_PATH
    },
    head = {
      cmd             = "head",
      args            = nil,
    },
    git_diff = {
      cmd_deleted     = "git diff --color HEAD --",
      cmd_modified    = "git diff --color HEAD",
      cmd_untracked   = "git diff --color --no-index /dev/null",
      -- uncomment if you wish to use git-delta as pager
      -- can also be set under 'git.status.preview_pager'
      -- pager        = "delta --width=$FZF_PREVIEW_COLUMNS",
    },
    man = {
      -- NOTE: remove the `-c` flag when using man-db
      -- replace with `man -c cat %s | col -bx` on not OSX
      cmd             = "man -P cat %s | col -bx",
    },
    builtin = {
      syntax          = true,         -- preview syntax highlight?
      syntax_limit_l  = 0,            -- syntax limit (lines), 0=nolimit
      syntax_limit_b  = 1024*1024,    -- syntax limit (bytes), 0=nolimit
      limit_b         = 1024*1024*10, -- preview limit (bytes), 0=nolimit
      -- previewer treesitter options:
      -- enable specific filetypes with: `{ enable = { "lua" } }
      -- exclude specific filetypes with: `{ disable = { "lua" } }
      -- disable fully with: `{ enable = false }`
      treesitter      = { enable = true, disable = {} },
      -- By default, the main window dimensions are calculted as if the
      -- preview is visible, when hidden the main window will extend to
      -- full size. Set the below to "extend" to prevent the main window
      -- from being modified when toggling the preview.
      toggle_behavior = "default",
      -- preview extensions using a custom shell command:
      -- for example, use `viu` for image previews
      -- will do nothing if `viu` isn't executable
      extensions      = {
        -- neovim terminal only supports `viu` block output
        ["png"]       = { "viu", "-b" },
        ["svg"]       = { "chafa" },
        ["jpg"]       = { "ueberzug" },
      },
      -- if using `ueberzug` in the above extensions map
      -- set the default image scaler, possible scalers:
      --   false (none), "crop", "distort", "fit_contain",
      --   "contain", "forced_cover", "cover"
      -- https://github.com/seebye/ueberzug
      ueberzug_scaler = "cover",
    },
  },
  -- provider setup
  files = {
    -- previewer      = "bat",          -- uncomment to override previewer
                                        -- (name from 'previewers' table)
                                        -- set to 'false' to disable
    prompt            = 'Files❯ ',
    multiprocess      = true,           -- run command in a separate process
    git_icons         = true,           -- show git icons?
    file_icons        = true,           -- show file icons?
    color_icons       = true,           -- colorize file|git icons
    -- path_shorten   = 1,              -- 'true' or number, shorten path?
    -- executed command priority is 'cmd' (if exists)
    -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
    -- default options are controlled by 'fd|rg|find|_opts'
    -- NOTE: 'find -printf' requires GNU find
    -- cmd            = "find . -type f -printf '%P\n'",
    find_opts         = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
    rg_opts           = "--color=never --files --hidden --follow -g '!.git'",
    fd_opts           = "--color=never --type f --hidden --follow --exclude .git",
    actions = {
      ["default"]     = actions.file_edit,
      ["ctrl-y"]      = function(selected) print(selected[1]) end,
    }
  },
  git = {
    files = {
      prompt        = 'GitFiles❯ ',
      cmd           = 'git ls-files --exclude-standard',
      multiprocess  = true,
      git_icons     = true,
      file_icons    = true,
      color_icons   = true,
    },
    status = {
      prompt        = 'GitStatus❯ ',
      cmd           = "git -c color.status=false status -s",
      file_icons    = true,
      git_icons     = true,
      color_icons   = true,
      previewer     = "git_diff",
      actions = {
        -- actions inherit from 'actions.files' and merge
        ["ctrl-l"]   = { actions.git_unstage, actions.resume },
        ["ctrl-h"]    = { actions.git_stage, actions.resume },
        ["ctrl-x"]  = { actions.git_reset, actions.resume },
      },
    },
    commits = {
      prompt        = 'Commits❯ ',
      cmd           = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset'",
      preview       = "git show --pretty='%Cred%H%n%Cblue%an <%ae>%n%C(yellow)%cD%n%Cgreen%s' --color {1}",
      actions = {
        ["default"] = actions.git_checkout,
      },
    },
    bcommits = {
      prompt        = 'BCommits❯ ',
      -- default preview shows a git diff vs the previous commit
      -- if you prefer to see the entire commit you can use:
      --   git show --color {1} --rotate-to=<file>
      --   {1}    : commit SHA (fzf field index expression)
      --   <file> : filepath placement within the commands
      cmd           = "git log --color --pretty=format:'%C(yellow)%h%Creset %Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset' <file>",
      preview       = "git diff --color {1}~1 {1} -- <file>",
      actions = {
        ["default"] = actions.git_buf_edit,
        ["ctrl-s"]  = actions.git_buf_split,
        ["ctrl-v"]  = actions.git_buf_vsplit,
        ["ctrl-t"]  = actions.git_buf_tabedit,
      },
    },
    branches = {
      prompt          = 'Branches❯ ',
      cmd             = "git branch --all --color",
      preview         = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
      actions = {
        ["default"] = actions.git_switch,
      },
    },
    stash = {
      prompt          = 'Stash> ',
      cmd             = "git --no-pager stash list",
      preview         = "git --no-pager stash show --patch --color {1}",
      actions = {
        ["default"]   = actions.git_stash_apply,
        ["ctrl-x"]    = { actions.git_stash_drop, actions.resume },
      },
      fzf_opts = {
        ["--no-multi"]  = '',
        ['--delimiter'] = "'[:]'",
      },
    },
    icons = {
      -- ["M"]           = { icon = "M", color = "yellow" },
      -- ["D"]           = { icon = "D", color = "red" },
      -- ["A"]           = { icon = "A", color = "green" },
      ["R"]           = { icon = "R", color = "yellow" },
      ["C"]           = { icon = "C", color = "yellow" },
      ["T"]           = { icon = "T", color = "magenta" },
      ["?"]           = { icon = "?", color = "magenta" },
      -- override git icons?
      ["M"]        = { icon = "★", color = "red" },
      ["D"]        = { icon = "✗", color = "red" },
      ["A"]        = { icon = "+", color = "green" },
    },
  },
  grep = {
    prompt            = 'Rg❯ ',
    input_prompt      = 'Grep For❯ ',
    multiprocess      = true,
    git_icons         = true,
    file_icons        = true,
    color_icons       = true,
    cmd            = "rg --vimgrep",
    grep_opts         = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
    rg_opts           = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096",

    rg_glob           = false,
    glob_flag         = "--iglob",
    glob_separator    = "%s%-%-",     -- query separator pattern (lua): ' --'
    actions = {
      -- actions inherit from 'actions.files' and merge
      -- this action toggles between 'grep' and 'live_grep'
      ["ctrl-g"]      = { actions.grep_lgrep }
    },
    no_header             = false,    -- hide grep|cwd header?
    no_header_i           = false,    -- hide interactive header?
  },
  args = {
    prompt            = 'Args❯ ',
    files_only        = true,
    actions           = { ["ctrl-x"] = { actions.arg_del, actions.resume } }
  },
  oldfiles = {
    prompt            = 'History❯ ',
    cwd_only          = false,
    stat_file         = true,         -- verify files exist on disk
    include_current_session = false,  -- include bufs from current session
  },
  buffers = {
    prompt            = 'Buffers❯ ',
    file_icons        = true,
    color_icons       = true,
    sort_lastused     = true,
    cwd_only          = false,
    cwd               = nil,
    actions = {
      ["ctrl-x"]      = { actions.buf_del, actions.resume },
    }
  },
  lines = {
    previewer         = "builtin",
    prompt            = 'Lines❯ ',
    show_unlisted     = false,
    no_term_buffers   = true,
    fzf_opts = {
      -- hide filename, tiebreak by line no.
      ['--delimiter'] = "'[\\]:]'",
      ["--nth"]       = '2..',
      ["--tiebreak"]  = 'index',
      ["--tabstop"]   = "1",
    },
    actions = {
      ["default"]     = actions.buf_edit_or_qf,
      ["alt-q"]       = actions.buf_sel_to_qf,
      ["alt-l"]       = actions.buf_sel_to_ll
    },
  },
  blines = {
    previewer         = "builtin",
    prompt            = 'BLines❯ ',
    show_unlisted     = true,
    no_term_buffers   = false,
    fzf_opts = {
      -- hide filename, tiebreak by line no.
      ['--delimiter'] = "'[\\]:]'",
      ["--with-nth"]  = '2..',
      ["--tiebreak"]  = 'index',
      ["--tabstop"]   = "1",
    },
    actions = {
      ["default"]     = actions.buf_edit_or_qf,
      ["alt-q"]       = actions.buf_sel_to_qf,
      ["alt-l"]       = actions.buf_sel_to_ll
    },
  },
  tags = {
    prompt                = 'Tags❯ ',
    ctags_file            = nil,
    multiprocess          = true,
    file_icons            = true,
    git_icons             = true,
    color_icons           = true,
    rg_opts               = "--no-heading --color=always --smart-case",
    grep_opts             = "--color=auto --perl-regexp",
    actions = {
      ["ctrl-g"]          = { actions.grep_lgrep }
    },
    no_header             = false,    -- hide grep|cwd header?
    no_header_i           = false,    -- hide interactive header?
  },
  btags = {
    prompt                = 'BTags❯ ',
    ctags_file            = nil,
    ctags_autogen         = false,
    multiprocess          = true,
    file_icons            = true,
    git_icons             = true,
    color_icons           = true,
    rg_opts               = "--no-heading --color=always",
    grep_opts             = "--color=auto --perl-regexp",
    fzf_opts = {
      ['--delimiter']     = "'[\\]:]'",
      ["--with-nth"]      = '2..',
      ["--tiebreak"]      = 'index',
    },
  },
  colorschemes = {
    prompt            = 'Colorschemes❯ ',
    live_preview      = true,       -- apply the colorscheme on preview?
    actions           = { ["default"] = actions.colorscheme, },
    winopts           = { height = 0.55, width = 0.30, },
    post_reset_cb     = function()
      -- reset statusline highlights after
      -- a live_preview of the colorscheme
      -- require('feline').reset_highlights()
    end,
  },
  quickfix = {
    file_icons        = true,
    git_icons         = true,
  },
  quickfix_stack = {
    prompt = "Quickfix Stack> ",
    marker = ">",                   -- current list marker
  },
  lsp = {
    prompt_postfix    = '❯ ',       -- will be appended to the LSP label
                                    -- to override use 'prompt' instead
    cwd_only          = false,      -- LSP/diagnostics for cwd only?
    async_or_timeout  = 5000,       -- timeout(ms) or 'true' for async calls
    file_icons        = true,
    git_icons         = false,
    -- The equivalent of using `includeDeclaration` in lsp buf calls, e.g:
    -- :lua vim.lsp.buf.references({includeDeclaration = false})
    includeDeclaration = true,      -- include current declaration in LSP context
    -- settings for 'lsp_{document|workspace|lsp_live_workspace}_symbols'
    symbols = {
        async_or_timeout  = true,       -- symbols are async by default
        symbol_style      = 1,          -- style for document/workspace symbols
                                        -- false: disable,    1: icon+kind
                                        --     2: icon only,  3: kind only
                                        -- NOTE: icons are extracted from
                                        -- vim.lsp.protocol.CompletionItemKind
        -- icons for symbol kind
        -- see https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#symbolKind
        -- see https://github.com/neovim/neovim/blob/829d92eca3d72a701adc6e6aa17ccd9fe2082479/runtime/lua/vim/lsp/protocol.lua#L117
        symbol_icons     = {
          File          = "",
          Module        = "",
          Namespace     = "󰦮",
          Package       = "",
          Class         = "",
          Method        = "",
          Property      = "",
          Field         = "",
          Constructor   = "",
          Enum          = "",
          Interface     = "",
          Function      = "",
          Variable      = "",
          Constant      = "",
          String        = "",
          Number        = "󰎠",
          Boolean       = "󰨙",
          Array         = "󱡠",
          Object        = "",
          Key           = "",
          Null          = "󰟢",
          EnumMember    = "",
          Struct        = "",
          Event         = "",
          Operator      = "",
          TypeParameter = "󰗴",
        },
        -- colorize using Treesitter '@' highlight groups ("@function", etc).
        -- or 'false' to disable highlighting
        symbol_hl         = function(s) return "@" .. s:lower() end,
        -- additional symbol formatting, works with or without style
        symbol_fmt        = function(s, opts) return "[" .. s .. "]" end,
        -- prefix child symbols. set to any string or `false` to disable
        child_prefix      = true,
    },
    code_actions = {
        prompt            = 'Code Actions> ',
        async_or_timeout  = 5000,
        winopts = {
            row           = 0.40,
            height        = 0.35,
            width         = 0.60,
        },
    },
    finder = {
        prompt      = "LSP Finder> ",
        file_icons  = true,
        color_icons = true,
        git_icons   = false,
        async       = true,         -- async by default
        silent      = true,         -- suppress "not found" 
        separator   = "| ",         -- separator after provider prefix, `false` to disable
        includeDeclaration = true,  -- include current declaration in LSP context
        -- by default display all LSP locations
        -- to customize, duplicate table and delete unwanted providers
        providers   = {
            { "references",      prefix = require("fzf-lua").utils.ansi_codes.blue("ref ") },
            { "definitions",     prefix = require("fzf-lua").utils.ansi_codes.green("def ") },
            { "declarations",    prefix = require("fzf-lua").utils.ansi_codes.magenta("decl") },
            { "typedefs",        prefix = require("fzf-lua").utils.ansi_codes.red("tdef") },
            { "implementations", prefix = require("fzf-lua").utils.ansi_codes.green("impl") },
            { "incoming_calls",  prefix = require("fzf-lua").utils.ansi_codes.cyan("in  ") },
            { "outgoing_calls",  prefix = require("fzf-lua").utils.ansi_codes.yellow("out ") },
        },
    }
  },
  diagnostics ={
    prompt            = 'Diagnostics❯ ',
    cwd_only          = false,
    file_icons        = true,
    git_icons         = false,
    diag_icons        = true,
    icon_padding      = '',     -- add padding for wide diagnostics signs
    -- by default icons and highlights are extracted from 'DiagnosticSignXXX'
    -- and highlighted by a highlight group of the same name (which is usually
    -- set by your colorscheme, for more info see:
    --   :help DiagnosticSignHint'
    --   :help hl-DiagnosticSignHint'
    -- only uncomment below if you wish to override the signs/highlights
    -- define only text, texthl or both (':help sign_define()' for more info)
    -- signs = {
    --   ["Error"] = { text = "", texthl = "DiagnosticError" },
    --   ["Warn"]  = { text = "", texthl = "DiagnosticWarn" },
    --   ["Info"]  = { text = "", texthl = "DiagnosticInfo" },
    --   ["Hint"]  = { text = "", texthl = "DiagnosticHint" },
    -- },
    -- limit to specific severity, use either a string or num:
    --   1 or "hint"
    --   2 or "information"
    --   3 or "warning"
    --   4 or "error"
    -- severity_only:   keep any matching exact severity
    -- severity_limit:  keep any equal or more severe (lower)
    -- severity_bound:  keep any equal or less severe (higher)
  },
  complete_path = {
    cmd          = nil, -- default: auto detect fd|rg|find
    actions      = { ["default"] = actions.complete_insert },
  },
  complete_file = {
    cmd          = nil, -- default: auto detect rg|fd|find
    file_icons   = true,
    color_icons  = true,
    git_icons    = false,
    -- actions inherit from 'actions.files' and merge
    actions      = { ["default"] = actions.complete_insert },
    -- previewer hidden by default
    winopts      = { preview = { hidden = "hidden" } },
  },
  -- uncomment to use the old help previewer which used a
  -- minimized help window to generate the help tag preview
  -- helptags = { previewer = "help_tags" },
  -- uncomment to use `man` command as native fzf previewer
  -- (instead of using a neovim floating window)
  -- manpages = { previewer = "man_native" },
  -- 
  -- optional override of file extension icon colors
  -- available colors (terminal):
  --    clear, bold, black, red, green, yellow
  --    blue, magenta, cyan, grey, dark_grey, white
  file_icon_colors = {
    ["sh"] = "green",
  },
  -- padding can help kitty term users with
  -- double-width icon rendering
  file_icon_padding = '',
  -- uncomment if your terminal/font does not support unicode character
  -- 'EN SPACE' (U+2002), the below sets it to 'NBSP' (U+00A0) instead
  -- nbsp = '\xc2\xa0',
}

local function toggle()
	fzf.fzf_exec(function(fzf_cb)
		for key, value in pairs(fzf) do
			if type(value) == "function" and string.match(key, "complete") == nil then
				fzf_cb(key)
			end
			fzf_cb()
		end
	end, {
		actions = {
			["default"] = function(selected, _)
				fzf[selected[1]]()
			end,
		},
	})
end

local mapping = {
	f = {
		name = "Find",
		t = {
			toggle,
			"Toggle FZF",
		},
		f = {
			fzf.files,
			"Files",
		},
		h = {
			fzf.help_tags,
			"Help",
		},
		b = {
			fzf.buffers,
			"Buffers",
		},
	},
	g = {
		name = "Grep",
		l = {
			fzf.live_grep,
			"Live grep",
		},
		c = {
			fzf.grep_curbuf,
			"Code grep",
		},
	},
}

local mapping_options = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
