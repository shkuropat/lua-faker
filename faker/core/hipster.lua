--[==[examples

-- Optional arguments: num=3, supplemental=false, spaces_allowed = false
Faker.Hipster:words()
Faker.Hipster:words(4)
Faker.Hipster:words(4, true)
Faker.Hipster:words(4, true, true)

-- Optional arguments: word_count=4, supplemental=false, random_words_to_add=6
Faker.Hipster:sentence()
Faker.Hipster:sentence(3)
Faker.Hipster:sentence(3, true)
Faker.Hipster:sentence(3, false, 4)
Faker.Hipster:sentence(3, true, 4)

-- Optional arguments: sentence_count=3, supplemental=false
Faker.Hipster:sentences()
Faker.Hipster:sentences(1)
Faker.Hipster:sentences(1, true)

-- Optional arguments: sentence_count=3, supplemental=false, random_sentences_to_add=3
Faker.Hipster:paragraph()
Faker.Hipster:paragraph(2)
Faker.Hipster:paragraph(2, true)
Faker.Hipster:paragraph(2, false, 4)
Faker.Hipster:paragraph(2, true, 4)

-- Optional arguments: paragraph_count=3, supplemental=false
Faker.Hipster:paragraphs()
Faker.Hipster:paragraphs(1)
Faker.Hipster:paragraphs(1, true)

]==]
local Helpers = require 'faker.helpers'

local M = {
    __prefix = 'hipster',
}

M.word = function(self)
    random_word = self:fetch('lorem.words')
    return random_word:find('%s') and self:word() or random_word
end

M.words = function(self, num, supplemental, spaces_allowed)
    num = num or 3
    supplemental = supplemental or false
    spaces_allowed = spaces_allowed or false

    local resolved_num = resolve(num)
    local word_list = self:translate('faker.hipster.words')
    if supplemental then
        word_list = Helpers.array_merge(word_list, self:translate('faker.lorem.words'))
    end

    local words = {}
    for i=1, resolve(num) do
        table.insert(words, Helpers.sample(word_list))
    end
    if spaces_allowed then
        return words
    end
    local result = {}
    for _, word in ipairs(words) do
        if word:find('%s') == nil then
            table.insert(result, word)
        end
    end
    return result
end

M.sentence = function(self, word_count, supplemental, random_words_to_add)
    word_count = word_count or 4
    random_words_to_add = random_words_to_add or 6

    local words = self:words(word_count + math.random(tonumber(random_words_to_add)), supplemental, true)
    return Helpers.capitalize(table.concat(words, ' ')) .. '.'
end

M.sentences = function(self, sentence_count, supplemental)
    sentence_count = sentence_count or 3
    sentence_count = resolve(sentence_count)

    local result = {}
    for i=1, sentence_count do
        table.insert(result, self:sentence(nil, supplemental))
    end
    return result
end

M.paragraph = function(self, sentence_count, supplemental, random_sentences_to_add)
    sentence_count = sentence_count or 3
    sentence_count = resolve(sentence_count)
    random_sentences_to_add = random_sentences_to_add or 3
    
    sentences = self:sentences(sentence_count + math.random(tonumber(random_sentences_to_add)), supplemental)
    return table.concat(sentences, ' ')
end

M.paragraphs = function(self, paragraph_count, supplemental)
    paragraph_count = paragraph_count or 3
    paragraph_count = resolve(paragraph_count)

    local result = {}
    for i=1, paragraph_count do
        table.insert(result, self:paragraph(3, supplemental))
    end
    return result
end


function resolve(value)
    if type(value) == 'table' then
        return Helpers.sample(value)
    end
    return value
end

local Base = require "faker.base"
return Base(M)
