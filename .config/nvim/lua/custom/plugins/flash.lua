return {
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {},
    init = function()
      -- Create global mapping for <CR>
      vim.keymap.set({ 'n', 'x', 'o' }, '<CR>', function() require('flash').jump() end, { desc = 'Flash' })

      -- Disable the mapping in quickfix windows using an autocmd
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'qf',
        callback = function() vim.keymap.set({ 'n', 'x', 'o' }, '<CR>', '<CR>', { buffer = true, desc = 'Default quickfix enter' }) end,
      })
    end,
  },
}
