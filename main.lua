push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Initialize the game and its state
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Set the font
    smallFont = love.graphics.newFont('font.ttf', 8)
    love.graphics.setFont(smallFont)

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

    -- clear the screen with a specific color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    -- draw welcome text toward the top of the screen
    love.graphics.printf('Hello Pong!', 0, 20, VIRTUAL_WIDTH, 'center')

    -- draw the paddles
    love.graphics.rectangle('fill', 10, 30, 5, 20)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 50, 5, 20)
    -- draw the ball
    love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- end the virtual resolution drawing
    push:apply('end')
end

-- Update the game state, called each frame
-- function love.update(dt)

-- end
