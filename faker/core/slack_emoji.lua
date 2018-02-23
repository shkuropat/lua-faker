--[==[examples
-- Random Slack Emoji from any category
Faker.SlackEmoji:emoji()
]==]

local M = {
    __prefix = 'slack_emoji',
    __fetched_methods = {'people', 'nature', 'food_and_drink', 'celebration', 'activity', 'travel_and_places', 'objects_and_symbols', 'custom'},
    __parse_methods = {'emoji'}
}

local Base = require "faker.base"
return Base(M)
