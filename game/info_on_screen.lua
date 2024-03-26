function drawfps()
    love.graphics.setNewFont(10)
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 50, 2)
    love.graphics.printf("X : " .. ball.x / 2, 100, 2, 200)
    love.graphics.printf("Y : " .. ball.y / 2, 200, 2, 150)
end

function drawscore()
    love.graphics.setNewFont(30)
    love.graphics.printf(tostring(player2.score), 350, 40, 100, "left")
    love.graphics.printf(tostring(player.score), 350, 40, 100, "right")
end
