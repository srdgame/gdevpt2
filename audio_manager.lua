local pprint = require('deps/pprint')

-- Represents a resource manager for audio files
local AudioManager = {}

function AudioManager:new()
  local instance = {}
  self.__index = self
  AudioManager._init(instance)
  setmetatable(instance, self)
  return instance
end

function AudioManager._init(instance)
  instance.sounds = {}
end

function AudioManager:get_sound(sound, volume, looping)
  if (self.sounds[sound] == nil) then
    self.sounds[sound] = love.audio.newSource('audio/' .. sound .. '.wav')
  end
  local s = self.sounds[sound]
  s:rewind()
  s:setVolume(volume)
  s:setLooping(looping)
  return s
end

-- Return this class template
return AudioManager
