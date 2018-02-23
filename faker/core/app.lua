local M = {
    __prefix = 'app',
    __fetched_methods = {'name'},
    __parse_methods = {'author'},
}

M.version = function(self)
    local version = self:parse('app.version')
    if version == '' then
        version = self:numerify(self:fetch('app.version'))
    end
    return version
end

local Base = require "faker.base"
return Base(M)
