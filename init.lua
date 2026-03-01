print("ONURB IS ALIVE")


-- Line numbers
vim.opt.number = true
-- vim.opt.relativenumber = true

-- Show whitespace
vim.opt.list = true
vim.opt.listchars = {
  tab = "▸ ",
  trail = "·",
  nbsp = "␣",
}

-- Highlight trailing whitespace
vim.cmd([[
  highlight ExtraWhitespace guibg=#3c1f1f
  match ExtraWhitespace /\s\+$/
]])

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  -- Monokai
  {
    "tanvirtin/monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai").setup({})
      vim.cmd("colorscheme monokai")
    end,
  },

  -- Mason
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" }
      })
    end,
  },

-- COQ
{
  "ms-jpq/coq_nvim",
  branch = "coq",
  lazy = false,
  build = ":COQdeps",
  init = function()
    vim.g.coq_settings = {
      auto_start = "shut-up",
      keymap = { recommended = true },
    }
  end,
},
{ "ms-jpq/coq.thirdparty", branch = "3p", lazy = false },

-- LSP core
{ "neovim/nvim-lspconfig", event = "VeryLazy" },

-- Mason <-> LSP bridge
{
  "williamboman/mason-lspconfig.nvim",
  version = "^1.0.0",
  event = "VeryLazy",
  dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright", "ts_ls" },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")
    local coq = require("coq")

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        lspconfig[server_name].setup(coq.lsp_ensure_capabilities({}))
      end,
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup(coq.lsp_ensure_capabilities({
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
            },
          },
        }))
      end,
    })
  end,
},

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Carbon
  {
    "ellisonleao/carbon-now.nvim",
    cmd = "CarbonNow",
    config = function()
      require("carbon-now").setup({
        open_cmd = "xdg-open",
      })
    end,
  },

})
