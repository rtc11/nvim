return {
  'mhartington/formatter.nvim',
  config = function()
    local util = require "formatter.util"
    require('formatter').setup({
      filetype = {
        ocaml = {
          require("formatter.filetypes.ocaml"),
          function()
            return {
              exe = "ocamlformat",
              stdin = true,
              args = {
                "--enable-outside-detected-project",
                util.escape_path(util.get_current_buffer_file_name()),
              },
            }
          end
        },
        kotlin = {
          require('formatter.filetypes.kotlin'),
          function()
            return {
              exe = "ktlint",
              stdin = true,
              args = {
                "--stdin",
                "--format",
                "--log-level=none"
              },
            }
          end
        },
        rust = {
          require('formatter.filetypes.rust'),
          function()
            return {
              exe = 'rustfmt',
              stdin = true,
              args = {
                '--edition 2021'
              },
            }
          end
        },
        toaml = {
          require('formatter.filetypes.toml'),
          function()
            return {
              exe = 'taplo',
              stdin = true,
              try_node_modules = true,
              args = {
                'fmt',
                '--stdin-filepath',
                util.escape_path(util.get_current_buffer_file_name()),
                '-',
              },
            }
          end
        },
      },
    })

    --format on save
    --[[
    vim.api.nvim_create_augroup('__formatter__', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = '__formatter__',
      command = ':FormatWrite',
    })
    --]]
  end
}
