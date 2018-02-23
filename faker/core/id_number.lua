local M = {
    __prefix = 'id_number',
}

local INVALID_SSN = {
    '000%-%d%d%-%d%d%d%d',  --/0{3}-\d{2}-\d{4}/,
    '%d%d%d%-00%-%d%d%d%d', --/\d{3}-0{2}-\d{4}/,
    '%d%d%d%-%d%d%-0000',   --/\d{3}-\d{2}-0{4}/,
    '666%-%d%d%-%d%d%d%d',  --/666-\d{2}-\d{4}/,
    '9%d%d%-%d%d%-%d%d%d%d',--/9\d{2}-\d{2}-\d{4}/
}

M.valid = function(self)
    return _translate(self, 'valid')
end

M.invalid = function(self)
    return _translate(self, 'invalid')
end

M.ssn_valid = function(self)
    local ssn = self:regexify('[0-8]\\d{2}-\\d{2}-\\d{4}')
    return is_valid(INVALID_SSN, ssn) and ssn or self:ssn_valid()
end

function is_valid(regex_list, ssn)
    for _, pattern in ipairs(regex_list) do
        if string.match(ssn, pattern) then
            return false
        end
    end
    return true
end

function _translate(self, key)
    local res = self:parse('id_number.' .. key)
    if res == "" then
        res = self:numerify(self:fetch('id_number.' .. key))
    end
    return res
end

local Base = require "faker.base"
return Base(M)
