require("rose-pine").setup({
  styles = {
    bold = false,
    transparency = true,
  },
  highlight_groups = {
    FloatBorder = { fg = "rose" }
  }
})

vim.cmd('colorscheme rose-pine')
