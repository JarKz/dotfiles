return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    exclude = {
      filetypes = {
        "lspinfo",
        "checkhealth",
        "help",
        "man",
        "gitcommit",
        "dashboard",
      }
    },
  },
}
