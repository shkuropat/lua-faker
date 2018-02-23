local M = {
    __prefix = 'educator',
}

M.university = function(self)
    return self:fetch('educator.name') .. ' ' .. self:fetch('educator.tertiary.type')
end

M.course = function(self)
    return self:fetch('educator.tertiary.course.type') .. ' ' .. self:fetch('educator.tertiary.course.subject')
end

M.secondary_school = function(self)
    return self:fetch('educator.name') .. ' ' .. self:fetch('educator.secondary')
end

M.campus = function(self)
    return self:fetch('educator.name') .. " Campus"
end

local Base = require "faker.base"
return Base(M)
