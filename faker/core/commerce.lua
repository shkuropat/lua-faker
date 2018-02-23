--[==[examples
-- Optional arguments max=3, fixed_amount=false
Faker.Commerce:department()
Faker.Commerce:department(5)
Faker.Commerce:department(2, true)
]==]
local in_array = require('faker.helpers').in_array
local M = {
    __prefix = 'commerce',
}

M.color = function(self)
    return self:fetch('color.name')
end

M.department = function(self, max, fixed_amount)
    if (max == nil) then max = 3 end
    fixed_amount = fixed_amount or false

    local num
    if fixed_amount then num = max end
    num = num or (1 + math.random(max))

    local categories = categories(self, num)

    if num > 1 then
        return merge_categories(self, categories)
    end
    return categories[1]
end

M.product_name = function(self)
    return self:fetch('commerce.product_name.adjective') .. ' ' .. self:fetch('commerce.product_name.material') .. ' ' .. self:fetch('commerce.product_name.product')
end

M.material = function(self)
    return self:fetch('commerce.product_name.material')
end

M.price = function(self, min, max)
    min = min or 0
    max = max or 100
    return math.random(min * 100, max * 100)/100
end

function categories(self, num)
    local categories = {}
    while table.getn(categories) < num do
        local category = self:fetch('commerce.department')
        if in_array(categories, category) == false then
            table.insert(categories, category)
        end
    end
    return categories
end

function merge_categories(self, categories)
    local separator = self:fetch('separator')
    local last = table.remove(categories, 1)

    return table.concat({table.concat(categories, ", "), last}, separator)
end

local Base = require "faker.base"
return Base(M)
