local M = {
    __prefix = 'space',
    __fetched_methods = {'planet', 'moon', 'galaxy', 'nebula', 'star_cluster', 'constellation', 'star', 'agency', 'agency_abv', 'nasa_space_craft', 'company'},
}

M.distance_measurement = function(self)
    return math.random(10, 100) .. ' ' .. self:fetch('space.distance_measurement')
end

local Base = require "faker.base"
return Base(M)
