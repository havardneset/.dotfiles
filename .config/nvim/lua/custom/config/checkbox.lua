-- Markdown / Checkbox functionality
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

  -- Check if the current line already contains a checkbox
  if line:match '%- %[.%]' then
    -- Move to the next line and add a checkbox
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_buf_set_lines(0, cursor_pos[1], cursor_pos[1], true, { '- [ ] ' })
    vim.api.nvim_win_set_cursor(0, { cursor_pos[1] + 1, 0 })
  else
    -- Add a checkbox to the current line
    local new_line = '- [ ] ' .. line
    vim.api.nvim_set_current_line(new_line)
    -- Move the cursor to the end of the current line
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    cursor_pos[2] = #new_line
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end

  -- Enter insert mode
  vim.cmd 'startinsert!'
end, { desc = 'Add checkbox to current line or next line if already present' })

vim.keymap.set('n', '<leader>ca', ':AddCheckbox<CR>', { desc = 'Add checkbox' })
vim.keymap.set('n', '<leader>cc', ':ToggleCheckbox<CR>', { desc = 'Toggle checkbox' })
