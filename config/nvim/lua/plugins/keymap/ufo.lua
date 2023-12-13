local ufo = require("ufo")

local mapping_options = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  z = {
    name = "fold",
    R = { ufo.openAllFolds, "Open all folds" },
    M = { ufo.closeAllFolds, "Close all folds" },
    r = { ufo.openFoldsExceptKinds, "Open folds except kinds" },
    m = { ufo.closeFoldsWith, "Close folds with" },
  },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
