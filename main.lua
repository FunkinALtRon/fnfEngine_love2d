
local xml = love.filesystem.newFile("p2sonic.xml"):read()

local xmlTable = {}

for line in xml:gmatch("([^\n]+)") do
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
                    xmlTable[name]["0000"] =
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
                end
            else
                print(dataTable[1], frame, name)
                xmlTable[name][frame][dataTable[1]] = dataTable[2]
            end
        end

    end
end