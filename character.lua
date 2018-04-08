local pprint = require('deps/pprint')

-- Represents a character in the game world
Character = {}

function Character:new(image_world, image_encounter, image_talk,
  screen_width, screen_height, encounter_x, encounter_y)
  -- create a new table for the object instance
  local instance = {}
  self.__index = self
  Character._init(instance, image_world, image_encounter,
    image_talk, screen_width, screen_height, encounter_x, encounter_y)
  setmetatable(instance, self)
  return instance
end

function Character._init(instance, image_world, image_encounter,
  image_talk, screen_width, screen_height, encounter_x, encounter_y)
  instance.x = 100
  instance.y = 100
  instance.speed = 250
  instance.image_world = image_world
  instance.image_encounter = image_encounter
  instance.encounter_x = encounter_x
  instance.encounter_y = encounter_y
  -- index 1 is a list of what that character will do at that stage in benchmark 1
  -- e.g.: benchmarks[1][1] = { text = "don't kill me plz", effect = -1, thought = "foo bar"}
  -- benchmarks[1][2] = {thought = "...", ...}
  -- effects are an integer
  instance.benchmarks = {}
  instance.current_benchmark_position = 1
  instance.stress = 0
  instance.animation = {}
  instance.current_animation = 0
  instance.stressed_move = {}
  instance.image_talk = image_talk
  instance.intro = ""
  instance.campfire = nil

  instance.second_benchmarks = {}
end

function Character:increase_stress()
  self.stress = self.stress + 1
end

function Character:decrease_stress()
  if self.stress > 0 then
    self.stress = self.stress - 1
  end
end

function Character:inc_encounter()
  self.stress = 0
  self.current_benchmark_position = 1
  self.benchmarks = self.second_benchmarks
end

function Character:is_stressed()
  return self.stress >= 2
end

function Character:get_stressed_move()
  return self.stressed_move
end

function Character:get_thought(benchmark_number, benchmark_position)
  local bench = self.benchmarks[benchmark_number][benchmark_position]
  if bench == nil then
    return nil
  end
  return bench.thought
end

function Character:get_benchmark_move(benchmark_number, benchmark_position)
  return self.benchmarks[benchmark_number][benchmark_position]
end

function Character:get_campfire_move(benchmark_position)
  return self.campfire[benchmark_position]
end

function Character:is_next_move_nil(benchmark_number, benchmark_position)
  if self.benchmarks[benchmark_number] == nil or self:is_stressed() then
    return true
  else
    return self.benchmarks[benchmark_number][benchmark_position] == nil
  end
end

-- return this class template
return Character
