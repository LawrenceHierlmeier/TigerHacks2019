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

    --Grabs the pngs to sue as sprites within the window
    GreenS = love.graphics.newImage("GreenS.png")
    WhiteS = love.graphics.newImage("WhiteS.png")
    GreyS = love.graphics.newImage("GreyS.png")
    RedS = love.graphics.newImage("RedS.png")
    BrownS = love.graphics.newImage("BrownS.png")

    startI = 0 --used to shift the viewing window along the matrix
    
    --used to move further right and left after the screen stops moving
    moreRight = 0
    moreLeft = 0

    --How far right the matrix goes
    furthestRight = 50
    furthestDown = 10

    --position coordinates of the character in the matrix
    xPos = 3
    yPos = furthestDown - 2
   
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
end


function love.update(dt)

    --Restrains FPS
    if dt < 1/10 then
        love.timer.sleep(1/10 - dt)
    end

    --moves the character left along the matrix
    if love.keyboard.isDown("left") then
        if startI > 0 and moreRight == 0 then
            startI = startI - 1
            matrix[xPos][yPos] = WhiteS
            xPos = xPos - 1
            matrix[xPos][yPos] = GreyS
        end
        if moreRight > 0 then
            moreRight = moreRight - 1
            if matrix[furthestRight][yPos] ~= GreyS then
                matrix[xPos][yPos] = WhiteS
                xPos = xPos - 1
                matrix[xPos][yPos] = GreyS
            end
            if matrix[furthestRight][yPos] == GreyS then
                matrix[furthestRight-1][yPos] = GreyS
                matrix[furthestRight][yPos] = WhiteS
                xPos = xPos -1
            end
        end
        if startI == 0 and matrix[0][yPos] ~= GreyS then
            matrix[xPos][yPos] = WhiteS
            xPos = xPos - 1
            matrix[xPos][yPos] = GreyS
            moreLeft = moreLeft - 1
        end
    end

    --moves the chacter right along the matrix
    if love.keyboard.isDown("right") then
        if startI < furthestRight - 10 and moreLeft == 0 then
            startI = startI + 1
            matrix[xPos][yPos] = WhiteS
            xPos = xPos + 1
            matrix[xPos][yPos] = GreyS
        end
        if startI >= furthestRight - 10 and matrix[furthestRight][yPos] ~= GreyS then
            matrix[xPos][yPos] = WhiteS
            xPos = xPos + 1
            matrix[xPos][yPos] = GreyS
            moreRight = moreRight + 1
        end
        if moreLeft < 0 then
            moreLeft = moreLeft + 1
            if matrix[0][yPos] ~= GreyS then
                matrix[xPos][yPos] = WhiteS
                xPos = xPos + 1
                matrix[xPos][yPos] = GreyS
            end
            if matrix[0][yPos] == GreyS then
                matrix[1][yPos] = GreyS
                matrix[0][yPos] = WhiteS
                xPos = xPos + 1
            end
        end
    end

    --moves the character up
    if love.keyboard.isDown("up") then

    end
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
    love.graphics.print(x,200,200)
    love.graphics.print(change,200,220)
    love.graphics.print(width,100,100)
    love.graphics.print(height,100,120)



    --draws the enviroment matrix
    love.graphics.setColor(0,0,0)
    for i=startI,startI+10 do
        for j=0,10 do
            love.graphics.setColor(1,1,1)
            love.graphics.draw(matrix[i][j],i*20-(20*startI),j*20)
        end
    end
end