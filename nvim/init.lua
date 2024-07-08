require("generic.set")
require("generic.remap")
require("generic.cmds")
require("system.hiyank")

if os.getenv("NVIM_PROFILE") == "bare" then
    require("bare.init")
elseif os.getenv("NVIM_PROFILE") == "sandbox" then
    print "Sandbox mode"
    vim.env.XDG_CONFIG_HOME = "./.sandbox/config"
    vim.env.XDG_DATA_HOME = "./.sandbox/local/share"
    vim.env.XDG_STATE_HOME = "./.sandbox/.local/state"
    vim.env.XDG_CACHE_HOME = "./.sandbox/.cache"

    require("generic.lazy_init")
else
    require("generic.lazy_init")
end

