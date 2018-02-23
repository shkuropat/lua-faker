local M = {
    __prefix = 'yoda',
}

M.quote = function(self)
    return self:fetch('yoda.quotes')
end

local Base = require "faker.base"
return Base(M)
