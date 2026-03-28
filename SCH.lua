local inv = require('inventory')

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
        Custom commands:

        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.

                                        Light Arts              Dark Arts

        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
--]]



-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S { "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V" }

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    update_active_strategems()
    send_command('wait 2; input /lockstyleset 4')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal', 'Burst')
    state.IdleMode:options('Normal', 'PDT')


    info.low_nukes = S { "Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder" }
    info.mid_nukes = S { "Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
        "Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
    }
    info.high_nukes = S { "Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV", "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V" }

    gear.macc_hagondes = { name = "Hagondes Cuffs", augments = { 'Phys. dmg. taken -3%', 'Mag. Acc.+29' } }

    --send_command('^` input /ma Stun <t>')
    send_command('bind ^` input /ja Immanence <me>')



    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^`')

    --send_command('unbind ^`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets
    -- Precast sets to enhance JAs

    sets.precast.JA['Tabula Rasa'] = { legs = "Peda. Pants +1" }
    sets.precast.JA['Enlightenment'] = { body = inv.pedagogy_gown }
    sets.precast.JA['Tabula Rasa'] = { legs = "Pedagogy Pants" }


    -- Fast cast sets for spells

    -- Fast cast sets for spells
    local nuke_set = {
        ammo = inv.ghastly_tathlum,
        head = inv.arbatel_bonnet,
        hands = inv.arbatel_bracers,
        body = inv.arbatel_gown,
        legs = inv.arbatel_pants,
        feet = inv.arbatel_loafers,
        neck = inv.saevus_pendant,
        waist = inv.refoccilation_stone,
        left_ear = inv.malignance_earring,
        right_ear = inv.regal_earring,
        left_ring = inv.freke_ring,
        right_ring = inv.metamorph_ring,
        back = inv.SCH_MAB_CAPE,
    }
    local tp_set = {
        ammo = inv.crepuscular_pebble,
        head = inv.null_mask,
        hands = inv.gazu_bracelets,
        body = inv.jhakri_robe,
        legs = inv.jhakri_slops,
        feet = { name = "Psycloth Boots", augments = { 'Mag. Acc.+10', 'Spell interruption rate down +15%', 'MND+7', } },
        neck = inv.null_loop,
        waist = inv.windbuffet_belt,
        left_ear = inv.dedition_earring,
        right_ear = inv.brutal_earring,
        left_ring = inv.chirich_ring,
        right_ring = inv.crepuscular_ring,
        back = inv.null_shawl
    }
    local black_halo = {
        ammo = inv.oshashs_treastise,
        head = inv.null_mask,
        hands = inv.jhakri_cuffs,
        body = inv.jhakri_robe,
        legs = inv.jhakri_slops,
        feet = inv.merlinic_ws_feet,
        neck = inv.republican_medal,
        waist = inv.luminary_sash,
        left_ear = inv.moonshade_earring,
        right_ear = inv.ishvara,
        left_ring = inv.epaminondas_ring,
        right_ring = inv.corneilias_ring,
        back = inv.null_shawl
    }


    local resist_set = set_combine(nuke_set, {
        neck = "Sanctity Necklace",
        ammo = "Hydrocera",
        right_ring = "Perception Ring",
    })
    local low_tier_set = set_combine(nuke_set, {
        back = inv.SCH_HELX_REGEN_CAPE
    })
    local idle_set = {
        head = inv.null_mask,
        neck = inv.elite_royal_collar,
        body = inv.arbatel_gown,
        hands = inv.chironic_refresh_gloves,
        waist = inv.platinum_moogle_belt,
        left_ear = inv.lugalbanda_earring,
        right_ear = inv.alabaster_earring,
        left_ring = inv.gelat_ring_pdt,
        right_ring = inv.defending_ring,
        legs = inv.assiduity_pants,
        feet = inv.heralds_gaiters,
        ammo = inv.homiliary,
        back = inv.SCH_MAB_CAPE,
    }
    local idle_field = set_combine(idle_set, { feet = inv.arbatel_loafers })

    local burst_set = set_combine(nuke_set, {
        head = inv.pedagogy_mortarboard,
        neck = inv.mizu_kubikazri,
        right_ring = inv.mujin_band,
        legs = inv.agwus_slops,
    })
    local burst_helix_set = set_combine(burst_set, {
        back = inv.SCH_HELX_REGEN_CAPE
    })


    -- Fastcast set
    local fast_cast_set = {
        head = inv.amalric_coif,
        neck = inv.baetyl_pendant,
        body = inv.merlinic_fastcast_body,
        hands = inv.academics_bracers,
        left_ring = inv.weatherspoon_ring,
        right_ring = inv.kishar_ring,
        left_ear = inv.malignance_earring,
        right_ear = inv.loquacious_earring,
        waist = inv.witful_belt,
        legs = inv.psycloth_legs,
        feet = inv.merlin_feet_phalanx,
        back = inv.SCH_FASTCAST_CAPE,
        ammo = inv.sapience_orb,
    }



    -- Enhancing skill
    local enhancing_set = {
        head = inv.befouled_crown,
        body = inv.arbatel_bonnet,
        hands = inv.arbatel_bracers,
        left_ring = inv.stikini_ring,
        right_ring = inv.stikini_ring2,
        waist = inv.embla_sash,
        left_ear = inv.mimir_earring,
        right_ear = inv.andoaa_earring,
    }
    local barstatus_set = set_combine(enhancing_set, { neck = "Sroda necklace", })

    --Enfeebling set
    local enfeebling_set = {
        head = "Aya. Zucchetto +1",
        ammo = "Hydrocera",
        hands = "Jhakri Cuffs +1",
        legs = "Jhakri Slops +1",
        feet = { name = "Medium's Sabots", augments = { 'MP+50', 'MND+8', '"Conserve MP"+6', '"Cure" potency +3%', } },
        waist = "Salire Belt",
        left_ear = "Static Earring",
        right_ear = "Friomisi Earring",
        left_ring = "Perception Ring",
        right_ring = "Vertigo Ring",
    }
    --Cure set
    local cure_set = {
        ear1 = "Mendicant's earring",
        left_ring = "Vocane Ring",
        hands = "Telchine Gloves",
        waist = "Chuq'aba Belt",
    }

    sets.precast.FC = fast_cast_set
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, { waist = "Siegel Sash" })
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC,
        { body = "Mallquis Saio", hands = "Mallquis Cuffs +1", ear1 = "Barkaro. Earring", })


    sets.precast.FC.Cure = set_combine(sets.precast.FC, { body = "Heka's Kalasiris", back = "Pahtli Cape"
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Impact = set_combine(sets.precast.FC['Elemental Magic'], { head = empty, body = "Twilight Cloak" })


    -- Midcast Sets

    sets.midcast.FastRecast = fast_cast_set

    sets.midcast.Cure = cure_set

    sets.midcast.CureWithLightWeather = {
        main = "Chatoyant Staff",
        sub = "Achaq Grip",
        ammo = "Incantor Stone",
        head = "Gendewitha Caubeen",
        neck = "Colossus's Torque",
        ear1 = "Lifestorm Earring",
        ear2 = "Loquacious Earring",
        body = "Heka's Kalasiris",
        hands = "Bokwus Gloves",
        ring1 = "Prolix Ring",
        ring2 = "Sirona's Ring",
        back = "Twilight Cape",
        waist = "Korin Obi",
        legs = "Nares Trews",
        feet = "Academic's Loafers"
    }

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Regen = {
        head = inv.arbatel_bonnet,
        body = inv.telchine_body_regen,
        hands = inv.arbatel_bracers,
        legs = inv.telchine_legs_regen,
        feet = inv.telchine_feet_enh_dur,
        back = inv.SCH_HELX_REGEN_CAPE,
        waist = inv.embla_sash,
    }

    sets.midcast.Cursna = {
        neck = "Malison Medallion",
        hands = "Hieros Mittens",
        ring1 = "Ephedra Ring",
        feet = "Gendewitha Galoshes"
    }

    sets.midcast['Enhancing Magic'] = enhancing_set

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        neck = "Nodens Gorget",
        legs = inv.shedir_seraweels,
    })
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        head = inv.amalric_coif,
        legs = inv.shedir_seraweels,
        waist = inv.emphatikos_rope,
    })


    sets.midcast.Storm = set_combine(sets.midcast['Enhancing Magic'], { feet = "Pedagogy Loafers" })

    sets.midcast.Protect = { ring1 = "Sheltered Ring" }
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = { ring1 = "Sheltered Ring" }
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Barpetrify'] = barstatus_set
    sets.midcast['Barsilence'] = barstatus_set
    sets.midcast['Barvirus'] = barstatus_set
    sets.midcast['Barblind'] = barstatus_set
    sets.midcast['Barsleep'] = barstatus_set
    sets.midcast['Baramnesia'] = barstatus_set
    sets.midcast['Barpoison'] = barstatus_set
    sets.midcast['Barparalyze'] = barstatus_set
    sets.midcast.BarElement = set_combine(enhancing_set, { legs = inv.shedir_seraweels, })


    -- Custom spell classes
    sets.midcast.MndEnfeebles = set_combine(nuke_set, {})

    sets.midcast.IntEnfeebles = set_combine(nuke_set, {})

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = nuke_set

    sets.midcast.Kaustra = {
        main = inv.bunz,
        head = "Hagondes Hat",
        neck = "Eddy Necklace",
        ear1 = "Hecate's Earring",
        ear2 = "Friomisi Earring",
        body = "Hagondes Coat",
        hands = "Yaoyotl Gloves",
        ring1 = "Icesoul Ring",
        ring2 = "Strendu Ring",
        back = "Toro Cape",
        waist = "Cognition Belt",
        legs = "Hagondes Pants",
        feet = "Hagondes Sabots"
    }

    sets.midcast.Drain = set_combine(nuke_set, {})
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(nuke_set, {})

    sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, { main = "Lehbrailg +2" })

    --Helix spells get the low tier set
    sets.midcast.Helix = low_tier_set

    -- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast['Elemental Magic'] = nuke_set
    sets.midcast['Elemental Magic'].Resistant = resist_set
    sets.midcast['Helix'].Burst = burst_helix_set
    sets.midcast['Elemental Magic'].Burst = burst_set
    sets.midcast['Elemental Magic'].LowTierNuke = low_tier_set
    -- Custom refinements for certain nuke tiers
    sets.midcast['Elemental Magic'].HighTierNuke = nuke_set

    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = resist_set

    sets.midcast.Impact = {
        main = "Lehbrailg +2",
        sub = "Mephitis Grip",
        ammo = "Dosis Tathlum",
        head = empty,
        neck = "Eddy Necklace",
        ear1 = "Psystorm Earring",
        ear2 = "Lifestorm Earring",
        body = "Twilight Cloak",
        hands = gear.macc_hagondes,
        ring1 = "Icesoul Ring",
        ring2 = "Sangoma Ring",
        back = "Toro Cape",
        waist = "Demonry Sash",
        legs = "Hagondes Pants",
        feet = "Bokwus Boots"
    }

    sets.precast.WS['Black Halo'] = black_halo

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        main = "Chatoyant Staff",
        sub = "Mephitis Grip",
        head = "Nefer Khat +1",
        neck = "Wiglen Gorget",
        body = "Heka's Kalasiris",
        hands = "Serpentes Cuffs",
        ring1 = "Sheltered Ring",
        ring2 = "Paguroidea Ring",
        waist = "Austerity Belt",
        legs = "Nares Trews",
        feet = "Serpentes Sabots"
    }


    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle.Town = idle_set

    sets.idle.Field = idle_field

    sets.idle.Field.PDT = idle_set

    sets.idle.Weak = idle_set

    -- Defense sets

    sets.defense.PDT = idle_set

    sets.defense.MDT = idle_set

    sets.Kiting = { feet = "Herald's Gaiters" }

    sets.latent_refresh = { waist = "Fucho-no-obi" }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first6.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = tp_set



    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Ebullience'] = { head = inv.arbatel_bonnet, }
    sets.buff['Rapture'] = { head = inv.arbatel_bonnet, }
    sets.buff['Perpetuance'] = { hands = inv.arbatel_bracers }
    sets.buff['Penury'] = { legs = inv.arbatel_pants }
    sets.buff['Parsimony'] = { legs = inv.arbatel_pants }
    sets.buff['Celerity'] = { feet = "Pedagogy Loafers" }
    sets.buff['Alacrity'] = { feet = "Pedagogy Loafers" }

    sets.buff['Klimaform'] = { feet = inv.arbatel_loafers }

    sets.buff.FullSublimation = {
        head = inv.academics_mortarboard,
        ear1 = "Savant's Earring",
        body = inv.pedagogy_gown,
        waist = inv.embla_sash
    }
    sets.buff.PDTSublimation = { head = inv.academics_mortarboard, ear1 = "Savant's Earring" }

    --sets.buff['Sandstorm'] = {feet="Desert Boots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
end

function update_combat_form()
    -- Check for H2H or single-wielding
    --state.CombatForm:reset()
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main', 'sub', 'range')
        else
            enable('main', 'sub', 'range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' then
                return 'CureWithLightWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Elemental Magic' then
            if info.low_nukes:contains(spell.english) then
                return 'LowTierNuke'
            elseif info.mid_nukes:contains(spell.english) then
                return 'MidTierNuke'
            elseif info.high_nukes:contains(spell.english) then
                return 'HighTierNuke'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        if state.IdleMode.value == 'Normal' then
            idleSet = set_combine(idleSet, sets.buff.FullSublimation)
        elseif state.IdleMode.value == 'PDT' then
            idleSet = set_combine(idleSet, sets.buff.PDTSublimation)
        end
    end

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    add_to_chat('jobselfcomand getting called')
    add_to_chat(122, table.tostring(cmdParams))

    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type == 'WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
            if state.CastingMode.current == 'Burst' then
                equip(klimaform_burst)
                add_to_chat('equiping static earring')
            end
        end
        if spell.element == world.weather_element then
            equip({ waist = "Hachirin-no-Obi" })
            add_to_chat('equiping obi')
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123, 'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122, 'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122, 'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122, 'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123, 'Error: Unknown strategem [' .. strategem .. ']')
        end
    elseif buffactive['dark arts'] or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122, 'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123, 'Error: Unknown strategem [' .. strategem .. ']')
        end
    else
        add_to_chat(123, 'No arts has been activated yet.')
    end
end

-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4 * 60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 4)
end
