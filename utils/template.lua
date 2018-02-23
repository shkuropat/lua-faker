local Faker = require "faker"
local pprint = require "pprint"

local print_doc = function (execute_line)
    io.write(execute_line)
    local value = loadstring('local Faker = require "faker";return ' .. execute_line)();
    if type(value) == "table" then
        print( ' --[[')
        pprint(value)
        print( ']]')
    elseif type(value) == "string" then
        print (' -- "' .. value .. '"')
    elseif type(value) == "boolean" then
        if value then value = 'true' else value = 'false' end
        print (' -- ' .. value)
    else
        print (' -- ' .. value)
    end
end

Faker.add_locale('en')

print('\n### Faker.--[[module_name]]\n')

--[[description]]
if desc then
    print(desc)
end
print('\n```lua')
--[[code]]
print('```\n')
