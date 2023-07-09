Tower = Object:extend()

--sets tower stats
function Tower:new(x,y,z)
    self.x = x
    self.y = y
    self.damage = 1
    self.timer = 4 - (z * 0.6)
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
    --draws the tower based on type provided
    if self.type == 1 then
        love.graphics.setColor(0.8,0.4,1)
        love.graphics.rectangle("fill",self.x, self.y, 25, 25)
        love.graphics.circle("line",self.x + 10, self.y + 10, self.range)
        love.graphics.setColor(255,255,255)

    elseif self.type == 2 then
        love.graphics.setColor(0.4,1,0.8)
        love.graphics.rectangle("fill",self.x, self.y, 25, 25)
        love.graphics.circle("line",self.x + 10, self.y + 10, self.range)
        love.graphics.setColor(255,255,255)


    elseif self.type == 3 then
        love.graphics.setColor(1,0.4,0.8)
        love.graphics.rectangle("fill",self.x, self.y, 25, 25)
        love.graphics.circle("line",self.x + 10, self.y + 10, self.range)
        love.graphics.setColor(255,255,255)
    end
end




