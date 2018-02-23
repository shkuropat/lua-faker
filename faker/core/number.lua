--[==[examples
-- Required parameter: digits
Faker.Number:number(10)

-- Required parameter: l_digits
Faker.Number:decimal(2)

Faker.Number:decimal(2, 3)

-- Required parameter: digits
Faker.Number:hexadecimal(3)

Faker.Number:between(1, 10)
]==]
local M = {
    __prefix = 'number',
}


M.number = function (self, digits, scale)
    scale = scale or '%d' 
    local top_border = (scale == '%d') and 9 or 15
    local result = ''
    if (digits > 1) then
        result = string.format('%x', math.random(1, top_border))
        digits = digits - 1
    end
    for i=1, digits, 1 do
        result = result .. string.format('%x', math.random(0, top_border))
    end
    return result
end

M.decimal = function(self, l_digits, r_digits)
    if r_digits == nil then 
        r_digits = 2
    end
    local right_digits = ''
    if (r_digits > 1) then
        right_digits = tostring(math.random(0,9))
        r_digits = r_digits -1
    end
    right_digits = right_digits .. M.number(self, r_digits)
    return M.number(self, l_digits) .. '.' .. right_digits
end

M.hexadecimal = function(self, digits)
    return M.number(self, digits, '%x')
end

M.between = function(self, from, to)
    if from == nil then
        from = 1.0
    end
    if to == nil then
        to = 4999.99
    end
    if ((to % 1) == 0) and ((from % 1) == 0) then
        return math.random(from, to) 
    else
        return math.random(from, to) + math.random()
    end
end

M.positive = function(...)
    return M.between(...)
end

M.negative = function(...)
    return -1 * M.between(...)
end

M.digit = function(self)
    return tostring(math.random(0,9))
end

local Base = require "faker.base"
return Base(M)
