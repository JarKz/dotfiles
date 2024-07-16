local ufo = require("ufo")
local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")

wk.add(
  wk_utils.keymaps({
      z = {
        name = "fold",
        R = { ufo.openAllFolds, desc = "Open all folds" },
        M = { ufo.closeAllFolds, desc = "Close all folds" },
        r = { ufo.openFoldsExceptKinds, desc = "Open folds except kinds" },
        m = { ufo.closeFoldsWith, desc = "Close folds with" },
      },
    },
    {
      remap = false,
      nowait = false,
    }
  )
)
