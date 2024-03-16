Characters = require("source.objects.characters")

local startTimer = 0
Timer = 0

local BF = Characters:load("bfnew", 0, 0, 0)

function love.load()
    startTimer = love.timer.getTime()
    BF:PlayAnim("singUP-alt")
end

function love.update(dt)
    Timer = (love.timer.getTime() - startTimer)
    BF:update(dt)
end

function love.draw()
    BF:draw()
end