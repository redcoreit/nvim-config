require("generic.set")
require("generic.cmds")
require("system.hiyank")

if os.getenv("NVIM_PROFILE") == "bare" then
    require("bare.init")
elseif os.getenv("NVIM_PROFILE") == "sandbox" then
    print ("Sandbox mode: ".. vim.fn.getcwd())

    -- Get the current runtime paths
    local rtp = vim.api.nvim_list_runtime_paths()

    -- Filter out paths that start with '~' or 'C:\\Users'
    local filtered_rtp = {}
    for _, path in ipairs(rtp) do
        if not path:match("^~") and not path:match("^C:\\Users") then
            table.insert(filtered_rtp, path)
        end
    end

    -- Rebuild the runtime path
    vim.o.runtimepath = table.concat(filtered_rtp, ",")
    print(vim.o.runtimepath)

    vim.env.XDG_CONFIG_HOME = "../.sandbox/config"
    vim.env.XDG_DATA_HOME = "../.sandbox/local/share"
    vim.env.XDG_STATE_HOME = "../.sandbox/.local/state"
    vim.env.XDG_CACHE_HOME = "../.sandbox/.cache"

    require("generic.bootstrap_lazy")
else
    require("generic.bootstrap_lazy")
end

require("lua.generic.remap")
