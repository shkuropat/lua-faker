--[==[examples
-- Optional parameter: true_ratio=0.5
Faker.Boolean:boolean()
Faker.Boolean:boolean(0.2)
]==]


local M = {
    __prefix = 'boolean',
}

M.boolean = function (self, true_ratio)
    true_ratio = true_ratio or 0.5
    return math.random() < true_ratio
end

local Base = require "faker.base"
return Base(M)
