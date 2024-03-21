require("menu")

function love.load()
    player = {
        x = 730,
        y = 500,
        width = 20,
        height = 50,
        speed = 500,
        score = 0
    }
    player2 = {
        x = 50,
        y = 100,
        width = 20,
        height = 50,
        speed = 500,
        score = 0
    }
    ball = {
        x = 390,
        y = 290,
        width = 20,
        height = 20,
        speed_x = 200,
        speed_y = 200,
        color = {love.math.colorFromBytes(love.math.random(0, 255), love.math.random(0, 255), love.math.random(0, 255))}
    }
    pong = love.audio.newSource("sound/ping.mp3", "static")
    success = love.audio.newSource("sound/score.mp3", "static")
    fps = love.timer.getFPS()
    bot = 1
    disco = 0
    input = 0
    
end

function checkCollisionRectRect(rect1_x, rect1_y, rect1_width, rect1_height, rect2_x, rect2_y, rect2_width, rect2_height)
    local dx = rect2_x - (rect1_x + rect1_width)
    local dy = rect2_y - (rect1_y + rect1_height)
    local dw = (rect2_x + rect2_width) - rect1_x
    local dh = (rect2_y + rect2_height) - rect1_y

    return dx <= 0 and dy <= 0 and dw >= 0 and dh >= 0
end

function movePlayer1(dt)
    if bot == 1 then
        if ball.y < player.y then
            player.y = math.max(player.y - player.speed * dt, 20)
        elseif ball.y > player.y then
            player.y = math.min(player.y + player.speed * dt, love.graphics.getHeight() - 80)
        end
    end
end

function movePlayer2(dt)
    if ball.y < player2.y then
        player2.y = math.max(player2.y - player2.speed * dt, 20)
    elseif ball.y > player2.y then
        player2.y = math.min(player2.y + player2.speed * dt, love.graphics.getHeight() - 80)
    end
end

function resetBall()
    ball.x = 400
    ball.y = 300
    ball.speed_x = 200
    ball.speed_y = 200
    love.timer.sleep(0.1)
end

function check_score()
    if ball.x < 40 then
        success:play()
        player.score = player.score + 1
        resetBall()
    elseif ball.x > love.graphics.getWidth() - ball.width - 40 then
        success:play()
        player2.score = player2.score + 1
        resetBall()
    end
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        player2.y = math.max(player2.y - player2.speed * dt, 20)
    elseif love.keyboard.isDown("s") then
        player2.y = math.min(player2.y + player2.speed * dt, love.graphics.getHeight() - 80)
    end

    if love.keyboard.isDown("r") then
        player.score = 0
        player2.score = 0
        disco = 0
    end

    if love.keyboard.isDown("d") then
        disco = 1
    end

    if love.keyboard.isDown("up") then
        player.y = math.max(player.y - player.speed * dt, 20)
    elseif love.keyboard.isDown("down") then
        player.y = math.min(player.y + player.speed * dt, love.graphics.getHeight() - 80)
    end

    if checkCollisionRectRect(player.x, player.y, player.width, player.height, ball.x, ball.y, ball.width, ball.height) or
       checkCollisionRectRect(player2.x, player2.y, player2.width, player2.height, ball.x, ball.y, ball.width, ball.height) then
        pong:play()
        ball.speed_x = -ball.speed_x * 1.1
        ball.color = {love.math.colorFromBytes(love.math.random(0, 255), love.math.random(0, 255), love.math.random(0, 255))}
    end

    if ball.y < 20 or ball.y > love.graphics.getHeight() - ball.height - 31 then
        pong:play()
        ball.speed_y = -ball.speed_y
    end

    ball.x = ball.x + ball.speed_x * dt
    ball.y = ball.y + ball.speed_y * dt
    check_score()
end

function love.draw()
    if disco == 1 then
        love.graphics.setBackgroundColor({love.math.colorFromBytes(love.math.random(0, 255), love.math.random(0, 255), love.math.random(0, 255))})
    else
        love.graphics.setBackgroundColor(love.math.colorFromBytes(0, 0, 0))
    end
    love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
    love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
    love.graphics.rectangle("line", 50, 20, 700, 550)
    love.graphics.rectangle("line", 400, 20, 1, 550)
    love.graphics.setNewFont(30)
    love.graphics.printf(tostring(player2.score), 350, 40, 100, "left")
    love.graphics.printf(tostring(player.score), 350, 40, 100, "right")
    drawfps()
    love.graphics.setColor(ball.color)
    love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
end

