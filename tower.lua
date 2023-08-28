Tower = Object:extend()

--sets tower stats
function Tower:new(x,y,z)
    self.x = x
    self.y = y
    self.damage = 1
    self.timer = 2 - (z * 0.6)
    self.currtimer = self.timer
    self.type = z
    self.range = 70 + (z * 5)
    self.target = 0
end

function Tower:update(dt)
    --lowers the timer if target is acquired
    if self.currtimer > 0 and self.target > 0 then
        self.currtimer = self.currtimer - dt
        print(self.currtimer)
    --resets the timer if a target exits range
    end
end


function Tower:draw()

    if self.type == 1 then
        img = love.graphics.newImage("tower1.png")
        love.graphics.draw(img, self.x, self.y, 0, 0.4, 0.4)
        love.graphics.circle("line",self.x + 10, self.y + 10, self.range)
    elseif self.type == 2 then
        img = love.graphics.newImage("tower2.png")
        love.graphics.draw(img, self.x, self.y, 0, 0.4, 0.4)
        love.graphics.circle("line",self.x + 10, self.y + 10, self.range)
    elseif self.type == 3 then
        img = love.graphics.newImage("tower3.png")
        love.graphics.draw(img, self.x, self.y, 0, 0.4, 0.4)
        love.graphics.circle("line",self.x + 10, self.y + 10, self.range)
    end
end