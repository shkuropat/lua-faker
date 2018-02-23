local M = {
    __prefix = 'cat',
    __fetched_methods = {'name', 'breed', 'registry'},
}

local Base = require "faker.base"
return Base(M)
