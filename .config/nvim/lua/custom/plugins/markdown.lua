return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    init = function()
      vim.api.nvim_create_user_command('ToggleCheckbox', function()
        -- Get the current line
        local line = vim.api.nvim_get_current_line()

        -- Check if the line contains a checkbox
        if line:match '%[ %]' then
          -- Replace [ ] with [x]
          line = line:gsub('%[ %]', '[x]')
        elseif line:match '%[x%]' then
          -- Replace [x] with [ ]
          line = line:gsub('%[x%]', '[ ]')
        end

        -- Set the modified line
        vim.api.nvim_set_current_line(line)
      end, { desc = 'Toggle checkbox on the current line' })

      vim.keymap.set('n', '<leader>c', ':ToggleCheckbox<CR>', { desc = 'Toggle checkbox' })
    end,
  },
}
