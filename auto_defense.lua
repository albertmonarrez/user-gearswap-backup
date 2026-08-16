local res = require('resources')

-- Generic auto defensive response library, extracted from patterns in
-- Desertstorm_SAM.lua. Two independent, separately-configured pieces, both
-- driven automatically off HP% - no manual trigger required:
--   1. should_defend() - HP% check the caller polls to decide whether to equip
--      its own panic gear set. Equipping/reverting gear is left to the caller
--      since "normal gear" is deeply job/state specific.
--   2. update() - auto-fires/toggles job abilities (Super Jump, Defender) when
--      HP% drops below their configured threshold and the job/subjob matches.
-- Healing and spellcasting are intentionally out of scope.

---@alias AutoDefenseAbilityType 'fire_once'|'toggle'

---@class AutoDefenseAbility
---@field name string Job ability name as it appears in res.job_abilities, e.g. "Super Jump"
---@field type AutoDefenseAbilityType 'fire_once' latches until HP recovers above threshold_pct (e.g. Super Jump); 'toggle' turns on/off to track threshold_pct (e.g. Defender)
---@field threshold_pct number HP% (0-100) at/below which this ability should be active
---@field requires_job string|nil Three-letter job code; matches main OR sub job. Omit to apply regardless of job.
---@field target string|nil Windower target token, e.g. "<me>", "<bt>". Defaults to "<me>".

---@class AutoDefenseConfig
---@field gear_threshold_pct number|nil HP% (0-100) at/below which should_defend() returns true (default 20)
---@field abilities AutoDefenseAbility[]|nil Defaults to DEFAULT_ABILITIES (DRG sub Super Jump + High Jump, mirroring Desertstorm_SAM.lua) if omitted. Pass {} explicitly to disable ability auto-fire entirely.

---@class AutoDefense
---@field gear_threshold_pct number
---@field abilities AutoDefenseAbility[]
---@field fired table<string, boolean>
local AutoDefense = {}
AutoDefense.__index = AutoDefense

local BLOCKING_BUFFS = {
    'Weakness', 'Terror', 'Petrification', 'Sleep', 'Amnesia', 'Silence',
}

-- Statuses that leave the player unable to act/attack at all - can't fight back,
-- so should_defend() treats these as an immediate max-defense case regardless of
-- current HP%.
local INCAPACITATED_BUFFS = {
    'Sleep', 'Petrification', 'Stun', 'Terror',
}

-- Same DRG-sub jump combo Desertstorm_SAM.lua auto-fires below its AutoSaveThreshold -
-- an enmity-reset escape, not real mitigation. Applied whenever nothing is configured,
-- since it's a safe no-op for jobs/subjobs that don't have these abilities available.
---@type AutoDefenseAbility[]
local DEFAULT_ABILITIES = {
    { name = 'Super Jump', type = 'fire_once', threshold_pct = 25, requires_job = 'DRG', target = '<bt>' },
    { name = 'High Jump',  type = 'fire_once', threshold_pct = 25, requires_job = 'DRG', target = '<bt>' },
}

---@return boolean
local function safe_to_act()
    if player.status ~= 'Engaged' then return false end
    ---@diagnostic disable-next-line: undefined-global
    if world.area and TownZones and TownZones:contains(world.area) then return false end
    if windower.ffxi.get_info().mog_house then return false end
    for _, buff in ipairs(BLOCKING_BUFFS) do
        if buffactive[buff] then return false end
    end
    return true
end

---@param requires_job string|nil
---@return boolean
local function job_matches(requires_job)
    if not requires_job then return true end
    return player.main_job == requires_job or player.sub_job == requires_job
end

---@param config AutoDefenseConfig|nil
---@return AutoDefense
function AutoDefense.new(config)
    config = config or {}
    local instance = setmetatable({}, AutoDefense)
    instance.gear_threshold_pct = config.gear_threshold_pct or 20
    instance.abilities = config.abilities or DEFAULT_ABILITIES
    instance.fired = {}
    return instance
end

---@return boolean
function AutoDefense:should_defend()
    if not player or not player.hpp then return false end
    if player.status == 'Dead' then return false end

    for _, buff in ipairs(INCAPACITATED_BUFFS) do
        if buffactive[buff] then return true end
    end

    if buffactive['Weakness'] then return false end
    return player.hpp <= self.gear_threshold_pct
end

---@param name string
---@param target string|nil Defaults to "<me>"
function AutoDefense:_use_ability(name, target)
    send_command(string.format('input /ja "%s" %s', name, target or '<me>'))
end

---@param name string
---@return boolean
function AutoDefense:_recast_ready(name)
    local data = res.job_abilities:with('en', name)
    if not data or not data.recast_id then return false end
    local recast = windower.ffxi.get_ability_recasts()[data.recast_id]
    return recast == nil or recast == 0
end

---@param ability AutoDefenseAbility
function AutoDefense:_handle_fire_once(ability)
    if player.hpp > ability.threshold_pct then
        self.fired[ability.name] = nil
        return
    end
    if self.fired[ability.name] then return end
    if not self:_recast_ready(ability.name) then return end

    self:_use_ability(ability.name, ability.target)
    self.fired[ability.name] = true
end

---@param ability AutoDefenseAbility
function AutoDefense:_handle_toggle(ability)
    local active = buffactive[ability.name] and true or false
    local should_be_active = player.hpp <= ability.threshold_pct
    if should_be_active == active then return end
    if should_be_active and not self:_recast_ready(ability.name) then return end

    self:_use_ability(ability.name, ability.target)
end

-- Call every tick (e.g. from your file's own status_change/heartbeat handling).
function AutoDefense:update()
    if not player or not player.hpp then return end
    if not safe_to_act() then return end

    for _, ability in ipairs(self.abilities) do
        if job_matches(ability.requires_job) then
            if ability.type == 'fire_once' then
                self:_handle_fire_once(ability)
            elseif ability.type == 'toggle' then
                self:_handle_toggle(ability)
            end
        end
    end
end

return AutoDefense
