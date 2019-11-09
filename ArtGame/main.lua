function love.load()
    x = 100
    y = 20
    w = 60
    h = 60
    val = 0
    change = 0
    width, height = love.graphics.getDimensions()
    --whale1 = love.graphics.newImage("whaleT.png")
    --whale2 = love.graphics.newImage("whale2T.png")
    land1 = love.graphics.newImage("Land1.png")
    --whale = whale1
    love.graphics.setBackgroundColor(1,1,1)
    GreenS = love.graphics.newImage("GreenS.png")
    WhiteS = love.graphics.newImage("WhiteS.png")
    GreyS = love.graphics.newImage("GreyS.png")
    RedS = love.graphics.newImage("RedS.png")
    BrownS = love.graphics.newImage("BrownS.png")
    --love.graphics.setColor(0,0,0)
    startI = 0
    moreRight = 0
    moreLeft = 0
    furthestRight = 50
   
    matrix = {}
    for i=0,furthestRight do
        matrix[i] = {}
        for j=0,10 do
            matrix[i][j] = WhiteS
            if j == 9 or j == 10 then
                matrix[i][j] = GreenS
                if i == furthestRight then
                    matrix[i][j] = RedS
                end
                if i == 0 then
                    matrix[i][j] = BrownS
                end
            end
            if j == 8 and i == 3 then
                matrix[i][j] = GreyS
            end
        end
    end


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

        if startI > 0 and moreRight == 0 then
            startI = startI - 1
            matrix[3+startI][8] = GreyS
            matrix[3+startI+1][8] = WhiteS
        end
        if moreRight > 0 then
            moreRight = moreRight - 1
            if matrix[furthestRight][8] ~= GreyS then
                matrix[3+startI+moreRight][8] = GreyS
                matrix[3+startI+moreRight+1][8] = WhiteS
            end
            if matrix[furthestRight][8] == GreyS then
                matrix[furthestRight-1][8] = GreyS
                matrix[furthestRight][8] = WhiteS
            end
        end
        if startI == 0 and matrix[0][8] ~= GreyS then
            matrix[3+moreLeft][8] = GreyS
            matrix[3+moreLeft+1][8] = WhiteS
            moreLeft = moreLeft - 1
        end
    end

    if love.keyboard.isDown("right") then
        --x = x + 1
        --whale = whale1
        --love.graphics.print(x,50,50)

        if startI < furthestRight - 10 and moreLeft == 0 then
            startI = startI + 1
            matrix[3+startI][8] = GreyS
            matrix[3+startI-1][8] = WhiteS
        end
        if startI >= furthestRight - 10 and matrix[furthestRight][8] ~= GreyS then
            matrix[3+startI+moreRight][8] = GreyS
            matrix[3+startI+moreRight-1][8] = WhiteS
            moreRight = moreRight + 1
        end
        if moreLeft < 0 then
            moreLeft = moreLeft + 1
            if matrix[0][8] ~= GreyS then
                matrix[3+moreLeft][8] = GreyS
                matrix[3+moreLeft-1][8] = WhiteS
            end
            if matrix[0][8] == GreyS then
                matrix[1][8] = GreyS
                matrix[0][8] = WhiteS
            end
        end
    end
end

function love.draw()
    --love.graphics.setColor(0,0.4,0.4)
    love.graphics.setBackgroundColor(.05,1,1)
    love.window.setTitle("TigerHacks 2019")
    
    love.graphics.setColor(0,0,0)
    for d = 0, height, 15 do
        for n = 0, width, 20 do
            --love.graphics.setColor(0,0,0)
            --love.graphics.print("|",n,d)
            --love.graphics.print("__",n+6,d+2)
            if d == 300 then
                if n % 440 == 0 then
                    love.graphics.setColor(1,1,1)
                    love.graphics.draw(land1,n,d)
                end
            end
        end
    end


    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",x,300,50,50)

    --love.window.maximize()
    --love.graphics.print("x",10,10)
    --love.graphics.rectangle("fill",x,y,w,h)
    --love.graphics.draw(whale2,100,100)
    --love.graphics.setColor(0,0.4,0.4)
    love.graphics.print(x,200,200)
    love.graphics.print(change,200,220)
    --love.graphics.draw(whale,50,50)
    love.graphics.print(width,100,100)
    love.graphics.print(height,100,120)
    --love.graphics.draw(land1,200,200)

    love.graphics.setColor(0,0,0)
    for i=startI,startI+10 do
        for j=0,10 do
            love.graphics.setColor(1,1,1)
            love.graphics.draw(matrix[i][j],i*20-(20*startI),j*20)
        end
    end
end