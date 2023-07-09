--level, wave, money, and sound are kept out of load because there's no reason to initialize them multiple times
level = 1
wave = 1
money = 200
sound = love.audio.newSource("pop.ogg", "static")

function love.load()
   --Imports parts of the jumper library by Yonaba (https://github.com/Yonaba/Jumper/blob/master/README.md)
   Grid = require ("jumper.grid") -- The grid class
   Pathfinder = require ("jumper.pathfinder") -- The pathfinder class
   --Imports classic library to make classes work, also imports tower and enemy objects
   Object = require "classic"
   require "tower"
   require "enemy"

   --Initializes enemy and tower lists
   listOfEnemies = {Enemy(1,3,1), Enemy(2,3,1),Enemy(3,3,1),Enemy(4,3,1)}
   listOfTowers = {}

   --Following "if" function helps switch level maps and sets start/end point for enemy paths
   if level == 1 then
      --first level map
      tilemap = {
      {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
      {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
      {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
      {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
      {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
      {3, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3},
      {3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3},
      {3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3},
      {3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
      {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3}}

      startx, starty = 3, 2
      endx, endy = 18, 12
      offsetx = 0
      offsety = 25

      elseif level == 2 then
         --second level map
         tilemap = {
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3},-- 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 1, 0, 0, 0, 0, 0, 0, 1, 3, 3},-- 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {3, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 3, 3},-- 1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
         {3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 3},-- 1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
         {3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 3, 3},-- 1, 0, 0, 1, 1, 1, 1, 1, 1, 1},
         {3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},-- 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 0, 0, 1, 3, 3},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 1, 1, 1, 3, 3},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3}}

         startx, starty = 3, 2
         endx, endy = 16, 15
         offsetx = 25
         offsety = 0

         elseif level == 3 then
         --third level map
         tilemap = {
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 0, 0, 0, 0, 0, 0, 0, 0, 1},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 0, 0, 1, 1, 1, 1, 1, 1, 1},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
         {3, 1, 0, 0, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
         {3, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3},
         {3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 3},
         {3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 3, 3},
         {3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},-- 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
         {3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3}}

         startx, starty = 3, 2
         endx, endy = 16, 16
         offsetx = 0
         offsety = 25
      end

      walkable = 0
      -- Creates a grid object
      grid = Grid(tilemap)
      -- Creates a pathfinder object using Jump Point Search
      myFinder = Pathfinder(grid, 'BFS', walkable)
      
      --creates an end goal to defend from enemies
      goal ={
         x = endx * 25 + offsetx,
         y = endy * 25 + offsety,
         health = 3
      }
      -- Calculates the path, and its length
      calculatePath()
end

function love.update(dt)
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

function love.draw()
   --draws the goal, its health, and current money
   love.graphics.setBackgroundColor( 0, 0, 250, 5)
   love.graphics.circle("line", goal.x, goal.y, 22)
   love.graphics.print ("3/ "..goal.health, goal.x - 12, goal.y - 7)
   love.graphics.print ("Money "..money, 13, 9)

   --draws enemies
   for g,v in ipairs(listOfEnemies) do
      v:draw()
   end

   --draws towers
   for i,v in ipairs(listOfTowers) do
      love.graphics.setColor(0,0,0)
      v:draw()
   end
   
   for i=1,#tilemap do
      for j=1,#tilemap[i] do
          --If the value on row i, column j equals 1
         if tilemap[i][j] == 1 then
              --Draw the rectangle use i and j to position the rectangle.
              love.graphics.setColor(150,75,0)
              love.graphics.rectangle("fill", j * 25, i * 25, 25, 25)
              love.graphics.setColor(0,0,0)
              love.graphics.rectangle("line", j * 25, i * 25, 25, 25)

            --If the value on row i, column j equals 2
            elseif tilemap[i][j] == 2 then
            --Draws an empty rectangle, where tower will be drawn
            love.graphics.setColor(0,0,0)
              love.graphics.rectangle("line", j * 25, i * 25, 25, 25)
              love.graphics.setColor(150,75,0)
         end
      end
   end
end
   
function checkWaypoint(e,eindx)
   --loads a temporary variable with the values of the node enemy is moving towards
   temp = path[e.waypoint]

   if temp.x == endx and temp.y == endy then
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
         resolveShot(tower,enemy,indx)
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
   path, length = myFinder:getPath(startx, starty, endx, endy)
   print(endx,endy)
end

--after distance has been confirmed, target starts ticking off the timer and tower deals damage
function resolveShot (tower, enemy, eindx)
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
         print(listOfEnemies[2])
      elseif wave == 3 and level == 1 then
         listOfEnemies = {Enemy(3,3,2),Enemy(3,4,2),Enemy(1,3,2),Enemy(2,4,2),Enemy(5,3,2),Enemy(4,3,1),Enemy(6,3,1)}
         print("This location is reached")
      
      elseif wave == 1 and  level == 2 then
         listOfEnemies = {Enemy(3,3,3),Enemy(4,3,3),Enemy(5,3,3),Enemy(6,3,2),Enemy(6,4,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2)}
         print ("we are at level 2")
      
         elseif wave == 3 and  level == 2 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,4,2),Enemy(4,3,3)}
         print ("we are at level 2")

         elseif wave == 1 and  level == 3 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,1),Enemy(3,3,3)}
         print ("we are at level 3")

         elseif wave == 2 and  level == 3 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,3),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,2),Enemy(3,3,1)}
         print ("we are at level 3")

         elseif wave == 3 and  level == 3 then
         listOfEnemies = {Enemy(3,3,3),Enemy(3,4,3),Enemy(5,3,3),Enemy(4,3,2),Enemy(6,3,2),Enemy(7,3,2),Enemy(7,4,2),Enemy(8,3,2)}
         print ("we are at level 3")
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

   --resets wave to 0, first wave is always the same test wave
   wave = 0
   level = level + 1
   --initiates the new level
   love.load()
end