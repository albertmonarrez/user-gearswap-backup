---@meta
-- Pure type declarations for GearSwap's own globals (player, world, buffactive),
-- reverse-engineered from packet_parsing.lua/refresh.lua/statics.lua/helper_functions.lua.
-- This file is never require()'d - it exists only for LuaLS static analysis (picked
-- up automatically since it lives in this workspace folder, like any other .lua file).
--
-- These are distinct from Windower's own windower.ffxi.get_player()/get_info():
-- GearSwap keeps its own copies with different shapes (e.g. player.status is the
-- English status name here, not the numeric status id windower.ffxi.get_player()
-- returns).

---@class GSVitals
---@field hp number Current HP
---@field mp number Current MP
---@field tp number Current TP (0-3000)
---@field hpp number Current HP as a percentage of max (0-100)
---@field mpp number Current MP as a percentage of max (0-100)
---@field max_hp number
---@field max_mp number

---@class GSPlayer
---@field id number
---@field index number
---@field name string
---@field status string English status name (e.g. "Engaged", "Idle", "Dead"), converted from status_id via res.statuses
---@field status_id number Raw numeric status id
---@field main_job string Three-letter job code, e.g. "SAM"
---@field main_job_id number
---@field main_job_level number
---@field sub_job string Three-letter job code, e.g. "DRG"
---@field sub_job_id number
---@field sub_job_level number
---@field hp number Current HP (mirrors vitals.hp)
---@field mp number Current MP (mirrors vitals.mp)
---@field tp number Current TP (mirrors vitals.tp)
---@field hpp number Current HP% (mirrors vitals.hpp)
---@field mpp number Current MP% (mirrors vitals.mpp)
---@field max_hp number
---@field max_mp number
---@field vitals GSVitals
---@field buffs number[] Raw active buff ids, indexed 1-32 (255 = empty slot)
---@field target table|nil Current <t> target, or nil
---@field subtarget table|nil Current <st> target, or nil
---@field equipment table Currently equipped gear, keyed by slot name
---@field attack number Current total attack, gear/buffs included
---@field defense number Current total defense, gear/buffs included
---@field str number Total STR (base + gear/buff bonus)
---@field dex number Total DEX
---@field vit number Total VIT
---@field agi number Total AGI
---@field int number Total INT
---@field mnd number Total MND
---@field chr number Total CHR
---@field base_str number STR before gear/buff bonus
---@field base_dex number
---@field base_vit number
---@field base_agi number
---@field base_int number
---@field base_mnd number
---@field base_chr number
---@field add_str number Gear/buff bonus applied to STR
---@field add_dex number
---@field add_vit number
---@field add_agi number
---@field add_int number
---@field add_mnd number
---@field add_chr number
---@field fire_resistance number
---@field ice_resistance number
---@field wind_resistance number
---@field earth_resistance number
---@field lightning_resistance number
---@field water_resistance number
---@field light_resistance number
---@field dark_resistance number
---@field nation string
---@field nation_id number

---@class GSWorld
---@field area string Current zone name, e.g. "Bastok Markets", "Windurst Woods", "Upper Jeuno", "Abyssea - Konschtat". Always identical to world.zone - GearSwap just sets both to the same value.
---@field zone string Current zone name
---@field zone_id number
---@field day string
---@field day_element string
---@field moon_pct number
---@field moon string
---@field weather_id number Index into res.weather (res/weather.lua, ids 0-19). "Effective" weather for elemental/magic burst calc - overridden to a fixed id while a Geomancer Bolster-style weather buff is active (buff ids 178-185 for base weathers, 589-596 for the "II" tiers), regardless of the server's actual weather. Set in refresh.lua's weather_update(id).
---@field real_weather_id number Index into res.weather, same table as weather_id. Always the server's true ambient weather - never overridden by buffs, unlike weather_id.
---@field weather string English weather name, e.g. "Rain" - res.weather[weather_id][language]
---@field real_weather string English weather name for the true server weather - res.weather[real_weather_id][language]
---@field weather_element string English element name for weather_id's weather, e.g. "Water" - res.elements[res.weather[weather_id].element][language]. Pre-computed - no need to do the res.weather/res.elements lookup yourself.
---@field real_weather_element string Same as weather_element but for real_weather_id.
---@field weather_intensity number 0 (none) or 1-2, matching res.weather[weather_id].intensity
---@field real_weather_intensity number Same as weather_intensity but for real_weather_id.
---@field logged_in boolean

-- res.weather (res/weather.lua) - what world.weather_id / world.real_weather_id index into:
--   id  weather            element     intensity     id  weather            element     intensity
--    0  Fine patches       Light       0              10  Winds              Wind        1
--    1  Sunshine           Light       0              11  Gales              Wind        2
--    2  Clouds             Light       0              12  Snow               Ice         1
--    3  Fog                Light       0              13  Blizzards          Ice         2
--    4  Hot spells         Fire        1              14  Thunder            Lightning   1
--    5  Heat waves         Fire        2              15  Thunderstorms      Lightning   2
--    6  Rain               Water       1              16  Auroras            Light       1
--    7  Squalls            Water       2              17  Stellar glare      Light       2
--    8  Dust storms        Earth       1              18  Gloom              Dark        1
--    9  Sand storms        Earth       2              19  Darkness           Dark        2

---Mote-Include global (libs/Mote-Utility.lua) - only available if your job file
---does include('Mote-Include.lua'). Equivalent to world.weather_intensity, just
---the call site every Mote-Include job file actually uses (COR.lua,
---Desertstorm_GEO.lua, Desertstorm_SAM.lua) instead of reading the field directly.
---@return number intensity 0 = no weather, 1 = single weather, 2 = double weather
function get_weather_intensity() end

---GearSwap's buffactive table. Keys are case-insensitive (internally lowercased by
---a __index/__newindex metatable), so buffactive['Weakness'] and buffactive['weakness']
---both resolve the same entry. Value is the active stack count, or nil if not active.
---@alias GSBuffActive table<string, number>

---@type GSPlayer
player = nil

---@type GSWorld
world = nil

---@type GSBuffActive
buffactive = nil

---Not a GearSwap-provided global - a per-job-file convention (Desertstorm_SAM.lua,
---Desertstorm_PLD.lua, etc. each define their own S{...} (Windower's Sets lib) of
---zone names at top level). Job files that don't define it leave it nil, so always
---guard with `TownZones and` before calling :contains() - see safe_to_act() in
---data/auto_defense.lua.
---@type table|nil
TownZones = nil

---@class GSPetVitals
---@field hp number
---@field mp number
---@field hpp number
---@field mpp number
---@field max_hp number
---@field max_mp number
---@field tp number

---@class GSPet : GSPetVitals
---@field isvalid boolean False when you have no pet out (all other fields are stale/absent when false)
---@field name string
---@field mob_name string|nil
---@field id number
---@field index number
---@field element string English element name, e.g. "Fire" (avatars), "Physical" (most others)
---@field head string|nil BST jug pet head part, only set while main/sub job is BST (id 18)
---@field frame string|nil PUP automaton frame, only set while main/sub job is PUP (id 23)
---@field attachments table<string, boolean>|nil PUP automaton attachments, only set for PUP
---@field available_heads table<string, boolean>|nil
---@field available_frames table<string, boolean>|nil
---@field available_attachments table<string, boolean>|nil
---@field species table|nil Monstrosity species data, only set while main job is Monstrosity (id 23... see note) - not fully reverse-engineered

---@type GSPet
pet = nil

---@class GSFellow
---@field isvalid boolean False when you have no trust/fellow out
---@field name string|nil

---@type GSFellow
fellow = nil

---A single windower.ffxi.get_party() entry, copied in as-is plus a few GearSwap
---additions (buffactive/buff_details for party members GearSwap has visibility
---into). Not fully reverse-engineered - field list is what's used in practice.
---@class GSPartyMember
---@field mob table Raw mob table (id, index, name, hp, hpp, mp, mpp, race, ...)
---@field buffactive GSBuffActive|nil Only populated for the player and party members the client has buff visibility into
---@field buff_details table|nil

---One 6-slot party within the alliance. Also carries aggregate fields alongside
---the 1-6 member slots.
---@class GSAllianceParty
---@field [number] GSPartyMember
---@field count number Members present in this party (0-6)
---@field leader number|nil Leader's mob id

---@class GSAlliance
---@field [1] GSAllianceParty
---@field [2] GSAllianceParty
---@field [3] GSAllianceParty
---@field count number Total members across all three parties
---@field leader number|nil Alliance leader's mob id

---@type GSAlliance
alliance = nil

---Alias of alliance[1] - your own (possibly single-member) party.
---@type GSAllianceParty
party = nil

--------------------------------------------------------------------------------
-- User-callable functions exposed to job files, per the user_env sandbox built
-- in refresh.lua (~line 114). Some are aliased under a different name than their
-- definition in user_functions.lua - noted below where that's the case.
--------------------------------------------------------------------------------

---Merges the given gear set(s) into the pending equip. Call from precast/midcast/
---aftercast/status_change/etc. Later sets/slots override earlier ones.
---@param ... table One or more gear set tables to merge, in priority order
function equip(...) end

---Prevents slot(s) from being touched by any subsequent equip() call this cycle.
---@param ... string Slot names, e.g. 'main', 'sub', 'ammo', 'head'
function disable(...) end

---Re-allows previously disable()'d slot(s) and immediately re-equips anything
---that was queued for them. Aliased from user_enable in user_functions.lua.
---@param ... string Slot names
function enable(...) end

---Combines the provided gear sets into a new set and returns it, without equipping.
---@param ... table
---@return table
function set_combine(...) end

---Sends a command through Windower's console, as if typed by the player.
---Aliased from send_cmd_user - auto-prefixes with '@' if missing.
---@param command string
function send_command(command) end

---Cancels the spell/ability currently being precast. Only valid inside
---precast/pretarget/filtered_action.
---@param boolean boolean|nil Defaults to true if omitted
function cancel_spell(boolean) end

---Redirects the target of the spell currently being cast. Only valid inside pretarget.
---@param name string A valid target name
function change_target(name) end

---Adds extra delay (in seconds) before the current cast fires. Only valid inside
---precast/pretarget.
---@param delay number
function cast_delay(delay) end

---Prints a gear set to the chat log, one line per slot.
---@param set table
---@param title string|nil
function print_set(set, title) end

---Writes a line to the Windower chat log. Aliased from add_to_chat_user - accepts
---either (color, text) or just (text).
---@param num number|string Chat color code, or the text itself if color is omitted
---@param str string|nil
function add_to_chat(num, str) end

--------------------------------------------------------------------------------
-- Spell/action table, as passed into precast/midcast/aftercast/pretarget.
--------------------------------------------------------------------------------

---@class GSSpellTarget
---@field name string
---@field raw string Raw target string as typed, e.g. "<t>", "Some Mob"
---@field type string 'SELF'|'PLAYER'|'MONSTER'|'NPC'|'CORPSE'
---@field id number|nil
---@field index number|nil
---@field distance number Distance to target in yalms (plain linear distance, not squared)
---@field model_size number|nil
---@field ispartymember boolean|nil

---@class GSSpell
---@field id number
---@field name string Internal/short name
---@field english string Display name as shown in-game, e.g. "Cure IV", "Super Jump"
---@field en string Alias of english (some job files use this instead)
---@field type string 'Spell'|'JobAbility'|'WeaponSkill'|'Item'|'CorsairRoll'|...
---@field skill string|nil Skill category, e.g. "Enhancing Magic", "Healing Magic"
---@field action_type string|nil
---@field element string|nil
---@field prefix string|nil e.g. "/magic", "/jobability", "/weaponskill"
---@field tp_cost number|nil
---@field target GSSpellTarget
---@field interrupted boolean True if the cast was interrupted (silenced, hit while casting, etc.) - only meaningful in aftercast

--------------------------------------------------------------------------------
-- Job callback hooks. GearSwap core (gearswap.lua/flow.lua/triggers.lua) calls
-- these directly by name if your job file defines them - no eventArgs, single
-- spell/status args only. This is the convention Desertstorm_SAM.lua uses.
--------------------------------------------------------------------------------

---@param spell GSSpell
function precast(spell) end

---@param spell GSSpell
function midcast(spell) end

---@param spell GSSpell
function aftercast(spell) end

---@param spell GSSpell
function pretarget(spell) end

---English status names (already converted from status_id) - see GSStatusId below
---for the numeric id -> name mapping.
---@param newStatus string
---@param oldStatus string
function status_change(newStatus, oldStatus) end

--------------------------------------------------------------------------------
-- Mote-Include's job hook convention (libs/Mote-Include.lua). Only relevant if
-- your job file does include('Mote-Include.lua') - BLU.lua does, SAM.lua doesn't.
-- Mote-Include defines the raw precast/midcast/aftercast/status_change/buff_change
-- hooks above itself, and dispatches to these job_-prefixed ones (plus optional
-- user_-prefixed ones checked first) with an eventArgs you can use to cancel or
-- mark handled.
--------------------------------------------------------------------------------

---@class GSEventArgs
---@field handled boolean|nil Set true to skip GearSwap's default handling for this action
---@field cancel boolean|nil Set true to cancel the spell/ability entirely (precast/pretarget only)

---@param spell GSSpell
---@param action string The action name this hook is firing for, e.g. "precast" (Mote-Include passes this through verbatim - it's a string, not a windower Action object)
---@param spellMap string|nil Mote-Include's category mapping for the spell, e.g. "Cure", "RangedAttack"
---@param eventArgs GSEventArgs
function job_precast(spell, action, spellMap, eventArgs) end

---@param spell GSSpell
---@param action string
---@param spellMap string|nil
---@param eventArgs GSEventArgs
function job_midcast(spell, action, spellMap, eventArgs) end

---@param spell GSSpell
---@param action string
---@param spellMap string|nil
---@param eventArgs GSEventArgs
function job_aftercast(spell, action, spellMap, eventArgs) end

---@param spell GSSpell
---@param action string
---@param spellMap string|nil
---@param eventArgs GSEventArgs
function job_pretarget(spell, action, spellMap, eventArgs) end

---Runs after default_precast() has already equipped sets.precast[...] - the only
---place to layer overrides onto that base set without them getting clobbered by
---it. This is the one that actually fires for WeaponSkill actions - they have no
---cast bar, so GearSwap goes straight from precast to aftercast and job_midcast/
---job_post_midcast never run for them (see BLU.lua's job_post_precast).
---@param spell GSSpell
---@param action string
---@param spellMap string|nil
---@param eventArgs GSEventArgs
function job_post_precast(spell, action, spellMap, eventArgs) end

---@param spell GSSpell
---@param action string
---@param spellMap string|nil
---@param eventArgs GSEventArgs
function job_post_midcast(spell, action, spellMap, eventArgs) end

---@param spell GSSpell
---@param action string
---@param spellMap string|nil
---@param eventArgs GSEventArgs
function job_post_aftercast(spell, action, spellMap, eventArgs) end

---@param newStatus string
---@param oldStatus string
---@param eventArgs GSEventArgs
function job_status_change(newStatus, oldStatus, eventArgs) end

---@param buff string Buff name (case as reported by the game, not necessarily lowercase)
---@param gain boolean True if the buff was just gained, false if just lost
---@param eventArgs GSEventArgs|nil
function job_buff_change(buff, gain, eventArgs) end

--------------------------------------------------------------------------------
-- Recast lookups and job ability resource data, as used by auto_defense.lua.
--------------------------------------------------------------------------------

---Keyed by recast_id (NOT ability/spell id) -> seconds remaining, 0 if ready.
---@alias GSRecastTable table<number, number>

---@class JobAbilityResource
---@field id number
---@field en string English name, e.g. "Super Jump"
---@field ja string
---@field recast_id number Index into windower.ffxi.get_ability_recasts()
---@field mp_cost number
---@field tp_cost number
---@field range number
---@field duration number|nil
---@field status number|nil Buff id applied while this ability's effect is active
---@field type string 'JobAbility'

--------------------------------------------------------------------------------
-- Numeric status ids (player.status_id, and what player.status/status_change's
-- strings are derived from via res.statuses[id].english). Not exhaustive - just
-- the ones job files actually compare against.
--------------------------------------------------------------------------------

---@enum GSStatusId
GSStatusId = {
    IDLE = 0,
    ENGAGED = 1,
    DEAD = 2,
    ENGAGED_DEAD = 3,
    EVENT = 4,
    CHOCOBO = 5,
    RESTING = 33,
}
