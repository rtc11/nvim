return {
    -----------------------------------------------------------------------------
    ---- crate suggestions in rust toml
    -----------------------------------------------------------------------------
    {
        'saecki/crates.nvim',
        tag = 'stable',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    },

    -----------------------------------------------------------------------------
    ---- lua autocompletion
    -----------------------------------------------------------------------------
    {
        'L3MON4D3/LuaSnip',
        lazy = false,
        dependencies = {
            'rafamadriz/friendly-snippets',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
        end
    },

    -----------------------------------------------------------------------------
    ---- lua autocompletion
    -----------------------------------------------------------------------------
    {
        'hrsh7th/cmp-nvim-lsp',
        lazy = false,
        config = true,
    },

    -----------------------------------------------------------------------------
    ---- lua autocompletion
    -----------------------------------------------------------------------------
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            'hrsh7th/cmp-buffer',           -- source for text in buffer
            'hrsh7th/cmp-path',             -- source for file system path
            'L3MON4D3/LuaSnip',             -- snippet engine
            'saadparwaiz1/cmp_luasnip',     -- for autocompletion
            'rafamadriz/friendly-snippets', -- useful snippets
            'udalov/kotlin-vim',
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            cmp.setup({
                completion = {
                    completeopt = 'menu,menuone', --,preview,noselect',
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestion
                    ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" },  -- text within current buffer
                    { name = "path" },    -- file system paths
                })
            })
        end
    }
}
