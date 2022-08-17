Tiles = Class{}

function Tiles:init(x, y)
    self.x = x
    self.y = y
    self.isBomb = false
    self.value = 0
    self.revealed = false
    self.isFlag = false


    image = {
        love.graphics.newImage("Tiles/empty.png"),
        love.graphics.newImage("Tiles/1.png"),
        love.graphics.newImage("Tiles/2.png"),
        love.graphics.newImage("Tiles/3.png"),
        love.graphics.newImage("Tiles/4.png"),
        love.graphics.newImage("Tiles/5.png"),
        love.graphics.newImage("Tiles/6.png"),
        love.graphics.newImage("Tiles/7.png"),
        love.graphics.newImage("Tiles/8.png"),
        love.graphics.newImage("Tiles/bomb.png"),
        love.graphics.newImage("Tiles/hidden.png"),
        love.graphics.newImage("Tiles/flag.png")
        }

    quad = love.graphics.newQuad(0, 0, 16, 16,16,16)
end

function Tiles:update(dt)

end

function Tiles:render()
        if self.revealed == false then
            love.graphics.draw(image[11], quad, self.x, self.y)
        elseif self.revealed == true then
            love.graphics.draw(image[self.value], quad, self.x, self.y)
        end
        if self.isFlag == true and self.revealed == false then
            love.graphics.draw(image[12], quad, self.x, self.y)
        end
end


