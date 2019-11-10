--notes
--currently have an "air jump" ability, where the character can jump while falling off a block higher than the ground below
--could leave in or try and remove, will determine later


function love.load()
    x = 100
    y = 20
    w = 60
    h = 60
    val = 0
    change = 0

    width, height = love.graphics.getDimensions()
    land1 = love.graphics.newImage("Land1.png")


    love.graphics.setBackgroundColor(1,1,1)

    testMap = love.graphics.newImage("testMap.png")
    testMapData = love.image.newImageData("testMap.png")
    mapWidth, mapHeight = testMap:getDimensions()
    --mapHeight = 100

    --Grabs the pngs to sue as sprites within the window
    GreenS = love.graphics.newImage("GreenS.png")
    --r = 0.13333333333333  
    --g = 0.69411764705882
    --b = 0.29803921568627

    WhiteS = love.graphics.newImage("WhiteS.png")
    GreyS = love.graphics.newImage("GreyS.png")
    RedS = love.graphics.newImage("RedS.png")
    BrownS = love.graphics.newImage("BrownS.png")
    LightBlueS = love.graphics.newImage("LightBlueS.png")

    --used to move further right and left after the screen stops moving
    moreRight = 0
    moreLeft = 0

    --How far right the matrix goes
    furthestRight = mapWidth-1
    furthestDown = mapHeight-1

    startI = 0 --used to shift the viewing window along the matrix
    startJ = furthestDown - 10

    r,g,b,a = testMapData:getPixel(0,mapHeight-1)

    --position coordinates of the character in the matrix
    xPos = 3
    yPos = furthestDown - 2

    --tracks where in t a jump the character is
    jumpLog = 0
    jumpLogChange = 1
    UpDown = 1
    actuallyJumped = 0
   
    --Creates a matrix that contains the game enviroment
    matrix = {}
    for i=0,furthestRight do
        matrix[i] = {}
        for j=0,furthestDown do
            matrix[i][j] = WhiteS
            if j == furthestDown-1 or j == furthestDown then
                matrix[i][j] = GreenS
                if i == furthestRight then
                    matrix[i][j] = RedS
                end
                if i == 0 then
                    matrix[i][j] = BrownS
                end
            end
            if j == yPos and i == xPos then
                matrix[xPos][yPos] = GreyS
            end
        end
    end

    matrix[3][7] = GreenS
    matrix[7][8] = GreenS
    matrix[0][8] = GreenS
    matrix[7][6] = LightBlueS
end


function love.update(dt)

    --Restrains FPS
    if dt < 1/10 then
        love.timer.sleep(1/10 - dt)
    end

    --moves the character left along the matrix
    if love.keyboard.isDown("left") then
        if startI > 0 and moreRight == 0 and matrix[xPos-1][yPos] ~= GreenS then
            startI = startI - 1
            matrix[xPos][yPos] = WhiteS
            xPos = xPos - 1
            matrix[xPos][yPos] = GreyS
        end
        if moreRight > 0 and matrix[xPos-1][yPos] ~= GreenS then
            moreRight = moreRight - 1
            if matrix[furthestRight][yPos] ~= GreyS and matrix[xPos-1][yPos] ~= GreenS then
                matrix[xPos][yPos] = WhiteS
                xPos = xPos - 1
                matrix[xPos][yPos] = GreyS
            end
            if matrix[furthestRight][yPos] == GreyS and matrix[xPos-1][yPos] ~= GreenS then
                matrix[furthestRight-1][yPos] = GreyS
                matrix[furthestRight][yPos] = WhiteS
                xPos = xPos -1
            end
        end
        if startI == 0 and matrix[0][yPos] ~= GreyS and matrix[xPos-1][yPos] ~= GreenS then
            matrix[xPos][yPos] = WhiteS
            xPos = xPos - 1
            matrix[xPos][yPos] = GreyS
            moreLeft = moreLeft - 1
        end
    end

    --moves the chacter right along the matrix
    if love.keyboard.isDown("right") then
        if startI < furthestRight - 10 and moreLeft == 0 and matrix[xPos+1][yPos] ~= GreenS then
            startI = startI + 1
            matrix[xPos][yPos] = WhiteS
            xPos = xPos + 1
            matrix[xPos][yPos] = GreyS
        end
        if startI >= furthestRight - 10 and matrix[furthestRight][yPos] ~= GreyS and matrix[xPos+1][yPos] ~= GreenS then
            matrix[xPos][yPos] = WhiteS
            xPos = xPos + 1
            matrix[xPos][yPos] = GreyS
            moreRight = moreRight + 1
        end
        if moreLeft < 0 and matrix[xPos+1][yPos] ~= GreenS then
            moreLeft = moreLeft + 1
            if matrix[0][yPos] ~= GreyS and matrix[xPos+1][yPos] ~= GreenS then
                matrix[xPos][yPos] = WhiteS
                xPos = xPos + 1
                matrix[xPos][yPos] = GreyS
            end
            if matrix[0][yPos] == GreyS and matrix[xPos+1][yPos] ~= GreenS then
                matrix[1][yPos] = GreyS
                matrix[0][yPos] = WhiteS
                xPos = xPos + 1
            end
        end
    end

    --moves the character up
    if love.keyboard.isDown('up') then
        actuallyJumped = 0
        y = y + 1
        if jumpLog == 0 and matrix[xPos][yPos-1] ~= GreenS then
            matrix[xPos][yPos] = WhiteS
            yPos = yPos - UpDown
            matrix[xPos][yPos] = GreyS
            actuallyJumped = 1
        end
        if jumpLog == 1 and matrix[xPos][yPos-1] ~= GreenS then
            matrix[xPos][yPos] = WhiteS
            yPos = yPos - UpDown
            matrix[xPos][yPos] = GreyS
            actuallyJumped = 1
            if matrix[xPos][yPos+1] == GreenS or matrix[xPos][yPos+1] == LightBlueS then
                jumpLog = 0
            end
        end
        if jumpLog == 2 and matrix[xPos][yPos-1] ~= GreenS then
            matrix[xPos][yPos] = WhiteS
            yPos = yPos - UpDown
            matrix[xPos][yPos] = GreyS
            actuallyJumped = 1
            if matrix[xPos][yPos+1] == GreenS or matrix[xPos][yPos+1] == LightBlueS then
                jumpLog = 0
            end
        end
        if jumpLog == 3 and matrix[xPos][yPos-1] ~= GreenS then
            matrix[xPos][yPos] = WhiteS
            yPos = yPos - UpDown
            matrix[xPos][yPos] = GreyS
            actuallyJumped = 1
            if matrix[xPos][yPos+1] == GreenS or matrix[xPos][yPos+1] == LightBlueS then
                jumpLog = 0
            end
        end
        if jumpLog == 4 and matrix[xPos][yPos-1] ~= GreenS then
            matrix[xPos][yPos] = WhiteS
            yPos = yPos - UpDown
            matrix[xPos][yPos] = GreyS
            actuallyJumped = 1
            if matrix[xPos][yPos+1] == GreenS or matrix[xPos][yPos+1] == LightBlueS then
                jumpLog = 0
            end
        end

        if jumpLog < 4 and UpDown == 1 and actuallyJumped == 1 then
            jumpLog = jumpLog + jumpLogChange
        end
        if jumpLog == 4 then
            UpDown = -1
        end
        if jumpLog > -1 and UpDown == -1 then
            jumpLog = jumpLog - jumpLogChange
        end
        if jumpLog == -1 then
            UpDown = 1
        end
<<<<<<< HEAD

        if jumpLog == -1 and (matrix[xPos][yPos+1] ~= GreenS and matrix[xPos][yPos+1] ~= LightBlueS) and (matrix[xPos][yPos+1] ~= GreenS or matrix[xPos][yPos+1] ~= LightBlueS) then
            matrix[xPos][yPos] = WhiteS
            yPos = yPos + 1
            matrix[xPos][yPos] = GreyS
        end
    end

    --checks if the charater is on the ground
    if not love.keyboard.isDown('up') then
        if (matrix[xPos][yPos+1] ~= GreenS and matrix[xPos][yPos+1] ~= LightBlueS) and (matrix[xPos][yPos+1] ~= GreenS or matrix[xPos][yPos+1] ~= LightBlueS) then
=======

        if jumpLog == -1 and (matrix[xPos][yPos+1] ~= GreenS and matrix[xPos][yPos+1] ~= LightBlueS) and (matrix[xPos][yPos+1] ~= GreenS or matrix[xPos][yPos+1] ~= LightBlueS) then
>>>>>>> ec74a8efedb5c37dbfa88520f7103f36ddbdfd3e
            matrix[xPos][yPos] = WhiteS
            yPos = yPos + 1
            matrix[xPos][yPos] = GreyS
        end
<<<<<<< HEAD
        UpDown = 1
        jumpLog = 0
    end


    --drops the character off a cloud if they press down oon one
    if love.keyboard.isDown('down') then
        if matrix[xPos][yPos+1] == LightBlueS then
            matrix[xPos][yPos] = WhiteS
            yPos = yPos + 2
            matrix[xPos][yPos] = GreyS
        end
=======
>>>>>>> ec74a8efedb5c37dbfa88520f7103f36ddbdfd3e
    end

    --checks if the charater is on the ground
    if not love.keyboard.isDown('up') then
        if (matrix[xPos][yPos+1] ~= GreenS and matrix[xPos][yPos+1] ~= LightBlueS) and (matrix[xPos][yPos+1] ~= GreenS or matrix[xPos][yPos+1] ~= LightBlueS) then
            matrix[xPos][yPos] = WhiteS
            yPos = yPos + 1
            matrix[xPos][yPos] = GreyS
        end
        UpDown = 1
        jumpLog = 0
    end

    matrix[7][6] = LightBlueS
end

function love.draw()
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

    love.graphics.setColor(0,0,0)
    love.graphics.print(x,200,200)
<<<<<<< HEAD
    love.graphics.print(mapWidth,200,220)
    love.graphics.print(mapHeight,200,240)
    love.graphics.print(r,200,260)
    love.graphics.print(g,220,280)
    love.graphics.print(b,240,300)

    --love.graphics.print(width,100,100)
    --love.graphics.print(height,100,120)
=======
    love.graphics.print(y,200,220)
    love.graphics.print(width,100,100)
    love.graphics.print(height,100,120)
>>>>>>> ec74a8efedb5c37dbfa88520f7103f36ddbdfd3e



    --draws the enviroment matrix
    love.graphics.setColor(0,0,0)
    for i=startI,startI+10 do
        for j=startJ,startJ+10 do
            love.graphics.setColor(1,1,1)
            love.graphics.draw(matrix[i][j],i*20-(20*startI),j*20-(20*startJ))
        end
    end

end