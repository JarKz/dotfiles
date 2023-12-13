-- ({ "roobert/search-replace.nvim" })
return {
  'JarKz/search-replace-additional-configuration.nvim',
  dependencies = { "folke/which-key.nvim", },
  branch = 'dev',
  config = function()
    vim.o.inccommand = 'split'
    require('search-replace').setup({
      -- optionally override defaults
    })
    require('plugins.keymap.search_replace')
  end,
}
