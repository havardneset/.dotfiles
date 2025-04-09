local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- Navigate between LSP diagnostics (errors/warnings)
vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next, { desc = 'Go to next LSP error' })
vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev, { desc = 'Go to previous LSP error' })

-- Manipulate quickfix list
vim.api.nvim_set_keymap('n', '<leader>eq', ':cexpr []<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>eo', ':copen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ec', ':cclose<CR>', { noremap = true, silent = true })

-- Remap <C-i> so <Tab> doesn't interfere
vim.api.nvim_set_keymap('n', '<C-i>', '<C-i>', { noremap = true, silent = true })

-- Map line navigation to easier mappings
vim.keymap.set({ 'n', 'v', 'o' }, 'gh', '^')
vim.keymap.set({ 'n', 'v', 'o' }, 'gl', '$')
vim.keymap.set({ 'n', 'v', 'o' }, 'gj', '%')

-- Paste without overriding the current register
vim.keymap.set('x', 'p', [["_dP]], { desc = 'Paste without overwriting register' })

-- Remap 'c' to use the black hole register so it doesn't overwrite the unnamed register
vim.api.nvim_set_keymap('n', 'c', '"_c', { noremap = true })
vim.api.nvim_set_keymap('n', 'C', '"_C', { noremap = true })
vim.api.nvim_set_keymap('n', 'cc', '"_cc', { noremap = true })
vim.api.nvim_set_keymap('v', 'c', '"_c', { noremap = true })

-- Search and replace word under the cursor.
vim.keymap.set('n', '<Leader>r', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]])

-- Highlight when yanking (copying) text
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

-- Tab to indent and Shift-Tab to unindent
-- Normal mode mappings
map('n', '<Tab>', '>>', { silent = true })
map('n', '<S-Tab>', '<<', { silent = true })

-- Visual mode mappings
map('v', '<Tab>', '>gv', { silent = true })
map('v', '<S-Tab>', '<gv', { silent = true })
