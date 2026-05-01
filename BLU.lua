local inv = require('inventory')
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

local ATTACK_CAPPED = 3800

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false

    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

    blue_magic_maps = {}

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    -- Physical Spells --

    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S {
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S {
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S {
        'Battle Dance', 'Bloodrake', 'Death Scissors', 'Dimensional Death',
        'Empty Thrash', 'Quadrastrike', 'Sinker Drill', 'Spinal Cleave',
        'Uppercut', 'Vertical Cleave'
    }

    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S {
        'Amorphic Spikes', 'Asuran Claws', 'Barbed Crescent', 'Claw Cyclone', 'Disseverment',
        'Foot Kick', 'Frenetic Rip', 'Goblin Rush', 'Hysteric Barrage', 'Paralyzing Triad',
        'Seedspray', 'Sickle Slash', 'Smite of Rage', 'Terror Touch', 'Thrashing Assault',
        'Vanity Dive'
    }

    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S {
        'Body Slam', 'Cannonball', 'Delta Thrust', 'Glutinous Dart', 'Grand Slam',
        'Power Attack', 'Quad. Continuum', 'Sprout Smack', 'Sub-zero Smash'
    }

    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S {
        'Benthic Typhoon', 'Feather Storm', 'Helldive', 'Hydro Shot', 'Jet Stream',
        'Pinecone Bomb', 'Spiral Spin', 'Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S {
        'Mandibular Bite', 'Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S {
        'Ram Charge', 'Screwdriver', 'Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S {
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S {
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S {
        'Blastbomb', 'Blazing Bound', 'Bomb Toss', 'Cursed Sphere', 'Dark Orb', 'Death Ray',
        'Diffusion Ray', 'Droning Whirlwind', 'Embalming Earth', 'Firespit', 'Foul Waters',
        'Ice Break', 'Leafstorm', 'Maelstrom', 'Rail Cannon', 'Regurgitation', 'Rending Deluge',
        'Retinal Glare', 'Subduction', 'Tem. Upheaval', 'Water Bomb'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S {
        'Acrid Stream', 'Evryone. Grudge', 'Magic Hammer', 'Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S {
        'Eyes On Me', 'Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S {
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S {
        'Charged Whisker', 'Gates of Hades'
    }

    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S {
        '1000 Needles', 'Absolute Terror', 'Actinic Burst', 'Auroral Drape', 'Awful Eye',
        'Blank Gaze', 'Blistering Roar', 'Blood Drain', 'Blood Saber', 'Chaotic Eye',
        'Cimicine Discharge', 'Cold Wave', 'Corrosive Ooze', 'Demoralizing Roar', 'Digest',
        'Dream Flower', 'Enervation', 'Feather Tickle', 'Filamented Hold', 'Frightful Roar',
        'Geist Wall', 'Hecatomb Wave', 'Infrasonics', 'Jettatura', 'Light of Penance',
        'Lowing', 'Mind Blast', 'Mortal Ray', 'MP Drainkiss', 'Osmosis', 'Reaving Wind',
        'Sandspin', 'Sandspray', 'Sheep Song', 'Soporific', 'Sound Blast', 'Stinking Gas',
        'Sub-zero Smash', 'Venom Shell', 'Voracious Trunk', 'Yawn'
    }

    -- Breath-based spells
    blue_magic_maps.Breath = S {
        'Bad Breath', 'Flying Hip Press', 'Frost Breath', 'Heat Breath',
        'Hecatomb Wave', 'Magnetite Cloud', 'Poison Breath', 'Radiant Breath', 'Self-Destruct',
        'Thunder Breath', 'Vapor Spray', 'Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S {
        'Blitzstrahl', 'Frypan', 'Head Butt', 'Sudden Lunge', 'Tail slap', 'Temporal Shift',
        'Thunderbolt', 'Whirl of Rage'
    }

    -- Healing spells
    blue_magic_maps.Healing = S {
        'Healing Breeze', 'Magic Fruit', 'Plenilune Embrace', 'Pollen', 'Restoral', 'White Wind',
        'Wild Carrot'
    }

    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S {
        'Barrier Tusk', 'Diamondhide', 'Magic Barrier', 'Metallic Body', 'Plasma Charge',
        'Reactor Cool', 'Occultation'
    }

    -- Other general buffs
    blue_magic_maps.Buff = S {
        'Amplification', 'Animating Wail', 'Battery Charge', 'Carcharian Verve', 'Cocoon',
        'Erratic Flutter', 'Exuviation', 'Fantod', 'Feather Barrier', 'Harden Shell',
        'Memento Mori', 'Nat. Meditation', 'Orcish Counterstance', 'Refueling',
        'Regeneration', 'Saline Coat', 'Triumphant Roar', 'Warm-Up', 'Winds of Promyvion',
        'Zephyr Mantle'
    }


    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S {
        'Absolute Terror', 'Bilgestorm', 'Blistering Roar', 'Bloodrake', 'Carcharian Verve',
        'Crashing Thunder', 'Droning Whirlwind', 'Gates of Hades', 'Harden Shell', 'Polar Roar',
        'Pyric Bulwark', 'Thunderbolt', 'Tourbillion', 'Uproot'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'HighAcc')
    state.HybridMode:options('Normal', 'AccDT', 'DWT')
    state.CastingMode:options('Normal', 'TH')
    state.IdleMode:options('Normal', 'PDT')


    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')

    update_combat_form()
    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end

-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    local assimilator_jubah = inv.assimilator_body
    local assimilator_legs = inv.assimilator_legs
    local assimilator_feet = "Assim. Charuqs +2"

    local luhlaza_legs = inv.luhlaza_legs
    local oshasha_treatise = "Oshasha's Treatise"
    local store_tp_cape = { name = "Rosmerta's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', } }


    sets.buff['Burst Affinity'] = { legs = assimilator_legs }
    sets.buff['Chain Affinity'] = { head = inv.hashishin_head, feet = assimilator_feet }
    sets.buff.Efflux = { back = store_tp_cape, legs = inv.hashishin_legs }
    sets.buff.Diffusion = { feet = inv.luhlaza_feet }
    sets.expiacion_max_tp = { left_ear = inv.regal_earring }

    local treasure_hunter = {
        ammo = "Per. Lucky Egg",
        waist = "Chaac Belt",
        head = "Wh. Rarab Cap +1",
        right_ring = inv.defending_ring,
        left_ring = inv.hoxne_ring,
        back = inv.null_shawl
    }
    -- Precast Sets
    --Blue magic nukes
    local nuke_set = {
        ammo = inv.ghastly_tathlum,
        head = inv.hashishin_head,
        body = inv.hashishin_mintan,
        neck = inv.sibyl_scarf,
        hands = inv.hashishin_hands,
        legs = luhlaza_legs,
        feet = inv.hashishin_feet,
        waist = inv.orpheus_sash,
        left_ear = inv.regal_earring,
        right_ear = inv.friomisi_earring,
        left_ring = "Acumen ring",
        right_ring = inv.metamorph_ring,
        back = inv.BLU_SKILL_CAPE,
    }
    local blue_skill = {
        head = inv.luhlaza_head,
        neck = inv.mirage_stole,
        body = assimilator_jubah,
        back = inv.BLU_SKILL_CAPE,
        hands = inv.hashishin_hands,
        left_ear = inv.njordr_earring,
        right_ear = inv.hashishin_earring,
        right_ring = inv.stikini_ring2,
        left_ring = inv.stikini_ring,
        legs = inv.hashishin_legs,
        feet = inv.luhlaza_feet
    }
    local spell_intr_down = {
        ammo = inv.staunch_tathlum,
        head = inv.null_mask,
        neck = inv.loricate_torque,
        hands = "Rawhide Gloves",
        waist = "Emphatikos Rope",
        legs = assimilator_legs,
        left_ear = inv.halasz_earring,
        feet = { name = "Psycloth Boots", augments = { 'Mag. Acc.+10', 'Spell interruption rate down +15%', 'MND+7', } },
    }
    --physical blue spells
    local physical_set = set_combine(nuke_set, {
        neck = "Rep. Plat. Medal",
        waist = { name = "Sailfi Belt +1", augments = { 'Path: A', } },
        left_ring = "Ifrit Ring",
        right_ring = "Apate Ring",
        back = { name = "Rosmerta's Cape", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Store TP"+10', } },
    })

    local savage_blade = {
        ammo = oshasha_treatise,
        neck = inv.mirage_stole,
        head = inv.hashishin_head,
        body = assimilator_jubah,
        hands = inv.jhakri_cuffs,
        legs = inv.luhlaza_legs,
        feet = inv.nyame_feet,
        waist = inv.sailfi_belt,
        right_ear = inv.ishvara,
        left_ear = inv.moonshade_earring,
        left_ring = inv.corneilias_ring,
        right_ring = inv.epaminondas_ring,
        back = inv.BLU_SAV_WS_CAPE,
    }
    local black_halo = savage_blade

    local requiescat_set = set_combine(savage_blade, {
        neck = inv.fotia_gorget,
        -- waist = "Light Belt",
        left_ear = "Ishvara Earring",
        right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
    })

    local vorpal_blade = set_combine(savage_blade, { right_ring = "Begrudging Ring", })

    local burst_set = set_combine(nuke_set, {
        left_ear = "Static Earring",
        left_ring = "Mujin Band",
        right_ring = "Locus Ring",
        hands = { name = "Amalric Gages", augments = { 'INT+10', 'Mag. Acc.+15', '"Mag.Atk.Bns."+15', } },
    })

    --TP set
    local tp_set = {
        ammo = inv.coiste_bodhar,
        head = inv.malignance_chapeau,
        body = inv.Adhemar_A_body,
        hands = inv.Adhemar_A_hands,
        legs = inv.Herc_TA_legs,
        feet = inv.Herc_TA_feet,
        neck = inv.mirage_stole,
        waist = inv.windbuffet_belt,
        left_ear = inv.suppanomimi,
        right_ear = inv.dedition_earring,
        left_ring = inv.eponas_ring,
        right_ring = inv.chirich_ring,
        back = inv.null_shawl
    }
    local tp_hybrid_set = {
        ammo = inv.aurgelmir_orb,
        head = inv.malignance_chapeau,
        body = inv.malignance_tabard,
        hands = inv.malignance_gloves,
        legs = inv.malignance_tights,
        feet = inv.malignance_boots,
        neck = inv.mirage_stole,
        waist = inv.reiki_yotai,
        left_ear = inv.eabani_earring,
        right_ear = inv.dedition_earring,
        left_ring = inv.eponas_ring,
        right_ring = inv.chirich_ring,
        back = inv.null_shawl
    }
    local dual_wield_traits_high = {
        ammo = inv.coiste_bodhar,
        head = inv.malignance_chapeau,
        body = inv.malignance_tabard,
        hands = inv.Adhemar_A_hands,
        legs = inv.malignance_tights,
        feet = inv.Herc_TA_feet,
        neck = inv.mirage_stole,
        waist = inv.windbuffet_belt,
        left_ear = inv.crepus_earring,
        right_ear = inv.dedition_earring,
        left_ring = inv.eponas_ring,
        right_ring = inv.chirich_ring,
        back = inv.null_shawl
    }
    local tp_hybrid_mevasion_set = {
        ammo = inv.coiste_bodhar,
        head = inv.malignance_chapeau,
        body = inv.hashishin_mintan,
        hands = inv.malignance_gloves,
        legs = inv.malignance_tights,
        feet = inv.malignance_boots,
        neck = inv.mirage_stole,
        waist = inv.null_belt,
        left_ear = inv.suppanomimi,
        right_ear = inv.crepus_earring,
        left_ring = inv.eponas_ring,
        right_ring = inv.defending_ring,
        back = inv.null_shawl
    }


    local tp_set_acc = {
        ammo = inv.coiste_bodhar,
        head = inv.malignance_chapeau,
        body = inv.Adhemar_A_body,
        hands = inv.gazu_bracelets,
        legs = inv.Herc_TA_legs,
        feet = inv.malignance_boots,
        neck = inv.mirage_stole,
        waist = inv.windbuffet_belt,
        left_ear = inv.suppanomimi,
        right_ear = inv.crepus_earring,
        left_ring = inv.eponas_ring,
        right_ring = inv.chirich_ring,
        back = inv.null_shawl,
    }
    local tp_high_acc = {
        -- sub = "Flametongue",
        ammo = "Aurgelmir Orb",
        head = inv.malignance_chapeau,
        body = inv.malignance_tabard,
        hands = inv.gazu_bracelets,
        legs = inv.malignance_tights,
        feet = inv.malignance_boots,
        neck = inv.null_loop,
        waist = inv.sailfi_belt,
        left_ear = inv.crepus_earring,
        right_ear = inv.hashishin_earring,
        left_ring = inv.eponas_ring,
        right_ring = inv.chirich_ring,
        back = inv.null_shawl,
    }

    local idle_set = set_combine(tp_set, {
        head = inv.null_mask,
        neck = inv.null_loop,
        body = inv.hashishin_mintan,
        right_ring = inv.defending_ring,
        waist = inv.null_belt,
        hands = inv.gletis_hands,
        left_ear = inv.alabaster_earring,
        legs = { name = "Carmine Cuisses +1", augments = { 'Accuracy+20', 'Attack+12', '"Dual Wield"+6', } },
        feet = inv.gletis_feet,
    })
    local idle_town = idle_set

    -- Fastcast set
    local fast_cast_set = {
        head = inv.amalric_coif,
        neck = inv.baetyl_pendant,
        body = inv.dread_jupon,
        hands = inv.leyline_gloves,
        legs = inv.psycloth_legs,
        feet = inv.carmine_feet,
        waist = inv.witful_belt,
        left_ear = inv.alabaster_earring,
        right_ear = inv.loquacious_earring,
        left_ring = inv.weatherspoon_ring,
        right_ring = inv.lebeche_ring,
        back = inv.swith_cape,
        ammo = inv.sapience_orb,
    }

    -- Base Weaponskill set
    local chant_du_cygne = {
        hands = inv.Adhemar_A_hands,
        head = inv.Adhemar_A_head,
        body = "Gleti's Cuirass",
        legs = "Gleti's Breeches",
        feet = inv.thereoid_greaves,
        neck = inv.mirage_stole,
        waist = "Light Belt",
        left_ear = inv.odr_earring,
        right_ear = inv.mache_earring_p1,
        left_ring = inv.eponas_ring,
        right_ring = inv.begrudging_ring,
        back = inv.BLU_CRIT_WS_CAPE,
        ammo = "Jukukik Feather",
    }
    local sanguine_blade = set_combine(nuke_set, {
        neck = inv.baetyl_pendant,
        hands = inv.jhakri_cuffs,
        ring1 = inv.corneilias_ring,
        ring2 = inv.epaminondas_ring,
        back = inv.BLU_SAV_WS_CAPE,
        ammo = inv.oshashs_treastise,
    })
    local max_defense_set = {
        ammo = inv.staunch_tathlum,
        head = inv.hashishin_head,
        body = inv.hashishin_mintan,
        hands = inv.hashishin_hands,
        legs = inv.hashishin_legs,
        feet = inv.nyame_feet,
        neck = inv.warders_charm,
        waist = inv.platinum_moogle_belt,
        left_ear = inv.alabaster_earring,
        right_ear = inv.eabani_earring,
        left_ring = inv.acrchon_ring,
        right_ring = "Cacoethic Ring +1",
        back = "Null Shawl",

    }

    -- Damage taken set
    local pdt_set = {
        ammo = inv.coiste_bodhar,
        head = inv.malignance_chapeau,
        neck = inv.mirage_stole,
        body = inv.hashishin_mintan,
        back = inv.null_shawl,
        hands = inv.malignance_gloves,
        legs = inv.malignance_tights,
        feet = inv.malignance_boots,
        waist = inv.windbuffet_belt,
        -- waist = inv.platinum_moogle_belt,
        left_ring = inv.eponas_ring,
        right_ring = inv.defending_ring,
        left_ear = inv.alabaster_earring,
        right_ear = inv.dedition_earring,
    }
    -- Cure set
    local cure_set = set_combine(pdt_set, spell_intr_down, {
        right_ear = inv.mendicants_earring,
        hands = "Telchine Gloves",
        waist = inv.gishdubar_sash,
        left_ring = inv.lebeche_ring,
        right_ring = inv.najis_loop,
        feet = inv.mediums_sabots,
        back = inv.BLU_CURE_CAPE,
    })

    local magic_accuracy = {
        ammo = inv.hydrocera,
        head = inv.hashishin_head,
        body = inv.hashishin_mintan,
        hands = inv.hashishin_hands,
        legs = inv.hashishin_legs,
        feet = inv.malignance_boots,
        neck = inv.null_loop,
        waist = inv.null_belt,
        left_ear = inv.njordr_earring,
        right_ear = inv.hashishin_earring,
        left_ring = inv.stikini_ring2,
        right_ring = inv.metamorph_ring,
        back = inv.null_shawl,
    }
    local pdl_plus_items = {
        ammo = inv.crepuscular_pebble,
        hands = inv.gletis_hands,
    }



    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = { hands = "Mirage Bazubands +2" }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells

    sets.precast.FC = fast_cast_set
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, { body = inv.hashishin_mintan })


    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = chant_du_cygne
    sets.precast.WS.acc = chant_du_cygne

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = requiescat_set
    sets.precast.WS['Sanguine Blade'] = sanguine_blade
    sets.precast.WS['Savage Blade'] = savage_blade
    sets.precast.WS['Savage Blade'].attack_capped = set_combine(savage_blade, pdl_plus_items)
    sets.precast.WS['Expiacion'] = savage_blade
    sets.precast.WS['Expiacion'].attack_capped = set_combine(savage_blade, pdl_plus_items)
    sets.precast.WS['Vorpal Blade'] = vorpal_blade
    sets.precast.WS['Vorpal Blade'].attack_capped = set_combine(vorpal_blade, pdl_plus_items)
    sets.precast.WS['Black Halo'] = black_halo
    sets.precast.WS['Black Halo'].attack_capped = set_combine(black_halo, pdl_plus_items)
    sets.precast.WS['Red Lotus Blade'] = sanguine_blade
    sets.precast.WS['Seraph Blade'] = sanguine_blade


    -- Midcast Sets
    sets.midcast.FastRecast = fast_cast_set

    sets.midcast['Blue Magic'] = nuke_set

    -- Physical Spells --

    sets.midcast['Blue Magic'].Physical = physical_set
    sets.midcast['Blue Magic'].PhysicalAcc = physical_set
    sets.midcast['Blue Magic'].PhysicalStr = physical_set
    sets.midcast['Blue Magic'].PhysicalDex = sets.midcast['Blue Magic'].Physical
    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical)
    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --

    sets.midcast['Blue Magic'].Magical = nuke_set

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {
            main = { name = "Nibiru Cudgel", augments = { 'MP+50', 'INT+10', '"Mag.Atk.Bns."+15', } },
            sub = { name = "Nibiru Cudgel", augments = { 'MP+50', 'INT+10', '"Mag.Atk.Bns."+15', } },
        })

    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicAccuracy = magic_accuracy
    sets.midcast['Dream Flower'] = set_combine(magic_accuracy, spell_intr_down)
    sets.midcast['Dream Flower'].TH = set_combine(sets.midcast['Dream Flower'], treasure_hunter)
    sets.midcast['Cruel Joke'] = magic_accuracy
    sets.midcast['Tenebral Crush'] = set_combine(nuke_set, { head = inv.pixie_hairpin, left_ring = inv.acrchon_ring })



    -- Breath Spells --

    sets.midcast['Blue Magic'].Breath = nuke_set

    -- Other Types --

    sets.midcast['Blue Magic'].Stun = sets.midcast['Blue Magic'].MagicAccuracy

    sets.midcast['Blue Magic']['White Wind'] = cure_set

    sets.midcast['Blue Magic'].Healing = cure_set

    sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(pdt_set, spell_intr_down, blue_skill)
    -- sets.midcast['Occultation'] = set_combine(sets.midcast['Blue Magic'].SkillBasedBuff, { hands = inv.hashishin_hands })


    sets.midcast['Blue Magic'].Buff = set_combine(pdt_set, spell_intr_down)
    sets.midcast["Battery Charge"] = set_combine(pdt_set, spell_intr_down, {
        head = inv.amalric_coif,
        waist = inv.gishdubar_sash,
    })

    sets.midcast.Protect = { ring1 = "Sheltered Ring" }
    sets.midcast.Protectra = { ring1 = "Sheltered Ring" }
    sets.midcast.Shell = { ring1 = "Sheltered Ring" }
    sets.midcast.Shellra = { ring1 = "Sheltered Ring" }
    sets.midcast.Aquaveil = { head = "Amalric Coif", legs = "Shedir Seraweels", waist = "Emphatikos Rope" }




    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = { hands = "Magus Bazubands" }


    sets.latent_refresh = { waist = "Fucho-no-obi" }


    -- Resting sets
    sets.resting = {}

    -- Idle sets
    sets.idle = idle_set

    sets.idle.Normal = idle_set
    sets.idle.PDT = pdt_set

    sets.idle.Town = idle_town

    -- Defense sets
    sets.defense.PDT = pdt_set
    -- sets.defense.Normal = pdt_set

    sets.Kiting = { name = "Carmine Cuisses +1", augments = { 'Accuracy+20', 'Attack+12', '"Dual Wield"+6', } }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    sets.engaged = tp_set

    sets.engaged.Acc = tp_set_acc
    sets.engaged.HighAcc = tp_high_acc
    sets.engaged.Acc = tp_set_acc

    sets.engaged.AccDT = tp_hybrid_set
    sets.engaged.DWT = dual_wield_traits_high
    sets.engaged.MEva = tp_hybrid_mevasion_set

    sets.engaged.Refresh = set_combine(tp_set, { head = "Rawhide Mask", body = inv.hashishin_mintan })

    sets.engaged.DW = tp_set

    sets.engaged.DW.Acc = tp_set_acc

    sets.engaged.DW.Refresh = tp_set

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)


    sets.self_healing = cure_set
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff, active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end

    if spell.type == 'WeaponSkill' then
        if player.attack >= ATTACK_CAPPED then
            local ws_set = sets.precast.WS[spell.name]
            if ws_set and ws_set.attack_capped then
                equip(ws_set.attack_capped)
            end
        end
        if spell.english == 'Expiacion' then
            if player.vitals.tp > 1800 then
                equip(sets.expiacion_max_tp)
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category, spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
        state.CombatForm:reset()
    else
        state.CombatForm:set('DW')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 3)
end

local function set_lockstyle()
    local lockstyles = { '5', '13', '13' }
    local lockstyle = lockstyles[math.random(#lockstyles)]
    send_command(string.format('wait 4; input /lockstyleset %s', lockstyle))
end

windower.register_event('job change', set_lockstyle)
