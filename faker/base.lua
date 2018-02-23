local Locales = require "faker.locales"
local Helpers = require "faker.helpers"
local split = Helpers.split
table.copy = Helpers.table_copy

local M = {}

local Numbers  = Helpers.range('0', '9'); M.Numbers = Numbers;
local ULetters = Helpers.range('A', 'Z'); M.ULetters = ULetters;
local Letters  = Helpers.array_merge(ULetters, Helpers.range('a', 'z')); M.Letters = Letters;

function get_value(self, data, path)
    if (type(data) ~= 'table' or table == nil) then
        return nil
    end
    local head = table.remove(path, 1)
    if table.getn(path) == 0 then
        return data[head]
    end
    return self:get_value(data[head], path)
end
M.get_value = get_value

function translate(self, key, options)
    if (options == nil) then
        options = {}
    end
    local locale = options.locale or Locales.current_locale
    local lang = locale:match("(.*)-")
    local path = split(key, '.')
    local result = self:get_value(Locales.get_locale(locale), table.copy(path))
    if (result == nil and lang ~= locale) then
        result = self:get_value(Locales.get_locale(lang), table.copy(path))
    end

    if (result == nil) then
        result = self:get_value(Locales.get_locale(Locales.base_locale), path)
    end

    if (result == nil) then
        error('Invalid path:' .. key)
    end

    return result
end
M.translate = translate

function fetch(self, key)
    local fetched = self:translate('faker.' .. key)

    if (type(fetched) == 'table') then
        fetched = Helpers.sample(fetched)
    end

    if (string.find(fetched, '^%/') and string.find(fetched,'%/$')) then
        fetched = self:regexify(fetched)
    end

    return fetched
end
M.fetch = fetch

function fetch_all(self, key)
    local fetched = self:translate('faker.' .. key)
    if (type(fetched) == 'table' and table.getn(fetched) == 1) then
        fetched = fetched[1]
    end
    if (type(fetched) ~= 'table' and string.find(fetched, '^%/') and string.find(fetched,'%/$')) then
        fetched = self:regexify(fetched)
    end
    return fetched
end
M.fetch_all = fetch_all

function numerify(self, number_string)
    math.randomseed( os.time() )
    local res, _ = string.gsub ( number_string, '#', function () return math.random(1,9) .. ''end, 1)
    res, _ = string.gsub (res, '#', function () return math.random(1,9) .. ''end)
    return res
end
M.numerify = numerify

function letterify(self, letter_string)
    local res, _ = string.gsub(letter_string, '?', function () return Helpers.sample(ULetters) end)
    return res
end
M.letterify = letterify

function bothify(self, str)
    return self:letterify(self:numerify(str))
end
M.bothify = bothify

function regexify(self, re)
    function repeat_range(what, from, to)
        local res = ''
        math.randomseed( os.time() )
        for i =1, math.random(from, to) do
            res = res .. what
        end
        return res
    end
    
    -- Ditch the anchors
    re = string.gsub (re, '/?^?', '')
    re = string.gsub(re, '$?/?$', '')
    -- All {2} become {2,2} and ? become {0,1}
    re = string.gsub(re, '{(%d+)}', '{%1,%1}')
    re = string.gsub(re, '?', '{0,1}')
    -- [12]{1,2} becomes [12] or [12][12]
    re = re.gsub(re, '(%[[^%]]+%]){(%d+),(%d+)}', repeat_range)
    -- (12|34){1,2} becomes (12|34) or (12|34)(12|34)
    re = re.gsub(re, '(%([^%]]+%)){(%d+),(%d+)}', repeat_range)
    -- A{1,2} becomes A or AA or \d{3} becomes \d\d\d
    re = re.gsub(re, '(\\?.){(%d+),(%d+)}', repeat_range)
    -- (this|that) becomes 'this' or 'that'
    re = re.gsub(re, '%((.-)%)', function (match) return Helpers.sample(split(match, '|')) end)
    -- All A-Z inside of [] become C (or X, or whatever)
    re = re.gsub(re, '(%[([^%]]+)%])', function (match)
        return match.gsub(match, '(%w%-%w)', function (range)
            local range_arr = split(range, '-')
            return Helpers.sample(Helpers.range( range_arr[1], range_arr[2] ))
        end)
    end)
    -- All [ABC] become B (or A or C)
    re = re.gsub(re, '(%[([^%]]+)%])', function (match, first)
        return Helpers.sample(split(first, ''))
    end)
    
    re = re.gsub(re, '\\d', function () return Helpers.sample(Numbers) end)
    re = re.gsub(re, '\\w', function () return Helpers.sample(Letters) end)
    
    return re
end
M.regexify = regexify

function parse(self, key)
    local re ='(#{(%a-)%.?([_%a]+)})'
    local fetched = self:fetch(key)
    local res = fetched
    string.gsub(fetched, re, function(match, kls, method)
        if kls == '' then
            res = string.gsub(res, match, self[method](self), 1)
            return
        end
    
        kls = require('faker')[kls]
        res = string.gsub(res, match, kls[method](kls), 1)
        return
    end)
    if (res == fetched) then
        res = ''
    end
    return res
end
M.parse = parse;

function __in_system_table(obj, table_name, f)
    if obj[table_name] then
        for key, value in pairs(obj[table_name]) do
            if type(key) == 'number' and value == f then
                return true
            elseif key == f then
                return true
            end
        end
    end
    return false
end
return function(child)
    local prefix = child.__prefix
    child = setmetatable(child, {__index = function(self, f, ...)
        if f == '__parse_methods' then return nil end
        if f == '__alias_method' then return nil end

        if __in_system_table(self, '__alias_method', f) then
            return self[ self['__alias_method'][f] ]
        end

        local key = self.__prefix .. '.' .. f
        if M[f] then
            return M[f]
        end

        if __in_system_table(self, '__parse_methods', f) then
            return function(self, f)
                return parse(self,key)
            end
        end

        return function(self, f)
            return fetch(self, key)
        end
    end})
    return setmetatable({}, {__index =child})
end
