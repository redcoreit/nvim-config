local cfg_cmp = function()
    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-o>'] = cmp.mapping.select_next_item(),
            ['<Enter>'] = cmp.mapping.confirm({ select = true }),
            ["<C-u>"] = cmp.mapping.scroll_docs(-4),
            ["<C-d>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
        }, 
        {
            { name = 'path' },
        },
        {
            { name = 'buffer' },
        })
    })
end

local cfg_powershell_es = function()
    -- TODO: this is not working, but no clue why
    local lspconfig = require("lspconfig")

    local bundle_path = "C:\\Users\\roland.halbaksz\\AppData\\Local\\nvim-data\\mason\\packages\\powershell-editor-services"
    local command_fmt = [[& '%s/PowerShellEditorServices/Start-EditorServices.ps1' -BundledModulesPath '%s' -LogPath '%s/powershell_es.log' -SessionDetailsPath '%s/powershell_es.session.json' -FeatureFlags @() -AdditionalModules @() -HostName nvim -HostProfileId 0 -HostVersion 1.0.0 -Stdio -LogLevel Normal]] local temp_path = vim.fn.stdpath("cache")
    local command = command_fmt:format(bundle_path, bundle_path, temp_path, temp_path)    

    lspconfig.powershell_es.setup({
        init_options = {
          enableProfileLoading = false,
        },
        filetypes = { "ps1" },
        bundle_path = bundle_path,
        cmd = {'pwsh', '-NoLogo', '-NoProfile', '-Command', command},
        root_dir = lspconfig.util.root_pattern("*.ps1"),
    })
end

local cfg_lua = function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                hint = {
                    enable = true,
                    setType = true,
                },
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    })
end

local cfg = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "powershell_es",
            --"csharp_ls",
            "omnisharp",
            "jsonls",
            "yamlls",
        },
        handlers = {
            ["powershell_es"] = cfg_powershell_es,
            ["lua_ls"] = cfg_lua,
            function(server_name)
                require("lspconfig")[server_name].setup({})
            end,
        },
    })


    cfg_cmp()

    vim.lsp.inlay_hint.enable()

    vim.diagnostic.config({
        virtual_text = {severity = {min = vim.diagnostic.severity.ERROR}},
        signs = {severity = {min = vim.diagnostic.severity.HINT}},
        underline = {severity = {min = vim.diagnostic.severity.WARN}},
        update_in_insert = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    })
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = 
        { 
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            {
                --'hrsh7th/cmp-path',

                -- https://github.com/hrsh7th/cmp-path/pull/60
                "yehuohan/cmp-path",
                commit = "cc4560b7ff39125c3aa9c2dd1050704d4d0a9bf7",
            },
            'hrsh7th/cmp-cmdline',
        },
        config = cfg,
    }
}
