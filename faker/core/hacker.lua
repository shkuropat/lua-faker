--[==[description
Are you having trouble writing tech-savvy dialogue for your latest screenplay?
Worry not! Hollywood-grade technical talk is ready to fill out any form where you need to look smart.
]==]
local Helpers = require "faker.helpers"
local M = {
    __prefix = 'hacker',
    __fetched_methods = {'abbreviation', 'adjective', 'noun', 'verb', 'ingverb'},

}
local phrases = function(self)
    local upper_inverb = Helpers.capitalize(self:ingverb())
    return {
        "If we " .. self:verb() .. " the " .. self:noun() .. ", we can get to the " .. self:abbreviation() .. " " .. self:noun() .. " through the " .. self:adjective() .. " " .. self:abbreviation() .. " " .. self:noun() .. "!",
        "We need to " .. self:verb() .. " the " .. self:adjective() .. " " .. self:abbreviation() .. " " .. self:noun() .. "!",
        "Try to " .. self:verb() .. " the " .. self:abbreviation() .. " " .. self:noun() .. ", maybe it will " .. self:verb() .. " the " .. self:adjective() .. " " .. self:noun() .. "!",
        "You can't " .. self:verb() .. " the " .. self:noun() .. " without " .. self:ingverb() .. " the " .. self:adjective() .. " " .. self:abbreviation() .. " " .. self:noun() .. "!",
        "Use the " .. self:adjective() .. " " .. self:abbreviation() .. " " .. self:noun() .. ", then you can " .. self:verb() .. " the " .. self:adjective() .. " " .. self:noun() .. "!",
        "The " .. self:abbreviation() .. " " .. self:noun() .. " is down, " .. self:verb() .. " the " .. self:adjective() .. " " .. self:noun() .. " so we can " .. self:verb() .. " the " .. self:abbreviation() .. " " .. self:noun() .. "!",
         upper_inverb .. " the " .. self:noun() .. " won't do anything, we need to " .. self:verb() .. " the " .. self:adjective() .. " " .. self:abbreviation() .. " " .. self:noun() .. "!",
        "I'll " .. self:verb() .. " the " .. self:adjective() .. " " .. self:abbreviation() .. " " .. self:noun() .. ", that should " .. self:noun() .. " the " .. self:abbreviation() .. " " .. self:noun() .. "!"
    }
end

M.say_something_smart = function(self)
    return Helpers.sample(phrases(self))
end

local Base = require "faker.base"
return Base(M)
