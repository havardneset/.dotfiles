return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      picker = {
        enabled = true,
        layout = {
          preset = 'bottom',
        },
        win = {
          input = {
            keys = {
              -- Enable tab completion
              ['<Tab>'] = { 'list_down', mode = { 'i', 'n' } },
              ['<S-Tab>'] = { 'list_up', mode = { 'i', 'n' } },
            },
          },
        },
        sources = {
          files = {
            hidden = true,
            ignored = true,
            follow = true,
          },
          grep = {
            hidden = true,
            follow = true,
          },
        },
      },
    },
    config = function(_, opts)
      local snacks = require 'snacks'
      snacks.setup(opts)

      -- Set up keymaps
      local pick = snacks.picker

      vim.keymap.set('n', '<leader>sh', function() pick.help() end, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', function() pick.keymaps() end, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', function() pick.files() end, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sr', function() pick.git_files() end, { desc = '[S]earch [R]epo' })
      vim.keymap.set('n', '<leader>ss', function() pick.pickers() end, { desc = '[S]earch [S]elect Picker' })
      vim.keymap.set('n', '<leader>sg', function() pick.grep() end, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', function() pick.diagnostics() end, { desc = '[S]earch [D]iagnostics' })

      -- Smart picker combining buffers, recent files, and all files with frecency
      vim.keymap.set('n', '<leader><leader>', function() pick.smart() end, { desc = '[ ] Smart file finder (buffers + recent + files)' })

      -- Search for open tasks in notes
      vim.keymap.set(
        'n',
        '<leader>to',
        function()
          pick.grep {
            cwd = '~/Documents/notes',
            search = '\\[ ]',
            prompt = 'Open tasks',
          }
        end,
        { desc = '[O]pen [T]asks' }
      )

      -- Search config files
      vim.keymap.set('n', '<leader>sc', function() pick.files { cwd = '~/.config' } end, { desc = '[S]earch [C]onfig' })

      -- Search Neovim config files
      vim.keymap.set('n', '<leader>sn', function() pick.files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
