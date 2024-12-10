return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    init = function()
      vim.api.nvim_create_user_command('ToggleCheckbox', function()
        local line = vim.api.nvim_get_current_line()

        if line:match '%[ %]' then
          line = line:gsub('%[ %]', '[x]')
        elseif line:match '%[x%]' then
          line = line:gsub('%[x%]', '[ ]')
        end

        -- Set the modified line
        vim.api.nvim_set_current_line(line)
      end, { desc = 'Toggle checkbox on the current line' })

      vim.api.nvim_create_user_command('AddCheckbox', function()
        local line = vim.api.nvim_get_current_line()
        local new_line = '- [ ] ' .. line
        vim.api.nvim_set_current_line(new_line)
      end, { desc = 'Add checkbox to current line' })

      vim.keymap.set('n', '<leader>ac', ':AddCheckbox<CR>', { desc = 'Add checkbox' })
      vim.keymap.set('n', '<leader>c', ':ToggleCheckbox<CR>', { desc = 'Toggle checkbox' })
    end,
  },
}
