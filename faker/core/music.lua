local sample = require("faker.helpers").sample
local M = {
    __prefix = 'music',
    __fetched_methods = {'instruments'},
    __alias_method = {
        ['instrument'] = 'instruments',
    }
}


M.key = function (self)
    return sample(self:keys()) .. sample(self:key_variants())
end

M.keys = function(self)
    return {'C', 'D', 'E', 'F', 'G', 'A', 'B'}
end

M.key_variants = function(self)
    return {'b', '#', ''}
end

local Base = require "faker.base"
return Base(M)
