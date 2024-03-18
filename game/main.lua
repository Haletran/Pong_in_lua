function love.load()
    player = {
        x = 730,
        y = 500,
        size = 25
    }
    player2 = {
        x2 = 50,
        y2 = 100,
        size = 25
    }
end

function love.update(dt)
    if love.keyboard.isDown("up") then
        player.y = player.y - 200 * dt
    elseif love.keyboard.isDown("down") then
        player.y = player.y + 200 * dt
    elseif love.keyboard.isDown("w") then
        player2.y2 = player2.y2 - 200 * dt
    elseif love.keyboard.isDown("s") then
        player2.y2 = player2.y2 + 200 * dt
    end
end

function love.draw()
    love.graphics.rectangle("fill", player.x, player.y, 20, 50)
    love.graphics.rectangle("fill", player2.x2, player2.y2, 20, 50)
    love.graphics.rectangle("line", 50, 10, 700, 550)
end
