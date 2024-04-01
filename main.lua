WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- Initialize the game and its state
function love.load()
  love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })
end

-- Draw the game state to the screen, called after update
function love.draw()
  love.graphics.printf(
    'Hello Pong!', 
    0, 
    WINDOW_HEIGHT / 2 - 6,
    WINDOW_WIDTH, 
    'center' 
  )
end

-- Update the game state, called each frame
-- function love.update(dt)
  
-- end