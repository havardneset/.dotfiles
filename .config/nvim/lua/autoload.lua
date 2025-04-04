local function load_lua_modules_from(dir)
  local config_path = vim.fn.stdpath 'config' .. '/lua/' .. dir
  local scan = require 'plenary.scandir' -- Make sure plenary is installed
  for _, file in ipairs(scan.scan_dir(config_path, { depth = 1, add_dirs = false })) do
    if file:match '%.lua$' then
      local mod = file:gsub(vim.fn.stdpath 'config' .. '/lua/', ''):gsub('%.lua$', ''):gsub('/', '.')
      pcall(require, mod)
    end
  end
end

load_lua_modules_from 'custom/config'
