-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Search and replace word under the cursor.
vim.keymap.set('n', '<Leader>r', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Prettify JSON
vim.api.nvim_create_user_command('JsonFormat', function()
  vim.cmd '%!jq'
end, {})

vim.keymap.set('n', '<leader>js', ':JsonFormat<CR>')

-- Replace newlines
vim.api.nvim_create_user_command('NewLines', function()
  vim.cmd '%s/ 	/\r/g'
end, {})

vim.keymap.set('n', '<leader>nl', ':NewLines<CR>')

-- Centralize screen after moving
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true })

-- decode JWT tokens
vim.api.nvim_create_user_command('JwtDecodeBuffer', function()
  -- Get the content of the entire buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local jwt = table.concat(lines, '') -- Combine all lines into a single string

  if jwt == '' then
    print 'The buffer is empty or does not contain a valid JWT.'
    return
  end

  -- Shell command to decode the JWT (both header and payload)
  local cmd = string.format("echo '%s' | sed 's/\\./\\n/g' | base64 --decode | jq", jwt)
  local handle = io.popen(cmd)
  local result = handle:read '*a'
  handle:close()

  -- Display the result in a new buffer
  if result and result ~= '' then
    vim.cmd 'new' -- Open a new split window
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result, '\n'))
  else
    print 'Failed to decode the JWT.'
  end
end, {})

-- Mapping for <leader>jwt
vim.keymap.set('n', '<leader>jwt', ':JwtDecodeBuffer<CR>', { noremap = true, silent = true })
