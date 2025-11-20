return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      php = { "phpcbf", "pint" }, 
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    },
    formatters = {
      phpcbf = {
        command = "phpcbf",
        args = { "--standard=WordPress", "-" },
        stdin = true,
        timeout_ms = 30000,
        -- This is the key: only run phpcbf if the project looks like WordPress
        condition = function(ctx)
          return vim.fs.find(
            { "wp-config.php", "wp-content", "wp-includes" },
            { upward = true, path = ctx.dirname }
          )[1] ~= nil
        end,
      },
      pint = {
        command = "vendor/bin/pint",
        args = { "$FILENAME" },
        stdin = false,
      },
   },
  format_on_save = {
     -- These options will be passed to conform.format()
     timeout_ms = 10000,
     -- lsp_format = "fallback",
   },
  },
}
