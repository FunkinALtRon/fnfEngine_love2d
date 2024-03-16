local song = {}
song.bpm = 100
song.speed = 1
song.audio = {}

local Json = require("source.libs.json")

function song:getChart(songName, diff)
    local chart = {}
    local jsonFile = love.filesystem.newFile("assets/data/" .. songName .."/" .. songName .. diff .. ".json")
    local charttable = Json.decode(jsonFile:read())

    song.audio = {love.audio.newSource("assets/songs/" .. songName .. "/Inst.ogg", "static"), love.audio.newSource("assets/songs/" .. songName .. "/Voices.ogg", "static")}

    for i, section in ipairs(charttable["song"]["notes"]) do
        local mustHitSection = section["mustHitSection"]
        for j, notesSection in ipairs(section["sectionNotes"]) do
            local NoteData = {}
            for t, data in ipairs(notesSection) do
                table.insert(NoteData, data)
            end
            if mustHitSection then
                if NoteData[2] > 3 then
                    NoteData[2] = NoteData[2] - 4
                else
                    NoteData[2] = NoteData[2] + 4
                end
            end
            table.insert(chart, NoteData)
        end
    end

    table.sort(chart, function (a,b)
        return a[1] < b[1]
    end)

    return chart
end


return song