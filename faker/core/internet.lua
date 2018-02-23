--[==[examples
-- Optional argument name=nil
Faker.Internet:email()
Faker.Internet:email('Nancy')

-- Optional argument name=nil
Faker.Internet:free_email()
Faker.Internet:free_email('Nancy')

-- Optional argument name=nil
Faker.Internet:safe_email()
Faker.Internet:safe_email('Nancy')

-- Optional arguments specifier=nil, separators={'.', '_'}
Faker.Internet:user_name()
Faker.Internet:user_name('Nancy')
Faker.Internet:user_name('Nancy Johnson', {'.', '_', '-'})

-- Optional arguments: min_length=8, max_length=16
Faker.Internet:password()
Faker.Internet:password(8)
Faker.Internet:password(10, 20)
Faker.Internet:password(10, 20, true)

-- Private IP range according to RFC 1918 and 127.0.0.0/8 and 169.254.0.0/16.
Faker.Internet:private_ip_v4_address()

-- Guaranteed not to be in the ip range from the private_ip_v4_address method.
Faker.Internet:public_ip_v4_address()

-- Optional argument prefix=''
Faker.Internet:mac_address()
Faker.Internet:mac_address('55:44:33')

-- Optional arguments: host=domain_name, path="/#{user_name}"
Faker.Internet:url()
Faker.Internet:url('example.com')
Faker.Internet:url('example.com', '/foobar.html')

-- Optional arguments: words=nil, glue=nil
Faker.Internet:slug()
Faker.Internet:slug('foo bar')
Faker.Internet:slug('foo bar', '-')

]==]
local Helpers = require 'faker.helpers'
local Locales = require "faker.locales"
local Name = require 'faker.core.name'
local Company = require 'faker.core.company'
local Lorem = require 'faker.core.lorem'

local sample = Helpers.sample
local shuffle = Helpers.shuffle
local split = Helpers.split

local M = {
    __prefix = 'internet',
    __fetched_methods = {'domain_suffix'},
}

string.prepare = function(str)
    return str:lower()
end

M.email = function(self, name)
    return table.concat({self:user_name(name), self:domain_name()}, '@')
end

M.free_email = function(self, name)
    return table.concat({self:user_name(name), self:fetch('internet.free_email')}, '@')
end

M.safe_email = function(self, name)
    local domain = 'example.' .. sample({'org', 'com', 'net'})
    return table.concat({self:user_name(name), domain}, '@')
end

M.user_name = function(...)
    local current_locale = Locales.current_locale
    Locales.current_locale = 'en'
    function generate_name(self, specifier, separators)
        separators = separator or {'.', '_'}
        if type(specifier) == 'string' then
            local words = {}
            for word in string.gmatch(specifier, "%w+") do table.insert(words, word) end
            return string.prepare( table.concat( shuffle(words), sample(separators)) )
        end
        if type(specifier) == 'number' then
            local tries = 0
            local result = ''
            while (string.len(result) < specifier and tries <= 7) do
                result = self:user_name(nil, separators)
                tries = tries + 1
            end
            while(string.len(result) < specifier) do
                result = result .. result
            end
            return result
        end
        return string.prepare(sample({
            Name:first_name(),
            table.concat({Name:first_name(), Name:last_name()}, sample(separators))
        }))
    end
    local res = generate_name(...)
    Locales.current_locale = current_locale
    return res
end

M.password = function(self, min_length, max_length, mix_case, special_chars)
    min_length = min_length or 8
    max_length = max_length or 16
    mix_case = mix_case or true
    special_chars = special_chars or false

    local temp = Lorem:characters(min_length)
    local diff_length = max_length - min_length
    if diff_length > 0 then
        diff_rand = math.random(diff_length)
        temp = temp .. Lorem:characters(diff_rand)
    end
    
    if mix_case then
        for i=1, #temp do
            if i % 2 == 0 then
                temp = temp:sub(1,i-1) .. temp:sub(i,i):upper() .. temp:sub(i+1,#temp)
            end
        end
    end
    if special_chars then
        chars = {'!', '@', '#', '$', '%', '^', '&', '*'}
        for i=1, table.getn(chars) do
            j = math.random(min_length) 
            if j <= #temp then
                temp = temp:sub(1, j-1) .. chars[i] .. temp:sub(j+1, #temp)
            end
        end
    end

    return temp
end

M.domain_name = function(self)
    local current_locale = Locales.current_locale
    Locales.current_locale = 'en'
    local res = table.concat({string.prepare(self:domain_word()), self:domain_suffix()}, '.')
    Locales.current_locale = current_locale
    return res
end

M.domain_word = function(self)
    return Helpers.split(Company:name(), ' ')[1]
end

M.mac_address = function(self, prefix)
    prefix = prefix or ''
    local prefix_digits = split(prefix, ':')
    local digits = {}
    for _, value in ipairs(prefix_digits) do
        table.insert(digits, tonumber(value, 16))
    end
    for i=1, (6-table.getn(digits)) do
        table.insert(digits, math.random(256))
    end
    for i, value in ipairs(digits) do
        digits[i] = string.format('%02x', value)
    end

    return table.concat( digits, ':')
end

M.ip_v4_address = function(self)
    local digits = {}
    for i = 1, 4 do
        table.insert(digits, math.random(2, 254))
    end
    return table.concat(digits, '.')
end

local private_net_masks = function(like_table)
    local masks = {
        {10},
        {127},
        {169, 254},
        {172, Helpers.range(16,31)},
        {192, 168},
    }

    if like_table then return masks end
    local math_exprs = {}
    for _, mask in ipairs(masks) do
        for i, d in ipairs(mask) do
            if type(d) == 'table' then
                mask[i] = '(' .. table.concat(d, '|') .. ')'
            end
        end
        local expr = '^' .. table.concat(mask, '%.') .. '%.'
        table.insert(math_exprs, expr)
    end
    return math_exprs
end

local is_private_net = function(str)
    local net_masks =  private_net_masks()
    for _, mask in ipairs(net_masks) do
        if string.match(str, mask) then
            return true
        end
    end
    return false
end

M.public_ip_v4_address = function(self)
    local ip
    repeat
        ip = self:ip_v4_address()
    until not is_private_net(ip)
    return ip
end

M.private_ip_v4_address = function(self)
    local net_masks = private_net_masks(true)
    local mask = net_masks[math.random(table.getn(net_masks))]

    local digit
    local digits = {}
    for i =1, 4 do
        if (mask[i]) then
            if type(mask[i]) == 'table' then
                digit = mask[i][ math.random(table.getn(mask[i])) ]
                if string.match(digit, '%%') then
                    digit = string.format(digit, math.random(99))
                end
            else
                digit = mask[i]
            end
        else
            digit = math.random(2, 254)
        end
        table.insert(digits, digit)
    end
    return table.concat(digits, '.')
end

M.ip_v4_cidr = function(self)
    return table.concat({self:ip_v4_address(), 1 + math.random(31)}, '/')
end

M.ip_v6_address = function(self)
    local digits = {}
    for i=1,8 do
        table.insert(digits, string.format('%x', math.random(65536)))
    end
    return table.concat(digits, ':')
end

M.ip_v6_cidr = function(self)
    return table.concat({self:ip_v6_address(), 1 + math.random(127)}, '/')
end

M.url = function (self, host, path, scheme)
    host = host or self:domain_name()
    path = path or "/" .. self:user_name() 
    scheme = scheme or 'http'
    return scheme .. '://' .. host .. path
end

M.slug = function(self, words, glue)
    words = words or Lorem:words(2)
    if type(words) == 'string' then
        local str_words = words
        words = {}
        for word in string.gmatch(str_words, "%w+") do table.insert(words, word) end
    end
    glue = glue or sample({'-', '_', '.'})
    return table.concat(words, glue):lower()
end

M.device_token = function(self)
    local digits = {}
    for i =1, 64 do
        table.insert(digits, string.format("%x", math.random(0, 15)))
    end
    return table.concat( digits, '')
end

local Base = require "faker.base"
return Base(M)
