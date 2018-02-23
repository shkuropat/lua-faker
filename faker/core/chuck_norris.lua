--[==[description
from: https://github.com/jenkinsci/chucknorris-plugin/blob/master/src/main/java/hudson/plugins/chucknorris/FactGenerator.java
]==]
local M = {
    __prefix = 'chuck_norris',
    __fetched_methods = {'fact',},
}

local Base = require "faker.base"
return Base(M)
