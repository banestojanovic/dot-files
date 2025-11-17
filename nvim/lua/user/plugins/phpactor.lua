-- PHP Refactoring Tools

return {
  'phpactor/phpactor',
  build = 'composer install --no-dev --optimize-autoloader',
  ft = 'php',
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<Leader>pm', ':PhpactorContextMenu<CR>' },
    { '<Leader>pn', ':PhpactorClassNew<CR>' },
  }
}
