function love.load()
    x = 20
    y = 20
    w = 60
    h = 60
    val = 0
    change = 0
    whale1 = love.graphics.newImage("whaleT.png")
    whale2 = love.graphics.newImage("whale2T.png")
    whale = whale1
    love.graphics.setBackgroundColor(1,1,1)
    love.graphics.setColor(0,0,0)
end

function love.update(dt)
    w = w + 1
    h = h + 1

    if dt < 1/10 then
        love.timer.sleep(1/10 - dt)
    end

    if love.keyboard.isDown("left") then
        x = x - 1
        if val == 0 then
            whale = whale1
            change = 1
        end
        if val == 1 then
            whale = whale2
            change = -1
        end

        val = val + change
        --love.timer.sleep(1)
        --whale = whale2
        --love.timer.sleep(1)
    end
    if love.keyboard.isDown("right") then
        x = x + 1
        --whale = whale1
        --love.graphics.print(x,50,50)
    end
end

function love.draw()
    --love.graphics.setColor(0,0.4,0.4)
    love.graphics.setBackgroundColor(.05,1,1)
    --love.graphics.print("x",10,10)
    --love.graphics.rectangle("fill",x,y,w,h)
    --love.graphics.draw(whale2,100,100)
    --love.graphics.setColor(0,0.4,0.4)
    love.graphics.print(x,200,200)
    love.graphics.print(change,200,220)
    love.graphics.draw(whale,50,50)
    love.graphics.print(tostring(love.timer.getFPS()), 300,300)

end