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
    send_command('wait 4; input /lockstyleset 3')
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
        head = gear.Atro_Chapeau,
        neck = gear.Loricate_torque,
        --ear1="",
        ear2 = gear.Loquac_Earring,
        body = gear.WN_Kaftan,
        hands = gear.Gende_Gages,
        ring1 = gear.Murky_Ring,
        ring2 = gear.Kishar_Ring,
        back = gear.Solemnity_Cape,
        waist = gear.Embla_Sash,
        legs = gear.Aya_Cosciales,
        feet = gear.Merl_Crackows,
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
        ear1 = gear.Mimir_Earring,
        --ear2="",
        -- body = "",
        hands = gear.Viti_Gloves,
        --ring1="",
        --ring2="",
        back = gear.Sucellos_Cape_MND,
        waist = gear.Olympus_Sash,
        legs = gear.Atro_Tights, -- RDM AF legs
        -- feet = "",
    }

    -- Enhancing duration (Stoneskin, Protect, Shell, etc.)
    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
        -- sub=gear.e,
        hands = gear.Atro_Gloves, -- "Enhancing Magic duration" augment
        waist = gear.Embla_Sash,

    })

    -- Phalanx (no Phalanx-specific piece owned - falls back to base Enhancing)
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {})

    -- Refresh (self) (no dedicated Refresh piece owned - falls back to base Enhancing)
    sets.midcast['Refresh'] = set_combine(sets.midcast.EnhancingDuration, {
        body = gear.Atrophy_Tabard,
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Enfeebling Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Enfeebling Magic (base)
    sets.midcast['Enfeebling Magic'] = {
        --main="",
        --sub="",
        --range="",
        ammo = gear.Hydrocera,
        head = gear.Atro_Chapeau,
        neck = gear.Erra_Pendant,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Snotra_Earring,
        body = gear.Atrophy_Tabard,
        hands = gear.Atro_Gloves,
        -- ring1 = gear.Kishar_Ring,
        ring2 = gear.Kishar_Ring,
        back = gear.Sucellos_Cape_MND,
        waist = gear.Null_Belt,
        legs = gear.Atro_Tights,
        feet = gear.Atro_Boots,
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
        head = gear.Jhakri_Coronal,
        neck = gear.Mizu_Kubikazari,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Arbatel_Earring,
        body = gear.Jhakri_Robe,
        hands = gear.Jhakri_Cuffs,
        --ring1="",
        --ring2="",
        -- back = gear.Nexus_Cape,
        --waist="",
        legs = gear.Jhakri_Slops,
        feet = gear.Jhakri_Pigaches,
    }

    -- Magic Burst
    sets.midcast['Elemental Magic'].MB = set_combine(sets.midcast['Elemental Magic'], {
        ring2 = gear.Mujin_Band,
        legs = gear.Egbesu_Slops,
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
        head = gear.Vanya_Hood,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        --ear2="",
        body = gear.Vanya_Robe,
        hands = gear.Vanya_Cuffs,
        ring1 = gear.Murky_Ring,
        --ring2="",
        back = gear.Solemnity_Cape, -- "Cure" potency +10%
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


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Idle Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default idle
    sets.idle = {
        --main="",
        sub = gear.Genmei_Shield,
        --range="",
        --ammo="",
        head = gear.Viti_Chapeau,
        neck = gear.Loricate_torque,
        ear1 = gear.Alabaster_Earring,
        ear2 = gear.Sherida_Earring,
        body = gear.Atrophy_Tabard,
        hands = gear.Bunzi_Gloves,
        ring1 = gear.Murky_Ring,
        ring2 = gear.Shneddick_Ring,
        back = gear.Sucellos_Cape_MND,
        waist = gear.Null_Belt,
        legs = gear.WN_Braccae,
        feet = gear.WN_Clomps,
    }

    -- Idle DT
    sets.idle.DT = set_combine(sets.idle, {
        -- waist = gear.Null_Belt,
    })

    -- Idle Refresh (no dedicated refresh piece owned - falls back to base idle)
    sets.idle.Refresh = set_combine(sets.idle, {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Base engaged (sword + shield - no offhand dagger owned)
    sets.engaged = {
        -- main = gear.Vitiation_Sword,
        -- sub = gear.Choco_Shield,
        ammo = gear.Ginsen,
        head = gear.Aya_Zucchetto,
        neck = gear.Loricate_torque,
        ear1 = gear.Brutal_Earring,
        ear2 = gear.Sherida_Earring,
        body = gear.Ayanmo_Corazza,
        hands = gear.Bunzi_Gloves,
        ring1 = gear.Murky_Ring,
        ring2 = gear.Petrov_Ring,
        back = gear.Null_Shawl,
        waist = gear.Sailfi_Belt,
        legs = gear.Jhakri_Slops,
        feet = gear.Battlecast_gaiters,
    }

    -- Accuracy focus (no dedicated accuracy piece owned - falls back to base engaged)
    sets.engaged.Acc = set_combine(sets.engaged, {})

    -- DT while engaged
    sets.engaged.DT = set_combine(sets.engaged, {
        --main="",
        --sub="",
        --range="",
        --ammo="",
        --head="",
        -- neck = gear.Loricate_torque,
        --ear1="",
        --ear2="",
        --body="",
        --hands="",
        --ring1="",
        --ring2="",
        -- back = gear.Intarabus_Cape_DT,
        --waist="",
        --legs="",
        --feet="",
    })


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
        -- ring1 = gear.Atro_Gloves,
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
        ammo = gear.Ghastly_Tathlum,
        head = gear.Jhakri_Coronal,
        ear1 = gear.Moonshade_Earring,
        --ear2="",
        body = gear.Egbesu_Frock,
        hands = gear.Jhakri_Cuffs,
        --ring1="",
        --ring2="",
        back = gear.Sucellos_Cape_MND,
        --waist="",
        legs = gear.Jhakri_Slops,
        feet = gear.Jhakri_Pigaches,
    })
    sets.precast.WS['Seraph Blade'] = sets.precast.WS['Sanguine Blade']
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
