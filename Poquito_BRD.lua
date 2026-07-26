---@diagnostic disable: undefined-global
-- Original: Motenten / Modified: Arislan
-- GearSwap Lua for BRD
-- Player: Player
-- Generated: 2026-06-12 18:21

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
    state.Buff['Soul Voice'] = buffactive['Soul Voice'] or false
    state.Buff['Nightingale'] = buffactive['Nightingale'] or false
    state.Buff['Troubadour'] = buffactive['Troubadour'] or false

    -- no_swap_gear = S { "Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
    --     "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring" }
    no_swap_gear = S {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job. Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

local function set_lockstyle()
    send_command('wait 4; input /lockstyleset 1')
end

-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'STP', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

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

    local gear = require('Poquito_Gear')

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast Cast
    sets.precast.FC = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Nahtirah_Hat,
        neck = gear.Aoidos_Matinee,
        --ear1="",
        ear2 = gear.Loquac_Earring,
        body = gear.Inyanga_Jubbah,
        hands = gear.Gende_Gages,
        ring1 = gear.Kishar_Ring,
        --ring2="",
        back = gear.Intarabus_Cape_FC,
        waist = gear.Embla_Sash,
        legs = gear.Aya_Cosciales,
        feet = gear.Fili_Cothurnes,
    }

    -- Song precast
    sets.precast.FC.Song = set_combine(sets.precast.FC, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Fili_Calot,
        neck = gear.Aoidos_Matinee,
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
    ---------------------------------------- JA Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Soul Voice
    sets.precast.JA['Soul Voice'] = {
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
        legs = gear.Bihu_Cannions,
        --feet="",
    }

    -- Nightingale
    sets.precast.JA['Nightingale'] = {
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
        feet = gear.Bihu_Slippers,
    }

    -- Troubadour
    sets.precast.JA['Troubadour'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        body = gear.Bihu_Jstcorps,
        --hands="",
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        --legs="",
        --feet="",
    }

    -- Clarion Call
    sets.precast.JA['Clarion Call'] = {
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


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Idle Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default idle
    sets.idle = {
        --main="",
        --sub="",
        range = gear.Miracle_Cheer,
        --ammo="",
        head = gear.Null_Masque,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Eabani_Earring,
        body = gear.Fili_Hongreline,
        hands = gear.Fili_Manchettes,
        ring1 = gear.Murky_Ring,
        ring2 = gear.Shneddick_Ring,
        back = gear.Intarabus_Cape_DT,
        waist = gear.Flume_Belt,
        legs = gear.Assid_Pants,
        feet = gear.Fili_Cothurnes,
    }

    -- Idle DT
    sets.idle.DT = {
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


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Base engaged (damage)
    sets.engaged = {
        --main="",
        --sub="",
        range = gear.Linos,
        --ammo="",
        head = gear.Aya_Zucchetto,
        neck = gear.Bards_Charm,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Brutal_Earring,
        body = gear.Ayanmo_Corazza,
        hands = gear.Bunzi_Gloves,
        ring1 = gear.Murky_Ring,
        ring2 = gear.Petrov_Ring,
        back = gear.Null_Shawl,
        waist = gear.Sailfi_Belt,
        legs = gear.Revelation_Brais,
        feet = gear.Battlecast_gaiters,
    }

    -- Store TP focus
    sets.engaged.STP = {
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

    -- Accuracy focus
    sets.engaged.Acc = {
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

    -- Normal + DT
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

    -- STP + DT
    sets.engaged.STP.DT = {
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

    -- Acc + DT
    sets.engaged.Acc.DT = {
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
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Physical DT
    sets.defense.PDT = {
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

    -- Magical DT
    sets.defense.MDT = {
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
    ---------------------------------------- Song Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Base singing (shared slots across all songs)
    sets.midcast.Singing = {
        --main="",
        --sub="",
        range = gear.Miracle_Cheer,
        --ammo="",
        head = gear.Fili_Calot,
        neck = gear.Moonbow_Whistle,
        ear1 = gear.Alabaster_Earring,
        --ear2="",
        body = gear.Fili_Hongreline,
        hands = gear.Fili_Manchettes,
        ring1 = gear.Murky_Ring,
        --ring2="",
        back = gear.Intarabus_Cape_DT,
        --waist="",
        legs = gear.Inyanga_Shalwar,
        feet = gear.Brioso_Slippers,
    }

    -- Song duration (extends base with duration-specific slots)
    sets.midcast.SongDuration = set_combine(sets.midcast.Singing, {
        --head="",
        --body="",
        --hands="",
        --legs="",
        --feet="",
    })

    -- Paeon (HP regen)
    sets.midcast.Paeon = set_combine(sets.midcast.Singing, {
        head = gear.Brioso_Roundlet,
        --body="",
        --hands="",
        --legs="",
        --feet="",
    })

    -- Ballad (MP regen)
    sets.midcast.Ballad = set_combine(sets.midcast.Singing, {
        --head="",
        --body="",
        --hands="",
        legs = gear.Fili_Rhingrave,
        --feet="",
    })

    -- Minne (defense)
    sets.midcast.Minne = set_combine(sets.midcast.Singing, {
        --head="",
        --body="",
        --hands="",
        --legs="",
        --feet="",
    })

    -- Madrigal (accuracy)
    sets.midcast.Madrigal = set_combine(sets.midcast.Singing, {
        --head="",
        --body="",
        --hands="",
        --legs="",
        --feet="",
    })

    -- March (haste)
    sets.midcast.March = set_combine(sets.midcast.Singing, {
        --head="",
        --body="",
        --hands="",
        --legs="",
        --feet="",
    })

    -- Minuet (attack)
    sets.midcast.Minuet = set_combine(sets.midcast.Singing, {
        --head="",
        --body="",
        --hands="",
        --legs="",
        --feet="",
    })

    -- Carol (elemental resistance)
    sets.midcast.Carol = set_combine(sets.midcast.Singing, {
        --head="",
        --body="",
        --hands="",
        --legs="",
        --feet="",
    })
    sets.midcast.Sherzo = set_combine(sets.midcast.Singing, {
        --head="",
        --body="",
        --hands="",
        --legs="",
        feet = gear.Fili_Cothurnes,
    })

    -- Lullaby (sleep/enfeeble)
    sets.midcast.Lullaby = set_combine(sets.midcast.Singing, {
        head = gear.Brioso_Roundlet,
        body = gear.Brioso_Just,
        hands = gear.Inyanga_Dastanas,
        waist = gear.Harfners_Sash,
        legs = gear.Inyanga_Shalwar,
        feet = gear.Brioso_Slippers,
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
        head = gear.Vanya_Hood,
        neck = gear.Reti_Pendant,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Calamitous_Earring,
        body = gear.Vanya_Robe,
        hands = gear.Vanya_Cuffs,
        ring1 = gear.Murky_Ring,
        --ring2="",
        back = gear.Intarabus_Cape_DT,
        waist = gear.Flume_Belt,
        legs = gear.Vanya_Slops,
        feet = gear.Vanya_Clogs,
    }
    sets.midcast.Curaga = sets.midcast.Cure
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default WS set
    sets.precast.WS = {
        --head="",
        neck = gear.Bards_Charm,
        --ear1="",
        ear2 = gear.Ishvara_Earring,
        body = gear.Bihu_Jstcorps,
        --hands="",
        --ring1="",
        --ring2="",
        back = gear.Intarabus_Cape_WS,
        waist = gear.Sailfi_Belt,
        --legs="",
        --feet="",
    }

    -- Aeolian Edge: Magical (DEX:40%, INT:40%)
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        body = gear.WN_Kaftan,
        hands = gear.WN_Mittens,
        --ring1="",
        --ring2="",
        back = gear.Alabaster_Mantle,
        --waist="",
        legs = gear.WN_Braccae,
        feet = gear.WN_Clomps,
    })

    -- Evisceration: Physical (DEX:50%)
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        --neck="",
        --ear1="",
        --ear2="",
        body = gear.WN_Kaftan,
        hands = gear.WN_Mittens,
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        legs = gear.WN_Braccae,
        feet = gear.WN_Clomps,
    })

    -- Rudra's Storm: Physical (DEX:80%)
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
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

    -- Savage Blade: Physical (STR:50%, MND:50%)
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
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

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_rings()
    check_moving()
end

function check_rings()
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

function check_moving()
    -- Movement gear logic can go here
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
