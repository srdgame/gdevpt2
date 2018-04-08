local pprint = require('deps/pprint')
-- represents an interactible object in a map
Object = {}

function Object:new(x, y, text)
  local instance = {}
  self.__index = self
  Object._init(instance, x, y, text)
  setmetatable(instance, self)
  return instance
end

function Object._init(instance, x, y, text)
  instance.x = x
  instance.y = y
  instance.text = text
end

return Object
