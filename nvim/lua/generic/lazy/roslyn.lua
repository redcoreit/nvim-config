-- https://github.com/seblj/roslyn.nvim

local opts = {
    -- "auto" | "roslyn" | "off"
    --
    -- - "auto": Does nothing for filewatching, leaving everything as default
    -- - "roslyn": Turns off neovim filewatching which will make roslyn do the filewatching
    -- - "off": Hack to turn off all filewatching. (Can be used if you notice performance issues)
    filewatching = "roslyn",

    -- Optional function that takes an array of targets as the only argument. Return the target you
    -- want to use. If it returns `nil`, then it falls back to guessing the target like normal
    -- Example:
    --
    -- choose_target = function(target)
    --     return vim.iter(target):find(function(item)
    --         if string.match(item, "Foo.sln") then
    --             return item
    --         end
    --     end)
    -- end
    choose_target = nil,

    -- Optional function that takes the selected target as the only argument.
    -- Returns a boolean of whether it should be ignored to attach to or not
    --
    -- I am for example using this to disable a solution with a lot of .NET Framework code on mac
    -- Example:
    --
    -- ignore_target = function(target)
    --     return string.match(target, "Foo.sln") ~= nil
    -- end
    ignore_target = nil,

    -- Whether or not to look for solution files in the child of the (root).
    -- Set this to true if you have some projects that are not a child of the
    -- directory with the solution file
    broad_search = true,

    -- Whether or not to lock the solution target after the first attach.
    -- This will always attach to the target in `vim.g.roslyn_nvim_selected_solution`.
    -- NOTE: You can use `:Roslyn target` to change the target
    lock_target = false,
}

local function force_update_diag()
    local clients = vim.lsp.get_clients({ name = "roslyn" })
    if not clients or #clients == 0 then
        return
    end

    local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
    for _, buf in ipairs(buffers) do
        vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
    end
end

local cfg = function()
    require("roslyn").setup()

    vim.lsp.config("roslyn", {
        on_attach = function()
            -- vim.notify("Roslyn LSP attached")
        end,
        settings = {
            ["csharp|inlay_hints"] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = true,
                csharp_enable_inlay_hints_for_implicit_variable_types = true,
                csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                csharp_enable_inlay_hints_for_types = true,
                dotnet_enable_inlay_hints_for_indexer_parameters = true,
                dotnet_enable_inlay_hints_for_literal_parameters = true,
                dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                dotnet_enable_inlay_hints_for_other_parameters = true,
                dotnet_enable_inlay_hints_for_parameters = true,
                dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ["csharp|code_lens"] = {
                dotnet_enable_references_code_lens = false,
            },
            ["csharp|background_analysis"] = {
                dotnet_analyzer_diagnostics_scope = "fullSolution",
                dotnet_compiler_diagnostics_scope = "fullSolution"
            },
            ["csharp|symbol_search"] = {
                dotnet_search_reference_assemblies = true
            }
        },
    })

    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        pattern = "*",
        callback = force_update_diag
    })

    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "MakeDotnetFinished",
        callback = force_update_diag
    })
end

return { 
    {
        "seblj/roslyn.nvim",
        config = cfg,
        ft = "cs",
        opts = opts,
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
    },
}
