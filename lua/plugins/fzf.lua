return {
    -----------------------------------------------------------------------------
    -- fzf
    -----------------------------------------------------------------------------
    {
        "junegunn/fzf"
    },
    -----------------------------------------------------------------------------
    -- sane vim defaults for fzf
    -----------------------------------------------------------------------------
    {
        "junegunn/fzf.vim",
        keys = {
            { "<leader>sf", "<cmd>FZF<cr>",  desc = "[S]earch [F]iles with fzf" },
            { "<leader>sg", "<cmd>Rg<cr>",  desc = "[S]earch [G]rep with ripgrep" },
            { "<leader>sj", "<cmd>Jumps<cr>",  desc = "[S]earch [J]ump" },
            { "<leader>sb", "<cmd>Buf<cr>",  desc = "[S]earch [B]uffer" },
            { "<leader><space>", "<cmd>Buf<cr>",  desc = "[S]earch [B]uffer" },
        },
        config = function()

            -- Send selected ripgrep results to the quickfix list
            -- Usage: tab to toggle a candidate, or ctrl-a to select all, or ctrl-d to deselect all
            --        ctrl-q send the selected to quickfix list and opens it with :copen
            vim.g.fzf_action = {
                ['ctrl-q'] = function(selected)
                    local quickfix_list = {}
                    for _, item in ipairs(selected) do 
                        table.insert(quickfix_list, { filename = item })
                    end
                    vim.fn.setqflist(quickfix_list, 'r')
                    vim.cmd("copen")
                end,
                ['enter'] = 'edit'
            }
        end
    },
}
