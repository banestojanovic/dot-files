require('user.options')
require('user.keymaps')

github = 'https://github.com/'

vim.pack.add{
  { src = github .. 'catppuccin/nvim' },
  { src = github .. 'neovim/nvim-lspconfig' },
  { src = github .. 'mason-org/mason.nvim' },
  { src = github .. 'nvim-lua/plenary.nvim' },
  { src = github .. 'hoob3rt/lualine.nvim' },
  { src = github .. 'jessarcher/vim-heritage' },
}

require('mason').setup({
    ui = {
        height = 0.8
    }
})

vim.cmd("colorscheme catppuccin")

vim.pack.add({ github .. 'folke/which-key.nvim' })

require('which-key').setup({
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
})

-- Dashboard
vim.pack.add({ github .. 'nvim-tree/nvim-web-devicons' }) -- Dependency
vim.pack.add({ github .. 'glepnir/dashboard-nvim' })
require('dashboard').setup()

-- Treesitter
vim.pack.add( { 
    { src = github .. 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
    { src = github .. 'JoosepAlviste/nvim-ts-context-commentstring' },
    { src = github .. 'nvim-treesitter/nvim-treesitter-textobjects' },
    { src = github .. 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
} )
require('nvim-treesitter').setup( { 
    ensure_installed = {
      'arduino',
      'bash',
      'blade',
      'comment',
      'css',
      'diff',
      'dockerfile',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'html',
      'http',
      'ini',
      'javascript',
      'json',
      'jsonc',
      'lua',
      'make',
      'markdown',
      'passwd',
      'php',
      'php_only',
      'phpdoc',
      'python',
      'regex',
      'ruby',
      'rust',
      'sql',
      'svelte',
      'typescript',
      'vim',
      'vue',
      'xml',
      'yaml',
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = { "yaml" }
    },
    rainbow = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['if'] = '@function.inner',
          ['af'] = '@function.outer',
          ['ia'] = '@parameter.inner',
          ['aa'] = '@parameter.outer',
        },
      },
    },
} )

-- Telescope
vim.pack.add({
    github .. 'sharkdp/fd',
    github .. 'nvim-lua/plenary.nvim',
    github .. 'nvim-tree/nvim-web-devicons',
    github .. 'nvim-telescope/telescope-live-grep-args.nvim',
    github.. 'nvim-telescope/telescope-ui-select.nvim',
    { src = github .. 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
    github .. 'nvim-telescope/telescope.nvim'
})

require('telescope').setup()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-- Bufferline
vim.pack.add({ github .. 'akinsho/bufferline.nvim' })

local inactiveBg = {
  bg = { attribute = 'bg', highlight = 'BufferlineInactive' },
}

require('bufferline').setup({
    options = {
      indicator = {
        icon = ' ',
      },
      show_close_icon = false,
      tab_size = 0,
      max_name_length = 25,
      offsets = {
        {
          filetype = 'NvimTree',
          text = '  Files',
          highlight = 'StatusLine',
          text_align = 'left',
        },
        {
          filetype = 'neo-tree',
          text = function()
            return ' '..vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
          end,
          highlight = 'StatusLineComment',
          text_align = 'left',
        },
      },
      hover = {
        enabled = true,
        delay = 0,
        reveal = { "close" },
      },
      separator_style = 'slant',
      modified_icon = '',
      custom_areas = {
        left = function()
          return {
            { text = ' ' },
          }
        end,
        right = function()
          return {
            { text = '    ', fg = '#8fff6d' },
          }
        end,
      },
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and " " or " "
        return icon .. count
      end,
    },
    highlights = {
      fill = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      background = inactiveBg,
      close_button = inactiveBg,
      diagnostic = inactiveBg,
      diagnostic_visible = inactiveBg,
      modified = inactiveBg,
      modified_visible = inactiveBg,
      hint = inactiveBg,
      hint_visible = inactiveBg,
      info = inactiveBg,
      info_visible = inactiveBg,
      warning = inactiveBg,
      warning_visible = inactiveBg,
      error = inactiveBg,
      error_visible = inactiveBg,
      hint_diagnostic = inactiveBg,
      hint_diagnostic_visible = inactiveBg,
      info_diagnostic = inactiveBg,
      info_diagnostic_visible = inactiveBg,
      warning_diagnostic = inactiveBg,
      warning_diagnostic_visible = inactiveBg,
      error_diagnostic = inactiveBg,
      error_diagnostic_visible = inactiveBg,
      duplicate = inactiveBg,
      duplicate_visible = inactiveBg,
      separator = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
        bg = { attribute = 'bg', highlight = 'BufferlineInactive' },
      },
      separator_selected = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      separator_visible = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      trunc_marker = {
        bg = { attribute = 'bg', highlight = 'StatusLine' },
      },

      -- Tabs
      tab = inactiveBg,
      tab_separator = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
        bg = { attribute = 'bg', highlight = 'BufferlineInactive' },
      },
      tab_separator_selected = {
        fg = { attribute = 'bg', highlight = 'StatusLine' },
      },
      tab_close = {
        bg = 'yellow',
      },
    },
})


-- Status line
vim.pack.add( { github .. 'nvim-lualine/lualine.nvim' } )

require('lualine').setup({
    options = {
      section_separators = '',
      component_separators = '',
      globalstatus = true,
      theme = {
        normal = {
          a = 'StatusLine',
          b = 'StatusLine',
          c = 'StatusLine',
        },
      },
    },
    sections = {
      lualine_a = {
        'mode',
      },
      lualine_b = {
        'branch',
        {
          'diff',
          symbols = { added = ' ', modified = ' ', removed = ' ' },
        },
        function ()
          return '󰅭 ' .. vim.pesc(tostring(#vim.tbl_keys(vim.lsp.get_clients())) or '')
        end,
        { 'diagnostics', sources = { 'nvim_diagnostic' } },
      },
      lualine_c = {
        'filename'
      },
      lualine_y = {
        'filetype',
        'encoding',
        'fileformat',
        '(vim.bo.expandtab and "␠ " or "⇥ ") .. vim.bo.shiftwidth',
      },
      lualine_z = {
        'searchcount',
        'selectioncount',
        'location',
        'progress',
      },
    }
})


-- File tree sidebar
vim.pack.add( { 
    github .. 'MunifTanjim/nui.nvim',
    github .. 's1n7ax/nvim-window-picker',
    { src = github .. 'nvim-neo-tree/neo-tree.nvim', branch = 'v3.x' }
} )

require('window-picker').setup({
    filter_rules = {
          autoselect_one = true,
          include_current_win = false,
          bo = {
            filetype = { 'neo-tree', "neo-tree-popup", "notify" },
            buftype = { 'terminal', "quickfix" },
          },
        },
        highlights = {
          statusline = {
            focused = {
              bg = '#9d7cd8',
            },
            unfocused = {
              bg = '#9d7cd8',
            },
          },
        },
})

require('neo-tree').setup({
    close_if_last_window = true,
    hide_root_node = true,
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      "document_symbols",
    },
    source_selector = {
      winbar = true,
      statusline = false,
      separator = { left = "", right= "" },
      show_separator_on_edge = true,
      highlight_tab = "SidebarTabInactive",
      highlight_tab_active = "SidebarTabActive",
      highlight_background = "StatusLine",
      highlight_separator = "SidebarTabInactiveSeparator",
      highlight_separator_active = "SidebarTabActiveSeparator",
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function (file_path)
          require("neo-tree.command").execute({ action = "close" })
        end,
      }
    },
    default_component_configs = {
      indent = {
        padding = 0,
      },
      name = {
        use_git_status_colors = false,
        highlight_opened_files = true,
      },
    },
    window = {
      mappings = {
        ["<cr>"] = "open_with_window_picker",
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git",
        },
      },
      -- follow_current_file = {
      --   enabled = true,
      -- },
      group_empty_dirs = false
    },
})

vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal toggle<CR>')

-- Abolish
vim.pack.add({ github .. 'tpope/vim-abolish' })

-- Auto-pairs
vim.pack.add({
    { src = github .. 'windwp/nvim-autopairs', config = true }
})
require('nvim-autopairs').setup()


-- Barbecue
vim.pack.add({
    { src = github .. 'SmiteshP/nvim-navic' },
    { src = github .. 'utilyre/barbecue.nvim', event = 'BuffRead' }
})

require('barbecue').setup({
    theme = 'catppuccin',
})
require('nvim-navic').setup({
    lsp = {
        auto_attach = true,
    }
})

-- Close buffers without closing the split window.
vim.pack.add({ github .. 'famiu/bufdelete.nvim' })
vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
vim.keymap.set('n', '<Leader>Q', ':bufdo Bdelete<CR>')

-- Completion
vim.pack.add({
    { src = github .. 'hrsh7th/cmp-nvim-lsp' },
    { src = github .. 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { src = github .. 'hrsh7th/cmp-buffer' },
    { src = github .. 'hrsh7th/cmp-path' },
    -- { src = github .. 'hrsh7th/cmp-copilot' },
    { src = github .. 'L3MON4D3/LuaSnip' },
    { src = github .. 'saadparwaiz1/cmp_luasnip' },
    { src = github .. 'onsails/lspkind-nvim' },
    { src = github .. 'hrsh7th/cmp-nvim-lsp' },
    { src = github .. 'hrsh7th/cmp-nvim-lsp' },
    { src = github .. 'hrsh7th/cmp-nvim-lsp' },
    { src = github .. 'hrsh7th/cmp-nvim-lsp' },
    { src = github .. 'hrsh7th/nvim-cmp', event = 'InsertEnter' }
})

require('cmp').setup({
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        local lspkind = require('lspkind')

        require('luasnip/loaders/from_snipmate').lazy_load()

        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        local source_map = {
          buffer = "Buffer",
          nvim_lsp = "LSP",
          nvim_lsp_signature_help = "Signature",
          luasnip = "LuaSnip",
          nvim_lua = "Lua",
          path = "Path",
          copilot = "Copilot",
        }

        local function ltrim(s)
          return s:match'^%s*(.*)'
        end

        cmp.setup({
          preselect = false,
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          view = {
            entries = { name = 'custom', selection_order = 'near_cursor' },
          },
          window = {
            completion = {
              col_offset = -2 -- align the abbr and word on cursor (due to fields order below)
            }
          },
          formatting = {
            fields = { "kind", "abbr", "menu" },
            format = lspkind.cmp_format({
              mode = 'symbol',
              -- See: https://www.reddit.com/r/neovim/comments/103zetf/how_can_i_get_a_vscodelike_tailwind_css/
              before = function(entry, vim_item)
                -- Replace the 'menu' field with the kind and source
                vim_item.menu = '  ' .. vim_item.kind .. ' (' .. (source_map[entry.source.name] or entry.source.name) .. ')'
                vim_item.menu_hl_group = 'SpecialComment'

                vim_item.abbr = ltrim(vim_item.abbr)

                if vim_item.kind == 'Color' and entry.completion_item.documentation then
                  local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
                  if r then
                    local color = string.format('%02x', r) .. string.format('%02x', g) ..string.format('%02x', b)
                    local group = 'Tw_' .. color
                    if vim.fn.hlID(group) < 1 then
                      vim.api.nvim_set_hl(0, group, {fg = '#' .. color})
                    end
                    vim_item.kind_hl_group = group
                    return vim_item
                  end
                end

                return vim_item
              end
            }),
          },
          mapping = {
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              elseif has_words_before() then
                cmp.complete()
                print('complete...')
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
            -- ['<CR>'] = cmp.mapping(function (fallback)
            --   if cmp.visible() then
            --     if luasnip.expandable() then
            --       luasnip.expand()
            --     else
            --       cmp.confirm({
            --         select = true,
            --       })
            --     end
            --   else
            --     fallback()
            --   end
            -- end),
            ['<CR>'] = cmp.mapping.confirm({ select = false }),
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip' },
            -- { name = 'copilot' },
            { name = 'buffer' },
            { name = 'path' },
          },
          experimental = {
            -- ghost_text = true,
          },
        })

        -- cmp.setup.filetype("sql", {
        --   sources = cmp.config.sources({
        --     { name = 'vim-dadbod-completion' },
        --   }, {
        --     { name = 'buffer' },
        --   })
        -- })
      end,
})