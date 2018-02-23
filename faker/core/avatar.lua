--[==[examples
Faker.Avatar:image()

Faker.Avatar:image("my-own-slug")

Faker.Avatar:image("my-own-slug", "50x50")

Faker.Avatar:image("my-own-slug", "50x50", "jpg")

Faker.Avatar:image("my-own-slug", "50x50", "bmp")

Faker.Avatar:image("my-own-slug", "50x50", "bmp", "set1", "bg1")
]==]


local Lorem = require 'faker.core.lorem'
local in_array = require('faker.helpers').in_array

local M = {
    __prefix = 'avatar',
}

local SUPPORTED_FORMATS = {'png', 'jpg', 'bmp'}

M.image = function (self, slug, size, format, set, bgset)
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

    local bgset_query = ''
    if (bgset) then
        bgset_query = "&bgset=" .. bgset
    end
    return "https://robohash.org/" .. slug .. '.' .. format .. '?size=' .. size .. '&set=' .. set .. bgset_query
end

local Base = require "faker.base"
return Base(M)
