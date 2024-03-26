require("info_on_screen")


function start_game()
    function checkCollisionRectRect(rect1_x, rect1_y, rect1_width, rect1_height, rect2_x, rect2_y, rect2_width,
                                    rect2_height)
        return rect1_x < rect2_x + rect2_width and
            rect1_x + rect1_width > rect2_x and
            rect1_y < rect2_y + rect2_height and
            rect1_y + rect1_height > rect2_y
    end

    function movePlayer1(dt)
        if bot == 1 then
            if ball.y < player.y then
                player.y = math.max(player.y - player.speed * dt, 20)
            elseif ball.y > player.y then
                player.y = math.min(player.y + player.speed * dt, love.graphics.getHeight() - 110)
            end
        end
    end

    function movePlayer2(dt)
        if ball.y < player2.y then
            player2.y = math.max(player2.y - player2.speed * dt, 20)
        elseif ball.y > player2.y then
            player2.y = math.min(player2.y + player2.speed * dt, love.graphics.getHeight() - 110)
        end
    end

    function resetBall()
        ball.x = 400
        ball.y = 300
        ball.speed_x = 200
        ball.speed_y = 200
        ball.width = 10
        ball.height = 10
        love.timer.sleep(0.1)
    end

    function check_score()
        if ball.x < 20 then
            success:play()
            player.score = player.score + 1
            resetBall()
        elseif ball.x > love.graphics.getWidth() - ball.width - 20 then
            success:play()
            player2.score = player2.score + 1
            resetBall()
        end
    end

    function love.update(dt)
        movePlayer1(dt)
        if love.keyboard.isDown("w") then
            player2.y = math.max(player2.y - player2.speed * dt, 20)
        elseif love.keyboard.isDown("s") then
            player2.y = math.min(player2.y + player2.speed * dt, love.graphics.getHeight() - 110)
        end

        if love.keyboard.isDown("escape") then
            print("Goodbye!")
            love.event.quit()
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
            player.y = math.min(player.y + player.speed * dt, love.graphics.getHeight() - 110)
        end

        if checkCollisionRectRect(player.x, player.y, player.width, player.height, ball.x, ball.y, ball.width, ball.height) or
            checkCollisionRectRect(player2.x, player2.y, player2.width, player2.height, ball.x, ball.y, ball.width, ball.height) then
            pong:play()
            input = 1
            ball.speed_x = -ball.speed_x * 1.1
            ball.color = { love.math.colorFromBytes(love.math.random(0, 255), love.math.random(0, 255),
                love.math.random(0, 255)) }
        end

        if input == 1 and bigger == 1 then
            if ball.width and ball.height < 60 then
                ball.width = ball.width * 1.1
                ball.height = ball.height * 1.1
            end
            input = 0
        end

        if ball.y < 20 or ball.y > love.graphics.getHeight() - ball.height - 30 then
            pong:play()
            ball.speed_y = -ball.speed_y
        end

        ball.x = ball.x + ball.speed_x * dt
        ball.y = ball.y + ball.speed_y * dt
        check_score()
    end

    function love.draw()
        if disco == 1 then
            love.graphics.setBackgroundColor({ love.math.colorFromBytes(love.math.random(0, 255),
                love.math.random(0, 255), love.math.random(0, 255)) })
        else
            love.graphics.setBackgroundColor(love.math.colorFromBytes(0, 0, 0))
        end
        love.graphics.setColor(love.math.colorFromBytes(255, 255, 255))
        love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
        love.graphics.rectangle("fill", player2.x, player2.y, player2.width, player2.height)
        love.graphics.rectangle("line", 50, 20, 700, 550)
        love.graphics.rectangle("line", 400, 20, 1, 550)
        drawscore()
        drawfps()
        love.graphics.setColor(ball.color)
        love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.height)
    end
end
