require("generic.set")
require("generic.remap")
require("generic.cmds")
require("system.hiyank")

if os.getenv("NVIM_PROFILE") == "bare" then
    require("bare.init")
else
    require("generic.lazy_init")
end

