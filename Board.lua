Board = Class{}
boardCords = {}
image  = {}


require 'Tiles'

function Board:init(x, y)
    self.x = x
    self.y = y
    self.Xaxis = 0
    self.Yaxis = 0
    c = 1
    self.flags = 10
    self.points = 0

    for i = self.x, (24*16) + self.x , 16 do
        for j = self.y, (10*16) + self.y , 16 do
            boardCords[c] = Tiles(i,j)
            boardCords[c].isBomb = false
            c = c + 1
        end
    end

    c = 1
    Board:bombAssigner()

    for i = 16, (25*16), 16 do
        for j = 16, (11*16) , 16 do
            boardCords[c].value = Board:tileMapping(i, j)  
            c = c + 1
        end
    end
end

function Board:update(dt)

    if self.points == 10 then
        gameState = 'Win'
    end


    if gameState == 'GameOver' then
        for i = 1, 275, 1 do
            if boardCords[i].isBomb == true then
                boardCords[i].revealed = true
            end
        end
    end
end

function Board:render() 

    for i = 1, 275, 1 do
        boardCords[i]:render()
    end
    --debug
    -- love.graphics.print(tostring(Board:getBox(self.Xaxis,self.Yaxis)),450,90)
    -- love.graphics.print(tostring(self.points),450,110)
    -- love.graphics.print(tostring(c),450,130)
    --love.graphics.print(tostring(boardCords[Board:getBox(self.Xaxis, self.Yaxis)].isFlag),450,150)
    -- love.graphics.print(tostring(boardCords[Board:getBox(self.Xaxis,self.Yaxis)].value),450,150)
end

function Board:tileMapping(row,col) 
    local count = 1
    local rowCords = {row-16, row, row+16}
    local colCords = {col-16, col, col+16}
    

    if  boardCords[Board:getBox(row, col)].isBomb == true then
        return 10
    else 
        --Check surroundings 
        for r = 1, 3, 1 do
            for c = 1, 3, 1 do
                curRow = rowCords[r]
                curCol = colCords[c]        

                if (curRow >= 16 and curRow <= 400 and curCol >= 16 and curCol <= 176) then
                    if boardCords[Board:getBox(curRow, curCol)].isBomb == true then
                        count = count + 1

                    end
                end

            end
        end
        --Output value found
        return count
    end
end

function Board:getXaxis()
    return self.Xaxis
end

function Board:getYaxis()
    return self.Yaxis
end

function Board:getFlags()
    return self.flags
end

function Board:getBox(i, j)
    x = i/16
    y = j/16
    return y+(11*(x-1))
end

function Board:bombAssigner()

    local c = 0

    while c ~= 10 do
        bomb = math.random(1, 275)
        if boardCords[bomb].isBomb == true then
            bomb = math.random(1, 275)
        else
            boardCords[bomb].isBomb = true
            c = c + 1
        end
    end
end

function Board:freeSpaces(row,col) 
    
    local rowCords = {row-16, row, row+16}
    local colCords = {col-16, col, col+16}

--
    --Check surroundings 
        for r = 1, 3, 1 do
            for c = 1, 3, 1 do
                curRow = rowCords[r]
                curCol = colCords[c]        

                if (curRow >= 16 and curRow <= 400 and curCol >= 16 and curCol <= 176) then
                    if not boardCords[Board:getBox(curRow, curCol)].revealed and boardCords[Board:getBox(curRow, curCol)].value == 1 then 
                        boardCords[Board:getBox(curRow, curCol)].revealed = true
                        Board:freeSpaces(curRow,curCol)
                    end
                end
            end
        end  
    --end 
end