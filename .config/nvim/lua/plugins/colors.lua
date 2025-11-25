return {
  { "LazyVim", opts = { colorscheme = "catppuccin" } },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      -- Remove strange background from the gutter.
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      -- Add transparent background to diagnostics.
      overrides = function(config)
        local theme = config.theme
        local color = require("kanagawa.lib.color")
        local make_highlight = function(c)
          local ratio = vim.o.background == "dark" and 0.95 or 0.80
          return { fg = c, bg = color(c):blend(theme.ui.bg, ratio):to_hex() }
        end
        -- stylua: ignore
        return {
          DiagnosticVirtualTextHint  = make_highlight(theme.diag.hint),
          DiagnosticVirtualTextInfo  = make_highlight(theme.diag.info),
          DiagnosticVirtualTextWarn  = make_highlight(theme.diag.warning),
          DiagnosticVirtualTextError = make_highlight(theme.diag.error),
        }
      end,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "bold,italic",
        },
      },
    },
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      bold_keywords = true,
      bright_border = true,
    },
  },
}
