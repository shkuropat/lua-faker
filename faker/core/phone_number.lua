--[==[description
Phone numbers may be in any of the following formats:

  * 333-333-3333
  * (333) 333-3333
  * 1-333-333-3333
  * 333.333.3333
  * 333-333-3333
  * 333-333-3333 x3333
  * (333) 333-3333 x3333
  * 1-333-333-3333 x3333
  * 333.333.3333 x3333

(Don't let the example output below fool you - any format can be returned at random.)
]==]
--[==[examples
-- Optional parameter: length=4
Faker.PhoneNumber:subscriber_number()
Faker.PhoneNumber:subscriber_number(2)
Faker.PhoneNumber:extension()
]==]
--[==[examples(en-US)
area_code()
Faker.PhoneNumber:exchange_code()
]==]
local M = {
    __prefix = 'phone_number',
    __alias_method = {
        ['extension'] = 'subscriber_number',
    },
}

function M.phone_number(self)
    local res = self:parse('phone_number.formats')
    if res == "" then
        res = self:numerify(self:fetch('phone_number.formats'))
    end
    return res
end

function M.cell_phone(self)
    local res = self:parse('cell_phone.formats')
    if res == "" then
        res = self:numerify(self:fetch('cell_phone.formats'))
    end
    return res
end

-- US only
function M.area_code(self)
    local ok, code = pcall(self.fetch, self, 'phone_number.area_code')
    if ok then
        return code
    end
    return nil
end

-- US only
function M.exchange_code(self)
    local ok, code = pcall(self.fetch, self, 'phone_number.exchange_code')
    if ok then
        return code
    end
    return nil
end

-- US only
function M.subscriber_number(self, length)
    length = length or 4
    length = math.random(2, length)

    local res = ''
    for i = 1, length, 1 do
        res = res .. string.char(math.random(48, 57))
    end
    return res
end

local Base = require "faker.base"
return Base(M)
