push = require 'push'

Class = require 'class'

require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- paddle speed; in update we multiply by the delta time
PADDLE_SPEED = 200

-- Initialize the game and its state
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Pong')

    math.randomseed(os.time())

    -- Set the fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
    scoreFont = love.graphics.newFont('font.ttf', 32)

    -- Set the active font to smallFont
    love.graphics.setFont(smallFont)

    -- making the virtual resolution to have a retro look
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    -- init paddles
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)

    -- init
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    -- game state variable used to transition between different parts of the game
    gameState = 'start'
end

-- Update the game state, called each frame
function love.update(dt)
    if gameState == 'play' then
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + ball.width + 1 -- +1 offset for collision

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end
        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - ball.width

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
        end

        -- upper and lower bound collision
        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy
        end

        if ball.y >= VIRTUAL_HEIGHT - ball.width then
            ball.y = VIRTUAL_HEIGHT - ball.width
            ball.dy = -ball.dy
        end
    end
    -- player 1 movement
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else
        player1.dy = 0
    end

    -- player 2 movement
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end

    -- update ball position
    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

-- Keyboard handling
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ball:reset()
        end
    end
end

-- Draw the game state to the screen, called after update
function love.draw()
    -- begin the virtual resolution drawing
    push:apply('start')

    -- clear the screen with a specific color
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

    -- draw welcome text toward the top of the screen
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    player1:render()
    player2:render()

    ball:render()

    displayFPS()
    -- end the virtual resolution drawing
    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
