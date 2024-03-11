local sparrow = {}

---gets quads from a sparrow format
---@param filepath string
---@param image love.Image
---@return table animations
function sparrow:getSparrow(filepath, image)
    local xml = love.filesystem.newFile(filepath .. ".xml")

    local xmlTable = {}
    local animations = {}

    for line in xml:read():gmatch("([^\n]+)") do
        line = line:gsub("[</>\t]", "")
        if line:match("SubTexture") then
            line = line:gsub("SubTexture", "")
            local name = ""
            local frame = "0000"
            for data in line:gmatch('([^ ]+)') do
                
                local dataTable = {}
                for information in data:gmatch('([^=]+)') do
                    local info
                    if information:match('%b""') then
                        info = tonumber(information:gsub('"', "")) or information:gsub('"', "")
                    else
                        if information:match('true') or information:match('false') then
                            if information:match('true') then
                                info = true
                            else
                                info = false
                            end
                        else
                            info = information
                        end
                    end
                    table.insert(dataTable, info)
                end
                -- need to replace this with animation and not xmltable because this feels useless
                if dataTable[1] == "name" then
                    name = dataTable[2]:sub(0, #dataTable[2] - 4)
                    if xmlTable[name] == nil then
                        xmlTable[name] = {}
                    end
                        frame = dataTable[2]:sub(#dataTable[2] - 3, #dataTable[2])
                        xmlTable[name][frame] =
                        {
                            x = 0,
                            y = 0,
                            width = 0,
                            height = 0,
                            frameX = 0,
                            frameY = 0,
                            frameHeight = 0,
                            frameWidth = 0,
                            Rrotated = false,
                        }
                else

                    xmlTable[name][frame][dataTable[1]] = dataTable[2]
                end
            end

        end
    end
    for animation, data in pairs(xmlTable) do
        animations[animation] = {}
        for frame, frames in pairs(data) do
            animations[animation][frame] = {
                quad = love.graphics.newQuad(frames["x"], frames["y"], frames["width"], frames["height"], image:getWidth(), image:getHeight()),
                frameX =  frames["frameX"],
                frameY = frames["frameY"],
                frameWidth = frames["frameWidth"],
                frameHeight = frames["frameHeight"],
                Rrotated = frames["Rrotated"],
            }
            -- for var, value in pairs(frames) do
            --     print(var, value)
            -- end
        end
    end

    xmlTable = nil
    xml:release()
    return animations
end


return sparrow