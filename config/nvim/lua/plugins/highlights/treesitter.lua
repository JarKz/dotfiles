return {
  "nvim-treesitter/nvim-treesitter",
  build = function(_)
    vim.cmd("TSUpdate")
    -- vim.cmd("TSInstall all")
  end,
  opts = {
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gis",
        node_incremental = "gan",
        scope_incremental = "gas",
        node_decremental = "gin",
      },
    },
    autotag = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    ensure_installed = {
      'bash',
      'c',
      'cmake',
      'comment',
      'cpp',
      'css',
      'dhall',
      'diff',
      'dockerfile',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'glsl',
      'go',
      'gpg',
      'groovy',
      'html',
      'http',
      'hyprlang',
      'javascript',
      'json',
      'latex',
      'llvm',
      'lua',
      'luadoc',
      'luap',
      'luau',
      'make',
      'markdown',
      'markdown_inline',
      'nix',
      'proto',
      'python',
      'query',
      'regex',
      'rust',
      'sql',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    }
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
    vim.filetype.add({
      pattern = { [".*/hypr/.*%.conf"] = "hyprlang" }
    })
  end
}
