--level, wave, money, and sound are kept out of load because there's no reason to initialize them multiple times
level = 1
wave = 1
money = 200
sound = love.audio.newSource("pop.ogg", "static")

function love.load()
   if level == 6 then
      listOfEnemies = {}
      listOfTowers = {}
      
   else
   --Imports parts of the jumper library by Yonaba (https://github.com/Yonaba/Jumper/blob/master/README.md)
   Grid = require ("jumper.grid") -- The grid class
   Pathfinder = require ("jumper.pathfinder") -- The pathfinder class
   --Imports classic library to make classes work, also imports tower and enemy objects
   Object = require "classic"
   require "tower"
   require "enemy"
   require "level"
   tiled = Level(level)
   tilemap = tiled:convertTilemap(tiled.tilemap)
   for i,tile in ipairs(tilemap) do
      print(tile[i])   
   end
   --Initializes enemy and tower lists
   listOfEnemies = {Enemy(1,3,1), Enemy(2,3,1),Enemy(3,3,1),Enemy(4,3,1)}
   listOfTowers = {}

      walkable = 0
      -- Creates a grid object
      grid = Grid(tilemap)
      --Creates a pathfinder object using Jump Point Search
      myFinder = Pathfinder(grid, 'DFS', walkable)
      --creates an end goal to defend from enemies
      goal ={
         x = tiled.endX * 25 + tiled.offsetX,
         y = tiled.endY * 25 + tiled.offsetY,
         health = 3
      }
      -- Calculates the path, and its length
      calculatePath()
   end
end

function love.update(dt)
if level == 6 then
   print("lol")
else
   --checks whether wave's been cleared
   if #(listOfEnemies) <= 0 then
      print(#(listOfEnemies))
      waveSwitcher()
   end

   --iterates through present towers and enemies to see if any can be shot
   for j,t in ipairs(listOfTowers) do
      for k=#listOfEnemies,1,-1 do
         e = listOfEnemies[k]
         towerShoot(e,t,k,dt)
      end
   end

   --checks if enemy has reached the end goal
   for i, enemy in ipairs(listOfEnemies) do
      enemy:update(dt)
      checkWaypoint(enemy,i)
   end
end

end

function love.draw()
   if level == 6 then
      love.graphics.print("You beat the game!", 300, 200)

   else
   --draws the goal, its health, and current money
   love.graphics.setBackgroundColor( 0.7, 1, 0.4)
   gimg = love.graphics.newImage("goal.png")

   love.graphics.setColor(1,1,1)
   love.graphics.draw(gimg, goal.x - 25, goal.y - 30)
   love.graphics.setColor(0,0,0)
   love.graphics.print ("3/ "..goal.health, goal.x - 6, goal.y - 7)
   love.graphics.print ("Level: "..level,400,9)
   love.graphics.print ("Money: "..money, 13, 9)

   tOne = love.graphics.newImage("tower1.png")
   tTwo = love.graphics.newImage("tower2.png")
   tThree = love.graphics.newImage("tower3.png")

   love.graphics.setColor(1,1,1)
   love.graphics.draw(tOne, 70, 560, 0, 0.8, 0.8, 32, 54)
   love.graphics.draw(tTwo, 300, 560, 0, 0.8, 0.8, 32, 54)
   love.graphics.draw(tThree, 540, 560, 0, 0.8, 0.8, 32, 54)
   love.graphics.setColor(0,0,0)
   love.graphics.print ("L-Click: 100 Money ", 110,530,0,1.3,1.3)
   love.graphics.print ("R-Click: 200 Money ", 340, 530, 0, 1.3, 1.3)
   love.graphics.print ("Middle Click: 300 Money", 580, 530, 0, 1.3, 1.3)

   --draws enemies
   for g,v in ipairs(listOfEnemies) do
      v:draw()
   end

   --draws towers
   for i,v in ipairs(listOfTowers) do
      love.graphics.setColor(1,1,1)
      v:draw()
   end

   for i=1,#tilemap do
      for j=1,#tilemap[i] do
          --If the value on row i, column j equals 1
         if tilemap[i][j] == 1 then
              --Draw the rectangle use i and j to position the rectangle.
              love.graphics.setColor(0.5,0.5,0.5)
              love.graphics.rectangle("fill", j * 25, i * 25, 25, 25)
              love.graphics.setColor(0,0,0)
              love.graphics.rectangle("line", j * 25, i * 25, 25, 25)

            --If the value on row i, column j equals 2
            elseif tilemap[i][j] == 2 then
            --Draws an empty rectangle, where tower will be drawn
            love.graphics.setColor(0,0,0)
              love.graphics.rectangle("line", j * 25, i * 25, 25, 25)
               
         end
      end
   end
   Level:draw()
   end
end
   
function checkWaypoint(e,eindx)
   --loads a temporary variable with the values of the node enemy is moving towards
   temp = path[e.waypoint]

   if temp.x == tiled.endX and temp.y == tiled.endY then
      --intercepts the enemy that reaches the end goal, dealing damage (might be redundant)
      goal.health = goal.health - 1
      table.remove(listOfEnemies, eindx)

      --if end goal is destroyed, reset the game
      if goal.health == 0 then
         wave = 1
         level = 1
         money = 200
         love.load()
      end
   end
   --when an enemy reaches target node, switch target to next node
   if e.x >= temp.x and e.y >= temp.y then
      if e.waypoint <= #(path) then
         e.waypoint = e.waypoint + 1
         temp = path[e.waypoint]
         e.targetX = temp.x
         e.targetY = temp.y
      end
   end
end

function love.mousepressed(x, y, button, istouch)
   --use an array of rectangles to detect stuff easier
   local temp = checkSpawnPoint(x,y)

   --checks whether spawn location is valid for a tower
   if temp.g then
      --checks if player has enough money and which button is pressed to create a tower
      if button == 1 and money >= 100 then
         table.insert(listOfTowers, Tower(temp.a * 25,temp.b * 25, 1))
         money = money - 100
         tilemap[temp.b][temp.a] = 2
      elseif button == 2 and money >= 200 then
         table.insert(listOfTowers, Tower(temp.a * 25, temp.b * 25, 2))
         money = money - 200
         tilemap[temp.b][temp.a] = 2
      elseif button == 3 and money >= 300 then
         table.insert(listOfTowers, Tower(temp.a * 25, temp.b * 25, 3))
         money = money - 300
         tilemap[temp.b][temp.a] = 2
      end
   end
end

function towerShoot(enemy, tower, indx, dt)
   --check whether enemy is within range
   local distance = math.sqrt((enemy.x * 25 - tower.x)^2 + (enemy.y *25 - tower.y)^2) -- Calculate distance between tower and enemy

   if distance <= tower.range then
      --assign target to the tower to shoot at
      if tower.target == 0 then
         tower.target = indx
         tower:update(dt)
      else
         --resolves the actual damage of the shot
         tower:update(dt)
         resolveShot(tower)
      end
   else
      --when target gets out of range it stops being a target
      if tower.target ~= 0 then
         tower.target = 0
      end
   end
   --end
end

function checkSpawnPoint(x,y)
   for i = 1,#tilemap do
      for j = 1,#tilemap do
         if tilemap[i][j] == 1 then
            if x >= j * 25 and x <= j * 25 + 25 then
               if y>= i * 25 and y <= i * 25 + 25 then
                  positionTow = {a = j, b = i, g = true}
                  return positionTow
               end
            end
         end
      end
   end
   positionTow = {a = x, b = y, g = false}
   return positionTow

end

function calculatePath()
   -- Calculates the path, and its length
   path, length = myFinder:getPath(tiled.startX, tiled.startY, tiled.endX, tiled.endY)

   if path then
      print(('Path found! Length: %.2f'):format(length))
       for node, count in path:iter() do
         print(('Step: %d - x: %d - y: %d'):format(count, node.x, node.y))
       end
    end
end

--after distance has been confirmed, target starts ticking off the timer and tower deals damage
function resolveShot (tower)
   if tower.currtimer <= 0 and goal.health > 0 then
      tempe = listOfEnemies[tower.target]
      if tempe ~= nil then
         if tempe.health > 0 then
            tempe.health = tempe.health - tower.damage
            tower.currtimer = tower.timer
         else
            --removes the enemy from play, plays sound, and increases money
            table.remove(listOfEnemies,tower.target)
            sound:play()
            money = money + tempe.reward
            tower.target = 0
            tower.currtimer = tower.timer
         end
      end
   end
end

function waveSwitcher()
   --spawns a new wave when the whole previous wave is killed
   if wave < 3 then
      wave = wave + 1
      calculatePath()
      if wave == 2 and level == 1 then
         listOfEnemies = {Enemy(1,3,2),Enemy(2,4,2),Enemy(3,3,2),Enemy(4,3,1),Enemy(5,3,1),Enemy(6,3,1)}

      elseif wave == 3 and level == 1 then
         listOfEnemies = {Enemy(3,3,2),Enemy(3,4,2),Enemy(1,3,2),Enemy(2,4,2),Enemy(5,3,2),Enemy(4,3,1),Enemy(6,3,1)}
      
      elseif wave == 1 and  level == 2 then
         listOfEnemies = {Enemy(3,3,3),Enemy(4,3,3),Enemy(5,3,3),Enemy(6,3,2),Enemy(6,4,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2)}
      
      elseif wave == 2 and  level == 2 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,4,2),Enemy(4,3,3)}

         elseif wave == 3 and  level == 2 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,4,2),Enemy(4,3,3)}

         elseif wave == 1 and  level == 3 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,3)}

         elseif wave == 2 and  level == 3 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,1)}

         elseif wave == 3 and  level == 3 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,4,3),Enemy(5,3,3),Enemy(4,3,2),Enemy(6,3,2),Enemy(7,3,2),Enemy(7,4,2),Enemy(8,3,2)}
         
         elseif wave == 1 and  level == 4 then
         listOfEnemies = {Enemy(2,2,2),Enemy(4,2,3),Enemy(4,3,3),Enemy(5,3,3),Enemy(6,3,2),Enemy(6,4,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2)}
      
         elseif wave == 2 and  level == 4 then
         listOfEnemies = {Enemy(3,3,3),Enemy(4,2,3),Enemy(4,2,3),Enemy(4,2,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,4,2),Enemy(4,3,3)}

         elseif wave == 3 and  level == 4 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,3)}

      elseif wave == 1 and  level == 5 then
         listOfEnemies = {Enemy(2,2,2),Enemy(4,3,3),Enemy(5,3,3),Enemy(6,3,2),Enemy(6,4,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(5,3,3),Enemy(6,3,3)}
      
         elseif wave == 2 and  level == 5 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,4,2),Enemy(4,3,3),Enemy(6,3,3),Enemy(6,4,3),Enemy(7,4,2)}

         elseif wave == 3 and  level == 5 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,3),Enemy(3,3,3)}

         end

         --resets targets to 0 to avoid any un-reset towers
         for i,tow in ipairs(listOfTowers) do
            tow.target = 0
         end
   --when maximum number of waves is reached, change level
   elseif wave >= 3 then
      levelSwitch()
   end


end

function levelSwitch()
   --removes all towers on level switch and gives back part of the money used for the towers
   townum = #listOfTowers
   money = money + (townum * 50)
   
   for i,t in ipairs(listOfTowers) do
      table.remove(listOfTowers,i)
   end
   level = level + 1

   --resets wave to 0, first wave is always the same test wave
   if level == 6 then
      love.graphics.print("END OF GAME",40,40)
   else

   wave = 0
   tiledn = {}
   tiledn = Level(level)
   --initiates the new level
      love.load()
   end
end
