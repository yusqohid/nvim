return {
  {
    "karb94/neoscroll.nvim",
    lazy = false,
    opts = {},
  },

  {
    'stevearc/oil.nvim',
    opts = {
      view_options = {
        show_hidden = true,
      },
      delete_to_trash = true,
      float = {
        padding = 4,
        max_width = 0.8,
        max_height = 0,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
  },

  {
    "otavioschwanck/arrow.nvim",
    event = { "BufNewFile", "BufReadPre" },
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    opts = {
      show_icons = true,
      leader_key = '\\',             -- Recommended to be a single key
      buffer_leader_key = 'm',       -- Per Buffer Mappings
    }
  },

  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",       -- (optional) for NES functionality
    },
    event = "InsertEnter",
    -- cmd = "Copilot",
    config = function()
      require("copilot").setup({
        suggestion = { auto_trigger = true },
      })
    end
  },

  {
    "folke/flash.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },

  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    -- Plugin hanya akan dimuat saat Anda menekan tombol-tombol di bawah ini
    keys = {
      { "<up>",          function() require("multicursor-nvim").lineAddCursor(-1) end, mode = { "n", "x" }, desc = "Add cursor above" },
      { "<down>",        function() require("multicursor-nvim").lineAddCursor(1) end,  mode = { "n", "x" }, desc = "Add cursor below" },
      { "<leader>m",     function() require("multicursor-nvim").matchAddCursor(1) end, mode = { "n", "x" }, desc = "Match next word" },
      { "<c-q>",         function() require("multicursor-nvim").toggleCursor() end,    mode = { "n", "x" }, desc = "Toggle cursor" },
      { "<c-z>",         function() require("multicursor-nvim").enableCursors() end,   mode = { "n", "x" }, desc = "Toggle cursor" },
      { "<c-leftmouse>", function() require("multicursor-nvim").handleMouse() end,     mode = "n",          desc = "Mouse cursor" },
    },
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()

      -- 1. Setup Highlight (Warna Kursor)
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { reverse = true })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn" })
      hl(0, "MultiCursorDisabledCursor", { reverse = true })

      -- 2. Setup Keymap Layer
      mc.addKeymapLayer(function(layerSet)
        layerSet({ "n", "x" }, "<left>", mc.prevCursor)
        layerSet({ "n", "x" }, "<right>", mc.nextCursor)
        layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor)

        -- Esc cerdas: Jika ada banyak kursor, hapus kursornya.
        -- Jika sudah tinggal satu, kembali ke Normal mode biasa.
        layerSet("n", "<esc>", function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          else
            mc.clearCursors()
          end
        end)
      end)
    end
  }
}
