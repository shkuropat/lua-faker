--[==[examples
-- Optional arguments: dir, name, extension, directory_separator
Faker.File:file_name('path/to')
Faker.File:file_name('foo/bar', 'baz')
Faker.File:file_name('foo/bar', 'baz', 'doc')
Faker.File:file_name('foo\\\\bar', 'baz', 'doc')
Faker.File:file_name('foo/bar', 'baz', 'mp3', '\\\\')
]==]
local Lorem = require 'faker.core.lorem'
local Internet = require 'faker.core.internet'
local in_array = require('faker.helpers').in_array

local M = {
    __prefix = 'file',
    __fetched_methods = {'extension', 'mime_type'},
}


M.file_name = function (self, dir, name, ext, directory_separator)
    dir = dir or Internet:slug()
    name = name or Lorem:word():lower()
    ext = ext or self:extension()
    --directory_separator = directory_separator or '/'
    if directory_separator then
        dir = string.gsub(dir, self:_separator_antipod(directory_separator), directory_separator);
    else
        directory_separator = '\\'
        if string.find(dir, '/') then
            directory_separator = '/'
        end
    end

    return table.concat({dir, name}, directory_separator) .. '.' .. ext
end

M._separator_antipod = function (self, separator)
    if separator == '/' then
        return '\\'
    end
    return '/'
end
local Base = require "faker.base"
return Base(M)
