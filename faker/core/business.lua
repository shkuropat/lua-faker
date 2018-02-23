--[==[excludes
credit_card_numbers()
credit_card_types()
]==]
local M = {
    __prefix = 'business',
    __fetched_methods = {'credit_card_numbers', 'credit_card_types'},
    __alias_method = {
        ['credit_card_number'] = 'credit_card_numbers',
        ['credit_card_type'] = 'credit_card_types',
    }
}

M.credit_card_expiry_date = function(self)
    return os.date("*t", os.time() + (365 * (math.random(4) + 1)))
end

local Base = require "faker.base"
return Base(M)
