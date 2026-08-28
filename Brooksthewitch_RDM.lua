---@diagnostic disable: undefined-global
-- Original: Motenten / Modified: Arislan
-- GearSwap Lua for RDM
-- Player: Brooksthewitch
-- Generated: 2026-08-26

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

    local gear = require('Brooksthewitch_Gear')

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast Cast
    sets.precast.FC = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Merl_Hood_FC,
        --neck="",
        --ear1="",
        ear2 = gear.Loquac_Earring,
        body = gear.Merl_Jubbah_FC,
        -- hands = gear.Merl_Dastanas,
        --ring1="",
        --ring2="",
        --back="",
        --waist="",
        legs = gear.Aya_Cosciales,
        feet = gear.Merl_Crackows_FC,
    }

    -- Fast Cast for spells (same as base FC for RDM)
    sets.precast.FC['Red Mage'] = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- JA Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Chainspell (no dedicated Chainspell-cost piece owned)
    sets.precast.JA['Chainspell'] = {}

    -- Convert (no dedicated MP-return piece owned)
    sets.precast.JA['Convert'] = {}

    -- Composure (no dedicated Composure-boosting piece owned)
    sets.precast.JA['Composure'] = {}

    -- Saboteur (no dedicated enfeebling-potency hands owned)
    sets.precast.JA['Saboteur'] = {}

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
        body = gear.Temachtiani_Shirt,
        hands = gear.Duelists_Gloves, -- RDM AF hands
        --ring1="",
        --ring2="",
        --back="",
        waist = gear.Embla_Sash, -- Enhancing Magic skill +10
        legs = gear.Temachtiani_Pants,
        feet = gear.Temachtiani_Boots,
    }

    -- Enhancing duration (Stoneskin, Protect, Shell, etc.) - no duration-specific piece owned
    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {})

    -- Phalanx
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        ear1 = gear.Sortiarius_Earring, -- Enhances "Phalanx" effect
    })

    -- Refresh (self)
    sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'], {
        neck = gear.Null_Loop, -- "Refresh"+1
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Enfeebling Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enfeebling Magic (base)
    sets.midcast['Enfeebling Magic'] = {
        --main="",
        --sub="",
        --range="",
        ammo = gear.Ghastly_Tathlum,
        head = gear.Aya_Zucchetto,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Erilaz_Earring,
        body = gear.Jhakri_Robe,
        hands = gear.Jhakri_Cuffs,
        ring1 = gear.Jhakri_Ring,
        --ring2="",
        --back="",
        --waist="",
        legs = gear.Jhakri_Slops,
        feet = gear.Jhakri_Pigaches,
    }

    -- Enfeebling with Saboteur active (no Saboteur-specific piece owned)
    sets.midcast['Enfeebling Magic'].Saboteur = set_combine(sets.midcast['Enfeebling Magic'], {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Elemental Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Elemental Magic (base nuke)
    sets.midcast['Elemental Magic'] = {
        --main="",
        --sub="",
        --range="",
        ammo = gear.Ghastly_Tathlum,
        head = gear.Merl_Hood_FC,
        --neck="",
        ear1 = gear.Erilaz_Earring,
        ear2 = gear.Boii_Earring,
        body = gear.Merl_Jubbah_FC,
        hands = gear.Jhakri_Cuffs,
        ring1 = gear.Dingir_Ring, -- Magic Attack Bonus
        --ring2="",
        back = gear.Nantosuelta_Cape_MAB,
        waist = gear.Isa_Belt, -- Elemental Magic skill +10, Mag.Atk.Bns.
        legs = gear.Jhakri_Slops,
        feet = gear.Merl_Crackows_FC,
    }

    -- Magic Burst
    sets.midcast['Elemental Magic'].MB = set_combine(sets.midcast['Elemental Magic'], {
        ring2 = gear.Hetairoi_Ring, -- Magic burst damage
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Dark Magic Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Dark Magic (Drain, Aspir, Stun) - shares Enfeebling gear, no dedicated piece owned
    sets.midcast['Dark Magic'] = sets.midcast['Enfeebling Magic']


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Healing Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Cure
    sets.midcast.Cure = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Merl_Hood_FC, -- no Vanya Hood owned
        neck = gear.Loricate_torque,
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

    -- Doom (Holy Water) - no gear override needed
    sets.buff.Doom = {}

    -- Composure active (bonus to self-buffs) - no dedicated piece owned
    sets.buff.Composure = {}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Idle Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default idle
    sets.idle = {
        --main="",
        sub = gear.Ammurapi_Shield, -- M.Eva/M.Def idle shield
        --range="",
        --ammo="",
        head = gear.Aya_Zucchetto,
        neck = gear.Loricate_torque,
        --ear1="",
        --ear2="",
        body = gear.Geomancy_Tunic,
        hands = gear.Merl_Dastanas,
        ring1 = gear.Murky_Ring,
        -- ring2 = "",
        back = gear.Nantosuelta_Cape,
        waist = gear.Flume_Belt,
        legs = gear.Jhakri_Slops,
        feet = gear.Merl_Crackows_Pet,
    }

    -- Idle DT
    sets.idle.DT = set_combine(sets.idle, {
        waist = gear.Null_Belt,
    })

    -- Idle Refresh (no dedicated refresh piece owned - falls back to base idle)
    sets.idle.Refresh = set_combine(sets.idle, {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Base engaged (sword + dagger for extra hits/Store TP)
    sets.engaged = {
        main = gear.Tokko_Sword,
        sub = gear.Daybreak,
        --range="",
        ammo = gear.Ghastly_Tathlum,
        head = gear.Aya_Zucchetto,
        --neck="",
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Brutal_Earring,
        body = gear.Ayanmo_Corazza,
        hands = gear.Duelists_Gloves,
        ring1 = gear.Barataria_Ring,
        --ring2="",
        --back="",
        waist = gear.Sailfi_Belt,
        legs = gear.Assid_Pants,
        feet = gear.Odyssean_Greaves,
    }

    -- Accuracy focus (no dedicated accuracy piece owned - falls back to base engaged)
    sets.engaged.Acc = set_combine(sets.engaged, {})

    -- DT while engaged (swap to sword + shield for defense)
    sets.engaged.DT = set_combine(sets.engaged, {
        sub = gear.Genmei_Shield,
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
        --back="",
        --waist="",
        --legs="",
        --feet="",
    })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default WS (generic physical set - fallback for anything not defined below)
    sets.precast.WS = {
        main = gear.Malignance_Sword,
        head = gear.Atro_Chapeau,
        --neck="",
        ear1 = gear.Ishvara_Earring,
        ear2 = gear.Moonshade_Earring,
        body = gear.Egbesu_Frock,
        hands = gear.Jhakri_Cuffs,
        ring1 = gear.Mujin_Band,
        --ring2="",
        --back="",
        waist = gear.Sailfi_Belt,
        legs = gear.Atro_Tights,
        feet = gear.Atro_Boots,
    }

    -- Savage Blade: Physical (STR:50%, MND:50%)
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})

    -- Requiescat: Physical (MND:80%) - same MND/phys gear as Savage Blade
    sets.precast.WS['Requiescat'] = sets.precast.WS['Savage Blade']

    -- Chant du Cygne: Physical (DEX:75%) - no DEX-specific piece owned, reuses generic phys set
    sets.precast.WS['Chant du Cygne'] = sets.precast.WS['Savage Blade']

    -- Sanguine Blade: Magical (INT:50%, dark)
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        main = gear.Tokko_Sword,
        ammo = gear.Ghastly_Tathlum,
        head = gear.Merl_Hood_FC,
        ear1 = gear.Moonshade_Earring,
        --ear2="",
        body = gear.Merl_Jubbah_FC,
        hands = gear.Jhakri_Cuffs,
        ring1 = gear.Dingir_Ring,
        --ring2="",
        back = gear.Nantosuelta_Cape_MAB,
        --waist="",
        legs = gear.Jhakri_Slops,
        feet = gear.Merl_Crackows_FC,
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
