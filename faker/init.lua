local Locales = require "faker.locales"
local Helpers = require "faker.helpers"

local split = Helpers.split
table.copy = Helpers.table_copy
local M = {
    add_locale = Locales.add_locale,
    Address = require("faker.core.address"),
    App = require("faker.core.app"),
    Avatar = require("faker.core.avatar"),
    Beer = require("faker.core.beer"),
    --Bitcoin = require("faker.core.bitcoin"),
    Book = require("faker.core.book"),
    Boolean = require("faker.core.boolean"),
    Business = require("faker.core.business"),
    Cat = require("faker.core.cat"),
    ChuckNorris = require("faker.core.chuck_norris"),
    --Code = require("faker.core.code"),
    Color = require("faker.core.color"),
    Commerce = require("faker.core.commerce"),
    Company = require("faker.core.company"),
    Crypto = require("faker.core.crypto"),
    --Date = require("faker.core.date"),
    Educator = require("faker.core.educator"),
    File = require("faker.core.file"),
    Finance = require("faker.core.finance"),
    GameOfThrones = require("faker.core.game_of_thrones"),
    Hacker = require("faker.core.hacker"),
    Hipster = require("faker.core.hipster"),
    IDNumber = require("faker.core.id_number"),
    Internet = require("faker.core.internet"),
    Lorem = require("faker.core.lorem"),
    Music = require("faker.core.music"),
    Name = require("faker.core.name"),
    Number = require("faker.core.number"),
    PhoneNumber = require("faker.core.phone_number"),
    Placeholdit = require("faker.core.placeholdit"),
    Pokemon = require("faker.core.pokemon"),
    SlackEmoji = require("faker.core.slack_emoji"),
    Space = require("faker.core.space"),
    Superhero = require("faker.core.superhero"),
    Team = require("faker.core.team"),
    --Time = require("faker.core.time"),
    University = require("faker.core.university"),
    Vehicle = require("faker.core.vehicle"),
    Yoda = require("faker.core.yoda")
}


local Numbers  = Helpers.range('0', '9'); M.Numbers = Numbers;
local ULetters = Helpers.range('A', 'Z'); M.ULetters = ULetters;
local Letters  = Helpers.array_merge(ULetters, Helpers.range('a', 'z')); M.Letters = Letters;


function set_locale(name)
    if name == nil then
        name = Locales.base_locale
    end
    if not Locales.has_locale(name) then
        Locales.add_locale(name)
    end
    Locales.current_locale = name
    return true
end
M.set_locale = set_locale

function get_locale()
    return Locales.current_locale
end
M.get_locale = get_locale

M.set_locale('en')

return M
