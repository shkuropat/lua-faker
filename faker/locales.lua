local yaml = require 'yaml'
local fio = require 'fio'

local M = {
    base_locale = 'en',
    current_locale = nil
}

-- List of loaded locales
local locales = {}

local available_locales = {}

function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

function read_file(path)
    local fh = fio.open(path)
    local result = ''

    local buf = fh:read(1024)
    while (buf ~= '' ) do 
        result = result .. buf
        buf = fh:read(1024)
    end
    fh:close()
    return result
end

--- Add locale to pool, with base if exists.
-- @param name string
-- @param data string|hash
-- @return hash
function M.add_locale(name, data)

    if data == nil then
        if available_locales[name] == nil then
            error('Locale not found:' .. name)
        end
        data = available_locales[name]

        -- load base language if exists (used for rollback)
        local lang = name:match("(.*)-")
        if (name ~= lang and available_locales[lang] ~= nil) then
            M.add_locale(lang, nil)
        end
    end

    -- data in file
    if type(data) == 'string' then
        if (not fio.lstat(data)) then
            error('Locale ' .. data .. 'not found');
        end

        data = yaml.decode(read_file(data))[name]
    end
    locales[name] = data
end

function M.has_locale(name)
    return locales[name] ~= nil
end

function M.get_locale(name)
    return locales[name]
end

local search_pattern = 'ls ' .. fio.pathjoin( script_path(), 'locales', '*.yml')

f = io.popen(search_pattern)
for path in f:lines() do 
    name = path:match( "([^/]+).yml$" )
    available_locales[name] = path
end

return M
