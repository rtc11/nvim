return {
    -----------------------------------------------------------------------------
    --- LSP
    -----------------------------------------------------------------------------
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            { 'antosha417/nvim-lsp-file-operations', config = true },
            'mhartington/formatter.nvim', -- formatter
            'folke/neodev.nvim'       -- additional handy lua configs
        },
        opts = {
            inlay_hints = { enabled = true }
        },
        config = function()
            local lspconfig = require('lspconfig')
            local cmp_nvim_lsp = require('cmp_nvim_lsp')

            local on_attach = function(_, bufnr)
                local nmap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, })
                end
                local imap = function(keys, func, desc)
                    if desc then
                        desc = 'LSP: ' .. desc
                    end
                    vim.keymap.set('i', keys, func, { buffer = bufnr, desc = desc, })
                end

                nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
                nmap('<leader>ca', vim.lsp.buf.code_action, 'Code actions')
                nmap('gd', vim.lsp.buf.definition, 'Goto definition')
                nmap('gr', vim.lsp.buf.references, 'Goto references')
                nmap('gI', vim.lsp.buf.implementation, 'Goto implementation')
                nmap('<leader>D', vim.lsp.buf.type_definition, 'Type definition')
                nmap('gO', vim.lsp.buf.document_symbol, 'Goto document symbols')
                nmap('K', vim.lsp.buf.hover, 'Hover documentation')
                imap('<C-k>', vim.lsp.buf.signature_help, 'Signature documentation')
                nmap('gD', vim.lsp.buf.declaration, 'Goto declaration')
                nmap('<leader>f', ':Format<CR>', 'Format code')
                nmap('<leader>F', ':FormatWrite<CR>', 'Format code')
                nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace add folder')
                nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace remove folder')
                nmap('<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, 'Workspace list folders')

                vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                    vim.lsp.buf.format()
                end, { desc = 'Format current buffer with LSP' })
            end

            local capabilities = cmp_nvim_lsp.default_capabilities()
            local signs = { Error = '⊗ ', Warn = '⊕ ', Hint = '⨺ ', Info = 'ℹ︎ ' }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
            end

            lspconfig['rust_analyzer'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    ["rust-analyser"] = {
                        checkOnSave = {
                            enable = true,
                            command = 'clippy'
                        },
                    }
                }
            })
            lspconfig['kotlin_language_server'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern("settings.gradle.kts", "buildk.toml", "Makefile"),
                cmd = { '/Users/robin/code/kotlin/kotlin-language-server/server/build/install/server/bin/kotlin-language-server' },
                init_options = {
                    storagePath = "/Users/robin/.config/kotlin-language-server/"
                },
                settings = {
                    kotlin = {
                        compiler = { jvm = { target = "21" } }
                    }
                }
            })
            lspconfig['gopls'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
            lspconfig['clangd'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern(
                    ".git",
                    "Makefile",
                    "*.c",
                    "*.h"
                ),
            })
            lspconfig['metals'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "scala", "mill" }
            })
            lspconfig['lua_ls'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                        telemetry = { enable = false },
                    }
                }
            })
            lspconfig['ocamllsp'].setup({
                capabilities = capabilities,
                on_attach = on_attach
            })
            lspconfig['gleam'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern("gleam.toml"),
            })
            lspconfig['c3_lsp'].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                root_dir = lspconfig.util.root_pattern(
                    ".git",
                    "*.c3",
                    "project.json",
                    "manifest.json"
                ),
            })
        end
    },

    -----------------------------------------------------------------------------
    --- Package manager
    -----------------------------------------------------------------------------
    {
        'williamboman/mason.nvim',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            local mason = require('mason')
            local mason_lspconfig = require('mason-lspconfig')

            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "→",
                        package_uninstalled = "𐄂",
                    }
                }
            })

            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "ocamllsp",
                    "kotlin_language_server",
                    "gopls",
                    "clangd",
                    --                "gleam",
                },

                --            automatic_installation = true,
            })
        end
    }
}
