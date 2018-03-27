local sti = require("deps/sti/sti")
local pprint = require('deps/pprint')

-- Represents a resource manager for levels
LevelManager = {}

function LevelManager:new()
  local instance = {}
  self.__index = self
  LevelManager._init(instance)
  setmetatable(instance, self)
  return instance
end

function LevelManager._init(instance)
  instance.levels = {}
end

function LevelManager:get_level(file_name)
  if (self.levels[file_name] == nil) then
    self.levels[file_name] = sti('maps/' .. file_name .. '.lua', {'bump'})
  end
  return self.levels[file_name]
end

-- return this class template
return LevelManager
