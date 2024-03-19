require("menu")

function love.load()
    player = {
        x = 730,
        y = 500,
        size = 25,
        speed = 400,
        score = 0
    }
    player2 = {
        x = 50,
        y = 100,
        size = 25,
        speed = 400,
        score = 0
    }
    ball = {
        x = 400,
        y = 300,
        size = 10,
        speed_x = 300,
        speed_y = 300,
    }
    pong = love.audio.newSource("sound/ping.mp3", "static")
    success = love.audio.newSource("sound/score.mp3", "static")
    fps = love.timer.getFPS()
    bot = 1
end

function checkCollisionRectCircle(rx, ry, rw, rh, cx, cy, cr)
    local closestX = clamp(cx, rx, rx + rw)
    local closestY = clamp(cy, ry, ry + rh)
    local distanceX = cx - closestX
    local distanceY = cy - closestY
    return (distanceX * distanceX + distanceY * distanceY) <= (cr * cr)
end

function clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
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

function check_score()
    if ball.x < 60 then 
        success:play()
        player.score  = player.score + 1
        ball.x = 400
        ball.y = 300
        speed_x = 1
        speed_y = 1
    elseif ball.x > 800 then
        success:play()
        player2.score = player2.score + 1
        ball.x = 400
        ball.y = 300
        speed_y = 1
        speed_x = 1
    end
end


function love.update(dt)
    movePlayer1(dt)
    --movePlayer2(dt)
    if love.keyboard.isDown("w") then
        player2.y = math.max(player2.y - player2.speed * dt, 20)
    elseif love.keyboard.isDown("s") then
        player2.y = math.min(player2.y + player2.speed * dt, love.graphics.getHeight() - 80)
    end

    if love.keyboard.isDown("r") then
        player.score = 0
        player2.score = 0
    end

    if love.keyboard.isDown("up") then
        player.y = math.max(player.y - player.speed * dt, 20)
    elseif love.keyboard.isDown("down") then
        player.y = math.min(player.y + player.speed * dt, love.graphics.getHeight() - 80)
    end

    if ball.y < 20 or ball.y > love.graphics.getHeight() - ball.size - 30 then
        pong:play()
        ball.speed_y = -ball.speed_y - 1
    end

    if checkCollisionRectCircle(player.x, player.y, 20, 50, ball.x + ball.size / 2, ball.y + ball.size / 2, ball.size / 2) or
       checkCollisionRectCircle(player2.x, player2.y, 20, 50, ball.x + ball.size / 2, ball.y + ball.size / 2, ball.size / 2) then
        pong:play()
        ball.speed_x = -ball.speed_x - 1
    end

    ball.x = ball.x + ball.speed_x * dt
    ball.y = ball.y + ball.speed_y * dt
    check_score()
end



function love.draw()
    love.graphics.rectangle("fill", player.x, player.y, 20, 50)
    love.graphics.rectangle("fill", player2.x, player2.y, 20, 50)
    love.graphics.rectangle("line", 50, 20, 700, 550)
    love.graphics.circle("fill", ball.x, ball.y, ball.size)
    love.graphics.setNewFont(30)
    love.graphics.printf(tostring(player2.score), 350, 40, 100, "left")
    love.graphics.printf("|", 350, 40, 100, "center")
    love.graphics.printf(tostring(player.score), 350, 40, 100, "right")
    drawfps()
end



