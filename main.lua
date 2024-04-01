push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Initialize the game and its state
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- making the virtual resolution to have a retro look
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

-- Keyboard handling
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

-- Draw the game state to the screen, called after update
function love.draw()
    -- begin the virtual resolution drawing
    push:apply('start')

    love.graphics.printf('Hello Pong!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

    -- end the virtual resolution drawing
    push:apply('end')
end

-- Update the game state, called each frame
-- function love.update(dt)

-- end
