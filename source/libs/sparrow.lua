local sparrow = {}

local function pivotY(x, frames)
    if x ~= 0 then
        return frames["frameHeight"] / (frames["pivotY"])
    end
    return 0
end

local function pivotX(x, frames)
    if x ~= 0 then
        return frames["frameWidth"] / (frames["pivotX"])
    end
    return 0
end

---gets quads from a sparrow format
---@param filepath string
---@param image love.Image
---@return table XMlTable
function sparrow:getSparrow(filepath, image)

    local xmlfile = love.filesystem.newFile(filepath)

    local XMlTable = {}

    for line in xmlfile:read():gmatch("([^\n]+)") do
        line = line:gsub("\t[</>]", "")
        
        local name = ""
        local frame = "0000"
        if line:match("SubTexture") then
            line = line:gsub("SubTexture", 1)
            for vars in line:gmatch('%a+=%b""') do
                local dataTable = {}
                for DataValue in vars:gmatch("([^=]+)") do
                    table.insert(dataTable, DataValue)
                end

                if dataTable[1]:gsub('"', '') == "name" then
                    name = dataTable[2]:gsub('"', '')
                    frame = dataTable[2]:sub(#name - 2, #name + 1)
                    name = dataTable[2]:sub(2, #name - 3)
                    
                    if not XMlTable[name] then
                        XMlTable[name] = {}
                    end
                    
                    XMlTable[name][frame] = {
                        x = 0,
                        y = 0,
                        width = 0,
                        height = 0,
                        frameX = 0,
                        frameY = 0,
                        frameHeight = 0,
                        frameWidth = 0,
                        rotated = false
                    }
                else
                    if dataTable[2]:gsub('"', '') == "true" then
                        dataTable[2] = true
                    else
                        dataTable[2] = tonumber(dataTable[2]:gsub('"', '')) or dataTable[2]:gsub('"', '')
                    end
                    XMlTable[name][frame][dataTable[1]] = dataTable[2]
                end
            end
            XMlTable[name][frame].quad = love.graphics.newQuad(XMlTable[name][frame].x, XMlTable[name][frame].y, XMlTable[name][frame].width, XMlTable[name][frame].height, image:getWidth(), image:getHeight())
            -- removes x, y, width, and height from the table
            XMlTable[name][frame].x = nil
            XMlTable[name][frame].y = nil
            XMlTable[name][frame].width = nil
            XMlTable[name][frame].height = nil
        end
    end
    xmlfile:release()
    return XMlTable

    -- local xml = love.filesystem.newFile(filepath)

    -- local xmlTable = {}
    -- local animations = {}

    -- for line in xml:read():gmatch("([^\n]+)") do
    --     line = line:gsub("[</>\t]", "")
    --     if line:match("SubTexture") then
    --         line = line:gsub("SubTexture", "")
    --         local name = ""
    --         local frame = "0000"
    --         for data in line:gmatch('([^ ]+)') do
                
    --             local dataTable = {}
    --             for information in data:gmatch('([^=]+)') do
    --                 local info
    --                 if information:match('%b""') then
    --                     info = tonumber(information:gsub('"', "")) or information:gsub('"', "")
    --                 else
    --                     if information:match('true') then
    --                         if information:match('true') then
    --                             info = true
    --                         else
    --                             info = false
    --                         end
    --                     else
    --                         info = information
    --                     end
    --                 end
    --                 table.insert(dataTable, info)
    --             end
    --             -- need to replace this with animation and not xmltable because this feels useless
    --             if dataTable[1] == "name" then
    --                 name = dataTable[2]:sub(0, #dataTable[2] - 4)
    --                 print(name)
    --                 if xmlTable[name] == nil then
    --                     xmlTable[name] = {}
    --                 end
    --                     frame = dataTable[2]:sub(#dataTable[2] - 3, #dataTable[2])
    --                     xmlTable[name][frame] =
    --                     {
    --                         x = 0,
    --                         y = 0,
    --                         width = 0,
    --                         height = 0,
    --                         frameX = 0,
    --                         frameY = 0,
    --                         frameHeight = 0,
    --                         frameWidth = 0,
    --                         pivotX = 0,
    --                         pivotY = 0,
    --                         rotated = 0
    --                     }
    --             else
    --                 if dataTable[1] == "rotated" then
    --                     if dataTable[2] then
    --                         xmlTable[name][frame][dataTable[1]] = math.rad(-90)
    --                     else
    --                         xmlTable[name][frame][dataTable[1]] = 0
    --                     end
    --                 else
    --                     xmlTable[name][frame][dataTable[1]] = dataTable[2]
    --                 end
    --             end
    --         end

    --     end
    -- end
    -- for animation, data in pairs(xmlTable) do
    --     animations[animation] = {}
    --     for frame, frames in pairs(data) do
    --         animations[animation][frame] = {
    --             quad = love.graphics.newQuad(frames["x"], frames["y"], frames["width"], frames["height"], image:getWidth(), image:getHeight()),
    --             frameX =  frames["frameX"],
    --             frameY = frames["frameY"] - (((frames["rotated"] / math.rad(-90)) * (frames["height"] / 2))),
    --             frameWidth = frames["frameWidth"],
    --             frameHeight = frames["frameHeight"],
    --             pivotX = pivotX(frames["pivotX"], frames),
    --             pivotY = pivotX(frames["pivotY"], frames),
    --             rotated = frames["rotated"],
    --         }
    --         -- for var, value in pairs(frames) do
    --         --     print(var, value)
    --         -- end
    --     end
    -- end

    -- xmlTable = nil
    -- xml:release()
    -- return animations
end


return sparrow