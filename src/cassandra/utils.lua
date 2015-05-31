local _M = {}

function _M.big_endian_representation(num, bytes)
  if num < 0 then
    -- 2's complement
    num = math.pow(0x100, bytes) + num
  end
  local t = {}
  while num > 0 do
    local rest = math.fmod(num, 0x100)
    table.insert(t, 1, string.char(rest))
    num = (num-rest) / 0x100
  end
  local padding = string.rep(string.char(0), bytes - #t)
  return padding .. table.concat(t)
end

function _M.shuffle_array(arr)
  -- see: http://en.wikipedia.org/wiki/Fisher-Yates_shuffle
  local n = #arr
  while n >= 2 do
    local k = math.random(n)
    arr[n], arr[k] = arr[k], arr[n]
    n = n - 1
  end
  return arr
end

function _M.split_by_colon(str)
  local fields = {}
  str:gsub("([^:]+)", function(c) fields[#fields+1] = c end)
  return fields[1], fields[2]
end

function _M.hasbit(x, p)
  return x % (p + p) >= p
end

function _M.setbit(x, p)
  return _M.hasbit(x, p) and x or x + p
end

return _M
