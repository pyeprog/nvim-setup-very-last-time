return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
                selection_modes = {
                    ["@parameter.outer"] = "v",
                    ["@function.outer"] = "V",
                    ["@class.outer"] = "<c-v>",
                },
                include_surrounding_whitespace = true,
            },
        })

        local mappings = {
            af = { "@function.outer", "textobjects" },
            ["if"] = { "@function.inner", "textobjects" },
            ac = { "@class.outer", "textobjects" },
            ic = { "@class.inner", "textobjects" },
            as = { "@local.scope", "locals" },
        }

        for key, target in pairs(mappings) do
            vim.keymap.set({ "x", "o" }, key, function()
                require("nvim-treesitter-textobjects.select")
                    .select_textobject(target[1], target[2])
            end, { desc = "Select " .. target[1] })
        end
    end,
}
