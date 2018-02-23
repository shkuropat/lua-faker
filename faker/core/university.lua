local M = {
    __prefix = 'university',
    __fetched_methods = {'prefix', 'suffix'},
    __parse_methods = {'name'}
}

local Base = require "faker.base"
return Base(M)
