local M = {
    __prefix = 'book',
    __fetched_methods = {'title', 'publisher', 'genre'},
    __parse_methods = {'author'}
}

local Base = require "faker.base"
return Base(M)
