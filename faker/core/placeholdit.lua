--[==[examples

Faker.Placeholdit:image()
Faker.Placeholdit:image("50x50")
Faker.Placeholdit:image("50x50", 'jpg')
Faker.Placeholdit:image("50x50", 'gif', 'ffffff')
Faker.Placeholdit:image("50x50", 'jpeg', 'ffffff', '000')
Faker.Placeholdit:image("50x50", 'jpg', 'ffffff', '000', 'Some Custom Text')
]==]
local Lorem = require 'faker.core.lorem'
local in_array = require('faker.helpers').in_array

local M = {
    __prefix = 'placeholdit',
}

local SUPPORTED_FORMATS = {'png', 'jpg', 'jpeg', 'bmp', 'gif'}

M.image = function (self, size, format, background_color, text_color, text)
    size = size or '300x300'
    format = format or 'png'
    set = set or 'set1'

    if (not slug) then
        local words = Lorem:words()
        slug = table.concat(words, '')
    end

    if (not string.find(size, '^[0-9]+x[0-9]+$')) then
        error("Size should be specified in format 300x300")
    end
    if ( not in_array( SUPPORTED_FORMATS, format)) then
        error("Supported formats are " .. table.concat(SUPPORTED_FORMATS, ', '))
    end
    if (background_color and not (
        string.find(background_color, '^[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$') 
        or
        string.find(background_color, '^[0-9a-f][0-9a-f][0-9a-f]$')
    )) then
        error("background_color must be a hex value without '#'")
    end
    if (text_color and not (
        string.find(text_color, '^[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$')
        or
        string.find(text_color, '^[0-9a-f][0-9a-f][0-9a-f]$')
    )) then
        error("text_color must be a hex value without '#'")
    end

    local image_url = 'https://placehold.it/' .. size .. '.' ..  format
    if (background_color) then
        image_url = image_url .. '/' .. background_color
    end
    if (text_color) then
        image_url = image_url .. '/' .. text_color
    end
    if (text) then
        image_url = image_url .. "?text=" .. text
    end
    return image_url
end

local Base = require "faker.base"
return Base(M)
