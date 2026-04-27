require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'ts_ls',
    'eslint',
    'cssls',
    'html',
    'lua_ls',
  },
  handlers = {
    ts_ls = function()
      vim.lsp.config('ts_ls', {
        root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
      })
      vim.lsp.enable('ts_ls')
    end,

    eslint = function()
      vim.lsp.config('eslint', {
        root_markers = { 'eslint.config.js', 'eslint.config.mjs', '.eslintrc.js', '.eslintrc.json', 'package.json', '.git' },
      })
      vim.lsp.enable('eslint')
    end,

    cssls = function()
      vim.lsp.config('cssls', {
        root_markers = { 'package.json', '.git' },
      })
      vim.lsp.enable('cssls')
    end,

    html = function()
      vim.lsp.config('html', {
        root_markers = { 'package.json', '.git' },
      })
      vim.lsp.enable('html')
    end,

    lua_ls = function()
      vim.lsp.config('lua_ls', {
        root_markers = { '.luarc.json', '.luarc.jsonc', 'lazy-lock.json', '.git' },
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } }
          }
        }
      })
      vim.lsp.enable('lua_ls')
    end,
  }
})

vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = {
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ['<C-Space>'] = cmp.mapping.complete(),
}

cmp.setup({
  sources = { { name = 'nvim_lsp' } },
  mapping = cmp.mapping.preset.insert(cmp_mappings),
  snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf
    local opts = { buffer = bufnr, remap = false }

    -- if vim.g.vscode then
    --   vim.keymap.set("n", "gd", function()
    --     vim.fn.VSCodeNotify("editor.action.revealDefinition")
    --   end, opts)
    -- else
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- end
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    --    vim.keymap.set("n", "<leader>n", function() vim.fn.VSCodeNotify("workbench.action.files.newUntitledFile") end)
    --    vim.keymap.set("n", "<C-s>", function() vim.fn.VSCodeNotify("workbench.action.files.save") end)
    --    vim.keymap.set("n", "<leader>vd", function() vim.fn.VSCodeNotify("editor.action.showHover") end, opts)
    --    vim.keymap.set("n", "[d", function() vim.fn.VSCodeNotify("editor.action.marker.next") end, opts)
    --    vim.keymap.set("n", "]d", function() vim.fn.VSCodeNotify("editor.action.marker.prev") end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  end
})
