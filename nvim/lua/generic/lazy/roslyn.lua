-- https://github.com/seblj/roslyn.nvim

local opts = {
    exe = {
        "dotnet",
        vim.fs.joinpath("C:/root/sbin/roslyn-ls/", "x64", "Microsoft.CodeAnalysis.LanguageServer.dll"),
    },
    config = {
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
    },
    filewatching = false,
    broad_search = true,
    lock_target = false,

}

return { 
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = opts
}
