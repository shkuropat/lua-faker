--[==[examples

-- Optional arguments: num=3, supplemental=false (words from a supplementary list of Lorem-like words)
Faker.Lorem:words()
Faker.Lorem:words(4)
Faker.Lorem:words(4, true)

-- Optional arguments: char_count=255
Faker.Lorem:characters()
Faker.Lorem:characters(10)

-- Optional arguments: word_count=4, supplemental=false, random_words_to_add=6
Faker.Lorem:sentence()
Faker.Lorem:sentence(3)
Faker.Lorem:sentence(3, true)
Faker.Lorem:sentence(3, false, 4)
Faker.Lorem:sentence(3, true, 4)

-- Optional arguments: sentence_count=3, supplemental=false
Faker.Lorem:sentences()
Faker.Lorem:sentences(1)
Faker.Lorem:sentences(1, true)

-- Optional arguments: sentence_count=3, supplemental=false, random_sentences_to_add=3
Faker.Lorem:paragraph()
Faker.Lorem:paragraph(2)
Faker.Lorem:paragraph(2, true)
Faker.Lorem:paragraph(2, false, 4)
Faker.Lorem:paragraph(2, true, 4)

-- Optional arguments: paragraph_count=3, supplemental=false
Faker.Lorem:paragraphs()
Faker.Lorem:paragraphs(1)
Faker.Lorem:paragraphs(1, true)

]==]
--[==[excludes
words()
characters()
sentence()
sentences()
paragraph()
paragraphs()
]==]
local Helpers = require 'faker.helpers'
local Characters = Helpers.array_merge(Helpers.range('0', '9'), Helpers.range('a', 'z'))

local M = {
    __prefix = 'lorem',
}

M.word = function(self)
    return self:fetch('lorem.words')
end

M.words = function(self, num, supplemental)
    num = num or 3
    supplemental = supplemental or false

    local resolved_num = resolve(num)
    local words = self:translate('faker.lorem.words')
    if supplemental then
        words = Helpers.array_merge(words, self:translate('faker.lorem.supplemental'))
    end

    local result = {}
    for i=1, resolve(num) do
        table.insert(result, Helpers.sample(words))
    end
    return result
end

M.characters = function(self, char_count)
    char_count = char_count or 255
    char_count = tonumber(char_count)
    if char_count  < 1 then
        return ''
    end

    local result = {}
    for i=1, char_count do
        table.insert(result, Helpers.sample(Characters))
    end
    return table.concat(result)
end

M.sentence = function(self, word_count, supplemental, random_words_to_add)
    word_count = word_count or 4
    random_words_to_add = random_words_to_add or 6

    local words = self:words(word_count + math.random(tonumber(random_words_to_add)), supplemental)
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

M.question = function(self, word_count, supplemental, random_words_to_add)
    word_count = word_count or 4
    random_words_to_add = random_words_to_add or 6

    local words = self:words(word_count + math.random(tonumber(random_words_to_add)), supplemental)
    return Helpers.capitalize(table.concat(words, ' ')) .. '?'
end

M.questions = function(self, question_count, supplemental)
    question_count = question_count or 3
    question_count = resolve(question_count)

    local result = {}
    for i=1, question_count do
        table.insert(result, self:question(nil, supplemental))
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
