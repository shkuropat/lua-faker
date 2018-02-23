local M = {
    __prefix = 'beer',
    __fetched_methods = {'name', 'style', 'hop', 'yeast', 'malt'},
    __alias_method = {
        ['malts'] = 'malt',
    }
}

M.ibu = function(self)
    return math.random(10, 100) .. ' IBU'
end

M.alcohol = function(self)
    return math.random(20, 100)/10 .. '%'
end

M.blg = function(self)
    return math.random(50, 200)/10 .. '°Blg'
end

local Base = require "faker.base"
return Base(M)
