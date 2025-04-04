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
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result, '\n'))
    vim.api.nvim_set_option_value('filetype', 'json', { buf = buf })
  else
    print 'Failed to decode the JWT.'
  end
end, {})

-- Mapping for <leader>jwt
vim.keymap.set('n', '<leader>jwt', ':JwtDecodeBuffer<CR>', { noremap = true, silent = true })
