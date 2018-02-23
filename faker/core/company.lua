--[==[examples
-- Get a random company logo url in PNG format.
Faker.Company:logo()
]==]
local Helpers = require "faker.helpers"
local M = {
    __prefix = 'company',
    __fetched_methods = {'suffix', 'industry', 'profession'},
    __parse_methods = {'name'},
}

M.catch_phrase = function(self)
    local array_of_sets = self:translate('faker.company.buzzwords')
    return word_sample(self, array_of_sets)
end

M.buzzword = function(self)
    local array_of_sets = self:translate('faker.company.buzzwords')
    local words = {}
    for _, words_set in ipairs(array_of_sets) do
        for _, word in ipairs(words_set) do
            table.insert(words, word)
        end
    end
    return Helpers.sample(words)
end

M.bs = function(self)
    local array_of_sets = self:translate('faker.company.bs')
    return word_sample(self, array_of_sets)
end

M.ein = function(self)
    return string.format("%02d-%07d", math.random(10^2), math.random(10^7))
end

M.duns_number = function(self)
    return string.format("%02d-%03d-%04d", math.random(10^2), math.random(10^3), math.random(10^4))
end

M.logo = function(self)
    rand_num = math.random(13) + 1
    return "https://pigment.github.io/fake-logos/logos/medium/color/" .. rand_num .. ".png"
end

M.swedish_organisation_number = function(self)
    local base = string.format('%09d', math.random(10 ^ 9))
    return base .. luhn_algorithm(base)
end

M.australian_business_number = function(self)
    local base = string.format('%09d', math.random(10 ^ 9))
    abn = '00' .. base

    return tostring(99 - (abn_checksum(abn) % 89)) .. base
end

function luhn_algorithm(number)
    local multiplications = {}

    for i = 1, #number do
        local digit = number:sub(i,i)
        if (i-1) % 2 == 0 then
            table.insert(multiplications, digit * 2)
        else
            table.insert(multiplications, digit * 1)
        end
    end

    local sum = 0
    for _, num in ipairs(multiplications) do
        local num_str = tostring(num)
        for i = 1, #num_str do
            --sum = sum + string.byte( num_str:sub(i,i) )
            sum = sum + num_str:sub(i,i)
        end
    end
    if sum % 10 == 0 then
        return 0
    end
    return (math.floor(sum / 10) + 1) * 10 - sum
end

function abn_checksum(abn)
    local abn_weights = {10,1,3,5,7,9,11,13,15,17,19}
    local sum = 0

    for i, weight in ipairs(abn_weights) do
        sum = sum + weight * abn:sub(i,i)
    end

    return sum
end

function word_sample(self, array_of_sets)
    local words = {}
    for _, words_set in ipairs(array_of_sets) do
        table.insert(words, Helpers.sample(words_set))
    end
    return table.concat(words, ' ')
end


local Base = require "faker.base"
return Base(M)
