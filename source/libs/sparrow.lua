local sparrow = {}

---gets quads from a sparrow format
---@param filepath string
---@return animations table
function sparrow:getSparrow(filepath)
    local xml = love.filesystem.newFile(filepath .. ".xml")
    local img = love.graphics.newImage(filepath .. ".png")

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
        print(animation, data)
        animations[animation] = {}
        for frame, frames in pairs(data) do
            animations[animation][frame] = love.graphics.newQuad(frames["x"], frames["y"], frames["width"], frames["height"], img:getWidth(), img:getHeight())
            -- for var, value in pairs(frames) do
            --     print(var, value)
            -- end
        end
    end

    xml:release()
    img:release()
    return animations
end


return sparrow