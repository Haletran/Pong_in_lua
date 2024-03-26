require("game/game")

menus = { { "One Player", "Two Player", "Quit" } }

function love.load()
    current_menu = 1
    current_item = 1
    player = {
        x = 740,
        y = 260,
        width = 10,
        height = 80,
        speed = 500,
        score = 0
    }
    player2 = {
        x = 50,
        y = 230,
        width = 10,
        height = 80,
        speed = 500,
        score = 0
    }
    ball = {
        x = 390,
        y = 290,
        width = 10,
        height = 10,
        speed_x = 200,
        speed_y = 200,
        color = { love.math.colorFromBytes(love.math.random(0, 255), love.math.random(0, 255), love.math.random(0, 255)) }
    }
    pong = love.audio.newSource("sound/ping.mp3", "static")
    success = love.audio.newSource("sound/score.mp3", "static")
    fps = love.timer.getFPS()
    bot = 0
    disco = 0
    input = 0
    bigger = 0
end

function draw_title()
    love.graphics.print("Pong", 400, 50)
end

function love.draw()
    love.graphics.setColor(255, 255, 255)
    draw_title()
    for i, v in ipairs(menus[current_menu]) do
        if i == current_item then
            love.graphics.setColor(255, 0, 0)
        else
            love.graphics.setColor(255, 255, 255)
        end
        love.graphics.print(v, 100, 100 + i * 20)
    end
end

function menu_choose(current_item)
    if current_item == 1 then
        bot = 1
        start_game()
    elseif current_item == 2 then
        start_game()
    elseif current_item == 3 then
        love.event.quit()
    end
end

function love.update(dt)
    if love.keyboard.isDown("w") then
        current_item = current_item - 1
        if current_item < 1 then
            current_item = #menus[current_menu]
        end
        love.timer.sleep(0.2)
    elseif love.keyboard.isDown("s") then
        current_item = current_item + 1
        if current_item > #menus[current_menu] then
            current_item = 1
        end
        love.timer.sleep(0.2)
    else
        if love.keyboard.isDown("return") then
            menu_choose(current_item)
        end
    end
end
