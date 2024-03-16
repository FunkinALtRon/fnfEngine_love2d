Characters = require("source.objects.characters")
Song = require("source.backend.song")

local startTimer = 0
Timer = 0

local NoteIdx = 1

local Animations = {
    "singLEFT",
    "singDOWN",
    "singUP",
    "singRIGHT"
}

local BF = Characters:load("bfnew", 0, 0, 0)

local chart = {}

function love.load()
    startTimer = love.timer.getTime()
    BF:PlayAnim("idle")
    chart = Song:getChart("mulchmisses", "-hard")

    Song.audio[1]:play()
    Song.audio[2]:play()
end

function love.update(dt)
    Timer = (love.timer.getTime() - startTimer)
    BF:update(dt)

    for idx, note in ipairs(chart) do
        if (note[1] <= Timer * 1000) and NoteIdx == idx then
            print(note[2])
            if note[2] > 3 then
                BF:PlayAnim(Animations[note[2] - 3])
            end
            
            NoteIdx = NoteIdx + 1
        end
        
    end
end

function love.draw()
    BF:draw()
end

-- function love.keypressed(key, scancode, isrepeat)
--     if key == "w" then
--         BF:PlayAnim("singUP")
--     end
--     if key == "s" then
--         BF:PlayAnim("singDOWN")
--     end
--     if key == "d" then
--         BF:PlayAnim("singRIGHT")
--     end
--     if key == "a" then
--         BF:PlayAnim("singLEFT")
--     end
-- end