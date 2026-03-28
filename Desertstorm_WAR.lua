local inv = require('inventory')
local res = require 'resources'

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function user_setup()
    send_command('@wait 5;input /lockstyleset 14')

    state.IdleMode:options('Normal', 'Reraise', 'MEVA')
    state.HybridMode:options('Normal', 'AccDT')

    send_command('bind ^f10 gs c cycle MagicWSMode')
    send_command('bind f10 gs c cycle IdleMode')
    send_command('bind f11 gs c berserkmode')
    send_command('bind ^f11 gs c retaliationmode')
    send_command('bind !f11 gs c defendermode')
    send_command('bind f12 gs c wslist')

    state.OffenseMode = M { ['description'] = 'Engaged Mode', 'Normal', 'DT', 'HighAccuracy' }
    state.BerserkMode = M { ['description'] = 'Berserk Mode', 'Normal', 'Auto', 'Auto:Swap', 'Auto:NoSwap' }
    state.RetaliationMode = M { ['description'] = 'Retaliation Mode', 'Normal', 'Auto' }
    state.DefenderMode = M { ['description'] = 'Defender Mode', 'Normal', 'Auto' }
    state.MagicWSMode = M { ['description'] = 'Magic WS Mode', 'Normal', 'MAcc' }
    state.EnmityMode = M { ['description'] = 'Enmity Mode', 'Off', 'On' }
    state.WeaponskillMode:options('Normal', 'ACC')
    --state.WeaponskillMode:options('Normal','ACC','Iroha')
    select_default_macro_book()

    -- Set Common Aliases --
    send_command("alias axe gs equip sets.axe")
    send_command("alias sword gs equip sets.sword")
    send_command("alias greatsword gs equip sets.greatsword")
    send_command("alias greataxe gs equip sets.greataxe")
    send_command("alias wsset gs equip sets.ws")
    send_command("alias mwsset gs equip sets.ws.magic")
    send_command("alias strwsset gs equip sets.ws.strbased")
    send_command("alias vitwsset gs equip sets.ws.vitbased")
    send_command("alias eng gs equip sets.engaged.Normal")
    send_command("alias enmity gs equip sets.enmity")
    send_command("alias meva gs equip sets.meva")
    send_command("alias fc gs equip sets.precast.FastCast")
    send_command("alias idle gs equip sets.Idle.Current")
    send_command("alias shieldblock gs equip sets.engaged.ShieldBlock")
    send_command("alias g11_m2g11 input /ja Defender <me>")
    send_command("alias g11_m2g12 input /ja Restraint <me>")
    send_command("alias g11_m2g13 input /ja Berserk <me>")
    send_command("alias g11_m2g14 input /ja Warcry <me>")
    send_command("alias g11_m2g15 input /ja Aggressor <me>")
    send_command("alias g11_m2g16 gs c ws 1")
    send_command("alias g11_m2g17 gs c ws 2")
    send_command("alias g11_m2g18 gs c ws 3")


    WeaponSkill = {
        ["Great Sword"] = {
            ["1"] = "Resolution",
            ["2"] = "Scourge",
            ["3"] = "Shockwave"
        },
        ["Great Axe"] = {
            ["1"] = "Upheaval",
            ["2"] = "King's Justice",
            ["3"] = "Full Break"
        },
        ["Axe"] = {
            ["1"] = "Mistral Axe",
            ["2"] = "Decimation",
            ["3"] = "Cloudsplitter"
        },
        ["Sword"] = {
            ["1"] = "Savage Blade",
            ["2"] = "Requiescat",
            ["3"] = "Vorpal Blade"
        },
        ["Club"] = {
            ["1"] = "Realmrazer",
            ["2"] = "Black Halo",
            ["3"] = "Judgment"
        },
        ["Dagger"] = {
            ["1"] = "Evisceration",
            ["2"] = "Aeolian Edge",
            ["3"] = "Exenterator"
        },
        ["Polearm"] = {
            ["1"] = "Stardiver",
            ["2"] = "Impulse Drive",
            ["3"] = "Vorpal Thrust"
        },
        ["Staff"] = {
            ["1"] = "Cataclysm",
            ["2"] = "Earth Crusher",
            ["3"] = "Shattersoul"
        },

    }
end

function init_gear_sets()
    -- sets.greataxe = {
    --     main = "Chango",
    --     sub = "Utu Grip"
    -- }
    -- sets.greatsword = {
    --     main = "Ragnarok",
    --     sub = "Utu Grip"
    -- }
    sets.sword = {
        main = inv.naegling,
        sub = inv.blurred_shield
    }


    sets.meva = {
        ammo = inv.staunch_tathlum,
        --head="Volte Cap",
        head = "Sakpata's Helm",
        body = "Sakpata's Plate",
        hands = "Sakpata's Gauntlets",
        legs = "Sakpata's Cuisses",
        feet = "Sakpata's Leggings",
        --hands="Volte Bracers",
        --legs="Volte Brayettes",
        --feet="Volte Sollerets",
        neck = "Warder's Charm +1",
        waist = "Engraved Belt",
        left_ear = "Eabani Earring",
        right_ear = "Flashward Earring",
        left_ring = "Purity Ring",
        right_ring = "Vengeful Ring",
        back = { name = "Cichol's Mantle", augments = { 'MND+20', 'Eva.+20 /Mag. Eva.+20', 'Mag. Evasion+10', 'Mag. Evasion+15', } },
    }
    local tp_set = {
        ammo = inv.coiste_bodhar,
        head = inv.flama_head,
        body = inv.boii_body,
        hands = inv.tatenashi_hands,
        legs = inv.pummler_legs,
        feet = inv.pummler_feet,
        neck = inv.ainia_collar,
        waist = inv.sailfi_belt,
        left_ear = inv.schere_earring,
        right_ear = inv.boii_earring,
        left_ring = inv.niqmaddu_ring,
        right_ring = inv.chirich_ring,
        back = inv.null_shawl,
    }
    local hybrid_acc_dt = {
        ammo = inv.coiste_bodhar,
        head = inv.hjarrandi_helm,
        body = inv.boii_body,
        hands = inv.sakpatas_hands,
        legs = inv.pummler_legs,
        feet = inv.pummler_feet,
        neck = inv.null_loop,
        waist = inv.sailfi_belt,
        left_ear = inv.dedition_earring,
        right_ear = inv.boii_earring,
        left_ring = inv.niqmaddu_ring,
        right_ring = inv.defending_ring,
        back = inv.null_shawl,
    }
    local impulse_drive = {
        ammo = inv.yetshila,
        head = inv.agoge_mask,
        body = inv.hjarrandi_breastplate,
        hands = inv.boii_mufflers,
        legs = inv.boii_legs,
        feet = inv.boi_feet,
        neck = inv.republican_medal,
        waist = inv.sailfi_belt,
        left_ear = inv.moonshade_earring,
        right_ear = inv.boii_earring,
        left_ring = inv.niqmaddu_ring,
        right_ring = inv.begrudging_ring,
        back = inv.WAR_SAV_WS_CAPE,
    }


    sets.engaged = {}
    sets.engaged.Normal = tp_set
    sets.engaged.AccDT = hybrid_acc_dt

    sets.engaged.DW = set_combine(sets.engaged.Normal,
        { ear1 = inv.suppanomimi, back = { name = "Cichol's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dual Wield"+10', 'Damage taken-5%', } }, })
    sets.dt = hybrid_acc_dt

    sets.dt2 = set_combine(sets.engaged.Normal, {
        head = inv.hjarrandi_helm, --7
        neck = inv.null_loop,
        back = inv.WAR_TP_DT_CAPE,
        right_ring = inv.defending_ring,
    })
    sets.dtenmity = {
        ammo = inv.staunch_tathlum,   --3
        head = "Pummeler's Mask +3",  --5
        body = "Souv. Cuirass +1",    --10
        hands = "Pumm. Mufflers +3",  --7
        legs = "Souv. Diechlings +1", --4
        feet = "Souveran Schuhs +1",  --5
        neck = "Loricate Torque +1",  --6
        waist = "Flume Belt +1",      --4
        left_ear = "Cryptic Earring",
        right_ear = "Trux Earring",
        left_ring = "Apeile Ring +1",
        right_ring = "Apeile Ring",
        back = "Moonbeam Cape", --5
    }

    sets.enmity = {
        ammo = "Aqreqaq Bomblet",                                                                                            -- 2
        head = "Pummeler's Mask +3",                                                                                         -- 12  (+3 adds +3)
        body = { name = "Souveran Cuirass", augments = { 'HP+80', 'Enmity+7', 'Potency of "Cure" effect received +10%', } }, -- 17
        hands = "Pumm. Mufflers +3",                                                                                         -- 15
        legs = { name = "Odyssean Cuisses", augments = { 'Accuracy+22 Attack+22', '"Store TP"+6', 'STR+8', } },              -- 4   (+8 aug)
        feet = { name = "Yorium Sabatons", augments = { 'Enmity+9', } },                                                     -- 14
        neck = "Unmoving Collar +1",                                                                                         -- 10
        waist = "Sinew belt",                                                                                                -- 3
        left_ear = "Cryptic Earring",                                                                                        -- 4
        right_ear = "Trux Earring",                                                                                          -- 5
        left_ring = "Apeile Ring +1",                                                                                        -- 5~9
        right_ring = "Apeile Ring",                                                                                          -- 5~9
        back = "Philidor Mantle",                                                                                            -- 5 (jse back +5)
    }                                                                                                                        -- Enmity = 98-106
    sets.engaged.Reraise = set_combine(sets.engaged, { body = "Twilight Mail", head = "Twilight Helm" })
    sets.engaged.HighAccuracy = {
        ammo = inv.coiste_bodhar,
        head = inv.null_mask,
        body = inv.boii_body,
        hands = inv.tatenashi_hands,
        legs = inv.tatenashi_legs,
        feet = inv.tatenashi_feet,
        neck = inv.null_loop,
        waist = inv.null_belt,
        left_ear = inv.mache_earring_p1,
        right_ear = inv.boii_earring,
        left_ring = inv.niqmaddu_ring,
        right_ring = inv.cacoethic_ring,
        back = inv.null_shawl,
    }
    sets.engaged.DWAcc = set_combine(sets.engaged.HighAccuracy,
        { ear1 = "Suppanomimi", back = { name = "Cichol's Mantle", augments = { 'DEX+20', 'Accuracy+20 Attack+20', 'Accuracy+10', '"Dual Wield"+10', 'Damage taken-5%', } }, })

    sets.engaged.MedAccuracy = {
        ammo = inv.aurgelmir_orb,
        head = inv.flama_head,
        body = "Pumm. Lorica +3",
        hands = "Sulev. Gauntlets +2",
        legs = "Pumm. Cuisses +3",
        feet = "Pumm. Calligae +3",
        neck = "War. Beads +2",
        waist = "Ioskeha Belt +1",
        left_ear = "Cessance Earring",
        right_ear = "Telos Earring",
        left_ring = inv.niqmaddu_ring,
        right_ring = "Regal Ring",
        back = { name = "Cichol's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', } },
    }
    sets.engaged.ShieldBlock = {
        ammo = inv.staunch_tathlum, --2
        head = { name = "Valorous Mask", augments = { 'Mag. Acc.+22', 'MND+8', 'Chance of successful block +10', 'Accuracy+13 Attack+13', 'Mag. Acc.+12 "Mag.Atk.Bns."+12', } },
        -- body="Tartarus Platemail", -- 9
        body = "Hjarrandi Breastplate",                                                                                         --dt12
        hands = "Agoge Mufflers +3",                                                                                            -- pdt 6
        legs = "Arjuna Breeches",                                                                                               -- pdt 4
        feet = { name = "Souveran Schuhs +1", augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%', } }, -- pdt 5
        neck = "Loricate Torque +1",                                                                                            -- 6
        --neck="Combatant's Torque",
        waist = "Ioskeha Belt +1",
        left_ear = "Thureous Earring",
        right_ear = "Telos Earring",
        left_ring = inv.niqmaddu_ring,
        right_ring = inv.defending_ring, -- 10
        back = { name = "Cichol's Mantle", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+10', '"Dbl.Atk."+10', } },
    }                                    -- Axe + Shield = 4 pdt + 5 DT.    Totals: DT-38, PDT-18  (total PDT: 56) (should consider swapping neck)
    sets.engaged.MEVA = sets.meva
    sets.engaged.DT = sets.dt
    sets.ws = {
        ammo = inv.knobkierrie,
        head = inv.agoge_mask,
        body = inv.pummler_body,
        hands = inv.boii_mufflers,
        legs = inv.boii_legs,
        feet = inv.sulevias_feet,
        right_ear = inv.moonshade_earring,
        left_ear = inv.thrud_earring,
        neck = inv.warrior_beads,
        waist = inv.sailfi_belt,
        left_ring = inv.epaminondas_ring,
        right_ring = inv.corneilias_ring,
        back = inv.WAR_SAV_WS_CAPE,
    }
    --back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10',}},
    sets.ws.vitbased = set_combine(sets.ws, { left_ring = inv.niqmaddu_ring
    })
    sets.ws.strbased = set_combine(sets.ws)
    sets.ws.magic = {
        ammo = inv.knobkierrie,
        head = inv.null_mask,
        body = inv.boii_body,
        hands = inv.boii_mufflers,
        legs = inv.boii_legs,
        feet = inv.sulevias_feet,
        neck = inv.baetyl_pendant,
        waist = inv.orpheus_sash,
        left_ear = inv.sortiarius_earring_mab6,
        right_ear = inv.friomisi_earring,
        left_ring = inv.corneilias_ring,
        right_ring = inv.epaminondas_ring,
        back = inv.toro_cape,
    }
    sets.ws.magicAcc = sets.ws.magic

    sets.ws.wsd = {
        ammo = inv.knobkierrie,
        head = inv.blistering_sallet,
        body = inv.pummler_body,
        hands = inv.boii_mufflers,
        legs = inv.odyssean_legs,
        feet = inv.sulevias_feet,
        neck = inv.warrior_beads,
        waist = inv.sailfi_belt,
        left_ear = inv.ishvara,
        right_ear = inv.thrud_earring,
        left_ring = inv.corneilias_ring,
        right_ring = inv.epaminondas_ring,
        back = inv.WAR_SAV_WS_CAPE,
    }

    sets.ws["Ukko\'s Fury"] = {
        ammo = inv.yetshila,
        head = inv.blistering_sallet,
        body = inv.pummler_body,
        hands = inv.boii_mufflers,
        legs = inv.boii_legs,
        feet = inv.sulevias_feet,
        neck = inv.warrior_beads,
        waist = inv.sailfi_belt,
        left_ear = inv.schere_earring,
        right_ear = inv.boii_earring,
        left_ring = inv.niqmaddu_ring,
        right_ring = inv.corneilias_ring,
        back = inv.WAR_SAV_WS_CAPE,
    }


    sets.ws["Fell Cleve"] = sets.ws.strbased
    sets.ws["Scourge"] = sets.ws.wsd
    sets.ws["Resolution"] = sets.ws.strbased

    sets.ws["Decimation"] = sets.ws.strbased
    sets.ws["Rampage"] = sets.ws.wsd
    sets.ws["Mistral Axe"] = set_combine(sets.ws.wsd, { neck = inv.warrior_beads, waist = "Engraved Belt" })
    sets.ws["Savage Blade"] = {
        ammo = inv.knobkierrie,
        head = inv.agoge_mask,
        body = inv.pummler_body,
        hands = inv.boii_mufflers,
        legs = inv.boii_legs,
        feet = inv.sulevias_feet,
        neck = inv.warrior_beads,
        waist = inv.sailfi_belt,
        left_ear = inv.moonshade_earring,
        right_ear = inv.thrud_earring,
        left_ring = inv.corneilias_ring,
        right_ring = inv.epaminondas_ring,
        back = inv.WAR_SAV_WS_CAPE,
    }
    sets.pdl = {
        body = inv.sakpatas_body
    }
    sets.ws["Sanguine Blade"] = {
        ammo = inv.knobkierrie,
        head = inv.pixie_hairpin,
        hands = inv.nyame_hands,
        body = inv.nyame_mail,
        legs = inv.nyame_legs,
        feet = inv.nyame_feet,
        neck = inv.baetyl_pendant,
        waist = inv.orpheus_sash,
        left_ear = inv.friomisi_earring,
        right_ear = inv.thrud_earring,
        left_ring = inv.corneilias_ring,
        right_ring = inv.epaminondas_ring,
        back = inv.WAR_SAV_WS_CAPE,
    }
    sets.ws["Judgment"] = sets.ws["Savage Blade"]
    sets.ws["True Strike"] = sets.ws.wsd
    sets.ws["Black Halo"] = sets.ws.savageblade
    sets.ws["Metatron Torment"] = sets.ws.wsd
    sets.ws["Upheaval"] = {}
    sets.ws["Upheaval"].Normal = sets.ws.vitbased
    sets.ws["Upheaval"].ACC = {
        ammo = inv.knobkierrie,
        head = inv.agoge_mask,
        body = inv.pummler_body,
        hands = "Sulev. Gauntlets +2",
        legs = "Pumm. Cuisses +3",
        feet = "Pumm. Calligae +3",
        neck = inv.fotia_gorget,
        waist = "Fotia Belt",
        left_ear = "Cessance Earring",
        right_ear = "Telos Earring",
        left_ring = inv.niqmaddu_ring,
        right_ring = "Regal Ring",
        back = { name = "Cichol's Mantle", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'VIT+10', '"Dbl.Atk."+10', } },
    }
    sets.ws["Upheaval"].Iroha = {
        ammo = inv.knobkierrie,
        head = { name = "Agoge Mask +3", augments = { 'Enhances "Savagery" effect', } },
        body = "Tartarus Platemail",
        hands = "Sulev. Gauntlets +2",
        --legs={ name="Agoge Cuisses +3", augments={'Enhances "Warrior\'s Charge" effect',}},
        legs = "Pumm. Cuisses +3",
        feet = "Pumm. Calligae +3",
        neck = inv.fotia_gorget,
        waist = "Fotia Belt",
        left_ear = "Cessance Earring",
        right_ear = "Telos Earring",
        left_ring = "Moonlight Ring",
        right_ring = "Moonlight Ring",
        back = { name = "Cichol's Mantle", augments = { 'VIT+20', 'Accuracy+20 Attack+20', 'VIT+10', '"Dbl.Atk."+10', } },
    }
    sets.ws["Red Lotus Blade"] = sets.ws.magic
    sets.ws["Burning Blade"] = sets.ws.magic
    sets.ws["Cloudsplitter"] = sets.ws.magic
    sets.ws["Freezebite"] = sets.ws.magic
    sets.ws["Gust Slash"] = sets.ws.magic
    sets.ws["Aeolian Edge"] = sets.ws.magic
    sets.ws["Flash Nova"] = sets.ws.magic
    sets.ws["Cataclysm"] = sets.ws.magic
    sets.ws["Earth Crusher"] = sets.ws.magic
    sets.ws["Impulse Drive"] = impulse_drive
    sets.ws["Stardriver"] = set_combine(impulse_drive, { neck = inv.fotia_gorget, hands = inv.flama_hands })


    ---  PRECAST SETS  ---
    sets.precast = {}
    -- sets.precast.JA = set_combine(sets.enmity, {})
    sets.precast.JA = {}
    sets.precast.JA.Berserk = {
        back = inv.WAR_SAV_WS_CAPE,
        body = inv.pummler_body,
        feet = inv.agoge_feet
    }
    sets.MaxBerserk = set_combine(sets.precast.JA,
        {
            back = inv.WAR_SAV_WS_CAPE,
            body = inv.pummler_body,
            feet = inv.agoge_feet,
            main = "Firangi"
        })
    sets.precast.JA.Warcry = set_combine(sets.precast.JA, { head = inv.agoge_mask })
    sets.precast.JA.Aggressor = set_combine(sets.precast.JA, { head = inv.pummler_mask, body = "Agoge Lorica +3" })
    sets.precast.JA['Mighty Strikes'] = set_combine(sets.precast.JA, { hands = "Agoge Mufflers +3" })
    sets.precast.JA['Defender'] = set_combine(sets.precast.JA, { hands = "Agoge Mufflers +3" })
    sets.precast.JA['Blood Rage'] = set_combine(sets.precast.JA, { body = inv.boii_body })
    sets.precast.Restraint = set_combine(sets.precast.JA, { hands = inv.boii_mufflers })
    sets.precast.JA.Tomahawk = set_combine(sets.precast.JA, { ammo = "Thr. Tomahawk", feet = inv.agoge_feet })
    sets.precast.Ranged = { ammo = "Dart" }

    sets.CurePotencyRecv = {
        body = { name = "Souveran Cuirass", augments = { 'HP+80', 'Enmity+7', 'Potency of "Cure" effect received +10%', } },
        legs = { name = "Souv. Diechlings +1", augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%', } },
        feet = { name = "Souveran Schuhs +1", augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%', } },
    }

    sets.PhalanxPotencyRecv = {
        body = { name = "Souveran Cuirass", augments = { 'HP+80', 'Enmity+7', 'Potency of "Cure" effect received +10%', } },
        legs = { name = "Souv. Diechlings +1", augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%', } },
        feet = { name = "Souveran Schuhs +1", augments = { 'HP+105', 'Enmity+9', 'Potency of "Cure" effect received +15%', } },
    }

    sets.precast.WS = sets.ws

    sets.precast.FastCast = {
        ammo = inv.sapience_orb,
        head = "Sakpata's Helm",
        body = { name = "Odyss. Chestplate", augments = { 'Mag. Acc.+14', '"Fast Cast"+5', '"Mag.Atk.Bns."+6', } },
        hands = inv.leyline_gloves,
        legs = "Arjuna Breeches",
        feet = { name = "Odyssean Greaves", augments = { '"Mag.Atk.Bns."+15', '"Fast Cast"+4', 'Mag. Acc.+8', } },
        neck = inv.baetyl_pendant,
        waist = inv.platinum_moogle_belt,
        left_ear = "Loquac. Earring",
        right_ear = "Enchntr. Earring +1",
        left_ring = inv.weatherspoon_ring,
        right_ring = inv.gelat_ring_pdt,
        back = "Moonbeam Cape",
    }
    sets.sird = {
        ammo = inv.staunch_tathlum,
        head = { name = "Souv. Schaller +1", augments = { 'HP+105', 'VIT+12', 'Phys. dmg. taken -4', }, priority = 15 },
        legs = { name = "Founder's Hose", augments = { 'MND+10', 'Mag. Acc.+15', 'Attack+15', 'Breath dmg. taken -5%', }, priority = 2 },
        feet = { name = "Odyssean Greaves", augments = { '"Mag.Atk.Bns."+15', '"Fast Cast"+4', 'Mag. Acc.+8', }, priority = 1 },
        neck = "Moonbeam Necklace",
        waist = "Audumbla sash"
    }


    sets.midcast = {}

    ---  AFTERCAST SETS  ---
    sets.Idle = {
        ammo = inv.coiste_bodhar,
        body = inv.boii_body,
        hands = inv.sakpatas_hands,
        head = inv.null_mask,
        legs = inv.pummler_legs,
        feet = inv.hermes_sandals,
        neck = inv.null_loop,
        -- neck = inv.warrior_beads,
        waist = inv.sailfi_belt,
        left_ear = inv.schere_earring,
        right_ear = inv.boii_earring,
        left_ring = inv.niqmaddu_ring,
        right_ring = inv.chirich_ring,
        back = inv.null_shawl,
    }

    sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle

    sets.WakeSleep = { neck = inv.vim_torque }
    sets.ProtectBuff = { ring1 = "Sheltered Ring" }
end

function job_precast(spell)
    handle_equipping_gear(player.status)
    if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)']) then
        cancel_spell()
        send_command('@wait 1;')
        equip(sets.Idle.Current)
        return
    end
    if sets.precast.JA[spell.name] then
        equip(sets.precast.JA[spell.name])
    elseif spell.action_type == 'Magic' then
        equip(sets.precast.FastCast)
    end
    if spell.name == 'Ranged' then
        equip(sets.precast.Ranged)
    end
end

function job_post_precast(spell)
    if spell.type == 'WeaponSkill' and player.attack >= 4300 then
        equip(sets.pdl)
    end
    if player.tp > 1900 and spell.type == 'WeaponSkill' then
        equip({ left_ear = inv.ishvara })
        windower.add_to_chat(10, "Adding in Moonshade Earring for more TP:" .. player.tp)
        if state.MagicWSMode.value == "MAcc" and spell.name == "Aeolian Edge" then
            equip(sets.ws.magicAcc)
        end
        if spell.name == "Holy Water" then
            equip(sets.HolyWater)
        end
        if spell.name == "Cataclysm" and world.weather_element == "Dark" then
            equip(set_combine(sets.ws.magic,
                { head = "Pixie Hairpin +1", ring1 = "Archon Ring", waist = "Hachirin-no-Obi" }))
        end
    end
end

function job_midcast(spell)
    if spell.name == 'Ranged' then
        equip(sets.precast.Ranged)
    end
    if spell.action_type == 'Magic' then
        equip(sets.dtenmity)
    end
    if spell.name:contains('Utsusemi') or spell.skill == 'Enhancing Magic' or spell.skill == "Healing Magic" then
        equip(set_combine(sets.precast.FastCast, sets.sird))
    end
    if spell.name:contains('Phalanx') then
        equip(set_combine(sets.dt, sets.sird, { feet = "Souveran Schuhs +1", hands = "Souv. Handsch. +1", }))
    end
end

function job_post_midcast(spell)
    if spell.name == 'Utsusemi: Ichi' then
        send_command('cancel Copy Image|Copy Image (2)')
    end
    if spell.type == "WeaponSkill" then
        tpspent = spell.tp_cost
    end
end

function job_aftercast(spell)
    handle_equipping_gear(player.status)
    equip(sets.Idle.Current)
end

function job_post_aftercast(spell)
    if spell.type == "WeaponSkill" and (state.BerserkMode.value == "Auto" or state.BerserkMode.value == "Auto:Swap") and windower.ffxi.get_ability_recasts()[1] == 0 then
        currentMain = player.equipment.main
        currentSub = player.equipment.sub
        if state.BerserkMode.value == "Auto:Swap" then
            windower.add_to_chat("Current Equipment: " .. currentMain .. " " .. currentSub)
            equip(sets.MaxBerserk)
        end
        send_command("@wait 2.5;input /ja Berserk <me>")
    end
    if spell.name == "Berserk" and (state.BerserkMode.value == "Auto" or state.BerserkMode.value == "Auto:Swap") and currentMain and currentSub then
        equip({ main = currentMain, sub = currentSub })
    end
    if not buffactive.Retaliation and state.RetaliationMode.value == "Auto" and windower.ffxi.get_ability_recasts()[8] == 0 then
        send_command("@wait 2.5;input /ja Retaliation <me>")
    end
    if not buffactive.Defender and state.DefenderMode.value == "Auto" and windower.ffxi.get_ability_recasts()[3] == 0 then
        send_command("@wait 2.5;input /ja Defender <me>")
    end
end

function status_change(new, tab)
    handle_equipping_gear(player.status)
    if new == 'Resting' then
        equip(sets.Resting)
    else
        equip(sets.Idle.Current)
    end
end

function job_buff_change(status, gain_or_loss)
    job_handle_equipping_gear(player.status)
    if (gain_or_loss) then
        -- add_to_chat(4, '------- Gained Buff: ' .. status .. '-------')
        if status == "sleep" then
            equip(sets.WakeSleep)
        end
    else
        -- add_to_chat(3, '------- Lost Buff: ' .. status .. '-------')
    end
end

function job_self_command(command)
    if command[1]:lower() == "ws" and command[2] ~= nil then
        local EquipedGear = windower.ffxi.get_items()
        local CurrentSkill
        if EquipedGear.equipment.main == nil or EquipedGear.equipment.main == 0 then
            CurrentSkill = "Hand-to-Hand"
        else
            CurrentSkill = res.skills
                [res.items[windower.ffxi.get_items(EquipedGear.equipment.main_bag, EquipedGear.equipment.main).id].skill]
                .en
        end
        send_command('input /ws ' .. WeaponSkill[CurrentSkill][command[2]])
    end
    if command[1]:lower() == "wslist" then
        local EquipedGear = windower.ffxi.get_items()
        local CurrentSkill
        if EquipedGear.equipment.main == nil or EquipedGear.equipment.main == 0 then
            CurrentSkill = "Hand-to-Hand"
        else
            CurrentSkill = res.skills
                [res.items[windower.ffxi.get_items(EquipedGear.equipment.main_bag, EquipedGear.equipment.main).id].skill]
                .en
        end
        windower.add_to_chat(2, "WS List:")
        for i, v in pairs(WeaponSkill[CurrentSkill]) do
            windower.add_to_chat(2, i .. ") " .. v)
        end
    end
    if command[1]:lower() == "berserkmode" then
        currentMain = player.equipment.main
        currentSub = player.equipment.sub
        send_command('gs c cycle BerserkMode')
    end
    if command[1]:lower() == "retaliationmode" then
        send_command('gs c cycle RetaliationMode')
    end
    if command[1]:lower() == "defendermode" then
        send_command('gs c cycle defenderMode')
    end
end

function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
    equip(sets.Idle.Current)
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    if buffactive.sleep then
        equip(sets.WakeSleep)
    end
    if playerStatus == 'Idle' then
        equip(sets.Idle.Current)
    end
    if state.IdleMode.value == "Reraise" then
        sets.Idle.Current = set_combine(sets.Idle, { body = "Twilight Mail", head = "Twilight Helm" })
    elseif state.IdleMode.value == "MEVA" or state.OffenseMode.value == "MEVA" then
        sets.Idle.Current = sets.meva
    elseif state.IdleMode.value == "DT" or state.OffenseMode.value == "DT" then
        sets.Idle.Current = sets.dt
        sets.engaged.DT = sets.dt
    elseif state.OffenseMode.value == "ShieldBlock" then
        sets.Idle.Current = sets.engaged.ShieldBlock
    else
        sets.Idle.Current = sets.Idle
    end
end

function select_default_macro_book()
    set_macro_page(1, 5)
end
