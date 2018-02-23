#!/usr/bin/env tarantool

local Faker = require('faker')
local tap = require('tap')

local test = tap.test('faker tests')
test:plan(1)

test:test('faker', function(test)
    test:plan(1)
    Faker.set_locale('ru')
    test:is(Faker.get_locale(), 'ru', "Faker set locale")
end)

os.exit(test:check() == true and 0 or -1)
