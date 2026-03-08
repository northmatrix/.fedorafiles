require("nvchad.configs.lspconfig").defaults()

local servers = {
  html = {},
  cssls = {},
  awk_ls = {},
  bashls = {},

  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },

  clangd = {
    -- attach handler that disables formatting for clangd
    on_attach = function(client, bufnr)
      -- disable clangd's document formatting so another formatter (e.g. null-ls) can be used
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      -- (optional) set keymaps or other per-buffer settings here
      -- Example: vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap=true, silent=true})
    end,
  },
}

for name, opts in pairs(servers) do
  -- use vim.lsp.start/config depending on your Neovim LSP helper; adjust if you use lspconfig
  if opts.on_attach or opts.settings then
    require("lspconfig")[name].setup(opts)
  else
    require("lspconfig")[name].setup {}
  end
end

-- read :h vim.lsp.config for changing options of lsp servers
