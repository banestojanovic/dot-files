-- Show pending keybinds

return {
  'folke/which-key.nvim',
  enabled = true,
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
