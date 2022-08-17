WINDOW_WIDTH = 1920
WINDOW_HEIGHT = 1080

VIRTUAL_WIDTH = 496 
VIRTUAL_HEIGHT = 279


Class = require 'class'
push = require 'push'

require 'Board'

gameState = 'Title'


function love.load()

    math.randomseed(os.time())

    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,{
        fullscreen = true,
        vsync = true,
        resizable = true
    })

    --Fonts
    smallFont = love.graphics.newFont('04B_03__.TTF', 8)
    mediumFont = love.graphics.newFont('04B_03__.TTF', 16)
    largeFont = love.graphics.newFont('04B_03__.TTF', 32)

    --sounds
    sounds ={
        ['Explode'] = love.audio.newSource('SFX/Bomb.wav', 'static'),
        ['Flag'] = love.audio.newSource('SFX/Flag.wav', 'static'),
        ['Box'] = love.audio.newSource('SFX/Box.wav','static')
    }


    love.window.setTitle('Bombsweeper')
    rColor = 252
    gColor = 252
    bColor = 3
    colored = true 

    board = Board(48,64)

    timetaken = 0
    flagsleft = 0
end

function love.update(dt)
    if gameState == 'Title' then
        if colored == false then
            rColor = rColor - 3
            
            if gColor >= 181 then
                gColor = gColor - 3
            end

            if bColor <= 252 then 
                bColor = bColor + 3
            end
        end
        if colored == true then
            rColor = rColor + 3
            gColor = gColor + 3
            bColor = bColor - 3
        end
        if rColor == 255  then
            colored = false
        end
        if rColor == 0  then
            colored = true
        end
    end

    
    if gameState == 'PlayState'  then
        board:update(dt)
        timetaken = timetaken + dt
    end
    if gameState == 'GameOver'  then
        board:update(dt)
    end
end

function love.draw()
    push:apply('start')
    
    if gameState == 'Title' then
        love.graphics.clear(176/255, 176/255, 176/255, 1)
        love.graphics.setColor(gColor/255, rColor/255, bColor/255)
        love.graphics.setFont(largeFont)
        love.graphics.printf("WELCOME TO", 0  , 40, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("BOMBSWEEPER", 0  , 40+32, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(mediumFont)
        love.graphics.printf("Press enter to start!", 0  , 200, VIRTUAL_WIDTH, 'center')


    elseif gameState == 'PlayState' then
        love.graphics.clear(176/255, 176/255, 176/255, 1)
        board:render()
        --love.graphics.setColor(153/255, 43/255, 43/255, 1)
        love.graphics.setColor(190/255, 43/255, 43/255, 1)
        love.graphics.setFont(largeFont)
        love.graphics.print(tostring(math.floor(timetaken)),416,30)
        love.graphics.print(tostring(board:getFlags()),48,30)
        love.graphics.setColor(1,1,1,1)
        love.graphics.setFont(mediumFont)

    elseif gameState == 'GameOver' then
        love.graphics.clear(176/255, 176/255, 176/255, 1)
        board:render()
        love.graphics.setFont(largeFont)
        love.graphics.printf("GAME OVER", 0, 20, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf("Press enter to restart", 0, 20+32, VIRTUAL_WIDTH, 'center')
        --display exit or restart msg

    elseif gameState == 'Win' then
        love.graphics.clear(176/255, 176/255, 176/255, 1)
        love.graphics.setFont(largeFont)
        love.graphics.printf("CONGRATS", 0  , 40, VIRTUAL_WIDTH, 'center')
        love.graphics.printf("YOU WIN!!!", 0  , 80, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf("Press enter to Play again", 0, 220, VIRTUAL_WIDTH, 'center')
    end

    --debug
    -- love.graphics.print(c,5,30)
    -- love.graphics.print(d, 5, 50)
    -- love.graphics.print(i,5,70)
    -- love.graphics.print(j, 5, 90)

    push:apply('end')
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'return' then
        if gameState == 'Title' then
            gameState = 'PlayState'
        end
        
        if gameState == 'GameOver' or gameState == 'Win' then
            love.load()
            gameState = 'Title'
        end
    end
end

function love.mousepressed(x, y, button, istouch)
    if gameState == 'PlayState' then
        -- x = round16(round16(round16(x/(8/3))/16)*16)-32
        -- y = round16(round16(round16(y/(8/3))/16)*16)-48
        x = round16(math.floor(x/(1920/496))+8)-32
        y = round16(math.floor(y/(1920/496))+8)-32
            if button == 1 then   
                if x >=16 and x <= 400 and y >= 16 and y <= 176 then
                    if not boardCords[Board:getBox(x, y)].isFlag then 
                        boardCords[Board:getBox(x, y)].revealed = true 
                        sounds['Box']:play()
                        if boardCords[Board:getBox(x, y)].isBomb == true then
                            sounds['Explode']:play()
                            gameState = 'GameOver'
                        end
                        if boardCords[Board:getBox(x, y)].value == 1 then
                            Board:freeSpaces(x,y)
                        end
                    end 
                end
            end

            if button == 2 then

                if x >=16 and x <= 400 and y >= 16 and y <= 176 then
                    if boardCords[Board:getBox(x, y)].revealed == false then
                        sounds['Flag']:play()
                        if  boardCords[Board:getBox(x, y)].isFlag == false then
                            if board.flags >=1 then
                                boardCords[Board:getBox(x, y)].isFlag = true
                                board.flags = board.flags - 1
                            end
                        else
                            boardCords[Board:getBox(x, y)].isFlag = false 
                            board.flags = board.flags + 1
                        end
                    end

                    if boardCords[Board:getBox(x, y)].isBomb == true then
                        if boardCords[Board:getBox(x, y)].isFlag == true then
                            board.points = board.points + 1
                        else
                            board.points = board.points - 1
                        end
                    end
                end
             end
    end
end

function round16(x)
    return 16*(math.floor(x/16+0.5))
end

function love.resize(w, h)
    push:resize(w, h)
end