--[==[examples
--Optional parameter: types={
--  'visa', 
--  'mastercard', 
--  'discover', 
--  'american_express', 
--  'diners_club', 
--  'jcb', 
--  'switch', 
--  'solo', 
--  'dankort', 
--  'maestro', 
--  'forbrugsforeningen', 
--  'laser' 
--}

Faker.Finance:credit_card()
]==]
local Helpers = require('faker.helpers')
local table_copy = Helpers.table_copy
local sample = Helpers.sample

local M = {
    __prefix = 'finance',
}

local CREDIT_CARD_TYPES = {'visa', 'mastercard', 'discover', 'american_express', 'diners_club', 'jcb', 'switch', 'solo', 'dankort', 'maestro', 'forbrugsforeningen', 'laser'}

M.credit_card = function (self, ...)
    local types = {...}
    if #types == 0 then
        types = table_copy(CREDIT_CARD_TYPES)
    end
    local card_type = sample(types)
    local template = self:numerify(self:fetch("credit_card." .. card_type))
    return luhn(template)
end

function luhn(template)
    local digs={}; 
    for d in string.gmatch(string.reverse(template), '%d') do table.insert(digs, d); end

    sum = 0
    for i,p in ipairs(digs) do
        if math.fmod(i, 2) >0 then
            p = 2 * p
            if (p > 9) then
                p = p -9 
            end
        end
        sum = sum + p
    end
    sum = 10 - (math.fmod(sum, 10))
    if (sum == 10) then
        sum = 0
    end
    local res = string.gsub(template, 'L', sum)
    return res
end

local Base = require "faker.base"
return Base(M)
