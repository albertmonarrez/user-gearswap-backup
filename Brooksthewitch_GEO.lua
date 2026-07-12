local socket = require('socket')
---@diagnostic disable: undefined-global
-- Original: Motenten / Modified: Arislan
-- GearSwap Lua for GEO
-- Player: Player
-- Generated: 2026-06-12 18:16

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job. Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent. state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Bolster'] = buffactive['Bolster'] or false
    state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false
    state.Buff['Entrust'] = buffactive['Entrust'] or false

    no_swap_gear = S { "Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
        "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring" }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job. Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

local function set_lockstyle()
    send_command('wait 4; input /lockstyleset 3')
end

-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
    state.IdleMode:options('Normal', 'DT', 'Refresh')
    state.CastingMode:options('Normal', 'Resistant')
    state.HybridMode:options('Normal', 'DT')

    state.MagicBurst = M(false, 'Magic Burst')

    state.WeaponLock = M(false, 'Weapon Lock')

    -- Additional local binds
    -- include('Global-Binds.lua') -- OK to remove this line

    -- Default macro book/set
    set_macro_page(1, 1)
    set_lockstyle()
end

function user_unload()
    -- Unbind keys here if needed
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Gear Variables ----------------------------------------
    ------------------------------------------------------------------------------------------------

    local gear = require('Brooksthewitch_Gear')
    sets.pet = {}

    sets.MoveSpeed = {
        feet = gear.Geomancy_Sandals,
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast Cast
    sets.precast.FC = {
        --main="",
        --range="",
        head = gear.Merl_Hood_FC,
        --neck="",
        --ear1="",
        ear2 = gear.Loquac_Earring,
        body = gear.Merl_Jubbah_FC,
        --hands="",
        --ring1="",
        --ring2="",
        waist = gear.Embla_Sash,
        back = gear.Nantosuelta_Cape_FC,
        legs = gear.Geomancy_Pants,
        feet = gear.Merl_Crackows_FC,
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- JA Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Full Circle
    sets.precast.JA['Full Circle'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Bolster
    sets.precast.JA['Bolster'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        neck = gear.Bagua_Charm,
        --ear1="",
        --ear2="",
        body = gear.Bagua_Tunic,
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Life Cycle
    sets.precast.JA['Life Cycle'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        body = gear.Geomancy_Tunic,
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Radial Arcana
    sets.precast.JA['Radial Arcana'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        feet = gear.Bagua_Sandals,
    }

    -- Mending Halation
    sets.precast.JA['Mending Halation'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        legs = gear.Bagua_Pants,
        --feet="",
    }

    -- Concentric Pulse
    sets.precast.JA['Concentric Pulse'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Blaze of Glory
    sets.precast.JA['Blaze of Glory'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Dematerialize
    sets.precast.JA['Dematerialize'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Theurgic Focus
    sets.precast.JA['Theurgic Focus'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Enhancing Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enhancing Magic
    sets.midcast['Enhancing Magic'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Enhancing duration
    sets.midcast.EnhancingDuration = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Elemental Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Elemental Magic
    sets.midcast['Elemental Magic'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Jhakri_Coronal,
        neck = gear.Mizu_Kubikazari,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Sortiarius_Earring,
        body = gear.Jhakri_Robe,
        hands = gear.Jhakri_Cuffs,
        --ring1="",
        ring2 = gear.Jhakri_Ring,
        --back="",
        --waist="",
        legs = gear.Jhakri_Slops,
        feet = gear.Jhakri_Pigaches,
    }

    -- Magic Burst
    sets.midcast['Elemental Magic'].MB = set_combine(sets.midcast['Elemental Magic'], {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Healing Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Cure
    sets.midcast.Cure = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        neck = gear.Nodens_Gorget,
        ear1 = gear.Alabaster_Earring,
        --ear2="",
        body = gear.Vanya_Robe,
        hands = gear.Vanya_Cuffs,
        ring1 = gear.Murky_Ring,
        --ring2="",
        --back="",
        --waist="",
        legs = gear.Vanya_Slops,
        feet = gear.Vanya_Clogs,
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Buff Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Doom (Holy Water)
    sets.buff.Doom = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Entrust active
    sets.buff.Entrust = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Idle Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default idle
    sets.idle = {
        --main="",
        sub = gear.Genmei_Shield,
        range = gear.Dunna,
        head = gear.Azimuth_Hood,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Azimuth_Earring,
        body = gear.Jhakri_Robe,
        hands = gear.Azimuth_Gloves,
        ring1 = gear.Murky_Ring,
        --ring2="",
        back = gear.Nantosuelta_Cape_Pet,
        legs = gear.Assid_Pants,
        feet = gear.Azimuth_Gaiters,
    }

    -- Idle DT
    sets.idle.DT = set_combine(sets.idle, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    })

    -- Idle Refresh
    sets.idle.Refresh = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Idle with Luopan
    sets.idle.Pet = set_combine(sets.idle, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Base engaged
    sets.engaged = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Jhakri_Coronal,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Brutal_Earring,
        body = gear.MG_Bodice,
        hands = gear.MG_Gloves,
        ring1 = gear.Murky_Ring,
        --ring2="",
        --back="",
        --waist="",
        legs = gear.Jhakri_Slops,
        feet = gear.MGF_Ledelsens,
    }

    -- DT while engaged
    sets.engaged.DT = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Geomancy Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Geomancy base
    sets.midcast['Geomancy'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        neck = gear.Bagua_Charm,
        --ear1="",
        --ear2="",
        body = gear.Bagua_Tunic,
        -- hands = gear.Bagua_Mitaines,
        ring1 = gear.Murky_Ring,
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Geo- spells
    sets.midcast.Geo = set_combine(sets.midcast['Geomancy'], {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Azimuth_Hood,
        neck = gear.Bagua_Charm,
        --ear1="",
        --ear2="",
        --body="",
        hands = gear.Geomancy_Mitaines,
        --ring1="",
        --ring2="",
        back = gear.Nantosuelta_Cape_Pet,
        --waist="",
        --legs="",
        feet = gear.Bagua_Sandals,
    })

    -- Indi- spells
    sets.midcast.Indi = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Azimuth_Hood,
        neck = gear.Bagua_Charm,
        --ear1="",
        ear2 = gear.Azimuth_Earring,
        --body="",
        hands = gear.Geomancy_Mitaines,
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        legs = gear.Bagua_Pants,
        feet = gear.Azimuth_Gaiters,
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Pet Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Luopan potency/duration
    sets.pet.Luopan = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        hands = gear.Geomancy_Mitaines,
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        feet = gear.Geomancy_Sandals,
    }

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default WS set
    sets.precast.WS = {
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        hands = gear.Jhakri_Cuffs,
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Black Halo: Physical (STR:30%, MND:70%)
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        -- hands = gear.Jhakri_Cuffs,
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    })

    -- Exudation: Physical
    sets.precast.WS['Exudation'] = set_combine(sets.precast.WS, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    })

    -- Hexa Strike: Physical (STR:30%, MND:30%)
    sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    })
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Indi-') then
        equip(sets.midcast.Indi)
        eventArgs.handled = true
    elseif spell.english:startswith('Geo-') then
        equip(sets.midcast.Geo)
        eventArgs.handled = true
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Add any aftercast logic here
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Doom' then
        if gain then
            send_command('@input /p Doomed.')
        end
    end
end

function job_state_change(stateField, newValue, oldValue)
    -- Handle state changes like WeaponLock
    if stateField == 'Weapon Lock' then
        if newValue == true then
            disable('main', 'sub', 'range')
        else
            enable('main', 'sub', 'range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


local function check_rings()
    if no_swap_gear:contains(player.equipment.ring1) then
        disable('ring1')
    else
        enable('ring1')
    end
    if no_swap_gear:contains(player.equipment.ring2) then
        disable('ring2')
    else
        enable('ring2')
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_rings()
end

local move_x = nil
local move_y = nil
local is_moving = false
local last_move_poll = 0

local function check_moving()
    local now = socket.gettime()
    if now - last_move_poll < 0.3 then return end
    last_move_poll = now

    local mob = windower.ffxi.get_mob_by_target('me')
    if not mob then return end

    local nx, ny = mob.x, mob.y
    if (move_x ~= nx or move_y ~= ny) and mob.status ~= 1 then
        move_x = nx
        move_y = ny
        is_moving = true
        equip(sets.MoveSpeed)
    elseif is_moving then
        is_moving = false
        handle_equipping_gear(player.status)
    end
end

windower.register_event('prerender', check_moving)

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
