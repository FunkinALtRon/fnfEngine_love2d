local characters = {}
characters.character = {}

local sparrow = require("source.libs.sparrow")
local Json = require("source.libs.json")

local anim = "gf dance"

---comment
---@param time integer
---@param lastFrame string
---@param frames table
---@return string
local function updateframes(time, lastFrame, frames)

    local newframe = {}

    for i = 0, 3 do
        local newTime = tostring(time):sub(i - 4, i - 4)
        if newTime == "" then
            table.insert(newframe, "0")
        else
            table.insert(newframe, newTime)
        end
    end
    print(table.concat(newframe, ""), time)
    if not frames[table.concat(newframe, "")] then
        return lastFrame
    end

    return table.concat(newframe, "")
end

---comment
---@param JsonPath string
---@param x integer
---@param y integer
---@param angle integer
---@return table
function characters:load(JsonPath, x, y, angle)
    local characterJson = Json.decode(love.filesystem.newFile("assets/characters/" .. JsonPath .. ".json"):read())
    
    local img = love.graphics.newImage("assets/images/" .. characterJson.image .. ".png")
    characters.character["x"] = x or 0
    characters.character["y"] = y or 0
    characters.character["angle"] = angle or 0
    characters.character["animations"] = nil
    characters.character["animationsXML"] = sparrow:getSparrow("assets/images/" .. characterJson.image .. ".xml", img)
    characters.character["image"] = img
    characters.character["CurFrame"] = "0000"
    characters.character["CurAnimation"] = "gf dance0000"
    characters.character["startTimer"] = Timer

    return characters.character
end

function characters.character:update(dt)
    print(self.animationsXML[anim])
    self.CurFrame = updateframes(math.floor((Timer - self.startTimer) * 24), self.CurFrame, self.animationsXML[anim])
end

function characters.character:PlayAnim(AnimName)
    anim = AnimName
    self.CurFrame = "0000"
    self.startTimer = Timer
end

function characters.character:draw()
    love.graphics.draw(self.image, self.animationsXML[anim][self.CurFrame]["quad"], -self.animationsXML[anim][self.CurFrame]["frameX"], self.animationsXML[anim][self.CurFrame]["frameY"], self.animationsXML[anim][self.CurFrame]["rotated"], 0.5, 0.5, 0, 0)
end

return characters