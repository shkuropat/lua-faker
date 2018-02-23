local M = {
    __prefix = 'superhero',
    __fetched_methods = {'power', 'prefix', 'suffix', 'descriptor'},
    __parse_methods = {'name'}
}

local Base = require "faker.base"
return Base(M)
