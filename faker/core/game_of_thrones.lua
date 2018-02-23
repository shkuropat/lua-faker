local M = {
    __prefix = 'game_of_thrones',
    __fetched_methods = {'characters', 'houses', 'cities'},
}

local Base = require "faker.base"
return Base(M)
