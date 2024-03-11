local sparrow = require("source.libs.sparrow")

local img = love.graphics.newImage("assets/images/p2sonic.png")
local quads = sparrow:getSparrow("assets/images/p2sonic", img)


function love.draw()
    love.graphics.draw(img, quads["Right"]["0000"])
end