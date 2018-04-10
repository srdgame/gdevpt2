local Character = require('character')
local Enemy = require('enemy')
local Object = require('object')
local LevelManager = require('level_manager')
local AudioManager = require('audio_manager')
local bump = require("deps/bump/bump")
local pprint = require('deps/pprint')

-- State definitions
local STATE_NULL = -9999
local STATE_INTRO = -1
local STATE_MOVING = 0
local STATE_ENCOUNTER = 1
local STATE_ENCOUNTER_WAIT_FOR_INPUT = 2
local STATE_SHOWING_TEXT = 3
local STATE_CHARACTER_TALKING = 4
local STATE_CHANGING_TRUST = 5
local STATE_GET_NEXT_TEXT = 6
local STATE_ESCAPE_ENCOUNTER = 7
local STATE_DIED_ENCOUNTER = 8
local STATE_ENCOUNTER_INTRO = 9
local STATE_CAMPFIRE = 12
-- Menu State
local STATE_MAIN_MENU = 10
local STATE_RESOLUTION_SELECT = 11

-- Represents the GameState
-- This is everything in the game world that is updated and rendered.
local GameState = {}

function GameState:new(screen_width, screen_height)
  -- create a new table for the object instance
  local instance = {}
  -- hook up its metatable to the class definition
  setmetatable(instance, self)
  self.__index = self
  self:_init(screen_width, screen_height)
  -- return the instance
  return instance
end

function GameState:_init(screen_width, screen_height)
  self.characters = {}
  self.world_character = {}
  self.enemy = {}
  self.map = {}
  self.world = {}
  self.current_map = 0
  self.screen_width = screen_width
  self.screen_height = screen_height
  self.did_move = false
  self.state = STATE_CAMPFIRE
  self.return_state_after_text = STATE_MOVING
  self.encounter_background = love.graphics.newImage('data/background_graadiabs.png')
  self.current_text = ""
  self.current_text_to_display_idx = 1
  self.current_character = 1
  self.current_character_thought = ""
  self.selector = love.graphics.newImage('data/ui_selector.png')
  self.textbox = love.graphics.newImage('data/textbox_00.png')
  self.enemy_textbox = love.graphics.newImage('data/textbox_01.png')
  self.continue = love.graphics.newImage('data/ui_continue.png')
  self.current_benchmark = 1
  self.current_benchmark_position = 1
  self.trust_change_amount = 0
  self.text_buffer = ""
  self.prev_text = ""
  self.level_manager = LevelManager:new()
  self.doors = {}
  self.current_talking_head = nil -- either = to current_character OR "enemy"
  self.prev_talking_head = nil
  self.stress_meters = {
    love.graphics.newImage('data/ui_stress_00.png'),
    love.graphics.newImage('data/ui_stress_01.png'),
    love.graphics.newImage('data/ui_stress_02.png'),
    love.graphics.newImage('data/ui_stress_03.png')
  }
  self.new_idea = love.graphics.newImage('data/ui_new_idea.png')
  self.old_idea = love.graphics.newImage('data/ui_old_idea.png')
  self.audio_manager = AudioManager:new()
  self.current_song = self.audio_manager:get_sound('bgm', .3, true)
  self.current_song:play()
  self.current_sfx = nil
  self.trust_bar = love.graphics.newImage('data/ui_trust_bar.png')
  self.trust_slider = love.graphics.newImage('data/ui_trust_slider.png')
  self.text_box_blank = love.graphics.newImage('data/textbox_blnk.png')
  self.current_intro_char = 0
  self.resolutions = {
    { w = 640, h = 480 },
    { w = 1280, h = 960 },
    { w = 1440, h = 900 },
    { w = 1600, h = 1200 },
    { w = 1920, h = 1440 }
  }
  self.is_campfire = false
  self.had_campfire = false
  self.campfire_position = 0
  self.campfire_background = love.graphics.newImage('data/background_campfire.png')

  self.objects = {}
  self.showing_text_in_world = false
  self.title_card = love.graphics.newImage('data/titlecard_01.png')
  self.visual_fx = nil
  self.is_fading_to_map = false
  self.destination_map = ""
  self.is_fading_to_encounter = false
  self.is_fading_to_campfire = false
  self.should_fade_to_campfire = false
  self.is_fading_to_map_from_campfire = false
end
-- max chars on screen
local max_lines = 5
-- delay input for encounter
local user_input_timer = 0
local user_input_delay = .5
-- timer to delay how quickly text loads.
local text_draw_timer = 0
local text_draw_delay = .005

local text_sound_timer = 0
local text_sound_delay = .05

local walk_sound_timer = 0
local walk_sound_delay = .3

local fade_out_timer = 0
local fade_out_delay = .08
local fade_out_index = 1
local is_fading_out = 1
local fade_images = {
  love.graphics.newImage('data/1.png'),
  love.graphics.newImage('data/2.png'),
  love.graphics.newImage('data/3.png'),
  love.graphics.newImage('data/4.png'),
  love.graphics.newImage('data/5.png'),
  love.graphics.newImage('data/6.png'),
  love.graphics.newImage('data/7.png'),
  love.graphics.newImage('data/8.png'),
  love.graphics.newImage('data/9.png'),
  love.graphics.newImage('data/10.png')
}

function GameState:update(dt)
  -- update timers
  user_input_timer = user_input_timer + dt
  text_draw_timer  = text_draw_timer + dt
  text_sound_timer = text_sound_timer + dt
  walk_sound_timer = walk_sound_timer + dt
  fade_out_timer = fade_out_timer + dt

  if self.is_fading_to_map or self.is_fading_to_encounter or self.is_fading_to_campfire 
    or self.is_fading_to_map_from_campfire then 
    if (fade_out_timer >= fade_out_delay) then
      --pprint(fade_out_index)
      --pprint(fade_images[fade_out_index])
      fade_out_timer = 0
      if (is_fading_out) then
        fade_out_index = fade_out_index + 1
        if (fade_out_index == 10) then
          is_fading_out = false 
          if (self.is_fading_to_map) then
            self:initialize_map(self.destination_map[1], self.destination_map[2])
            self.destination_map = ""
          end
          if (self.is_fading_to_encounter) then
            self.state = STATE_ENCOUNTER_INTRO
            self.current_benchmark = 1
          end
          if (self.is_fading_to_campfire) then
            self.state = STATE_CAMPFIRE
          end
          if (self.is_fading_to_map_from_campfire) then
            self.is_campfire = false
            self:initialize_map('forest_01')
          end
        end
      else
        fade_out_index = fade_out_index - 1
        if (fade_out_index == 1) then
          is_fading_out = true
          fade_out_index = 1
          self.is_fading_to_map = false
          self.is_fading_to_encounter = false
          self.is_fading_to_campfire = false
          self.should_fade_to_campfire = false
          self.is_fading_to_map_from_campfire = false
        end
      end
    end
  end

  -- game state update
  if self.state == STATE_INTRO then
    if self.current_intro_char >= 3 then
      self.state = STATE_MOVING
      self.return_state_after_text = STATE_MOVING
    else
      self.current_intro_char = self.current_intro_char + 1
      self.state = STATE_SHOWING_TEXT
      self.return_state_after_text = STATE_INTRO
      self.current_text =  self:wrap_text(self.characters[self.current_intro_char].intro)
    end

  elseif self.state == STATE_MAIN_MENU then
    if user_input_timer >= user_input_delay then
      if love.keyboard.isDown('space') then
        user_input_timer = 0
        self.state = STATE_INTRO
        -- re-update before draw.
        self:update(dt)
      elseif love.keyboard.isDown('r') then
         user_input_timer = 0
         self.state = STATE_RESOLUTION_SELECT
      elseif love.keyboard.isDown('q') then
        love.event.quit()
      end
    end

  elseif self.state == STATE_RESOLUTION_SELECT then
    if user_input_timer >= user_input_delay then
      local change_res = false
      if love.keyboard.isDown('escape') then
        user_input_timer = 0
        self.state = STATE_MAIN_MENU
      end
      for ii=1,5 do
        if love.keyboard.isDown(ii) then
          self.screen_width = self.resolutions[ii].w
          self.screen_height = self.resolutions[ii].h
          change_res = true
          goto change_res -- no break statement!
        end
      end
      
      ::change_res::
      if change_res then
        love.window.setMode(self.screen_width, self.screen_height)
        self:reset_character_encounter_positions()
      end
    end

  elseif self.state == STATE_ENCOUNTER_INTRO then
    self.state = STATE_SHOWING_TEXT
    self.return_state_after_text = STATE_ENCOUNTER
    self.current_text = self:wrap_text(self.enemy.intro)
    self.current_talking_head = "narrator"
    self.prev_talking_head = "narrator"

  -- MOVING
  elseif self.state == STATE_MOVING then
    if self.is_fading_to_map then
      return
    end
    self.did_move = false
    self.showing_text_in_world = false
    -- check if player hit a door
    self:handle_door_collision()
    -- check if player hit an object
    local txt = self:handle_object_collision()
    if not (txt == nil) then
      -- display text on space
      if user_input_timer >= user_input_delay
        and love.keyboard.isDown('space') then
        self.showing_text_in_world = true
        self.state = STATE_SHOWING_TEXT
        self.return_state_after_text = STATE_MOVING
        self.current_text = self:wrap_text(txt)
        return
      end
    end
      -- check if the world character collided with an enemy
      if self:has_collided_on_enemy(self.map, self.world_character.x, self.world_character.y) then
        -- start encounter, reset current benchmark
        self.is_fading_to_encounter = true
      else
        self.did_move = self:update_move_player(dt)
      end
  elseif self.state == STATE_ENCOUNTER then
    -- enemy says a line
    self.current_text = self:wrap_text(self.enemy:say())
    self.current_talking_head = "enemy"
    self.prev_talking_head = "enemy"
    self.state = STATE_SHOWING_TEXT
    self.return_state_after_text = STATE_ENCOUNTER_WAIT_FOR_INPUT
    -- reset benchmark position
    self.current_benchmark_position = 1

  elseif self.state == STATE_SHOWING_TEXT then
    if self.current_text_to_display_idx == string.len(self.current_text) then
      if user_input_timer >= user_input_delay then
        if love.keyboard.isDown('space') then
          user_input_timer = 0
          if self.should_fade_to_campfire then
            self.is_fading_to_campfire = true
          else
            self.state = self.return_state_after_text
          end
          self.text_buffer  = ""
          self.current_text = ""
          self.current_text_to_display_idx = 0
          self.prev_talking_head = self.current_talking_head
          self.current_talking_head = nil
          if (self.showing_text_in_world) then
            self.showing_text_in_world = false
          end
        end
      end
    else
      if (text_draw_timer >= text_draw_delay) then
        self.current_text_to_display_idx = self.current_text_to_display_idx + 1
        -- wrap text for max_lines and wait for space
        local cur_text_len = string.len(self.current_text)
        local cur_lines_on_screen = select(2,string.sub(self.current_text, 0, self.current_text_to_display_idx - 1):gsub('\n', '\n'))
        if cur_lines_on_screen >= max_lines then
          self.text_buffer  = string.sub(self.current_text, self.current_text_to_display_idx, cur_text_len)
          self.current_text = string.sub(self.current_text, 0, self.current_text_to_display_idx - 1)
          self.state = STATE_GET_NEXT_TEXT
        else
           -- play sound when we add another character
          if (text_sound_timer >= text_sound_delay) then
            text_sound_timer = 0
            local sfx = love.audio.newSource('audio/char-text.wav')
            sfx:setVolume(1)
            sfx:play()
          end
        end
        text_draw_timer = 0
      end
    end

  elseif self.state == STATE_GET_NEXT_TEXT then
    if self.is_fading_to_campfire or self.is_fading_to_encounter then
      return
    end
    if user_input_timer >= user_input_delay then
         -- press enter to skip intro
      if (self.return_state_after_text == STATE_INTRO)
        and love.keyboard.isDown('return') then
        user_input_timer = 0
        self.state = STATE_MOVING
        self.return_state_after_text = STATE_NULL
        self.text_buffer = ""
        self.current_text = ""
        self.current_text_to_display_idx = 0
      end
      if love.keyboard.isDown('space') then
        user_input_timer = 0
        self.current_text = self.text_buffer
        self.current_text_to_display_idx = 1
        self.state = STATE_SHOWING_TEXT
      end
    end

  elseif self.state == STATE_ENCOUNTER_WAIT_FOR_INPUT then
    if self.is_fading_to_campfire or self.is_fading_to_encounter then
      return
    end
    -- render thought on initially selected character
    local get_thought_for_initial_character = self.current_character_thought == ""
    -- if the player pressed enter advance convo
    if user_input_timer >= user_input_delay or (get_thought_for_initial_character and not self.return_state_after_text == STATE_CAMPFIRE) then
      if get_thought_for_initial_character and  not self.return_state_after_text == STATE_CAMPFIRE then
        goto get_thought
      end
      -- go to next valid character
      if love.keyboard.isDown('s') then
        user_input_timer = 0
        ::get_another_character_down::
        self.current_character = (self.current_character % 3) + 1
        if self.is_campfire and self.characters[self.current_character]:get_campfire_move(self.campfire_position) == nil then
          goto get_another_character_down
        end
      elseif love.keyboard.isDown('w') then
        user_input_timer = 0
        ::get_another_character_up::
        self.current_character = ((self.current_character - 2) % 3) + 1
        if self.is_campfire and self.characters[self.current_character]:get_campfire_move(self.campfire_position) == nil then
          goto get_another_character_up
        end        
      end
      ::get_thought::
      if self.is_campfire then
          self.current_character_thought = ""
      else
        if self.characters[self.current_character]:is_next_move_nil(self.current_benchmark, self.current_benchmark_position) then
          self.current_character_thought = "..."
        else
          self.current_character_thought = self.characters[self.current_character]:get_thought(self.current_benchmark, self.current_benchmark_position)
        end
      end

      if love.keyboard.isDown('space') then
        user_input_timer = 0
        -- the current character makes his move
        self.current_talking_head = self.current_character
        self.state = STATE_SHOWING_TEXT
        self.return_state_after_text = STATE_CHANGING_TRUST
         
        local move = ""
        -- INPUT FOR CAMPFIRE
        if self.is_campfire then
            move = self.characters[self.current_character]:get_campfire_move(self.campfire_position)               
          if move == nil then
            self.current_text = "..."
          else
            self.current_text = self:wrap_text(move)
            self.current_character_thought = ""
          end
          self.return_state_after_text = STATE_CAMPFIRE
          goto end_enc_wait_for_input
        end
        move = self.characters[self.current_character]:get_benchmark_move(self.current_benchmark, self.current_benchmark_position)
        if self.characters[self.current_character]:is_stressed() then
          self.return_state_after_text = STATE_DIED_ENCOUNTER
          self.current_text = self:wrap_text(self.characters[self.current_character]:get_stressed_move().text)
        else
          if move == nil then
            self.current_text = "..."
            self.trust_change_amount = -2
          else
            self.current_text = self:wrap_text(move.text)
            self.trust_change_amount = move.effect
          end
        end
        self.current_character_thought = ""
        self.current_benchmark_position = self.current_benchmark_position + 1
        -- adjust stress
        self.characters[self.current_character]:increase_stress()
        for k,v in pairs(self.characters) do
          if not (k == self.current_character) then
            self.characters[k]:decrease_stress()
          end
        end
        ::end_enc_wait_for_input::
      end
    end

  elseif self.state == STATE_CHANGING_TRUST then
    if not (self.trust_change_amount == 0) then
      local delta = 1
      if self.trust_change_amount > 0 then
        delta = -1
      end
        self.enemy:change_trust(delta * -1)
        self.trust_change_amount = self.trust_change_amount + delta
    else
      -- is encounter over?
      if self.enemy.trust > 10 then
        self.state = STATE_ESCAPE_ENCOUNTER
      else
        -- check if we can advance to the next benchmark
        if self:are_all_moves_nil(self.current_benchmark, self.current_benchmark_position) then
          self.current_benchmark = self.current_benchmark + 1
          -- is there another benchmark?
          if self:are_all_moves_nil(self.current_benchmark, 1) then
            if self.enemy.trust >= 0 then
              self.state = STATE_ESCAPE_ENCOUNTER
            else
              self.state = STATE_DIED_ENCOUNTER
            end
          else
            self.state = STATE_ENCOUNTER
          end
        else
          self.state = STATE_ENCOUNTER_WAIT_FOR_INPUT
        end
      end
    end

  elseif self.state == STATE_ESCAPE_ENCOUNTER
    or self.state == STATE_DIED_ENCOUNTER then
    -- enemy says encounter text
    if self.state == STATE_ESCAPE_ENCOUNTER then
      self.current_text = self:wrap_text(self.enemy.escape_text)
    else
      self.current_text = self:wrap_text(self.enemy.death_text)
    end
    self.current_talking_head = "enemy"
    self.state = STATE_SHOWING_TEXT
    if self.had_campfire then
      self.return_state_after_text = STATE_MOVING

    else
      self.should_fade_to_campfire = true
      self.return_state_after_text = STATE_CAMPFIRE
    end
    -- remove enemy from map
    self:remove_enemy_from_map(self.map)
    self.enemy.image_world = "deleted"

  elseif self.state == STATE_CAMPFIRE then
    if self.is_fading_to_map_from_campfire then
      return
    end
    if self.is_campfire == false then
      self.current_song:stop()
      self.current_song = self.audio_manager:get_sound("fireside_chat", 1, true)
      self.current_song:play()
      --self:initialize_map('forest_01')
    end
    self.campfire_position = self.campfire_position + 1
    self.is_campfire = true
    
    if self.campfire_position == 16 then
      self.state = STATE_MOVING
      self.had_campfire = true
      self.current_song:stop()
      self.current_song = self.audio_manager:get_sound("forest", 1, true)
      self.current_song:play()
      self.is_fading_to_map_from_campfire = true
    else
     self.state = STATE_ENCOUNTER_WAIT_FOR_INPUT
     self.return_state_after_text = STATE_CAMPFIRE
     self:move_to_valid_character()
   end
  end
end

function GameState:move_to_valid_character()
  ::get_another_character_down::
  if self.is_campfire and self.characters[self.current_character]:get_campfire_move(self.campfire_position) == nil then
    self.current_character = (self.current_character % 3) + 1    
    goto get_another_character_down
  end
end

function GameState:are_all_moves_nil(benchmark_number, benchmark_position)
  local all_moves_nil = true
  for k,v in pairs(self.characters) do
    all_moves_nil = all_moves_nil and self.characters[k]:is_next_move_nil(benchmark_number, benchmark_position)
  end
  return all_moves_nil
end

function GameState:wrap_text(string)
  local font = love.graphics.getFont()
  local width, sequence = font:getWrap(string, 360)
  local res = ""
  for k,v in pairs(sequence) do
    res = res .. "\n" .. v
  end
  return res
end

function GameState:update_move_player(dt)
  local did_move = false
  if love.keyboard.isDown('w') then
    did_move = true
    -- animate
    self:animate_world_player(dt, "up")
    -- check bounds on current map
    local new_y = self.world_character.y - (self.world_character.speed * dt)
    if not self:has_collided_on_map(self.map, self.world_character.x, new_y) then
      self.world_character.y =  new_y
    end
  elseif love.keyboard.isDown('a') then
    did_move = true
    self:animate_world_player(dt, "left")
    -- check bounds on current map
    local new_x = self.world_character.x - (self.world_character.speed * dt)
    if not self:has_collided_on_map(self.map, new_x, self.world_character.y) then
      self.world_character.x = new_x
    end
  elseif love.keyboard.isDown('s') then
    did_move = true
    self:animate_world_player(dt, "down")
    -- check bounds on current map
    local new_y = self.world_character.y + (self.world_character.speed * dt)
    if not self:has_collided_on_map(self.map, self.world_character.x, new_y) then
      self.world_character.y = new_y
    end
  elseif love.keyboard.isDown('d') then
    did_move = true
    self:animate_world_player(dt, "right")
    -- check bounds on current map
    local new_x = self.world_character.x + (self.world_character.speed * dt)
    if not self:has_collided_on_map(self.map, new_x, self.world_character.y) then
      self.world_character.x = new_x
    end
  end

  if did_move then
    if walk_sound_timer >= walk_sound_delay then
      walk_sound_timer = 0
      local sfx = love.audio.newSource('audio/walk.wav')
      sfx:setVolume(.5)
      sfx:play()
    end
  end
  return did_move
end

function GameState:animate_world_player(dt, direction)
  if not (self.world_character.current_animation == direction) then
    self.world_character.current_animation = direction
  else
    self.world_character.animation[self.world_character.current_animation]:update(dt)
  end
end

function GameState:has_collided_on_map(map, character_x, character_y)
  -- check if hit wall on map
  for k,t in pairs(map.bump_collidables) do
    if self:has_collided(character_x, character_y, t.x, t.y, t.width, t.height) then
      return true
    end
  end
  return false
end

function GameState:has_collided_on_enemy(map, character_x, character_y)
  for k, object in pairs(map.objects) do
    if object.name == "enemy" then
      if self:has_collided(character_x, character_y, object.x, object.y, 32, 32) then
        return true
      end
    end
  end
  return false
end

function GameState:handle_object_collision()
  local wx = self.world_character.x
  local wy = self.world_character.y
  for k,v in pairs(self.objects) do
    if not (wx > (v.x - 8) + 32 or
        (v.x - 8) > wx + 32 or
        wy > (v.y - 8) + 32 or
        (v.y - 8) > wy + 32) then
      return v.text
    end
  end
  return nil
end

function GameState:handle_door_collision()
  local wx = self.world_character.x
  local wy = self.world_character.y
  for coords, map in pairs(self.doors) do
    if not (wx > coords.x + 32 or
        coords.x > wx + 32 or
        wy > coords.y + 32 or
        coords.y > wy + 32) then
        self.is_fading_to_map = true
        self.destination_map = {map, coords.target}
      break
    end
  end
end

function GameState:remove_enemy_from_map(map)
  for k, object in pairs(map.objects) do
    if object.name == "enemy" then
      -- this is totally a hack, but I couldn't figure out how to delete
      -- objects from maps otherwise. Setting map[k] = nil didn't do it
      -- since map.objects returns a list with different keys than the global map.
      object.name = "not any more"
      break
    end
  end
end

function GameState:has_collided(character_x, character_y, obj_x, obj_y, obj_w, obj_h)
  if not ((obj_w + obj_x <= character_x + 8 or character_x + 24 <= obj_x)
  or (obj_h + obj_y <= character_y + 20 or obj_y >= character_y + 36)) then
    return true
  end
  return false
end

function GameState:draw()
  -- scale world
  local scale_screen_width =  love.graphics.getWidth() / 640
  local scale_screen_height = love.graphics.getHeight() / 480
  local swidth = love.graphics.getWidth() / scale_screen_width 
  local sheight = love.graphics.getHeight() / scale_screen_height
  love.graphics.scale(scale_screen_width, scale_screen_height)

  if self.state == STATE_MAIN_MENU then
    love.graphics.draw(self.title_card, 0, 0)


  elseif self.state == STATE_RESOLUTION_SELECT then
    love.graphics.print({{255,255,128}, "Press the number of the new Resolution. ESC to go back."}, math.floor(swidth * .3), math.floor(sheight / 4))
    for k,v in pairs(self.resolutions) do
      love.graphics.print({{255,255,128}, k .. ")" .. " " .. v.w .. "x" .. v.h}, math.floor(swidth * .4), math.floor(sheight / 3) + (k * 20))
    end

  elseif self.state == STATE_INTRO or ((self.state == STATE_GET_NEXT_TEXT
    or self.state == STATE_SHOWING_TEXT)
    and self.return_state_after_text == STATE_INTRO) then
    -- print character name
    love.graphics.print({{255,255,128}, self.characters[self.current_intro_char].full_name}, math.floor(swidth * .36), 110)
    -- render character
    love.graphics.draw(self.characters[self.current_intro_char].image_encounter, math.floor(swidth * .4), 120)
    -- render text box
    love.graphics.draw(self.text_box_blank, 84, math.floor(sheight * .5))
    -- render text
    local string_to_render = string.sub(self.current_text, 0, self.current_text_to_display_idx)
    love.graphics.print({{255,255,128}, string_to_render}, 150, math.floor(sheight * .535))

    -- render 'next' modals
    if self.state == STATE_GET_NEXT_TEXT
    or (self.current_text_to_display_idx > 0
      and self.current_text_to_display_idx == string.len(self.current_text)) then
      love.graphics.draw(self.continue, 500, math.floor(sheight * .7), 0, 1, 1, 0, 0)
      love.graphics.print({{255,255,128}, "Press Enter to Skip..."}, 84, math.floor(sheight * .75), 0, 1, 1, 0, 0)
    end

    -- CAMPFIRE
  elseif self.is_campfire then
      -- render campfire scene
      love.graphics.draw(self.campfire_background, 0, 0, 0, 1, 1, 0, 0)
      -- render characters
      local cur_character = self.characters[self.current_character]
      local bermund = self.characters[1]
      local sheera = self.characters[2]
      local holly = self.characters[3]
      love.graphics.draw(bermund.campfire_image, bermund.campfire_x, bermund.campfire_y)
      love.graphics.draw(sheera.campfire_image, sheera.campfire_x, sheera.campfire_y)
      love.graphics.draw(holly.campfire_image, holly.campfire_x, holly.campfire_y)
      -- render selector
      if self.state == STATE_ENCOUNTER_WAIT_FOR_INPUT then
        love.graphics.draw(self.selector, cur_character.campfire_x - 5,
          cur_character.campfire_y + 20, 0, 1, 1, 0, 0)
      end
      -- render text
      local string_to_render = self.current_text
      string_to_render = string.sub(self.current_text, 0, self.current_text_to_display_idx)
      if not (self.current_text == "") then
        self.prev_text = string_to_render
      end
      if self.state == STATE_SHOWING_TEXT
        or self.state == STATE_ENCOUNTER_WAIT_FOR_INPUT
        or self.state == STATE_GET_NEXT_TEXT
        or self.state == STATE_CAMPFIRE then
          local head = self.current_talking_head
          if head == nil then
            head = self.prev_talking_head
          end

          if not (head == nil) and (head == 1 or head == 2 or head == 3) then
            love.graphics.draw(self.textbox, 320, 3, 0, 1, 1, 240, 0)
            love.graphics.draw(self.characters[head].image_talk, 92, 15, 0, 1, 1, 0, 0)
            love.graphics.print({{255, 255, 128}, self.prev_text},
              198, math.floor(sheight * .04))
          end
      end

      if self.state == STATE_ENCOUNTER_WAIT_FOR_INPUT then
        for k,v in pairs(self.characters) do
          local idea = self.new_idea
          if (self.characters[k]:get_campfire_move(self.campfire_position)) then
            love.graphics.draw(idea, self.characters[k].campfire_x + 25,
              self.characters[k].campfire_y - 10, 0, 1, 1, 0, 0) 
          end
        end
      end
    -- render 'next' modals
    if self.state == STATE_GET_NEXT_TEXT
    or (self.current_text_to_display_idx > 0
      and self.current_text_to_display_idx == string.len(self.current_text)) then
      local xposfactor = .15
      love.graphics.draw(self.continue,
      math.floor(swidth * xposfactor), 110, 0, 1, 1, 0, 0)
    end

  elseif not(self.return_state_after_text == STATE_INTRO)
    and(self.state == STATE_ENCOUNTER
  or self.state == STATE_ENCOUNTER_WAIT_FOR_INPUT
  or self.state == STATE_SHOWING_TEXT
  or self.state == STATE_GET_NEXT_TEXT
  or self.state == STATE_CHANGING_TRUST
  or self.state == STATE_ESCAPE_ENCOUNTER
  or self.state == STATE_DIED_ENCOUNTER
  or self.state == STATE_ENCOUNTER_INTRO)
  and (not self.showing_text_in_world) then
    -- render background and enemy
    love.graphics.draw(self.encounter_background, 0, 0, 0, 1, 1, 0, 0)
    love.graphics.draw(self.enemy.image_encounter,
      swidth * .65, (sheight / 2) - 10, 0, 1, 1, 0, 0)
    -- render players
    local cur_character = self.characters[self.current_character]
    local bermund = self.characters[1]
    local sheera = self.characters[2]
    local holly = self.characters[3]

    love.graphics.draw(bermund.image_encounter,
    bermund.encounter_x, bermund.encounter_y, 0, 1, 1, 0, 0)

    love.graphics.draw(sheera.image_encounter,
    sheera.encounter_x, sheera.encounter_y, 0, 1, 1, 0, 0)

    love.graphics.draw(holly.image_encounter,
    holly.encounter_x, holly.encounter_y, 0, 1, 1, 0, 0)

    --render text to screen
    local string_to_render = self.current_text
    string_to_render = string.sub(self.current_text, 0, self.current_text_to_display_idx)
    if not (self.current_text == "") then
      self.prev_text = string_to_render
    end

    if self.state == STATE_SHOWING_TEXT
      or self.state == STATE_CHANGING_TRUST
      or self.state == STATE_ENCOUNTER_WAIT_FOR_INPUT
      or self.state == STATE_GET_NEXT_TEXT then
       
      -- render textbox and talking head
        if self.current_talking_head == "narrator" then
          -- render textbox blnk
          love.graphics.draw(self.text_box_blank, 320, 3, 0, 1, 1, 240, 0)
          love.graphics.print({{255,255,128}, self.prev_text}, 140, math.floor(sheight * .04))

        elseif self.current_talking_head == "enemy" or
          ((self.current_talking_head == nil or string.len(self.current_talking_head) == 0)
          and self.prev_talking_head == "enemy") then
          love.graphics.draw(self.enemy_textbox, 320, 3, 0, 1, 1, 240, 0)
          love.graphics.draw(self.enemy.image_talk, swidth - 188, 15, 0, 1, 1, 0, 0)
          love.graphics.print({{255,255,128}, self.prev_text}, 92, math.floor(sheight * .04))
        else
          love.graphics.draw(self.textbox, 320, 3, 0, 1, 1, 240, 0)
          local head = self.current_talking_head
          if head == nil then
            head = self.prev_talking_head
          end
          if self.characters[head] then
            love.graphics.draw(self.characters[head].image_talk, 92, 15, 0, 1, 1, 0, 0)
          end
          love.graphics.print({{255, 255, 128}, self.prev_text},
            198, math.floor(sheight * .04))
        end
      end
    -- render 'next' modals
    if self.state == STATE_GET_NEXT_TEXT
    or (self.current_text_to_display_idx > 0
      and self.current_text_to_display_idx == string.len(self.current_text)) then
      local xposfactor = .15
      love.graphics.draw(self.continue,
      math.floor(swidth * xposfactor), 110, 0, 1, 1, 0, 0)
    end

    -- render selector
    if self.state == STATE_ENCOUNTER_WAIT_FOR_INPUT then
      love.graphics.draw(self.selector, cur_character.encounter_x - 5,
        cur_character.encounter_y + 20, 0, 1, 1, 0, 0)
    end

    -- render indicator based on current thought
    if self.state == STATE_ENCOUNTER_WAIT_FOR_INPUT then
      for k,v in pairs(self.characters) do
        local idea = self.new_idea
        local thought = nil
        if self.characters[k]:is_next_move_nil(self.current_benchmark,
          self.current_benchmark_position) then
          thought = "..."
        else
          thought = self.characters[k]:get_thought(self.current_benchmark, self.current_benchmark_position)
        end
        if thought == nil
          or string.len(thought) == 0
          or thought == "..." then
          idea = self.old_idea
        end
        love.graphics.draw(idea, self.characters[k].encounter_x + 25,
        self.characters[k].encounter_y - 10, 0, 1, 1, 0, 0)
      end
  end

  -- Render Stress level over each character
  for k,v in pairs(self.characters) do
    local stress_num_color = {255,255,128}
    love.graphics.draw(self.stress_meters[self.characters[k].stress + 1],
      self.characters[k].encounter_x + 100, self.characters[k].encounter_y + 80, 0, 1, 1, 0, 0)
  end

    -- render trust meter
    love.graphics.draw(self.trust_bar, math.floor(swidth * .6), math.floor(sheight * .25))
    love.graphics.draw(self.trust_slider, math.floor(swidth * .8) + (self.enemy.trust * -4.7), math.floor(sheight * .26))
    -- render thought bubble
    if self.state == STATE_ENCOUNTER_WAIT_FOR_INPUT
    and string.len(self.current_character_thought) > 0 then
      love.graphics.print({{255, 255, 128}, "THOUGHT: " .. self.current_character_thought},
        85, math.floor(sheight * .25))
    end
  else
    -- Translate world so that player is always centred
    local tx = math.floor(self.world_character.x - (swidth / 2) )
    local ty = math.floor(self.world_character.y - (sheight / 2) )
    love.graphics.translate(-tx, -ty)
    self.map:draw(-tx, -ty, scale_screen_width, scale_screen_height)

    if self.did_move then
      self.world_character.animation[self.world_character.current_animation]:draw(
        self.world_character.animation.image, self.world_character.x, self.world_character.y)
    else
      -- render idle version of cur animation
      self.world_character.animation[self.world_character.current_animation .. "_idle"]:draw(
        self.world_character.animation.image, self.world_character.x, self.world_character.y)
    end
    if self.enemy.image_world and
       not (self.enemy.image_world == "deleted") then
        love.graphics.draw(self.enemy.image_world, self.enemy.x, self.enemy.y, 0, 1, 1, 0, 0)
    end
    --draw visual effect
    if self.visual_fx then
      love.graphics.draw(self.visual_fx, tx, ty, 0, 1, 1, 0, 0)
    end
    if self.showing_text_in_world then
      love.graphics.translate(tx, ty)
       --render text to screen
      local string_to_render = self.current_text
      string_to_render = string.sub(self.current_text, 0, self.current_text_to_display_idx)
      if not (self.current_text == "") then
        self.prev_text = string_to_render
      end
      -- render textbox blnk
        love.graphics.draw(self.text_box_blank, math.floor(swidth  * .14), math.floor(sheight * .7), 0, 1, 1, 0, 0)
        love.graphics.print({{255,255,128}, self.prev_text}, math.floor(swidth * .18), math.floor(sheight * .73))
      -- render 'next' modals
      if self.state == STATE_GET_NEXT_TEXT
      or (self.current_text_to_display_idx == string.len(self.current_text)) then
        love.graphics.draw(self.continue, math.floor(swidth * .83), math.floor(sheight * .9), 0, 1, 1, 0, 0)
      end
      love.graphics.translate(-tx, -ty)
    end
    if self.is_fading_to_map or self.is_fading_to_map_from_campfire then
      love.graphics.translate(tx, ty)
      love.graphics.draw(fade_images[fade_out_index], 0, 0)
      love.graphics.translate(-tx, -ty)
      return
    end      
  end
  if self.is_fading_to_encounter or self.is_fading_to_campfire or self.is_fading_to_map_from_campfire then
      love.graphics.draw(fade_images[fade_out_index], 0, 0)
  end
end

function GameState:initialize_map(map, coords)
  self.enemy = {}
  self.doors = {}
  self.objects = {}
  self.map = self.level_manager:get_level(map)
  local world = bump.newWorld(32)
  self.map:bump_init(world)
  self.world = world
  if (string.find(map, 'tutorial_')) then
    self.visual_fx = love.graphics.newImage('data/vignette.png')
  else
    self.visual_fx = nil
  end
  if coords then
    self.world_character.x = tonumber(coords.x)
    self.world_character.y = tonumber(coords.y)
  end

  for k, object in pairs(self.map.objects) do
    if object.name == "character" and not coords then
      self.world_character.x = object.x
      self.world_character.y = object.y
    end
    if object.name == "enemy" then
      self.enemy = Enemy:new(love.graphics.newImage('data/dungeon_graadiabs.png'),
                        love.graphics.newImage('data/battle_graadiabs.png'),
                        love.graphics.newImage('data/textbox_graadiabs.png'))
      self.enemy.x = object.x
      self.enemy.y = object.y
    end
    if object.name == 'door' then
      coords = {}
      coords.x = object.x
      coords.y = object.y
      target = {}
      target.x = object.properties.target_x
      target.y = object.properties.target_y
      coords.target = target
      self.doors[coords] = object.type
    end
    if object.name == 'barrel' then
      table.insert(self.objects, Object:new(object.x, object.y, "It's a sturdy old mining barrel. There is a single copper piece on the lid, covered in mold. Picking that up doesn't seem worth it."))
    end
    if object.name == 'pickaxe' then
      table.insert(self.objects, Object:new(object.x, object.y, "The classic iron pickaxe. It appears that its previous owner abandoned it in a hurry. Perhaps they only needed it to obtain materials to create a better pickaxe."))
    end
    if object.name == 'crate' then
      table.insert(self.objects, Object:new(object.x, object.y, "It doesn't seem like it's ever been opened. Knocking on it produces a hollow sound. Maybe it was just used as decoration, and never actually held anything."))
    end
    if object.name == 'tnt_box' then
      table.insert(self.objects, Object:new(object.x, object.y, "Explosives, for when regular mining just isn't dangerous enough. A close inspection reveals a small buildup of something crystalline on the wrappers. Perhaps someone less sane would see that as an opportunity, but you are not that person."))
    end
    if object.name == 'minecart_empty' then
      table.insert(self.objects, Object:new(object.x, object.y, "It seems to be made of ancient, well-rusted iron. All but one of its wheels have fused to their housing."))
    end
    if object.name == 'minecart_grey' then
      table.insert(self.objects, Object:new(object.x, object.y, "It's almost completely full of gravel. It appears that some genius overfilled it and then couldn't get it to move because it was too heavy."))
      end
    if object.name == 'minecart_brown' then
      table.insert(self.objects, Object:new(object.x, object.y, "It appears that whoever has already explored this place decided that this pile of rocks wasn't worth looting, or even taking the time to walk all the way up to it and inspect it. And yet here you are. Go figure."))
    end
    if object.name == 'door_board' then
      table.insert(self.objects, Object:new(object.x, object.y, "Seems like it was boarded up long ago. Looking through the barrier, you can tell that the shaft beyond has caved in. Never have you been more certain that you cannot explore an area."))
    end
    if object.name == 'lamppost' then
      table.insert(self.objects, Object:new(object.x, object.y, "Sheera declares that this lamppost is arcane in nature. According to her, it's 'beginner's work,' but she's never made anything like it before, so maybe she's not being entirely honest."))
    end
    if object.name == 'open_chest' then
      table.insert(self.objects, Object:new(object.x, object.y, "Whoever looted this chest beforehand seemed so excited about its contents that they also stole its lid. Perhaps they had a chest already, but needed a lid."))
    end
    if object.name == 'open_chest_deb' then
      table.insert(self.objects, Object:new(object.x, object.y, "The lock on this chest is actually still intact, but a steel lock can only do so much to protect a wooden chest from someone with an axe and enough determination."))
    end
  end
end

function GameState:reset_character_encounter_positions()
  local scale_screen_width =  love.graphics.getWidth() / 640
  local scale_screen_height = love.graphics.getHeight() / 480
  local swidth = love.graphics.getWidth() / scale_screen_width 
  local sheight = love.graphics.getHeight() / scale_screen_height

  self.characters[1].encounter_x = swidth * .05 + 96
  self.characters[1].encounter_y = sheight * .35

  self.characters[2].encounter_x = swidth * .05 + 48
  self.characters[2].encounter_y = sheight * .5

  self.characters[3].encounter_x = swidth * .05
  self.characters[3].encounter_y = sheight * .65

end

function GameState:initialize_characters(animation)
  local scale_screen_width =  love.graphics.getWidth() / 640
  local scale_screen_height = love.graphics.getHeight() / 480
  local swidth = love.graphics.getWidth() / scale_screen_width 
  local sheight = love.graphics.getHeight() / scale_screen_height

  self.world_character = Character:new(love.graphics.newImage('data/battle_graadiabs.png'),
    nil,
    screen_width,
    screen_height,
    nil,
    nil)
  self.world_character.animation = animation
  -- start by looking 'down'
  self.world_character.current_animation = "down"

  bermund = Character:new(nil,
    love.graphics.newImage('data/battle_bermund.png'),
    love.graphics.newImage('data/textbox_bermund.png'),
    screen_width,
    screen_height,
    swidth * .05 + 96,
    sheight * .35)
    bermund.full_name = "Berimund Dean, Half-Orc Thief"
    bermund.intro = "Berimund grew up an orphan working in a blacksmith's shop, and he fancied himself an actor. He tried out different accents on each customer, and reveled in their reactions. Berimund generally enjoyed his work-he was good at convincing customers that they deserved to buy the highest quality goods. However, the shop burned down three years into his employment, and he was only able to rescue a small set of throwing knives from the blaze. Berimund tried his hand at the town's theatre, but he could never land a role. When a year had passed after the shop burned down, Berimund found himself completely out of savings, with no prospect of a job, and no remaining family to turn to. He finally unwrapped the set of knives that he'd saved for a year, still pristine. He briefly considered selling them, but found that they were much better suited for cutting purses instead."

    bermund.benchmarks =
    {
      {
        {
          text = "*throwing himself to his knees* Our sincerest and humblest apologies, my lord! My foolish companions and I had no idea that we were in the presence of such grandeur!",
          effect = -3,
          thought = "Apologize, flatter"
        },
        {
          text = "Please, your Tallness, spare us our miserable lives! We are not worthy of such... lordly brilliance!",
          effect = -3,
          thought = "Spare us, great one!"
        }
      },
      {
        nil,
        {
          text = "My lord, please! If thou were so generous as to grant us thy mercy, we would gladly spread word throughout the land of how we were so mercifully spared by the honorable King Graadiabs, the Gigantic!",
          effect = 3,
          thought = "We can spread word of his glory"
        }
      },
      {
        {
          text = "O, great King Graadiabs! As much of an honor as it would be to fill your noble stomach, we can instead reward you with fame! Allow my companions and I to leave your chamber, and we will gladly sing your praises in every land we travel! We have ventured quite far and plan to journey farther, so please, allow us to sing praises of your legacy throughout the land!",
          effect = 10,
          thought = "We can sing his praise as we travel"
        }
      }
    }

    bermund.campfire =
    {
      "And they said I could never make it in the theatre.",
      nil,
      "You wound me! We survived, didn't we?",
      nil,
      "So, what's our next daring adventure?",
      "Have you ladies heard about the new lord of the realm? Sounds like a real piece of work. Maybe there's profit to be had in... inconveniencing him.",
      nil,
      nil,
      "I mean, we're not seriously considering taking this guy on, are we? We're just three assholes." ,
      nil,
      nil,
      nil,
      "All right, he's definitely the worst and we're doing something about it.",
      nil,
      "Something."

    }
    bermund.campfire_image = love.graphics.newImage('data/campfire_bermund.png')

  bermund.stressed_move =
  {
    text = "Please, my lord, tallest of the short ones! Oh, shit..."
  }
  bermund.campfire_x = bermund.encounter_x + 30
  bermund.campfire_y = bermund.encounter_y

  sheera = Character:new(nil,
  love.graphics.newImage('data/battle_sheera.png'),
  love.graphics.newImage('data/textbox_sheera.png'),
  screen_width,
  screen_height,
  swidth * .05 + 48,
  sheight * .5)
  sheera.full_name = "Sheera Torfaren, Elven Mage"
  sheera.intro = "Born into money, Sheera has never wanted for much. She began studying magic when she was just a little girl. She had several older siblings, so her parents were very comfortable sending her off to a magic academy, sleeping well with the knowledge that their aristocratic legacy was safe in their older offspring. Sheera spent almost ten years studying the intricacies of arcane magic, and when she finally returned to her family, they were... unimpressed. She was so caught up in her own studies and what she would be able to accomplish that she had never considered how little her family had really thought about her during her absence. She tried to fit back in with an already dysfunctional group of people that she hadn't spoken with in ten years, and simply couldn't fit. Sheera then decided that she would find herself a new family: one who could appreciate her dedication to magic."
  sheera.benchmarks =
    {
      {
        {
          text = "Our apologies, your... er... majesty. We didn't mean to intrude. We are seekers of adventure, and we have no desire to clash with you.",
          effect = 2,
          thought = "Apologize, we have no quarrel"
        },
        {
          text = "I believe that it would be the best option for everyone if we were all to peacefully go our separate ways.",
          effect = -2,
          thought = "Best if we leave peacefully"
        }
      },
      {
        {
          text = "Well, your grace, as much as I do respect that... opinion... my friends and I are seasoned adventurers.",
          effect = -2,
          thought = "We are adventurers"
        },
        {
          text = "We're not going to just sit and peacefully allow ourselves to be eaten. I must confess, I was always curious about precisely how resistant goblins are to fire.",
          effect = -3,
          thought = "We won't just sit idle"
        }
      },
      {
        {
          text = "Well, consider how a battle between our groups would transpire. You'll likely win in the end with sheer numbers, but I'd wager that we'll take a significant amount of your 'loyal subjects' with us. Now, is that a gamble you're willing to take, or are you going to make the smart decision and let us go in favor of other, weaker prey?",
          effect = 10,
          thought = "We'll take some of them with us if they fight"
        }
      }
    }
    sheera.stressed_move =
    {
      text = "All right, I've had it. I'm done arguing with a dirty goblin. Let us leave or we'll kill you all!",
    }

    sheera.campfire =
    {
        nil,
        "You probably couldn't, unless the audience were all goblins.",
        nil,
        "That's fair, I suppose.",
        "We didn't get much in terms of treasure, though. Seems like every crypt, dungeon, and ruin is occupied these days. If we're not careful, we might be out of a job. ",
        nil,
        "Easier said than done. He's a powerful political figure, he won't just let us kindly insert a knife into his chest." ,
        "Perhaps we could start small...",
        nil,
        "Did you hear that he promotes his soldiers to generals based solely on their reputation for cruelty?",
        "Or that his second-in-command actively burns arcane practitioners at the stake, and that he just doesn't care?",
        "Or that he's executed his entire court twice over already?",
        nil,
        "...What CAN we do, though?",
        nil
    }
    sheera.campfire_image = love.graphics.newImage('data/campfire_sheera.png')
    sheera.campfire_x = sheera.encounter_x * 4.5
    sheera.campfire_y = sheera.encounter_y

    holly = Character:new(nil,
    love.graphics.newImage('data/battle_holly.png'),
    love.graphics.newImage('data/textbox_holly.png'),
    screen_width,
    screen_height,
    swidth * .05,
    sheight * .65)
    holly.full_name = "Holly Wallace, Human Warrior"
    holly.intro = "Holly's origins are simple. Born on a small, family-owned farm, Holly grew up around folk with a solid work ethic and small desires. She wasted little and wanted for nothing, until she reached around eighteen years of age, when her farm was attacked by monsters. Her father had always had an old sword, \"just in case.\" Amidst the cacophony of terrified barn animals and ravenous, bloodthirsty monsters, Holly wrapped her hand around the hilt of that rusty, cracked old longsword, and defended her farm. Once the monsters were chased off, she resolved to take her newfound strength to where people needed it, especially lowly farmers or the poor, and she's been on that noble quest ever since. "
    holly.benchmarks =
    {
      {
        {
          text = "Oh, um... I'm sorry... sir. My friends and I were just exploring these caves, looking for treasure. We never meant to trespass",
          effect = -1,
          thought = "Apologize, just exploring"
        },
        {
          text = "If you don't mind, we'll be on our way! Sorry to disturb you.",
          effect = -1,
          thought = "Sorry to bother you"
        }
      },
      {
        {
          text = "Try it, short stuff",
          effect = -3,
          thought = "Try me"
        },
        {
          text = "We're not just gonna roll over and die. There may be a lot of you, but how many humans have you fought recently? We put up much more of a fight than the meat on us is worth.",
          effect = 3,
          thought = "A fight won't go the way you expect"
        }
      },
      { 
        {
          text = "Well... we'd really appreciate it. Can't you spare us out of the goodness of your heart?",
          effect = -2,
          thought = "It'd be very nice of you"
        }
      }
    }
    holly.stressed_move =
    {
      text = "You monsters are all the same. You want me in your stomach? Fine, but my sword is going there first.",
    }

    holly.campfire =
    {
        nil,
        "I mean, I'm inclined to agree. There's overacting and then there's you.",
        "Still though, I guess we're still alive, so... thanks.",
        nil,
        "So, what's next?",
        "Every farmer and townsperson I talk to is upset with all the political nonsense going on these days. We're three strong, brave heroes. Maybe we could do some good!",
        nil,
        "No, of course not. Then someone else would've done it.",
        nil,
        "Did you hear about how he demands from farmers twice the food they can produce?",
        "Or that he constantly declares that all Orcs are criminals?",
        "Or that he told townsfolk who were asking for protection from monsters that they should just buy swords themselves?",
        nil,
        nil,
        "Something."
    }
    holly.campfire_image = love.graphics.newImage('data/campfire_holly.png')
    holly.campfire_x = holly.encounter_x + 60
    holly.campfire_y = holly.encounter_y - 40
    self.characters[1] = bermund
    self.characters[2] = sheera
    self.characters[3] = holly
end

-- return this class template
return GameState
