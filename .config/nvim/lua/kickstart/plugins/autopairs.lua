-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    require('nvim-autopairs').setup {}
  end,
}
