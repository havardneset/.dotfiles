return {
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    dependencies = {
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
          library = {
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
      { 'Bilal2453/luvit-meta', lazy = true },
    },

    -- use a release tag to download pre-built binaries
    version = 'v0.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'default',
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' },
      },

      appearance = {
        -- Sets the fallback highlight groups to blink.cmp's default groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      -- default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, via `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'buffer', 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },

      -- experimental signature help support
      signature = { enabled = true },

      -- cmdline completion configuration
      cmdline = {
        enabled = true,
        keymap = {
          preset = 'inherit', -- inherit keymaps from main config
          ['<CR>'] = {}, -- disable Enter to accept in cmdline, just execute the command
        },
        completion = {
          menu = {
            auto_show = function(ctx)
              -- Only auto-show for commands (:), not for search (/, ?)
              return vim.fn.getcmdtype() == ':'
            end,
          },
        },
      },
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { 'sources.default' },
  },
}
-- vim: ts=2 sts=2 sw=2 et
