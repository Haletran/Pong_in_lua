function drawfps()
    love.graphics.setNewFont(10)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 50, 2)
    love.graphics.printf("X : "..ball.x / 2, 100, 2, 200)
    love.graphics.printf("Y : "..ball.y / 2, 200, 2, 150)
end