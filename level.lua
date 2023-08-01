tileChars = {
    ["-"] = 0,-- 0 represents an empty tile 
    ["|"] = 1,-- 1 represents a wall tile
    ["#"] = 3 -- 3 represents a solid tile
 }

Level = Object:extend()
function Level:new(a)
    --loads a level based on passed value
    if a == 1 then
        --Level holds parts of the level important for calculation
        self.tilemap = --tilemap representing the levels layout
            {
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|||||||||#######",
            "#|----------|#######",
            "#|----------|#######",
            "#|||||||||--|#######",
            "#########|--|#######",
            "#########|--||||||||",
            "#########|--------||",
            "#########|--------||",
            "#########|||||||||||",
            "####################",
            "####################",
            "####################",
            "####################",
            "####################",
            "####################"
            }
        self.num = {} --map in numeric form
        self.startX = 3 --holds start position for enemies on the x axis
        self.startY = 2 --holds start position for enemies on the y axis
        self.endX = 17  --holds end position for enemies on the x axis 
        self.endY = 12  --holds end position for enemies on the y axis
        self.offsetX = 25 --offset value of x for drawing the goal
        self.offsetY = 25 --offset value for y for drawing the goal

    elseif a == 2 then
        self.tilemap = 
            {
            "#|--|###############",
            "#|--|#####||||||||##",
            "#|--|||||||------|##",
            "#|---------------|##",
            "#|-----------||--|##",
            "#||||||||||||||--|##",
            "##############|--|##",
            "##############|--|##",
            "##############|--|##",
            "##############|--|##",
            "##############|--|##",
            "##############|--|##",
            "##############|--|##",
            "##############|--|##",
            "##############|--|##",
            "##############|--|##",
            "##############|--|##",
            "##############||||##",
            "####################",
            "####################"
            }
        self.num = {}
        self.startX = 3
        self.startY = 2
        self.endX = 16
        self.endY = 16
        self.offsetX = 20
        self.offsetY = 25
    elseif a == 3 then
        self.tilemap = 
            {
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--|###############",
            "#|--||||||||||||||##",
            "#|---------------|##",
            "#|---------------|##",
            "#|||||||||||||||||##",
            "####################",
            "####################"
            }
        self.num = {}
        self.startX = 3
        self.startY = 2
        self.endX = 16
        self.endY = 16
        self.offsetX = 25
        self.offsetY = 25
    elseif a == 4 then

        self.tilemap = {
            "#|--||||||||||||####",
            "#|-------------|####",
            "#|-------------|####",
            "#||||||||||||--|####",
            "############|--|####",
            "############|--|####",
            "############|--|####",
            "############|--|####",
            "############|--||||#",
            "############|-----|#",
            "############|-----|#",
            "############||||--|#",
            "###############|--|#",
            "###############|--|#",
            "###############|--|#",
            "###############||||#",
            "####################",
            "####################",
            "####################",
            "####################"
            }

        self.num = {}
        self.startX = 3
        self.startY = 2
        self.endX = 16
        self.endY = 13
        self.offsetX = 25
        self.offsetY = 25
    end
end

function Level:update()

end

function Level:draw()
    --checks if tilemap has been converted and draws the map
   if self.num ~= nil then
    for i, row in ipairs(self.num) do
        for j, tile in ipairs(row) do
            x = j * 25
            y = i * 25
  
           if tile == 0 then
           love.graphics.rectangle("line", x, y, 25, 25)
         end
     end
   end
    end
end
--Convert the tilemap to a numeric tilemap
function Level:convertTilemap(tilemap)
    tempnum = {}
    --convert the self.tilemap into numeric values
    for i, row in ipairs(tilemap) do
       numericRow = {}
       --converts a single row into numbers
       for j = 1, #row do
            char = row:sub(j,j)
            tileID = tileChars[char] or 0
            print(tileID)
            table.insert(numericRow, tileID)
       end
       --adds a whole row to the number tilemap
        table.insert(tempnum, numericRow)
   end
   --returns a numeric version of the tilemap
   return tempnum
end