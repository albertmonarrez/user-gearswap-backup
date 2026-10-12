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
    send_command('wait 4; input /lockstyleset 5')
end

function user_setup()
    state.OffenseMode:options('Normal', 'Enspell')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

    state.MagicBurst = M(false, 'Magic Burst')

    state.WeaponLock = M(false, 'Weapon Lock')

    send_command('bind +f9 gs c toggle MagicBurst')

    set_macro_page(1, 1)
    set_lockstyle()
end

function user_unload()
    send_command('unbind +f9')
end

function init_gear_sets()
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Gear Variables ----------------------------------------
    ------------------------------------------------------------------------------------------------

    local gear                      = require('Brooksthewitch_Gear')

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast Cast
    sets.precast.FC                 = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Atro_Chapeau,
        neck = gear.Loricate_torque,
        --ear1="",
        ear2 = gear.Loquac_Earring,
        body = gear.Merl_Jubbah_FC,
        -- hands = gear.Merl_Dastanas,
        ring1 = gear.Murky_Ring,
        ring2 = gear.Kishar_Ring,
        back = gear.Solemnity_Cape,
        waist = gear.Embla_Sash,
        legs = gear.Aya_Cosciales,
        feet = gear.Merl_Crackows_FC,
    }

    -- Fast Cast for spells (same as base FC for RDM)
    sets.precast.FC['Red Mage']     = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- JA Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Chainspell (no dedicated Chainspell-cost piece owned)
    sets.precast.JA['Chainspell']   = {}

    -- Convert (no dedicated MP-return piece owned)
    sets.precast.JA['Convert']      = {}

    -- Composure (no dedicated Composure-boosting piece owned)
    sets.precast.JA['Composure']    = {}

    -- Saboteur (no dedicated enfeebling-potency hands owned)
    sets.precast.JA['Saboteur']     = {}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Enhancing Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enhancing Magic skill-scaling gear - only spells whose potency actually
    -- scales with Enhancing Magic skill (Enspells, Gain-x, Temper) want this.
    local enhancing_skill_set       = {
        main = gear.Pukulatmuj,
        sub = gear.Forfend,
        --range="",
        --ammo="",
        head = gear.Umuthi_Hat,
        neck = gear.Dls_Torque,
        ear1 = gear.Mimir_Earring,
        ear2 = gear.Andoaa_Earring,
        body = gear.Vitiation_Tabard,
        hands = gear.Viti_Gloves,
        --ring1="",
        --ring2="",
        back = gear.Sucellos_Cape_STR,
        waist = gear.Olympus_Sash,
        legs = gear.Atro_Tights,
        --feet="",
    }

    -- Enhancing Magic (default - duration/fixed-potency spells: Protect, Shell, Blink, Stoneskin, Haste, Bar-spells, etc.)
    -- No main/sub here - these spells don't scale with Enhancing Magic skill, so don't swap weapons for them.
    sets.midcast['Enhancing Magic'] = {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        head = gear.Umuthi_Hat,
        neck = gear.Dls_Torque,
        ear1 = gear.Mimir_Earring,
        ear2 = gear.Andoaa_Earring,
        body = gear.Vitiation_Tabard,
        hands = gear.Atro_Gloves,
        --ring1="",
        --ring2="",
        back = gear.Sucellos_Cape_STR,
        waist = gear.Embla_Sash,
        legs = gear.Atro_Tights,
        --feet="",
    }

    sets.midcast.EnhancingDuration  = sets.midcast['Enhancing Magic']

    -- Phalanx
    sets.midcast['Phalanx']         = set_combine(sets.midcast['Enhancing Magic'], {
    })

    -- Refresh (self)
    sets.midcast['Refresh']         = set_combine(sets.midcast.EnhancingDuration, {
        body = gear.Atrophy_Tabard,
        legs = gear.Leth_Fuseau,
    })

    -- Enspells and stat/attack-boost spells scale potency with Enhancing Magic skill
    sets.midcast['Enfire']          = enhancing_skill_set
    sets.midcast['Enblizzard']      = enhancing_skill_set
    sets.midcast['Enaero']          = enhancing_skill_set
    sets.midcast['Enstone']         = enhancing_skill_set
    sets.midcast['Enthunder']       = enhancing_skill_set
    sets.midcast['Enwater']         = enhancing_skill_set
    sets.midcast['Gain-STR']        = enhancing_skill_set
    sets.midcast['Gain-DEX']        = enhancing_skill_set
    sets.midcast['Gain-VIT']        = enhancing_skill_set
    sets.midcast['Gain-AGI']        = enhancing_skill_set
    sets.midcast['Gain-INT']        = enhancing_skill_set
    sets.midcast['Gain-MND']        = enhancing_skill_set
    sets.midcast['Gain-CHR']        = enhancing_skill_set
    sets.midcast['Temper']          = enhancing_skill_set
    sets.midcast['Temper II']       = enhancing_skill_set


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Enfeebling Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enfeebling Magic (base)
    sets.midcast['Enfeebling Magic'] = {
        --main="",
        --sub="",
        --range="",
        ammo = gear.Ghastly_Tathlum,
        head = gear.Viti_Chapeau,
        neck = gear.Dls_Torque,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Snotra_Earring,
        body = gear.Atrophy_Tabard,
        hands = gear.Atro_Gloves,
        ring1 = gear.Metamor_Ring,
        ring2 = gear.Kishar_Ring,
        back = gear.Sucellos_Cape_STR,
        waist = gear.Null_Belt,
        legs = gear.Atro_Tights,
        feet = gear.Atro_Boots,
    }

    -- Enfeebling with Saboteur active (no Saboteur-specific piece owned)
    sets.midcast['Enfeebling Magic'].Saboteur = set_combine(sets.midcast['Enfeebling Magic'], {})

    -- Inundation (Treasure Hunter) - no Hoxne Ring owned, so ring2 stays as-is
    sets.midcast['Inundation'] = set_combine(sets.midcast['Enfeebling Magic'], {
        hands = gear.Merl_Dastanas_TH,
        waist = gear.Chaac_Belt,
        feet = gear.Merl_Crackows_TH,
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Elemental Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Elemental Magic (base nuke)
    sets.midcast['Elemental Magic'] = {
        --main="",
        --sub="",
        --range="",
        ammo = gear.Ghastly_Tathlum,
        head = gear.Jhakri_Coronal,
        neck = gear.Mizu_Kubikazari,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Malignance_Earring,
        body = gear.Jhakri_Robe,
        hands = gear.Jhakri_Cuffs,
        ring1 = gear.Freke_Ring,
        --ring2="",
        -- back = gear.Nantosuelta_Cape_MAB,
        waist = gear.Null_Belt,
        legs = gear.Jhakri_Slops,
        feet = gear.Jhakri_Pigaches,
    }

    -- Magic Burst
    sets.midcast['Elemental Magic'].MB = set_combine(sets.midcast['Elemental Magic'], {
        ring2 = gear.Mujin_Band,
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
        -- head = gear.Merl_Hood_FC,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        --ear2="",
        body = gear.Vanya_Robe,
        hands = gear.Vanya_Cuffs,
        ring1 = gear.Murky_Ring,
        --ring2="",
        back = gear.Solemnity_Cape,
        --waist="",
        legs = gear.Atro_Tights,
        feet = gear.Vanya_Clogs,
    }
    sets.midcast.Curaga = sets.midcast.Cure


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Buff Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Doom (Holy Water) - no gear override needed
    sets.buff.Doom = {}

    -- Composure active (bonus to self-buffs) - no dedicated piece owned
    sets.buff.Composure = {}

    -- Composure active, enhancing another player
    sets.buff.ComposureOther = {
        head = gear.Leth_Chappel,
        body = gear.Leth_Sayon,
        hands = gear.Leth_Gantherots,
        legs = gear.Leth_Fuseau,
        waist = gear.Embla_Sash,
        ring2 = gear.Kishar_Ring,
        back = gear.Sucellos_Cape_STR
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Idle Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default idle
    sets.idle = {
        --main="",
        -- sub = gear.Genmei_Shield,
        --range="",
        --ammo="",
        head = gear.Viti_Chapeau,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Malignance_Earring,
        body = gear.Atrophy_Tabard,
        hands = gear.Bunzi_Gloves,
        ring1 = gear.Murky_Ring,
        ring2 = gear.Shneddick_Ring,
        back = gear.Solemnity_Cape,
        waist = gear.Null_Belt,
        legs = gear.MGF_Chausses,
        feet = gear.Malignance_Boots,
    }

    -- Idle DT
    sets.idle.DT = set_combine(sets.idle, {})

    -- Idle Refresh (no dedicated refresh piece owned - falls back to base idle)
    sets.idle.Refresh = set_combine(sets.idle, {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Base engaged
    sets.engaged = {
        -- main = gear.Tokko_Sword,
        -- sub = gear.Daybreak,
        --range="",
        ammo = gear.Ginsen,
        head = gear.Malignance_Chapeau,
        neck = gear.Anu_Torque,
        ear1 = gear.Brutal_Earring,
        ear2 = gear.Sherida_Earring,
        body = gear.Malignance_Tabard,
        hands = gear.Malignance_Gloves,
        ring1 = gear.Murky_Ring,
        ring2 = gear.Rajas_Ring,
        --back="",
        waist = gear.Sailfi_Belt,
        legs = gear.Malignance_Tights,
        feet = gear.Malignance_Boots,
    }

    -- Accuracy focus (no dedicated accuracy piece owned - falls back to base engaged)
    sets.engaged.Enspell = set_combine(sets.engaged, {
        head = gear.Umuthi_Hat,
        hands = gear.Aya_Manopolas,
        neck = gear.Null_Loop,
        legs = gear.Atro_Tights,
        ear1 = gear.Eabani_Earring,
        ring2 = gear.Hetairoi_Ring,
        ammo = gear.sroda_tathlum,
    })

    -- DT while engaged
    sets.engaged.DT = set_combine(sets.engaged, {})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default WS (generic physical set - fallback for anything not defined below)
    sets.precast.WS = {
        head = gear.Viti_Chapeau,
        --neck="",
        ear1 = gear.Ishvara_Earring,
        ear2 = gear.Moonshade_Earring,
        body = gear.Egbesu_Frock,
        hands = gear.Atro_Gloves,
        --ring1="",
        --ring2="",
        back = gear.Sucellos_Cape_STR,
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
        ammo = gear.sroda_tathlum,
        head = gear.Jhakri_Coronal,
        ear1 = gear.Moonshade_Earring,
        --ear2="",
        body = gear.Egbesu_Frock,
        hands = gear.Jhakri_Cuffs,
        ring1 = gear.Freke_Ring,
        ring2 = gear.Jhakri_Ring,
        back = gear.Sucellos_Cape_STR,
        --waist="",
        legs = gear.Jhakri_Slops,
        feet = gear.Jhakri_Pigaches,
    })
    sets.precast.WS['Seraph Blade'] = sets.precast.WS['Sanguine Blade']
    sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Sanguine Blade']
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Main/sub held before an Enhancing Magic cast, re-equipped once it finishes.
local weapon_restore = nil

function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and not weapon_restore then
        weapon_restore = { main = player.equipment.main, sub = player.equipment.sub }
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff['Saboteur'] then
        equip(sets.midcast['Enfeebling Magic'].Saboteur)
        eventArgs.handled = true
    elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.midcast['Elemental Magic'].MB)
        eventArgs.handled = true
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and buffactive.composure and spell.target.type == 'PLAYER' then
        equip(sets.buff.ComposureOther)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
    if weapon_restore then
        equip(weapon_restore)
        weapon_restore = nil
    end
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

-- //gs c enspell: Tenzen enspell build - Enspell offense mode with its weapons.
-- //gs c naegling: physical melee build - Normal offense mode with its weapons.
-- //gs c cleave: Aeolian Edge cleave build - dagger main for the AoE weaponskill.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'enspell' then
        local gear = require('Brooksthewitch_Gear')
        equip({ main = gear.Vitiation_Sword, sub = gear.Levante_Dagger })
        state.OffenseMode:set('Enspell')
        add_to_chat(122, 'Offense Mode: ' .. state.OffenseMode.value)
        send_command('wait 0.3; gs c update')
        eventArgs.handled = true
    elseif cmdParams[1] == 'cleave' then
        local gear = require('Brooksthewitch_Gear')
        equip({ main = gear.Levante_Dagger, sub = gear.Bunzi_Rod })
        state.OffenseMode:set('Normal')
        add_to_chat(122, 'Offense Mode: ' .. state.OffenseMode.value)
        send_command('wait 0.3; gs c update')
        eventArgs.handled = true
    elseif cmdParams[1] == 'naegling' then
        local gear = require('Brooksthewitch_Gear')
        equip({ main = gear.Kaja_Sword, sub = gear.Levante_Dagger })
        state.OffenseMode:set('Normal')
        add_to_chat(122, 'Offense Mode: ' .. state.OffenseMode.value)
        send_command('wait 0.3; gs c update')
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
