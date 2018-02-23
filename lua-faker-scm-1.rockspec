package = "lua-faker"
version = "scm-1"

source = {
    url = "git://github.com:shkuropat/lua-faker.git",
    branch = 'master',
}

description = {
    summary    = "Fake identities generator (names, addresses, phones, IPs and others). Supports multiple languages.",
    homepage   = "https://github.com/shkuropat/lua-faker",
    license    = "MIT",
    maintainer = "Eugene Shkuropat <e.shkuropat@gmail.com>"
}

dependencies = {
    "lua == 5.1",
}

build = {
    type = "builtin",
    modules = {
        ["faker"] = "faker/init.lua",
    }
}
-- vim: syntax=lua ts=4 sts=4 sw=4 et
