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

        -- Check if the line contains a checkbox and toggle it
        if line:match '%[ %]' then
          line = line:gsub('%[ %]', '[x]')
        elseif line:match '%[x%]' then
          line = line:gsub('%[x%]', '[ ]')
        else
          return
        end

        -- Use vim.cmd.normal to make this action repeatable with `.`
        vim.cmd 'normal! "_dd' -- Delete the current line
        vim.cmd('normal! O' .. line) -- Insert the modified line
        vim.cmd 'normal! ==' -- Reindent (optional, if needed)
      end, { desc = 'Toggle checkbox on the current line' })

      vim.keymap.set('n', '<leader>c', ':ToggleCheckbox<CR>', { desc = 'Toggle checkbox' })
    end,
  },
}
