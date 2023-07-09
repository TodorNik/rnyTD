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
end

function Enemy:draw()
    --draws the enemy based on their  type
    tileSize = 25
    if self.type == 1 then
        local enemySize = 10 -- The size of the enemy
        local offsetX = (tileSize - enemySize) / 2
        local offsetY = (tileSize - enemySize) / 2
        love.graphics.circle("line", self.x * tileSize + offsetX, self.y * tileSize + offsetY, enemySize)
    elseif self.type == 2 then
        love.graphics.rectangle("line", self.x * 25, self.y * 25 , 20, 20)
    elseif self.type == 3 then
        love.graphics.circle("fill", self.x * 25, self.y * 25, 20)
    elseif self.type == 4 then
        love.graphics.rectangle("fill", self.x * 25, self.y * 25, 20, 20)
    end
end

