local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
      'nvim-telescope/telescope.nvim',
      version = '*',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    {
      'rose-pine/neovim',
      name = 'rose-pine',
    },

    {
      'nvim-treesitter/nvim-treesitter',
      branch = 'main',
      build = ':TSUpdate',
      config = function()
        require('nvim-treesitter').install { "javascript", "typescript", "c", "lua", "vim", "vimdoc", "query", "gitcommit", "diff" }

        vim.api.nvim_create_autocmd('FileType', {
          pattern = '*',
          callback = function(args)
            local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
            if lang then
              pcall(vim.treesitter.start, args.buf, lang)
            end
          end,
        })
      end

    },
    'theprimeagen/harpoon',
    'mbbill/undotree',
    'tpope/vim-fugitive',
    -- LSP Support
    'neovim/nvim-lspconfig',
    {
      'williamboman/mason.nvim',
      opts = {
        ui = {
          border = "rounded"
        }
      }
    },
    'williamboman/mason-lspconfig.nvim',
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    {
      "hrsh7th/nvim-cmp",
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },                      -- Required
    'hrsh7th/cmp-nvim-lsp', -- Required
    'L3MON4D3/LuaSnip',     -- Required
    -- Lua
    {
      "shortcuts/no-neck-pain.nvim", version = "*"
    },
    {
      "stevearc/conform.nvim",
      event = { "BufReadPre", "BufNewFile" },
    },
    'glench/vim-jinja2-syntax' -- Nunjucks!!
  },
  {
    ui = {
      border = "rounded"
    }
  }
)
