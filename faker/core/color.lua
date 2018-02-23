local M = {
    __prefix = 'color',
    __fetched_methods = {'name'},
    __alias_method = {
        ['color_name'] = 'name',
    }
}

M.hex_color = function(self)
    return string.format('#%06x', math.random() * 0xffffff)
end

M.single_rgb_color = function(self)
    return math.random(0, 255)
end

M.rgb_color = function(self)
    local res = {}
    for i=1,3 do table.insert(res, self:single_rgb_color()) end
    return res
end

M.single_hsl_color = function(self)
    return math.random(0, 36000) / 100
end

M.alpha_channel = function(self)
    return math.random()
end

M.hsl_color = function(self)
    local res = {}
    for i=1,3 do table.insert(res, self:single_hsl_color()) end
    return res
end

M.hsla_color = function(self)
    local res = self:hsl_color()
    table.insert(res, self:alpha_channel())
    return res
end

local Base = require "faker.base"
return Base(M)
