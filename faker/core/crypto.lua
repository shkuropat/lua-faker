local Lorem = require 'faker.core.lorem'
local digest = require('digest')
local M = {
    __prefix = 'crypto',
}

local Base = require "faker.base"


M.md5 = function(self)
    return digest.md5_hex(Lorem:characters())
end

M.sha1 = function(self)
    return digest.sha1_hex(Lorem:characters())
end

M.sha256 = function(self)
    return digest.sha256_hex(Lorem:characters())
end

return Base(M)
