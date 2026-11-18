return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true }),
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                local ok, highlights = pcall(vim.treesitter.query.get, lang, "highlights")
                if ok and highlights and pcall(vim.treesitter.start, args.buf, lang) then
                    vim.bo[args.buf].indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })

        -- Use Neovim 0.12's built-in node selection.
        vim.keymap.set({ "n", "x" }, "<C-CR>", function()
            vim.treesitter.select("parent")
        end, { desc = "Expand syntax selection" })

        vim.keymap.set("x", "<C-BS>", function()
            vim.treesitter.select("child")
        end, { desc = "Shrink syntax selection" })
    end,
}
