local sparrow = require("source.libs.sparrow")

local img = love.graphics.newImage("assets/images/p2sonic.png")
local animations = sparrow:getSparrow("assets/images/p2sonic", img)

function love.draw()
    love.graphics.draw(img, animations["Down"]["0000"]["quad"], 0 - animations["Down"]["0000"]["frameX"], 0 - animations["Down"]["0000"]["frameY"])
end