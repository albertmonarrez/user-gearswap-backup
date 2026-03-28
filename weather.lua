-- Simple weather and day detection for gearswap
-- Drop-in replacement for broken world.weather_element and world.day_element

-- NOTE: Weather IDs may vary by server/version. Test with //gs c weather and adjust if needed!
-- Day IDs should be standard across all servers (0-7 cycle)

-- Weather ID to Element mapping (based on wiki sources)

local weather_detection = {}

local weather_elements = {
    [1] = 0,  -- Sunny (Fire)
    [3] = 0,  -- Hot Spell (Fire)
    [4] = 0,  -- Heatwave (Fire)
    [5] = 5,  -- Rain (Water)
    [6] = 5,  -- Squall (Water)
    [7] = 2,  -- Wind (Wind)
    [8] = 2,  -- Gales (Wind)
    [9] = 3,  -- Dust Storm (Earth)
    [10] = 3, -- Sand Storm (Earth)
    [11] = 4, -- Thunder (Thunder)
    [12] = 4, -- Thunderstorms (Thunder)
    [13] = 1, -- Snow (Ice)
    [14] = 1, -- Blizzards (Ice)
    [15] = 6, -- Aurora (Light) - single
    [16] = 7, -- Gloom (Dark) - single
    [17] = 6, -- Stellar Glare (Light) - double
    [18] = 1, -- Cold Snap (Ice)
    [19] = 7, -- Miasma (Dark) - double
}

-- Weather intensity (1=single bonus, 2=double bonus)
local weather_intensity = {
    [1] = 1,  -- Sunny
    [3] = 2,  -- Hot Spell
    [4] = 2,  -- Heatwave
    [5] = 1,  -- Rain
    [6] = 2,  -- Squall
    [7] = 1,  -- Wind
    [8] = 2,  -- Gales
    [9] = 1,  -- Dust Storm
    [10] = 2, -- Sand Storm
    [11] = 1, -- Thunder
    [12] = 2, -- Thunderstorms
    [13] = 1, -- Snow
    [14] = 2, -- Blizzards
    [15] = 1, -- Aurora (single light)
    [16] = 1, -- Gloom (single dark)
    [17] = 2, -- Stellar Glare (double light)
    [18] = 2, -- Cold Snap
    [19] = 2, -- Miasma (double dark)
}

-- Simple functions to replace broken gearswap weather functions
function weather_detection.get_weather_element()
    local info = windower.ffxi.get_info()
    return weather_elements[info.weather]
end

function weather_detection.get_weather_intensity()
    local info = windower.ffxi.get_info()
    return weather_intensity[info.weather] or 0
end

-- Debug function to help map weather IDs on your server
function weather_detection.debug_weather()
    local info = windower.ffxi.get_info()
    local raw_weather_id = info.weather
    local mapped_element = weather_elements[raw_weather_id]
    local mapped_intensity = weather_intensity[raw_weather_id] or 0

    return string.format("Raw Weather ID: %d, Mapped Element: %s, Intensity: %d",
        raw_weather_id,
        mapped_element and tostring(mapped_element) or "Unknown",
        mapped_intensity)
end

-- Day ID to Element mapping (FFXI week cycle: "FEW WILL Die")
local day_elements = {
    [0] = 0, -- Firesday (Fire)
    [1] = 3, -- Earthsday (Earth)
    [2] = 5, -- Watersday (Water)
    [3] = 2, -- Windsday (Wind)
    [4] = 1, -- Iceday (Ice)
    [5] = 4, -- Lightningday (Thunder)
    [6] = 6, -- Lightsday (Light)
    [7] = 7, -- Darksday (Dark)
}

-- Element weakness mapping (what each element is weak to)
local elements = {
    weak_to = {
        [0] = 5, -- Fire weak to Water
        [1] = 0, -- Ice weak to Fire
        [2] = 1, -- Wind weak to Ice
        [3] = 2, -- Earth weak to Wind
        [4] = 3, -- Thunder weak to Earth
        [5] = 4, -- Water weak to Thunder
        [6] = 7, -- Light weak to Dark
        [7] = 6, -- Dark weak to Light
    }
}

-- Day element functions (replacements for world.day_element)
function weather_detection.get_day_element()
    local info = windower.ffxi.get_info()
    return day_elements[info.day]
end

-- Debug function for day info
function weather_detection.debug_day()
    local info = windower.ffxi.get_info()
    local day_id = info.day
    local day_element = day_elements[day_id]

    local day_names = { "Firesday", "Earthsday", "Watersday", "Windsday", "Iceday", "Lightningday", "Lightsday",
        "Darksday" }
    local day_name = day_names[day_id + 1] or "Unknown"

    return string.format("Day ID: %d (%s), Element: %s",
        day_id, day_name, day_element and tostring(day_element) or "Unknown")
end

return weather_detection
