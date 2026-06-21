---@diagnostic disable: undefined-global
-- Original: Motenten / Modified: Arislan
-- GearSwap Lua for RDM
-- Player: Poquito
-- Generated: 2026-06-20

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job. Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff['Saboteur']  = buffactive['Saboteur'] or false
    state.Buff['Composure'] = buffactive['Composure'] or false

    no_swap_gear            = S { "Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
        "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring" }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job. Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

local function set_lockstyle()
    send_command('wait 4; input /lockstyleset 1')
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

    state.MagicBurst = M(false, 'Magic Burst')

    state.WeaponLock = M(false, 'Weapon Lock')

    set_macro_page(1, 1)
    set_lockstyle()
end

function user_unload()
end

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
        head = gear.Merl_Hood,
        --neck="",
        --ear1="",
        ear2 = gear.Loquac_Earring,
        body = gear.Merl_Jubbah,
        -- hands = gear.Merl_Dastanas,
        --ring1="",
        --ring2="",
        -- back = gear.Intarabus_Cape_FC,
        --waist="",
        legs = gear.Aya_Cosciales,
        feet = gear.Merl_Crackows,
    }

    -- Fast Cast for spells (same as base FC for RDM)
    sets.precast.FC['Red Mage'] = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- JA Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Chainspell
    sets.precast.JA['Chainspell'] = {
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

    -- Convert
    sets.precast.JA['Convert'] = {
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

    -- Composure
    sets.precast.JA['Composure'] = {
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

    -- Saboteur
    sets.precast.JA['Saboteur'] = {
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
        -- body = gear.Temachtiani_Shirt,
        -- hands = gear.Temachtiani_Gloves,
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        -- legs = gear.Temachtiani_Pants,
        -- feet = gear.Temachtiani_Boots,
    }

    -- Enhancing duration (Stoneskin, Protect, Shell, etc.)
    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
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

    -- Phalanx
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
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

    -- Refresh (self)
    sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
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
    ---------------------------------------- Enfeebling Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enfeebling Magic (base)
    sets.midcast['Enfeebling Magic'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Aya_Zucchetto,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        --ear2="",
        body = gear.WN_Kaftan,
        hands = gear.WN_Mittens,
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        legs = gear.WN_Braccae,
        feet = gear.WN_Clomps,
    }

    -- Enfeebling with Saboteur active
    sets.midcast['Enfeebling Magic'].Saboteur = set_combine(sets.midcast['Enfeebling Magic'], {
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
    ---------------------------------------- Elemental Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Elemental Magic (base nuke)
    sets.midcast['Elemental Magic'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Merl_Hood,
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
    ---------------------------------------- Dark Magic Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Dark Magic (Drain, Aspir, Stun)
    sets.midcast['Dark Magic'] = {
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
    ---------------------------------------- Healing Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Cure
    sets.midcast.Cure = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Vanya_Hood,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        --ear2="",
        body = gear.Vanya_Robe,
        hands = gear.Vanya_Cuffs,
        ring1 = gear.Murky_Ring,
        --ring2="",
        -- back = gear.Intarabus_Cape_DT,
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

    -- Composure active (bonus to self-buffs)
    sets.buff.Composure = {
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
        --range="",
        --ammo="",
        head = gear.Aya_Zucchetto,
        neck = gear.Loricate_torque,
        --ear1="",
        --ear2="",
        body = gear.WN_Kaftan,
        hands = gear.WN_Mittens,
        ring1 = gear.Murky_Ring,
        -- ring2 = "",
        -- back = gear.Intarabus_Cape_DT,
        waist = gear.Flume_Belt,
        legs = gear.WN_Braccae,
        feet = gear.WN_Clomps,
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
    sets.idle.Refresh = set_combine(sets.idle, {
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
        head = gear.Aya_Zucchetto,
        --neck="",
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Brutal_Earring,
        body = gear.Ayanmo_Corazza,
        hands = gear.Aya_Manopolas,
        --ring1="",
        --ring2="",
        --back="",
        waist = gear.Sailfi_Belt,
        legs = gear.WN_Braccae,
        feet = gear.WN_Clomps,
    }

    -- Accuracy focus
    sets.engaged.Acc = set_combine(sets.engaged, {
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

    -- DT while engaged
    sets.engaged.DT = set_combine(sets.engaged, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        neck = gear.Loricate_torque,
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        back = gear.Intarabus_Cape_DT,
        --waist="",
        --legs="",
        --feet="",
    })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default WS
    sets.precast.WS = {
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

    -- Requiescat: Physical (MND:80%)
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
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

    -- Chant du Cygne: Physical (DEX:75%)
    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
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

    -- Sanguine Blade: Magical (INT:50%, dark)
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Merl_Hood,
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
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff['Saboteur'] then
        equip(sets.midcast['Enfeebling Magic'].Saboteur)
        eventArgs.handled = true
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
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
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
