return {
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'

      vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = '#51B3EC', bold = true })
      vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#51B3EC', bold = true })
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
