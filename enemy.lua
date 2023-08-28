Enemy = Object:extend()

--makes a new enemy with their own stats based on their type
function Enemy:new(a, b, c)
    self.x = b
    self.y = a
    self.speed = 0.012 / c
    self.health = 1 * c
    self.targetX = 3
    self.targetY = 3
    self.waypoint = 1
    self.type = c
    self.reward = 20 * c
    self.orientation = 1
end

function Enemy:update (dt)
        --moves the enemy horizontally
        if self.x < self.targetX then
            self.x = self.x + self.speed
        end

        --moves the enemy vertically
        if self.y < self.targetY then
            self.y = self.y + self.speed
        end

        if self.targetY > self.y then
            self.orientation = 1
        end
end

function Enemy:draw()
    if self.type == 1 then
        eimg = love.graphics.newImage("enemy1.png")
        love.graphics.draw(eimg, self.x * 25, self.y * 25, 0, 0.4, 0.4)
    elseif self.type == 2 then
        eimg = love.graphics.newImage("enemy2.png")
        love.graphics.draw(eimg, self.x * 25, self.y * 25, 0, 0.4, 0.4)
    elseif self.type == 3 then
        eimg = love.graphics.newImage("enemy3.png")
        love.graphics.draw(eimg, self.x * 25, self.y * 25, 0, 0.4, 0.4)
    end
end

