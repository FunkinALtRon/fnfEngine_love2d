local playState = {}
Characters = require("source.objects.characters")
Song = require("source.backend.song")

local startTimer = 0
local TimeMS = 0
Timer = 0

local Animations = {
    "singLEFT",
    "singDOWN",
    "singUP",
    "singRIGHT"
}

local BF = Characters:load("bfnew", 0, 0, 0)

local chart = {}
local section = 0
local beat = 0
local NoteIdx = 1

function playState:load()
    startTimer = love.timer.getTime()
    BF:PlayAnim("idle")
    chart = Song:getChart("mulchmisses", "-hard")

    Song.audio[1]:play()
    Song.audio[2]:play()
end

function playState:update(dt)
    Timer = (love.timer.getTime() - startTimer)
    TimeMS = Song.audio[1]:tell("seconds") * 1000
    BF:update(dt)

    for idx, note in ipairs(chart) do
        if (note[1] <= TimeMS) and NoteIdx == idx then
            print(note[2])
            if note[2] > 3 then
                BF.bop = false
                BF:PlayAnim(Animations[note[2] - 3])
            end
            
            NoteIdx = NoteIdx + 1
        end
        
    end

    if TimeMS / 1000 >= 4 * (section * (60/Song.bpm)) then
        section = section + 1
    end
    if TimeMS / 1000 >= 2 * (beat * (60/Song.bpm)) then
        beat = beat + 1
        BF:dance()
    end
end

function playState:draw()
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

return playState