return {
  {
    "mason-org/mason.nvim",
    version = "^2.0.0",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      vim.lsp.enable("pyright")
      vim.lsp.enable("clangd")
    end,
  },
}
