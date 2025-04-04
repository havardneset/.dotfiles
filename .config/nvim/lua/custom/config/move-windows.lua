-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
local function move_or_split(direction, split_type)
  if vim.fn.winnr '$' > 1 then
    vim.cmd('wincmd ' .. direction)
  else
    vim.cmd(split_type)
    vim.cmd('wincmd ' .. direction)
  end
end

vim.keymap.set('n', '<C-h>', function()
  move_or_split('h', 'vsplit')
end, { desc = 'Move focus to the left window or open a new one' })

vim.keymap.set('n', '<C-l>', function()
  move_or_split('l', 'vsplit')
end, { desc = 'Move focus to the right window or open a new one' })

vim.keymap.set('n', '<C-j>', function()
  move_or_split('j', 'split')
end, { desc = 'Move focus to the lower window or open a new one' })

vim.keymap.set('n', '<C-k>', function()
  move_or_split('k', 'split')
end, { desc = 'Move focus to the upper window or open a new one' })
