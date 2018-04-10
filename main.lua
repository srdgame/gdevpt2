local GameState = require('game_state')
local pprint = require('deps/pprint')
local anim8 = require('deps/anim8')

local game_state = {}
local map = {}
-- Configuration
function love.conf(t)
  t.screen = nil
end

function love.load()
  local screen_width = 1600
  local screen_height = 900
  love.window.setMode(screen_width, screen_height)
  game_state = GameState:new(screen_width, screen_height)

  -- create walking animations
  local image = love.graphics.newImage('data/spritesheet_holly.png')
  local g32 = anim8.newGrid(32,32, image:getWidth(),image:getHeight(),   0,0,     0)
  local g32l = anim8.newGrid(32,32, image:getWidth(),image:getHeight(),   0,96,     0)
  local animations = {
    image = image,
    down = anim8.newAnimation(g32('1-3', 1, '3-1', 1), 0.1),
    down_idle = anim8.newAnimation(g32(2, 1), 0.1),
    up = anim8.newAnimation(g32('1-3', 2, '3-1', 2), 0.1),
    up_idle = anim8.newAnimation(g32(2, 2), 0.1),
    right = anim8.newAnimation(g32('1-3', 3, '3-1', 3), 0.1),
    right_idle = anim8.newAnimation(g32(2, 3), 0.1),
    left = anim8.newAnimation(g32l('1-3', 1, '3-1', 1), 0.1),
    left_idle = anim8.newAnimation(g32l(2, 1), 0.1)
  }

  game_state:initialize_characters(animations)
  game_state:initialize_map('tutorial_01')
end

-- Update Game State
function love.update(dt)
  game_state:update(dt)
end

-- Render
function love.draw()
  game_state:draw()
end
