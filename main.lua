local states = {playState = require("source.states.playState")}
CurState = "playState"
function love.load()
    states[CurState]:load()
end

function love.update(dt)
    states[CurState]:update(dt)
end

function love.draw()
    states[CurState]:draw()
end