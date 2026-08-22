---@diagnostic disable: undefined-global
-- Gear inventory for Poquito
-- Returns a table of gear pieces referenced across job files

return {
    -- Range / Ammo
    Miracle_Cheer      = "Miracle Cheer",
    Matre_Bell         = "Matre Bell",
    Mavi_Tathlum       = "Mavi Tathlum",
    Knobkierrie        = "Knobkierrie",
    Ginsen             = "Ginsen",
    Relic_Horn         = "Relic Horn",
    Linos              = { name = "Linos", augments = { 'Accuracy+15', '"Store TP"+4', 'Quadruple Attack +2', } },
    Ghastly_Tathlum    = "Ghastly Tathlum +1",
    Hydrocera          = "Hydrocera",

    -- Sub
    Kali               = { name = "Kali", augments = { 'Mag. Acc.+15', 'String instrument skill +10', 'Wind instrument skill +10', } },
    Naegling           = "Naegling",
    Nibiru_Cudgel      = "Nibiru Cudgel",
    Kaja_Rod           = "Kaja Rod",
    Enki_Strap         = "Enki Strap",
    Adapa_Shield       = "Adapa Shield",
    Choco_Shield       = "Choco. Shield +1",
    Genmei_Shield      = "Genmei Shield",

    -- Head
    Fili_Calot         = "Fili Calot +2",
    Inyanga_Tiara      = "Inyanga Tiara +2",
    Aya_Zucchetto      = "Aya. Zucchetto +2",
    Vanya_Hood         = { name = "Vanya Hood", augments = { 'MP+50', '"Cure" potency +7%', 'Enmity-6', } },
    Tema_Headband      = "Tema. Headband",
    Merl_Hood          = "Merlinic Hood",
    Decennial_Crown    = "Decennial Crown",
    Redeyes            = "Redeyes",
    Bards_Roundlet     = "Bard's Roundlet",
    Brioso_Roundlet    = "Brioso Roundlet +2",
    Abyssal_Mask       = "Abyssal Mask",
    Ruwa_Armet         = "Ruwa Armet",
    Behemoth_Masque    = "Behemoth Masque",
    Goblin_Masque      = "Goblin Masque",
    GMoogle_Masque     = "G. Moogle Masque",
    Null_Masque        = "Null Masque",
    Nahtirah_Hat       = "Nahtirah Hat",

    -- Neck
    Moonbow_Whistle    = "Mnbw. Whistle +1",
    Aoidos_Matinee     = "Aoidos' Matinee",
    Bards_Charm        = { name = "Bard's Charm +1", augments = { 'Path: A', } },
    Loricate_torque    = "Loricate Torque +1",
    Quanpur_Necklace   = "Quanpur Necklace",
    Adad_Amulet        = "Adad Amulet",
    Erra_Pendant       = "Erra Pendant",
    Mizu_Kubikazari    = "Mizu. Kubikazari",
    Reti_Pendant       = "Reti Pendant",

    -- Ear
    Raising_Earring    = "Raising Earring",
    Dominance_Earring  = "Dominance Earring",
    Brutal_Earring     = "Brutal Earring",
    Alabaster_Earring  = "Alabaster Earring",
    Loquac_Earring     = "Loquac. Earring",
    Boii_Earring       = { name = "Boii Earring", augments = { 'System: 1 ID: 1676 Val: 0', 'Accuracy+6', 'Mag. Acc.+6', } },
    Eabani_Earring     = "Eabani Earring",
    Ishvara_Earring    = "Ishvara Earring",
    Calamitous_Earring = "Calamitous Earring",
    Bhikku_Earring     = { name = "Bhikku Earring +1", augments = { 'System: 1 ID: 1676 Val: 0', 'Accuracy+12', 'Mag. Acc.+12', '"Store TP"+4', } },
    Hashishin_Earring  = { name = "Hashishin Earring", augments = { 'System: 1 ID: 1676 Val: 0', 'Accuracy+6', 'Mag. Acc.+6', } },
    Arbatel_Earring    = { name = "Arbatel Earring", augments = { 'System: 1 ID: 1676 Val: 0', 'Mag. Acc.+6', } },
    Alabaster_Earring_2 = { name = "Alabaster Earring", augments = { 'Path: A', } },
    Moonshade_Earring  = { name = "Moonshade Earring", augments = { '"Mag.Atk.Bns."+4', 'TP Bonus +250', } },

    -- Body
    Fili_Hongreline    = "Fili Hongreline +2",
    Inyanga_Jubbah     = "Inyanga Jubbah +2",
    Ayanmo_Corazza     = "Ayanmo Corazza +2",
    Vanya_Robe         = { name = "Vanya Robe", augments = { 'MP+50', '"Cure" potency +7%', 'Enmity-6', } },
    Merl_Jubbah        = "Merlinic Jubbah",
    Bihu_Jstcorps      = { name = "Bihu Just. +4", augments = { 'Enhances "Troubadour" effect', } },
    Brioso_Just        = "Brioso Justau. +2",
    WN_Kaftan          = "WN Kaftan +1",
    Temachtiani_Shirt  = "Temachtiani Shirt",
    Novennial_Coat     = "Novennial Coat",
    Decennial_Coat     = "Decennial Coat",
    Behemoth_Suit      = "Behemoth Suit",
    Goblin_Suit        = "Goblin Suit",
    GMoogle_Suit       = "G. Moogle Suit",
    Perfection_Plate   = "Perfection Plate.",
    Egbesu_Frock       = "Egbesu Frock",
    Ruwa_Breastplate   = "Ruwa Breastplate",

    -- Hands
    Fili_Manchettes    = "Fili Manchettes +2",
    Inyanga_Dastanas   = "Inyan. Dastanas +2",
    Aya_Manopolas      = "Aya. Manopolas +1",
    Vanya_Cuffs        = { name = "Vanya Cuffs", augments = { 'MP+50', '"Cure" potency +7%', 'Enmity-6', } },
    Bihu_Cuffs         = { name = "Bihu Cuffs", augments = { 'Enhances "Con Brio" effect', } },
    Merl_Dastanas      = "Merlinic Dastanas",
    Brioso_Cuffs       = "Brioso Cuffs +4",
    Viti_Gloves        = { name = "Viti. Gloves +4", augments = { 'Enhancing Magic duration', } },
    Bunzi_Gloves       = "Bunzi's Gloves",
    WN_Mittens         = "WN Mittens +1",
    Gende_Gages        = "Gende. Gages +1",
    Temachtiani_Gloves = "Temachtiani Gloves",
    Leyline_Gloves     = { name = "Leyline Gloves", augments = { 'Accuracy+6', 'Mag. Acc.+2', '"Mag.Atk.Bns."+6', } },

    -- Rings
    Dim_Ring_Dem       = "Dim. Ring (Dem)",
    Inyanga_Ring       = "Inyanga Ring",
    Jubilee_Ring       = "Jubilee Ring",
    Echad_Ring         = "Echad Ring",
    Facility_Ring      = "Facility Ring",
    Warp_Ring          = "Warp Ring",
    Apate_Ring         = "Apate Ring",
    Caliber_Ring       = "Caliber Ring",
    Kishar_Ring        = "Kishar Ring",
    Empress_Band       = "Empress Band",
    Murky_Ring         = { name = "Murky Ring", augments = { 'Path: A', } },
    Shneddick_Ring     = "Shneddick Ring",
    Petrov_Ring        = "Petrov Ring",
    Excelsis_Ring      = "Excelsis Ring",
    Mujin_Band         = "Mujin Band",

    -- Back
    Intarabus_Cape_DT  = { name = "Intarabus's Cape", augments = { 'HP+30', 'Eva.+10 /Mag. Eva.+10', '"Cure" potency +10%', 'Phys. dmg. taken-2%', } },
    Intarabus_Cape_FC  = { name = "Intarabus's Cape", augments = { '"Fast Cast"+10', } },
    Intarabus_Cape_WS  = { name = "Intarabus's Cape", augments = { 'STR+20', 'Accuracy+20 Attack+20', 'STR+5', 'Weapon skill damage +10%', } },
    Nexus_Cape         = "Nexus Cape",
    Alabaster_Mantle   = "Alabaster Mantle",

    -- Waist
    Olympus_Sash       = "Olympus Sash",
    Flume_Belt         = "Flume Belt",
    Embla_Sash         = "Embla Sash",
    Sailfi_Belt        = "Sailfi Belt +1",
    Harfners_Sash      = "Harfner's Sash",

    -- Legs
    Fili_Rhingrave     = "Fili Rhingrave +2",
    Inyanga_Shalwar    = "Inyanga Shalwar +2",
    Aya_Cosciales      = "Aya. Cosciales +2",
    Vanya_Slops        = { name = "Vanya Slops", augments = { 'MP+50', '"Cure" potency +7%', 'Enmity-6', } },
    Hercl_Trousers     = "Herculean Trousers",
    Brioso_Cannions    = "Brioso Cannions +2",
    Assid_Pants        = "Assid. Pants +1",
    Bihu_Cannions      = { name = "Bihu Cannions", augments = { 'Enhances "Soul Voice" effect', } },
    WN_Braccae         = "WN Braccae +1",
    Temachtiani_Pants  = "Temachtiani Pants",
    Estqr_Fuseau       = "Estqr. Fuseau +1",
    Novennial_Hose     = "Novennial Hose",
    Decennial_Tights   = "Decennial Tights",
    Revelation_Brais   = "Revelation Brais",
    Egbesu_Slops       = "Egbesu Slops",

    -- Feet
    Inyanga_Crackows   = "Inyan. Crackows +1",
    Aya_Gambieras      = "Aya. Gambieras +1",
    Vanya_Clogs        = { name = "Vanya Clogs", augments = { 'MP+50', '"Cure" potency +7%', 'Enmity-6', } },
    Merl_Crackows      = "Merlinic Crackows",
    Brioso_Slippers    = "Brioso Slippers +3",
    Bihu_Slippers      = { name = "Bihu Slippers", augments = { 'Enhances "Nightingale" effect', } },
    Fili_Cothurnes     = "Fili Cothurnes +2",
    WN_Clomps          = "WN Clomps +1",
    Temachtiani_Boots  = "Temachtiani Boots",
    Odyssean_Greaves   = "Odyssean Greaves",
    Sprinters_Shoes    = "Sprinter's Shoes",
    Battlecast_gaiters = "Battlecast Gaiters",

    -- Weapons
    Lembing            = "Lembing",

    -- Waist
    Sroda_Belt         = "Sroda Belt",
    Null_Belt          = "Null Belt",
    Goblin_Belt        = "Goblin Belt",

    -- Back
    Null_Shawl         = "Null Shawl",

    -- Body
    Councilor_Garb     = "Councilor's Garb",

    -- Hands
    Councilor_Cuffs    = "Councilor's Cuffs",

}
