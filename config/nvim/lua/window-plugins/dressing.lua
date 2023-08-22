require("dressing").setup({
  input = {
    -- Set to false to disable the vim.ui.input implementation
    enabled = true,
    -- Default prompt string
    default_prompt = "Input:",
    -- Can be 'left', 'right', or 'center'
    prompt_align = "left",
    -- When true, <Esc> will close the modal
    insert_only = false,
    -- When true, input will start in insert mode.
    start_in_insert = true,
    border = require("window-plugins.window-config").border,
    -- 'editor' and 'win' will default to being centered, and 'cursor'
    relative = "editor",
    -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    prefer_width = 40,
    width = nil,
    -- min_width and max_width can be a list of mixed types.
    -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
    max_width = { 140, 0.9 },
    min_width = { 20, 0.2 },
    buf_options = {},
    win_options = {
      -- Window transparency (0-100)
      winblend = 0,
      -- Disable line wrapping
      wrap = false,
    },
    -- Set to `false` to disable
    mappings = {
      n = {
        ["<Esc>"] = "Close",
        ["<CR>"] = "Confirm",
      },
      i = {
        ["<C-c>"] = "Close",
        ["<CR>"] = "Confirm",
        ["<Up>"] = "HistoryPrev",
        ["<Down>"] = "HistoryNext",
      },
    },
    override = function(conf)
      conf.anchor = "SW"
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      return conf
    end,
    -- see :help dressing_get_config
    get_config = nil,
  },
  select = {
    -- Set to false to disable the vim.ui.select implementation
    enabled = true,
    -- Priority list of preferred vim.select implementations
    backend = { "fzf_lua", "fzf", "builtin", "nui" },
    -- Trim trailing `:` from prompt
    trim_prompt = true,
    fzf_lua = {
      winopts = {
        width = 0.4,
        height = 0.3,
      }
    },
    -- Used to override format_item. See :help dressing-format
    format_item_override = {},
    -- see :help dressing_get_config
    get_config = nil,
  },
})
