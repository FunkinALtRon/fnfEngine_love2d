local sparrow = require("source.libs.sparrow")

local img = love.graphics.newImage("assets/images/p2sonic.png")
local animations = sparrow:getSparrow("assets/images/p2sonic", img)
local frame = "0003"
local anim = "Idle"

function love.draw()
    love.graphics.draw(img, animations[anim][frame]["quad"], (love.graphics.getWidth() / 2) - animations[anim][frame]["frameX"], (love.graphics.getHeight() / 2) - animations[anim][frame]["frameY"], animations[anim][frame]["rotated"], 0.5, 0.5)
end