local inv = require('inventory')
local weather = require('weather')
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
	mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized h+ere will automatically be tracked.
function job_setup()
	state.Buff.Saboteur = buffactive.saboteur or false
end

function set_lockstyle()
	send_command('wait 4; input /lockstyleset 3')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

local crocea_daybreak = {
	main = { name = "Crocea Mors", augments = { 'Path: C', } },
	sub = "Daybreak",
}
local crocea_gletis = {
	main = { name = "Crocea Mors", augments = { 'Path: C', } },
	-- sub = "Gleti's Knife",
	sub = inv.gletis_knife,

}
local naegling_gletis = {
	main = "Naegling",
	sub = inv.gletis_knife,
	-- sub = inv.demersal_degen,

}
local naegling_machaera = {
	main = "Naegling",
	sub = { name = "Machaera +2", augments = { 'TP Bonus +1000', } },
}
local kaja_malevolance = {
	main = inv.levante_dagger,
	sub = { name = "Malevolence", augments = { 'INT+6', 'Mag. Acc.+7', '"Mag.Atk.Bns."+4', '"Fast Cast"+3', } },
}
local crocea_levante = {
	main = inv.crocea_mors,
	sub = inv.levante_dagger
}
local friomisi_set = { left_ear = inv.regal_earring, neck = inv.baetyl_pendant }

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('None', 'Normal')
	state.HybridMode:options('Normal', 'Acc', 'High Acc', 'AccWar')
	state.CastingMode:options('Normal', 'Burst')
	state.IdleMode:options('Normal', 'PDT', 'MDT')



	-- Add a new state for weapon mode with three options
	state.WeaponMode = M { ['description'] = 'Weapon Mode', 'Crocea+Daybreak', 'Excalibur+Gletis', 'Naegling+Gletis', "Naegling+Machera", 'Aeolian Cleave', 'Tenzen', '0 tp daggers' }

	-- Bind the F9 key to toggle weapon modes
	send_command('bind f9 gs c weaponmode')
	send_command('bind ~f9 gs c -weaponmode')

	gear.default.obi_waist = "Sekhmet Corset"

	select_default_macro_book()
	set_lockstyle()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets
	local atrophy_gloves = inv.atrophy_gloves
	local atrophy_tights = inv.atrophy_tights
	local vitiation_chapeau = inv.vitiation_chapeau
	local vitiation_tabard = inv.vitiation_tabard
	local lethargy_hands = inv.lethargy_hands
	local lethargy_legs = inv.lethargy_legs
	local oshasha_treatise = inv.oshashs_treastise
	local pixie_hairpin = inv.pixie_hairpin
	local cornelias_ring = inv.corneilias_ring


	local mind_cape = { name = "Sucellos's Cape", augments = { 'MND+20', 'Mag. Acc+20 /Mag. Dmg.+20', 'MND+10', 'Weapon skill damage +10%', } }

	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = { body = { name = inv.vitiation_tabard } }


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head = inv.atrophy_chapeau,
		body = inv.atrophy_tabard,
	}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	local nuke_set = {
		ammo = inv.ghastly_tathlum,
		head = inv.lethargy_chappel,
		body = inv.lethargy_body,
		hands = inv.lethargy_hands,
		legs = inv.lethargy_legs,
		feet = inv.vitiation_boots,
		neck = inv.sibyl_scarf,
		waist = inv.orpheus_sash,
		left_ear = inv.malignance_earring,
		right_ear = inv.regal_earring,
		left_ring = inv.freke_ring,
		right_ring = inv.metamorph_ring,
		back = inv.RDM_MAB_Cape,

	}
	local burst_set = set_combine(nuke_set, {
		main = inv.bunzi_rod,
		sub = inv.daybreak,
		head = inv.ea_hat,
		neck = inv.sibyl_scarf,
		body = inv.ea_houppe_p1,
		right_ring = inv.mujin_band,
	})
	local phalanx_set = {
		main = inv.sakpatas_sword,
		sub = inv.colada_phalanx,
		head = inv.phalanx_head,
		body = inv.body_phalanx,
		hands = inv.phalanx_hands,
		legs = inv.phalanx_legs,
		feet = inv.merlin_feet_phalanx
	}
	--Enfeebling set
	local enfeebling_set = {
		ammo = "Hydrocera",
		head = vitiation_chapeau,
		neck = { name = "Dls. Torque +1", augments = { 'Path: A', } },
		body = inv.atrophy_tabard,
		hands = lethargy_hands,
		legs = inv.atrophy_tights,
		feet = inv.vitiation_boots,
		waist = inv.null_belt,
		left_ear = inv.snorta_earring,
		right_ear = inv.regal_earring,
		left_ring = inv.kishar_ring,
		right_ring = inv.stikini_ring,
		back = mind_cape,
	}
	local enfeeble_potency = set_combine(enfeebling_set, { body = inv.lethargy_body })
	local max_enfeebling_acc = set_combine(enfeebling_set,
		{
			ammo = '',
			range = inv.ullr,
			back = inv.null_shawl,
			left_ring = inv.stikini_ring2,
			neck = inv.null_shawl
		})
	local enfeebling_acc = set_combine(enfeebling_set, { back = inv.null_shawl, left_ring = inv.stikini_ring2, })

	-- Fastcast set
	local fast_cast_set = {
		ammo = inv.staunch_tathlum,
		head = inv.atrophy_chapeau,
		neck = inv.loricate_torque,
		body = vitiation_tabard,
		hands = inv.leyline_gloves,
		legs = inv.psycloth_legs,
		feet = inv.nyame_feet,
		right_ear = inv.alabaster_earring,
		waist = inv.platinum_moogle_belt,
		right_ring = inv.weatherspoon_ring,
		left_ring = inv.defending_ring,
		back = inv.RDM_DW_Cape,
	}

	--TP sets
	-- Base TP set
	local tp_set = {
		ammo = inv.coiste_bodhar,
		head = inv.malignance_chapeau,
		body = inv.malignance_tabard,
		hands = inv.malignance_gloves,
		legs = inv.malignance_tights,
		feet = inv.malignance_boots,
		neck = inv.anu_torque,
		waist = inv.windbuffet_belt,
		left_ear = inv.sherida_earring,
		right_ear = inv.dedition_earring,
		left_ring = inv.crepuscular_ring,
		right_ring = inv.chirich_ring,
		back = inv.RDM_DW_Cape,
		-- back = inv.null_shawl,

	}
	local resist_stun_tp = {
		ammo = "Aurgelmir Orb",
		head = "Malignance Chapeau",
		body = "Onca Suit",
		neck = "Anu Torque",
		waist = { name = "Sailfi Belt +1", augments = { 'Path: A', } },
		left_ear = "Sherida Earring",
		right_ear = "Dedition Earring",
		left_ring = "Petrov Ring",
		right_ring = "Rajas Ring",
		back = inv.RDM_DW_Cape,
	}
	-- TP set for Naegling + Gleti's Knife

	local tp_naegling_machaera = set_combine(tp_set, naegling_machaera)

	local tp_crocea_daybreak = set_combine(tp_set, crocea_daybreak)

	local tp_naegling_gletis = set_combine(tp_set, naegling_gletis)


	-- TP set for Excalibur + Gleti's Knife
	local tp_excalibur_gletis = set_combine(tp_set, crocea_gletis)

	-- TP set for Malevolence Aeolian edge
	local tenzen = set_combine(crocea_levante, tp_set, {
		head = inv.umuthi_hat,
		hands = inv.ayanmo_hands,
		body = inv.ayanmo_corazza,
		-- back = inv.RDM_ENHANCHING_DURATION_CAPE,
		neck = inv.null_loop,
		waist = inv.orpheus_sash,
		legs = inv.vitiation_tights,
		left_ring = inv.metamorph_ring,
		left_ear = inv.alabaster_earring,
		right_ear = inv.suppanomimi,
		ammo = inv.sroda_tathlum

	})
	local aeolian_edge_cleave = set_combine(tp_set, {
		left_ring = inv.defending_ring,
		hands = inv.malignance_gloves,
		head = inv.malignance_chapeau,
		body = inv.malignance_tabard,
		feet = inv.malignance_boots,
		neck = inv.loricate_torque,
		waist = inv.windbuffet_belt,
		left_ear = inv.sherida_earring,
		right_ear = inv.dedition_earring,
		back = inv.RDM_DW_Cape,

	}, kaja_malevolance)

	local tp_0_dmg_daggers = set_combine(tp_set, {
		main = "Ethereal Dagger",
		sub = "Qutrub Knife",
		head = inv.umuthi_hat,
		hands = inv.ayanmo_hands,
		body = inv.ayanmo_corazza,
		neck = inv.null_loop,
		waist = inv.orpheus_sash,
		legs = inv.malignance_tights,
		left_ring = inv.stikini_ring,
		right_ring = inv.stikini_ring2,
		left_ear = inv.alabaster_earring,
		right_ear = inv.suppanomimi,
		feet = inv.taeon_dw_feet,
		ammo = inv.sroda_tathlum,
	})

	-- Base Weaponskill set
	local chant_du_cygne = {
		head = inv.blistering_sallet,
		body = inv.malignance_tabard,
		hands = inv.malignance_gloves,
		legs = inv.ayanmo_legs,
		feet = inv.thereoid_greaves,
		neck = inv.fotia_gorget,
		waist = inv.fotia_belt,
		left_ring = inv.ilabrat_ring,
		right_ring = inv.begrudging_ring,
		left_ear = inv.sherida_earring,
		right_ear = inv.mache_earring_p1,
		ammo = inv.yetshila,
		back = inv.RDM_Crit_Cape,
	}
	local savage_blade = {
		ammo = oshasha_treatise,
		neck = inv.republican_medal,
		head = inv.vitiation_chapeau,
		body = inv.nyame_mail,
		hands = inv.atrophy_gloves,
		legs = inv.nyame_legs,
		feet = inv.lethargy_feet,
		waist = inv.sailfi_belt,
		right_ear = inv.ishvara,
		left_ear = inv.moonshade_earring,
		left_ring = cornelias_ring,
		right_ring = inv.epaminondas_ring,
		back = inv.RDM_SAV_Cape,
	}
	local knights_of_round = {
		ammo = oshasha_treatise,
		neck = inv.republican_medal,
		head = inv.vitiation_chapeau,
		body = inv.nyame_mail,
		hands = inv.jhakri_cuffs,
		legs = inv.nyame_legs,
		feet = inv.lethargy_feet,
		waist = inv.sailfi_belt,
		left_ear = inv.ishvara,
		right_ear = inv.sherida_earring,
		left_ring = cornelias_ring,
		right_ring = inv.epaminondas_ring,
		back = inv.RDM_SAV_Cape,
	}

	local vorpal_blade = set_combine(savage_blade, { right_ring = "Begrudging Ring", })

	local aeolian_edge = {
		ammo = inv.sroda_tathlum,
		head = inv.lethargy_chappel,
		body = inv.lethargy_body,
		hands = inv.jhakri_cuffs,
		legs = lethargy_legs,
		feet = inv.lethargy_feet,
		neck = inv.baetyl_pendant,
		waist = inv.orpheus_sash,
		left_ear = inv.moonshade_earring,
		right_ear = inv.malignance_earring,
		left_ring = cornelias_ring,
		right_ring = inv.epaminondas_ring,
		back = mind_cape,
	}
	local eviceration = {
		head = inv.blistering_sallet,
		body = inv.malignance_tabard,
		hands = inv.malignance_gloves,
		legs = inv.ayanmo_legs,
		feet = inv.thereoid_greaves,
		neck = inv.fotia_gorget,
		waist = inv.fotia_belt,
		left_ring = inv.ilabrat_ring,
		right_ring = inv.begrudging_ring,
		left_ear = inv.sherida_earring,
		right_ear = inv.moonshade_earring,
		ammo = "Yetshila",
		back = inv.RDM_Crit_Cape,
	}
	local seraph_blade = {
		ammo = inv.sroda_tathlum,
		head = inv.lethargy_chappel,
		body = inv.lethargy_body,
		hands = inv.jhakri_cuffs,
		legs = lethargy_legs,
		feet = inv.lethargy_feet,
		neck = inv.fotia_gorget,
		waist = inv.orpheus_sash,
		left_ear = inv.moonshade_earring,
		right_ear = inv.malignance_earring,
		left_ring = inv.weatherspoon_ring,
		right_ring = inv.corneilias_ring,
		back = mind_cape,
	}
	local red_lotus_blade = {
		ammo = inv.sroda_tathlum,
		head = inv.lethargy_chappel,
		body = inv.lethargy_body,
		hands = inv.jhakri_cuffs,
		legs = lethargy_legs,
		feet = inv.lethargy_feet,
		neck = inv.baetyl_pendant,
		waist = inv.orpheus_sash,
		left_ear = inv.moonshade_earring,
		right_ear = inv.malignance_earring,
		left_ring = inv.epaminondas_ring,
		right_ring = inv.corneilias_ring,
		back = inv.RDM_SAV_Cape,
	}
	local sanguine_blade = set_combine(red_lotus_blade, {
		head = pixie_hairpin,
		-- waist = inv.orpheus_sash,
		-- waist = inv.hachirin_no_obi,
		back = mind_cape,
		left_ear = inv.regal_earring,
		left_ring = inv.corneilias_ring,
		right_ring = inv.epaminondas_ring,

	})
	local requiescat_set = {
		head = inv.lethargy_chappel,
		body = inv.lethargy_body,
		hands = inv.jhakri_cuffs,
		neck = inv.fotia_gorget,
		waist = inv.fotia_belt,
		legs = lethargy_legs,
		feet = inv.lethargy_feet,
		left_ear = "Ishvara Earring",
		right_ear = { name = "Moonshade Earring", augments = { 'Accuracy+4', 'TP Bonus +250', } },
		left_ring = cornelias_ring,
		right_ring = "Rufescent Ring",
		back = mind_cape,

	}
	local black_halo = {
		ammo = oshasha_treatise,
		neck = inv.republican_medal,
		head = inv.vitiation_chapeau,
		body = inv.lethargy_body,
		hands = inv.atrophy_gloves,
		legs = lethargy_legs,
		feet = inv.lethargy_feet,
		waist = inv.sailfi_belt,
		right_ear = inv.regal_earring,
		left_ear = inv.moonshade_earring,
		left_ring = inv.corneilias_ring,
		right_ring = inv.epaminondas_ring,
		back = mind_cape,

	}
	local empyreal_arrow = {
		neck = inv.null_loop,
		head = inv.malignance_chapeau,
		body = inv.malignance_tabard,
		hands = inv.malignance_gloves,
		legs = inv.malignance_tights,
		feet = inv.malignance_boots,
		waist = inv.null_belt,
		right_ear = inv.crepus_earring,
		left_ear = inv.moonshade_earring,
		left_ring = inv.corneilias_ring,
		right_ring = inv.epaminondas_ring,
		back = inv.null_shawl,

	}
	-- Damage Taken set	

	local pdt_set = {
		sub = "Genbu's Shield",
		head = inv.malignance_chapeau,
		neck = inv.loricate_torque,
		body = inv.lethargy_body,
		hands = inv.malignance_gloves,
		legs = inv.carmine_legs,
		feet = inv.malignance_boots,
		waist = "Flume Belt",
		left_ring = inv.defending_ring,
		right_ring = inv.gelat_ring_pdt,
		back = inv.RDM_DW_Cape,
	}

	local pdt_set2 = {
		ammo = "Staunch Tathlum",
		head = inv.lethargy_chappel,
		neck = inv.loricate_torque,
		body = inv.lethargy_body,
		hands = inv.nyame_hands,
		legs = inv.malignance_tights,
		feet = inv.malignance_boots,
		right_ear = inv.alabaster_earring,
		waist = inv.platinum_moogle_belt,
		right_ring = inv.defending_ring,
		back = inv.RDM_DW_Cape,
	}

	-- Enhancing skill
	local enhancing_set = {
		ammo = inv.staunch_tathlum,
		head = inv.befouled_crown,
		body = vitiation_tabard,
		hands = atrophy_gloves,
		legs = atrophy_tights,
		feet = inv.lethargy_feet,
		waist = inv.embla_sash,
		neck = { name = "Dls. Torque +1", augments = { 'Path: A', } },
		left_ear = inv.mimir_earring,
		right_ear = inv.lethargy_earring,
		left_ring = inv.defending_ring,
		back = inv.RDM_ENHANCHING_DURATION_CAPE,
	}
	local barstatus_set = set_combine(enhancing_set, { neck = "Sroda necklace", })

	local enhancing_duration = set_combine(enhancing_set, { hands = atrophy_gloves })

	local enhancing_regen = set_combine(enhancing_duration,
		{
			head = inv.telchine_cap_regen,
			hands = inv.telchine_gloves_regen,
			body = inv.telchine_body_regen,
			legs = inv.telchine_legs_regen,
			feet = inv.telchine_feet_regen,
		})

	local max_enhancing = set_combine(enhancing_set, {
		main = inv.pukulatmuj_1,
		sub = inv.forfend_p1,
		waist = inv.olympus_sash,
		head = inv.befouled_crown,
		neck = inv.incanters_torque,
		right_ear = inv.andoaa_earring,
		hands = inv.vitiation_gloves,
		left_ring = inv.stikini_ring2,
		right_ring = inv.stikini_ring,
		-- back = { name = "Ghostfyre Cape", augments = { 'Enfb.mag. skill +5', 'Enha.mag. skill +10', 'Mag. Acc.+6', } },
	})

	local treasure_hunter = {
		-- head = "Wh. Rarab Cap +1",
		head = inv.null_mask,
		body = inv.lethargy_body,
		ammo = "Per. Lucky Egg",
		waist = "Chaac Belt",
		feet = { name = "Merlinic Crackows", augments = { '"Repair" potency +1%', 'DEX+9', '"Treasure Hunter"+2', 'Mag. Acc.+20 "Mag.Atk.Bns."+20', } },
	}
	--Cure set
	local cure_set = set_combine(pdt_set2, {
		ammo = inv.staunch_tathlum,
		head = inv.vanya_hood,
		ear1 = "Mendicant's earring",
		hands = "Telchine Gloves",
		legs = inv.atrophy_tights,
		waist = inv.gishdubar_sash,
		left_ring = inv.najis_loop,
		right_ring = "Lebeche Ring",
		feet = inv.kaykaus_boots,
	})
	--Idle set
	local hat = {
		head = inv.vitiation_chapeau,
		body = inv.lethargy_body,
		hands = inv.lethargy_hands,
		neck = inv.null_loop,
		right_ear = inv.alabaster_earring,
		-- neck = { name = "Dls. Torque +1", augments = { 'Path: A', } },
		left_ring = inv.defending_ring,
		legs = inv.carmine_legs,
		feet = inv.merlinic_refresh,
		ammo = inv.homiliary,

	}
	local accuracy_set = set_combine(tp_set, {
		neck = inv.null_loop,
		right_ear = inv.crepus_earring,
		waist = inv.null_belt,
		ammo = inv.aurgelmir_orb,
		left_ring = inv.ilabrat_ring
	})
	local high_accuracy = set_combine(tp_set, {
		neck = inv.null_loop,
		hands = inv.gazu_bracelets,
		left_ear = inv.sherida_earring,
		right_ear = inv.crepus_earring,
		left_ring = inv.cacoethic_ring,
		waist = inv.null_belt,
		back = inv.null_shawl,
		ammo = inv.aurgelmir_orb
	})
	local war_accuracy = set_combine(tp_set, {
		-- left_ring = inv.defending_ring,
		back = inv.null_shawl,
		-- waist = inv.null_belt,

	})
	local kei_hp = set_combine(tp_set, {
		left_ring = inv.defending_ring,
		right_ring = inv.ilabrat_ring,
		back = inv.null_shawl,
		waist = inv.platinum_moogle_belt,
		right_ear = inv.odnowa_earring,


	})
	local cursna = {
		neck = inv.malison_medallion,
		right_ring = inv.menelaus_ring,
		back = inv.oretan_cape,
	}


	sets.accuracy = accuracy_set
	sets.high_accuracy = high_accuracy
	sets.war_acc = war_accuracy
	sets.kei = kei_hp

	sets.defense = pdt_set2

	-- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
	-- No other FC sets necessary.
	sets.precast.FC = fast_cast_set

	sets.precast.FC.Impact = set_combine(sets.precast.FC)

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = chant_du_cygne

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = requiescat_set
	sets.precast.WS['Sanguine Blade'] = sanguine_blade
	sets.precast.WS['Savage Blade'] = savage_blade
	sets.precast.WS['Vorpal Blade'] = vorpal_blade
	sets.precast.WS['Knights of Round'] = knights_of_round
	sets.precast.WS['Fast Blade'] = tp_set
	sets.precast.WS['Aeolian Edge'] = aeolian_edge
	sets.precast.WS['Red Lotus Blade'] = red_lotus_blade
	sets.precast.WS['Burning Blade'] = red_lotus_blade
	sets.precast.WS['Seraph Blade'] = seraph_blade
	sets.precast.WS['Shining Blade'] = seraph_blade
	sets.precast.WS['Death Blossom'] = savage_blade
	sets.precast.WS['Eviceration'] = eviceration
	sets.precast.WS['Black Halo'] = black_halo
	sets.precast.WS['Empyreal Arrow'] = empyreal_arrow
	sets.precast.WS['Flat Blade'] = savage_blade


	-- Midcast Sets
	sets.midcast.Stoneskin = set_combine(enhancing_set, {
		neck = "Nodens Gorget",
		legs = inv.shedir_seraweels,
		left_ear = inv.earthcry_earring,
		waist = inv.siegel_sash,
	})
	sets.midcast.FastRecast = fast_cast_set
	sets.midcast.Cure = cure_set
	sets.midcast.Curaga = sets.midcast.Cure
	sets.midcast.CureSelf = cure_set

	sets.midcast['Enhancing Magic'] = enhancing_set

	sets.midcast.Refresh = set_combine(enhancing_set,
		{
			head = inv.amalric_coif,
			body = inv.atrophy_tabard,
			hands = atrophy_gloves,
			legs = inv.lethargy_legs,
			waist = inv.gishdubar_sash,
		})
	sets.midcast['Haste II'] = enhancing_duration
	sets.midcast.Phalanx = set_combine(enhancing_duration, phalanx_set)
	sets.midcast.Regen = enhancing_regen
	sets.midcast.Enblizzard = max_enhancing
	sets.midcast.Enaero = max_enhancing
	sets.midcast.Enfire = max_enhancing
	sets.midcast.Enstone = max_enhancing
	sets.midcast.Enthunder = max_enhancing
	sets.midcast.Enwater = max_enhancing
	sets.midcast.Aquaveil = set_combine(enhancing_set,
		{ head = inv.amalric_coif, legs = inv.shedir_seraweels, waist = "Emphatikos Rope",
		})

	sets.midcast['Gain-STR'] = max_enhancing
	sets.midcast['Gain-DEX'] = max_enhancing
	sets.midcast['Gain-MND'] = max_enhancing
	sets.midcast['Gain-VIT'] = max_enhancing
	sets.midcast['Gain-INT'] = max_enhancing
	sets.midcast['Gain-AGI'] = max_enhancing
	sets.midcast['Gain-CHR'] = max_enhancing
	sets.midcast['Inundation'] = set_combine(enfeebling_set, treasure_hunter)


	sets.midcast['Enfeebling Magic'] = enfeebling_set
	sets.midcast['Enfeebling Magic'].Resistant = max_enfeebling_acc
	sets.midcast['Temper'] = max_enhancing
	sets.midcast['Temper II'] = max_enhancing



	sets.midcast['Elemental Magic'] = nuke_set
	sets.midcast['Elemental Magic'].Burst = burst_set

	--- Barstatus effect sets
	sets.midcast['Barpetrify'] = barstatus_set
	sets.midcast['Barsilence'] = barstatus_set
	sets.midcast['Barvirus'] = barstatus_set
	sets.midcast['Barblind'] = barstatus_set
	sets.midcast['Barsleep'] = barstatus_set
	sets.midcast['Baramnesia'] = barstatus_set
	sets.midcast['Barpoison'] = barstatus_set
	sets.midcast['Barparalyze'] = barstatus_set
	sets.midcast.BarElement = set_combine(enhancing_set, { legs = inv.shedir_seraweels, })

	--- Enfeebles
	sets.midcast['Dia'] = enfeeble_potency
	sets.midcast['Dia II'] = enfeeble_potency
	sets.midcast['Dia III'] = enfeeble_potency
	sets.midcast['Diaga'] = treasure_hunter
	sets.midcast['Paralyze'] = set_combine(enfeeble_potency, { left_ring = inv.metamorph_ring })
	sets.midcast['Paralyze II'] = set_combine(enfeeble_potency, { left_ring = inv.metamorph_ring })
	sets.midcast['Temper'] = max_enhancing
	sets.midcast['Addle'] = enfeeble_potency
	sets.midcast['Addle II'] = enfeeble_potency
	sets.midcast['Slow'] = set_combine(enfeeble_potency, { left_ring = inv.metamorph_ring })
	sets.midcast['Slow II'] = set_combine(enfeeble_potency, { left_ring = inv.metamorph_ring })
	sets.midcast['Gravity'] = enfeeble_potency
	sets.midcast['Gravity II'] = enfeeble_potency

	sets.midcast['Slow II'].Resistant = max_enfeebling_acc
	sets.midcast['Paralyze II'].Resistant = max_enfeebling_acc
	sets.midcast['Gravity II'].Resistant = max_enfeebling_acc
	sets.midcast['Silence'] = enfeebling_acc

	sets.midcast['Dispel'] = enfeebling_acc
	sets.midcast['Frazzle'] = set_combine(enfeebling_acc, { neck = inv.null_loop })
	sets.midcast['Frazzle II'] = set_combine(enfeebling_acc, { neck = inv.null_loop })

	sets.midcast['Dark Magic'] = enfeeble_potency
	sets.midcast['Cursna'] = cursna

	sets.midcast.Stun = enfeebling_acc

	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], { waist = "Fucho-no-Obi" })

	sets.midcast.Aspir = sets.midcast.Drain


	-- Sets for special buff conditions on spells.

	sets.buff.ComposureOther = {
		head = inv.lethargy_chappel,
		body = inv.lethargy_body,
		legs = inv.lethargy_legs,
		feet = inv.lethargy_feet,
	}

	sets.buff.Saboteur = { hands = lethargy_hands }


	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
		head = inv.vitiation_chapeau,
	}

	-- Idle sets
	-- Set up idle sets based on weapon mode
	-- sets.idle = {}
	sets.idle['Crocea+Daybreak'] = set_combine(tp_crocea_daybreak, hat)
	sets.idle['Naegling+Gletis'] = set_combine(tp_naegling_gletis, hat)
	sets.idle['Naegling+Machera'] = set_combine(tp_naegling_machaera, hat)
	sets.idle['Excalibur+Gletis'] = set_combine(tp_excalibur_gletis, hat)
	sets.idle['Aeolian Cleave'] = set_combine(aeolian_edge_cleave, hat)
	sets.idle['Tenzen'] = set_combine(tenzen, hat)

	sets.idle['0 tp daggers'] = set_combine(tp_0_dmg_daggers, hat)

	sets.idle.Town = {}
	sets.idle.Town['Crocea+Daybreak'] = set_combine(crocea_daybreak, hat)
	sets.idle.Town['Naegling+Gletis'] = set_combine(tp_naegling_gletis, hat)
	sets.idle.Town['Naegling+Machera'] = set_combine(tp_naegling_machaera, hat)
	sets.idle.Town['Excalibur+Gletis'] = set_combine(tp_excalibur_gletis, hat)
	sets.idle.Town['Aeolian Cleave'] = set_combine(aeolian_edge_cleave, hat)
	sets.idle.Town['Tenzen'] = set_combine(tenzen, hat)

	sets.idle.Town['0 tp daggers'] = set_combine(tp_0_dmg_daggers, hat)

	sets.idle.Weak = pdt_set

	sets.idle.PDT = pdt_set

	sets.idle.MDT = pdt_set2



	-- Defense sets
	sets.defense.PDT = pdt_set

	sets.defense.MDT = pdt_set2

	sets.Kiting = { legs = "Crimson Cuisses" }

	sets.latent_refresh = { waist = "Fucho-no-obi" }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	-- Set up engaged sets based on weapon mode
	-- sets.engaged = {}
	sets.engaged['Crocea+Daybreak'] = tp_crocea_daybreak
	sets.engaged['Excalibur+Gletis'] = tp_excalibur_gletis
	sets.engaged['Naegling+Gletis'] = tp_naegling_gletis
	sets.engaged['Naegling+Machera'] = tp_naegling_machaera
	sets.engaged['Aeolian Cleave'] = aeolian_edge_cleave
	sets.engaged['Tenzen'] = tenzen
	sets.engaged['0 tp daggers'] = tp_0_dmg_daggers

	sets.engaged.Defense = pdt_set
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function equip_obi_matching_weather(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
		if spell.element == world.weather_element then
			equip({ waist = "Hachirin-no-Obi" })
			-- add_to_chat('equiping obi')
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
		equip(sets.buff.Saboteur)
	elseif spell.skill == 'Enhancing Magic' then
		equip(sets.midcast.EnhancingDuration)
		if buffactive.composure and spell.target.type == 'PLAYER' then
			equip(sets.buff.ComposureOther)
		end
	elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	end
	equip_obi_matching_weather(spell, action, spellMap, eventArgs)
	local elemental_ws = {
		['Red Lotus Blade'] = true,
		['Burning Blade'] = true,
		['Seraph Blade'] = true,
		['Shining Blade'] = true
	}
	if elemental_ws[spell.english] then
		local player = windower.ffxi.get_player()
		if player.vitals.tp > 2800 then
			equip(friomisi_set)
		elseif player.vitals.tp > 1250 then
			equip({ neck = inv.baetyl_pendant })
		end
	elseif spell.english == 'Sanguine Blade' then
		-- print('sanguine')
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
-- function job_state_change(stateField, newValue, oldValue)
-- 	if stateField == 'Offense Mode' then
-- 		if newValue == 'None' then
-- 			enable('main', 'sub', 'range')
-- 		else
-- 			disable('main', 'sub', 'range')
-- 		end
-- 	end
-- end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end

	-- Apply the weapon mode to idle sets
	if state.IdleMode.value == 'Normal' then
		return set_combine(idleSet, sets.idle[state.WeaponMode.value])
	end

	return idleSet
end

-- Modify the default melee set after it was constructed.
-- Replace your current customize_melee_set function with this:
function customize_melee_set(meleeSet)
	-- Start with the weapon-specific base set
	local weaponSet = sets.engaged[state.WeaponMode.value]

	-- Apply hybrid mode modifications
	if state.HybridMode.value == 'Acc' then
		weaponSet = set_combine(weaponSet, sets.accuracy)
	elseif state.HybridMode.value == 'High Acc' then
		weaponSet = set_combine(weaponSet, sets.high_accuracy)
	elseif state.HybridMode.value == 'AccWar' then
		weaponSet = set_combine(weaponSet, sets.war_acc)
	elseif state.HybridMode.value == 'Kei' then
		weaponSet = set_combine(weaponSet, sets.kei)
	end

	return weaponSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
	display_current_caster_state()
	add_to_chat(122, 'Weapon Mode: ' .. state.WeaponMode.value)
	eventArgs.handled = true
end

-- Custom command to switch weapon modes
function job_self_command(cmdParams, eventArgs)
	local arg1 = cmdParams[1]
	if arg1 == 'weaponmode' then
		-- Cycle to next weapon mode
		state.WeaponMode:cycle()
		add_to_chat(122, 'Weapon Mode: ' .. state.WeaponMode.value)
		send_command('wait 0.3; gs c equip_weapons')
	elseif arg1 == '-weaponmode' then
		state.WeaponMode:cycleback()
		add_to_chat(122, 'Weapon Mode: ' .. state.WeaponMode.value)
		send_command('wait 0.3; gs c equip_weapons')
	elseif cmdParams[1] == 'equip_weapons' then
		-- Based on the weapon mode, equip the appropriate weapons
		-- This function will only be called after the slots are emptied
		if state.WeaponMode.value == 'Crocea+Daybreak' then
			equip(crocea_daybreak)
		elseif state.WeaponMode.value == 'Naegling+Gletis' then
			equip(naegling_gletis)
		elseif state.WeaponMode.value == 'Naegling+Machera' then
			equip(naegling_machaera)
		elseif state.WeaponMode.value == 'Excalibur+Gletis' then
			equip(crocea_gletis)
		elseif state.WeaponMode.value == 'Aeolian Cleave' then
			equip(kaja_malevolance)
		elseif state.WeaponMode.value == 'Tenzen' then
			equip(crocea_levante)
		elseif state.WeaponMode.value == '0 tp daggers' then
			equip({
				main = "Ethereal Dagger",
				sub = "Qutrub Knife",
			})
		end

		-- Re-enable the slots after equipping
		enable('main', 'sub')

		-- Update the engaged set
		if player.status == 'Engaged' then
			send_command('gs c update')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Clean up any key bindings when unloading the job file
function job_file_unload()
	send_command('unbind f9')
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'NIN' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'THF' then
		set_macro_page(1, 1)
	else
		set_macro_page(1, 1)
	end
end

-- Test command: //gs c weather
function self_command(command)
	if command == 'weather' then
		windower.add_to_chat(122, weather.debug_weather())
		windower.add_to_chat(122, weather.debug_day())
	end
end
