local M = {
    __prefix = 'name',
    __parse_methods = {'name', 'name_with_middle'},
    __fetched_methods = {'last_name', 'first_name', 'prefix', 'suffix'}
}


M.title = function(self)
    return self:fetch('name.title.descriptor') .. ' ' .. self:fetch('name.title.level') .. ' ' .. self:fetch('name.title.job')
end

M.job_title = function (self)
    return self:fetch_all('name.title.job')
end

local Base = require "faker.base"
return Base(M)
