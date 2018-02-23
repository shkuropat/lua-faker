--[==[examples
zip_code()
-- alias for zip_code
zip()
-- alias for zip_code
postcode()

-- Optional parameter: secondary_address=false
street_address()
street_address(true)
]==]
--[==[examples(en-US)
-- Optional parameter: state_abbreviation=''
zip_code("AL")
]==]
local M = {
    __prefix = 'address',
    __parse_methods = {'city', 'street_name'},
    __fetched_methods = {'street_suffix', 'city_suffix', 'city_prefix', 'state_abbr', 'state', 'time_zone', 'country', 'country_code'},
    __alias_method = {
        ['zip'] = 'zip_code',
        ['postcode'] = 'zip_code',
    },
}

M.street_address = function(self, include_secondary)
    if include_secondary == nil then include_secondary = false end
    return self:numerify(
        self:parse('address.street_address') .. 
        (include_secondary and ' ' .. self:secondary_address() or '')
    )
end

M.secondary_address = function(self)
    return self:bothify(self:fetch('address.secondary_address'))
end

M.building_number = function(self)
    return self:bothify(self:fetch('address.building_number'))
end

M.zip_code = function(self, state_abbreviation)
    state_abbreviation = state_abbreviation or ''
    if state_abbreviation == '' then
        return self:bothify(self:fetch('address.postcode'))
    end

    -- provide a zip code that is valid for the state provided
    -- see http://www.fincen.gov/forms/files/us_state_territory_zip_codes.pdf
    return self:bothify(self:fetch('address.postcode_by_state.' .. state_abbreviation))
end

M.latitude = function(self)
    return ((math.random() * 180) - 90) .. ''
end

M.longitude = function(self)
    return ((math.random() * 360) - 180) .. ''
end

local Base = require "faker.base"
return Base(M)
