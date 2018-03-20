local pprint = require('deps/pprint')

-- Represents a character in the game world
Enemy = {}

function Enemy:new(image_world, image_encounter, image_talk)
  -- create a new table for the object instance
  local instance = {}
  -- hook up its metatable to the class definition
  setmetatable(instance, self)
  self.__index = self
  self:_init(image_world, image_encounter, image_talk)
  return instance
end

function Enemy:_init(image_world, image_encounter, image_talk)
  self.x = 100
  self.y = 100
  self.image_world = image_world
  self.image_encounter = image_encounter
  self.image_talk = image_talk
  self.current_line = 0
  self.lines = {}
  self.lines[0] = "Halt, fiends! Who dares trespass into the chamber of King Graadiabs the Tall? Explain thyself!"
  self.lines[1] = "Hmm... well, you do seem to be very respectful, but my loyal subjects are quite hungry, and you morsels seem extra delicious..."
  self.lines[2] = "Well, even if we were to spare you, why should we? How does sparing you morsels benefit us?"
  self.escape_text = "Very well, you may go."
  self.death_text = "Fools! You exhaust my patience. Eat them!"
  self.trust = 0
  self.full_name = "King Graadiabs the Tall."
  self.intro = "The party finds themselves accidental trespassers into the chambers of King Graadiabs the Tall, a self-proclaimed goblin king. He stands on a small box that brings his height up to just under four feet, and he wears a crooked crown made of stone. He is surrounded by many, many loyal goblin subjects, several of whom carry rather sharp-looking spears... and upsettingly hungry grins."
end

function Enemy:say()
  local line = self.lines[self.current_line]
  if line == nil then
    return ""
  else
    self.current_line = self.current_line + 1
    return line
  end
end

function Enemy:change_trust(effect_amount)
  self.trust = self.trust + effect_amount
end
-- return this class template
return Enemy
