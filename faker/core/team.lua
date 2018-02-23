local M = {
    __prefix = 'team',
    __fetched_methods = {'creature'},
    __parse_methods = {'name'}
}

M.state = function(self)
    return self:fetch("address.state")
end

local Base = require "faker.base"
return Base(M)
