-- Markdown / Checkbox functionality

-- Helper function to toggle checkbox on a single line
local function toggle_checkbox_line(line)
  if line:match '%[ %]' then
    return line:gsub('%[ %]', '[x]')
  elseif line:match '%[x%]' then
    return line:gsub('%[x%]', '[ ]')
  end
  return line
end

vim.api.nvim_create_user_command('ToggleCheckbox', function(opts)
  local start_line, end_line

  if opts.range > 0 then
    -- Visual selection mode
    start_line = opts.line1
    end_line = opts.line2
  else
    -- Single line mode
    start_line = vim.api.nvim_win_get_cursor(0)[1]
    end_line = start_line
  end

  -- Get all lines in the range
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Toggle checkboxes in each line
  for i, line in ipairs(lines) do
    lines[i] = toggle_checkbox_line(line)
  end

  -- Set the modified lines back
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
end, { desc = 'Toggle checkbox on current line or selection', range = true })

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

vim.keymap.set('n', '<leader>ci', ':AddCheckbox<CR>', { desc = 'Add checkbox' })
vim.keymap.set('n', '<leader>cc', ':ToggleCheckbox<CR>', { desc = 'Toggle checkbox' })
vim.keymap.set('v', '<leader>cc', ':ToggleCheckbox<CR>', { desc = 'Toggle checkboxes in selection' })
