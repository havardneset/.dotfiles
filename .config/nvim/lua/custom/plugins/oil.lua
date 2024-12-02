return {
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
          return name == '..' or name == '.git'
        end,
      },
    },
    init = function()
      vim.api.nvim_set_keymap('n', '-', ':Oil<CR>', { noremap = true, silent = true })
    end,
  },
}
