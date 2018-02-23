local M = {
    __prefix = 'pokemon',
}

M.name = function(self)
    return self:fetch('pokemon.names')
end

M.location = function(self)
    return self:fetch('pokemon.locations')
end

local Base = require "faker.base"
return Base(M)
