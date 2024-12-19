return {
    { "junegunn/fzf" },
    {
        "junegunn/fzf.vim",
        keys = {
            {
                "<leader>sf",
                "<cmd>Files<cr>",
                desc ="fzf (files)",
            },
            {
                "<leader>sg",
                "<cmd>Rg<cr>",
                desc ="rg (content)",
            },
            {
                "<leader><space>",
                ":Jumps<cr>",
                desc = "Show jumps"
            },
        }
    },
}
