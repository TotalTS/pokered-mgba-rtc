-- based on pokered.sym
local ADDR_HOURS   = 0xDA39
local ADDR_MINUTES = 0xDA3A
local ADDR_SECONDS = 0xDA3B
local ADDR_DOW     = 0xDA3C
local ADDR_DAY     = 0xDA3D
local ADDR_MONTH   = 0xDA3E
local ADDR_YEAR    = 0xDA3F

-- initialize Buffers 
local RTCInfo = nil

function initializeBuffers()
    if not RTCInfo then
        RTCInfo = console:createBuffer("RTC Sync")
        RTCInfo:setSize(40, 10)
    end
end

-- From normal number to BCD (Binary Coded Decimal)
function toBCD(val)
    local tens = math.floor(val / 10)
    local ones = val % 10
    return (tens << 4) | ones
end

-- Synchronize Time
function syncTime()
    local date = os.date("*t")

    emu:write8(ADDR_HOURS,   date.hour)
    emu:write8(ADDR_MINUTES, date.min)
    emu:write8(ADDR_SECONDS, date.sec)
    emu:write8(ADDR_DOW,     date.wday - 1) 
    emu:write8(ADDR_DAY,     date.day)
    emu:write8(ADDR_MONTH,   date.month)
    emu:write8(ADDR_YEAR,    date.year % 100)

    RTCInfo:clear()
    RTCInfo:print(string.format("Status: Synchronized (BCD Mode)\n"))
    RTCInfo:print(string.format("PC Time: %02d:%02d:%02d\n", date.hour, date.min, date.sec))
    RTCInfo:print(string.format("Date:   %02d/%02d/%02d", date.day, date.month, date.year % 100))
end

-- main callback
-- Use 'frame' to execute constantly
callbacks:add("frame", function()
    -- Only proceed if emulator is ready
    if emu then
        initializeBuffers() -- create window if it doesn't exist
        
        -- Synchronize every 60 frames (once per second)
        if emu:currentFrame() % 60 == 0 then
            syncTime()
        end
    end
end)

console:log("Script RTC loaded for Pokémon.")