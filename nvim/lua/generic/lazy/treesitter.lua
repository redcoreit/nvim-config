-- Open the appropiate Visual Studio command prompt for your arquitecture. i.e.: x64 Native Tools Command Prompt
-- Use the echo command to export the variables into a temporary file:
-- echo PATH=%PATH% >> temp-env.txt
-- echo INCLUDE=%INCLUDE% >> temp-env.txt
-- echo LIB=%LIB% >> temp-env.txt

local cfg_pwsh = function()
    -- https://www.lunarvim.org/docs/features/supported-languages/powershell
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.powershell = {
        install_info = {
            url = "https://github.com/jrsconfitto/tree-sitter-powershell",
            files = {"src/parser.c"}
        },
        filetype = "ps1",
        used_by = { "psm1", "psd1", "pssc", "psxml", "cdxml" }
    }
end

local cfg = function()
    cfg_pwsh()

    require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { 
            "c", 
            "lua", 
            "rust", 
            "c_sharp", 
            "dot",
            "markdown",
            "json",
            "toml",
            "powershell",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    }
end

--return {}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = cfg,
    },
}
