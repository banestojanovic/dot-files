return {
  'mfussenegger/nvim-lint',
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'oxlint' },
      javascriptreact = { 'oxlint' },
      typescript = { 'oxlint' },
      typescriptreact = { 'oxlint' },
      php = { 'phpcs' },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
