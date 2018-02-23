function range(from, to)
    local stringify = false;
    local result = {};

    if (type(from) == 'string' and type(to) == 'string') then
        stringify = true;
        from = string.byte(from, 1);
        to = string.byte(to, 1);
    end

    for i=from,to,1 do
        table.insert(result, i);
    end

    if stringify then
        for i, val in pairs(result) do
            result[i] = string.char(val)
        end
    end
    return result
end

function array_merge(...)
    local args={...}
    result = table.remove(args, 1)
    for _,t in ipairs(args)do
        for k,v in pairs(t) do table.insert(result, v) end
    end
    return result
end

function array_reverse(t)
    local new_tbl = {}
    local len = #t
    for k, v in ipairs(t) do
        new_tbl[len + 1 - k] = v
    end
    return new_tbl
end

-- http://lua-users.org/wiki/SplitJoin
--function split ()
    --local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    --local fpat = "(.-)" .. pat
    --local last_end = 1
    --local s, e, cap = str:find(fpat, 1)
    --while s do
        --if s ~= 1 or cap ~= "" then
            --table.insert(t,cap)
        --end
        --last_end = e+1
        --s, e, cap = str:find(fpat, last_end)
    --end
    --if last_end <= #str then
        --cap = str:sub(last_end)
        --table.insert(t, cap)
    --end
    --return t
--end

function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

function split(str, sep)
    local result = {}
    if sep == '' then
        string.gsub(str, ".", function(c) table.insert(result,c) end)
    else
        local regex = ("([^%s]+)"):format(sep)
        for each in str:gmatch(regex) do
            table.insert(result, each)
        end
    end 
    return result
end

function table_copy(t)
    local u = { }
    for k, v in pairs(t) do u[k] = v end
    return setmetatable(u, getmetatable(t))
end

math.randomseed( os.time() )
function sample(source)
    return source[math.random(table.getn(source))]
end

function capitalize (str)
    local res, _ = str:gsub("^%l", string.upper)
    return res
end

function shuffle(source)
    local result = {unpack(source)}
    local tmp
    local p
    local len = table.getn(source)
    for i=1, len do
        p = math.floor(math.random() * len) + 1
        tmp = result[i]
        result[i] = result[p]
        result[p] = tmp
    end
    return result
end

function in_array(haystack, needle )
    for _, value in ipairs(haystack) do
        if value == needle then
            return true
        end
    end
    return false
end


return {
    range = range,
    sample = sample,
    split = split,
    table_copy = table_copy,
    array_merge = array_merge,
    split = split,
    file_exists = file_exists,
    range = range,
    capitalize = capitalize,
    shuffle = shuffle,
    in_array = in_array,
}
