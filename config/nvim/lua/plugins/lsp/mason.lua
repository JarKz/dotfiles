return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = require('config.window_config').border,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        'pyright',
        'bashls',
        'cssls',
        'efm',
        'gradle_ls',
        'groovyls',
        'html',
        'lua_ls',
        'stylelint_lsp',
        'ts_ls',
        -- INFO: disabled until mason resolves issue with correctness
        -- 'typst_lsp',
        'nil_ls',
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    opts = {
      ensure_installed = {
        'autopep8',
        'eslint_d',
        'vale',
        'fixjson',
        'htmlbeautifier',
        'jq',
        'jsonlint',
        'markdownlint',
        'prettier',
        'shellcheck',
        'shfmt',
        'yamllint',
        'nixpkgs-fmt'
      }
    }
  }
}
