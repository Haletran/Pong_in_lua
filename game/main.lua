function love.load()
    player = {
        x = 730,
        y = 500,
        size = 25,
        speed = 400,
        score = 0
    }
    player2 = {
        x2 = 50,
        y2 = 100,
        size = 25,
        speed = 400,
        score = 0
    }
    ball = {
        x = 400,
        y = 300,
        size = 10,
        speed = 200,
    }
end

function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
           x2 < x1 + w1 and
           y1 < y2 + h2 and
           y2 < y1 + h1
end

function movePlayer1(dt)
    if ball.y < player.y then
        player.y = player.y - player.speed * dt
    elseif ball.y > player.y then
        player.y = player.y + player.speed * dt
    end
end

function check_score()
    if ball.x < 0 then 
        player.score  = player.score + 1
        ball.x = 400
        ball.y = 300
    elseif ball.x > 800 then
        player2.score = player2.score + 1
        ball.x = 400
        ball.y = 300
    end
end


function love.update(dt)
    --movePlayer1(dt)

    if love.keyboard.isDown("w") then
        player2.y2 = math.max(player2.y2 - player2.speed * dt, 20)
    elseif love.keyboard.isDown("s") then
        player2.y2 = math.min(player2.y2 + player2.speed * dt, love.graphics.getHeight() - 80)
    end

    if love.keyboard.isDown("up") then
        player.y = math.max(player.y - player.speed * dt, 20)
    elseif love.keyboard.isDown("down") then
        player.y = math.min(player.y + player.speed * dt, love.graphics.getHeight() - 80)
    end

    if checkCollision(ball.x, ball.y, ball.size, ball.size, player.x, player.y, 20, 50) or
       checkCollision(ball.x, ball.y, ball.size, ball.size, player2.x2, player2.y2, 20, 50) then
        ball.speed = -ball.speed
    end
    ball.x = ball.x + ball.speed * dt
    check_score()
end

function love.draw()
    love.graphics.rectangle("fill", player.x, player.y, 20, 50)
    love.graphics.rectangle("fill", player2.x2, player2.y2, 20, 50)
    love.graphics.rectangle("line", 50, 20, 700, 550)
    love.graphics.circle("fill", ball.x, ball.y, ball.size)
    love.graphics.printf(tostring(player2.score), 350, 40, 100, "left")
    love.graphics.printf(tostring(player.score), 350, 40, 100, "right")
end


