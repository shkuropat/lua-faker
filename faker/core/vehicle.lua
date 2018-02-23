local Helpers = require('faker.helpers')
local sample = Helpers.sample
local array_merge = Helpers.array_merge
local M = {
    __prefix = 'vehicle',
}

local VIN_CHARS = '0123456789.ABCDEFGH..JKLMN.P.R..STUVWXYZ'
local VIN_MAP = '0123456789X'
local VIN_WEIGHTS = '8765432X098765432'

M.vin = function(self)
    local manufacture = sample(self:fetch_all('vehicle.manufacture'))
    local wmi = manufacture.wmi
    local wmi_ext 
    if manufacture.wmi_ext and (not manufacture.wmi_ext == '') then
        wmi_ext = split(manufacture.wmi_ext,'')
    end

    local c = {}
    for char in string.gmatch(VIN_CHARS, '%w') do table.insert(c, char); end

    local vehicle_identification_number = split(manufacture["wmi"], '')
    for i=1, 14, 1 do
        table.insert(vehicle_identification_number, sample(c))
    end

    if wmi_ext then
        for i=1, 3, 1 do
            vehicle_identification_number[12 + i] = wmi_ext[i]
        end
    end

    vehicle_identification_number[11] = self:fetch('vehicle.year')
    vehicle_identification_number[9] = vin_checksum(vehicle_identification_number)
    return string.upper(table.concat(vehicle_identification_number, ''))
end

M.manufacture = function(self)
    local manufacture = sample(self:fetch_all('vehicle.manufacture'))
    return manufacture.name
end

function calculate_vin_weight(character, i)
    local vin_chars_index, _ = string.find(VIN_CHARS, character)
    local vin_weight = string.sub(VIN_WEIGHTS, i,i)
    local vin_map_index, _ = string.find(VIN_MAP, vin_weight)
    return math.fmod(vin_chars_index -1, 10) * (vin_map_index -1)
end

function vin_checksum(vehicle_identification_number)
    local sum = 0
    for i, val in pairs(vehicle_identification_number) do
        sum = sum + calculate_vin_weight(val, i)
    end
    local index = math.fmod(sum, 11)
    return string.sub(VIN_MAP, index + 1, index+1)
end
local Base = require "faker.base"
return Base(M)
