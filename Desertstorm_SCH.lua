local inv = require('inventory')

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

        Toggle Function:
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.

        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler

        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order
        gs c nuke t1                    Cast tier 1 nuke of saved element
        gs c nuke t2                    Cast tier 2 nuke of saved element
        gs c nuke t3                    Cast tier 3 nuke of saved element
        gs c nuke t4                    Cast tier 4 nuke of saved element
        gs c nuke t5                    Cast tier 5 nuke of saved element
        gs c nuke helix                 Cast helix2 nuke of saved element
        gs c nuke storm                 Cast Storm II buff of saved element

        gs c sc tier                    Cycles SC Tier (1 & 2)
        gs c sc castsc                  Cast All the stuff to create a SC burstable by the nuke element set with '/console gs c nuke element'.

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.

        // OPTIONAL IF YOU WANT / NEED to skip the cycles...
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter.
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter.
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter.
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter.
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter.
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter.
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter.
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter.
--]]

-------------------------------------------------------------
--
--      ,---.     |    o
--      |   |,---.|--- .,---.,---.,---.
--      |   ||   ||    ||   ||   |`---.
--      `---'|---'`---'``---'`   '`---'
--           |
-------------------------------------------------------------

include('organizer-lib') -- Can remove this if you dont use organizer
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes:
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically.
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes.
idleModes = M('refresh', 'dt', 'mdt')
regenModes = M('hybrid', 'duration', 'potency')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1400 --important to update these if you have a smaller screen
hud_y_pos = 200  --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here:
windower.send_command('bind insert gs c nuke cycle')     -- insert to Cycles Nuke element
windower.send_command('bind delete gs c nuke cycledown') -- delete to Cycles Nuke element in reverse order
windower.send_command('bind f9 gs c toggle idlemode')    -- F9 to change Idle Mode
windower.send_command('bind !f9 gs c toggle runspeed')   -- Alt-F9 toggles locking on / off Herald's Gaiters
windower.send_command('bind f12 gs c toggle melee')      -- F12 Toggle Melee mode on / off and locking of weapons
windower.send_command('bind !` input /ma Stun <t>')      -- Alt-` Quick Stun Shortcut.
windower.send_command('bind home gs c sc tier')          -- home to change SC tier between Level 1 or Level 2 SC
windower.send_command('bind end gs c toggle regenmode')  -- end to change Regen Mode	
windower.send_command('bind f10 gs c toggle mb')         -- F10 toggles Magic Burst Mode on / off.
windower.send_command('bind !f10 gs c toggle nukemode')  -- Alt-F10 to change Nuking Mode
windower.send_command('bind ^F10 gs c toggle matchsc')   -- CTRL-F10 to change Match SC Mode      	
windower.send_command('bind !end gs c hud lite')         -- Alt-End to toggle light hud version

--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mburst'] = '(F10)'

keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_sc_level'] = '(HOME)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind end')
    send_command('unbind !f10')
    send_command('unbind `f10')
    send_command('unbind !f9')
    send_command('unbind !end')
end

--------------------------------------------------------------------------------------------------------------
include('SCH_Lib.lua')     -- leave this as is
refreshType = idleModes[1] -- leave this as is
--------------------------------------------------------------------------------------------------------------


-- Optional. Swap to your sch macro sheet / book
set_macros(1, 4) -- Sheet, Book
send_command('wait 4; input /lockstyleset 4')

-------------------------------------------------------------
--      ,---.                         |
--      |  _.,---.,---.,---.,---.,---.|--- ,---.
--      |   ||---',---||    `---.|---'|    `---.
--      `---'`---'`---^`    `---'`---'`---'`---'
-------------------------------------------------------------

-- Setup your Gear Sets below:
function get_sets()
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc

    sets.me = {}      -- leave this empty
    sets.buff = {}    -- leave this empty
    sets.me.idle = {} -- leave this empty

    local black_halo = {
        ammo = inv.oshashs_treastise,
        head = inv.null_mask,
        hands = inv.jhakri_cuffs,
        body = inv.nyame_mail,
        legs = inv.nyame_legs,
        feet = inv.merlinic_ws_feet,
        neck = inv.republican_medal,
        waist = inv.luminary_sash,
        left_ear = inv.moonshade_earring,
        right_ear = inv.ishvara,
        left_ring = inv.epaminondas_ring,
        right_ring = inv.corneilias_ring,
        back = inv.null_shawl
    }

    -- Your idle set
    sets.me.idle.refresh = {
        -- sub = inv.ammurapi_shield,
        head = inv.null_mask,
        neck = inv.null_loop,
        body = inv.arbatel_gown,
        hands = inv.chironic_refresh_gloves,
        waist = inv.platinum_moogle_belt,
        left_ear = inv.etiolation_earring,
        right_ear = inv.alabaster_earring,
        left_ring = inv.murky_ring,
        right_ring = inv.defending_ring,
        legs = inv.assiduity_pants,
        feet = inv.merlinic_refresh,
        ammo = inv.homiliary,
        back = inv.SCH_MAB_CAPE,
    }

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.idle.sublimation = set_combine(sets.me.idle.refresh, {
        head = inv.academics_mortarboard,
        -- ear1 = "Savant's Earring",
        body = inv.pedagogy_gown,
        waist = inv.embla_sash

    })
    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle[refreshType], {

    })
    sets.me.idle.mdt = set_combine(sets.me.idle[refreshType], {

    })
    -- Your MP Recovered Whilst Resting Set
    sets.me.resting = {

    }

    sets.me.latent_refresh = { waist = "Fucho-no-obi" }

    -- Combat Related Sets
    sets.me.melee = {
        ammo = inv.homiliary,
        head = inv.null_mask,
        hands = inv.gazu_bracelets,
        body = inv.arbatel_gown,
        legs = inv.arbatel_pants,
        feet = inv.nyame_feet,
        neck = inv.null_loop,
        waist = inv.windbuffet_belt,
        left_ear = inv.crepus_earring,
        right_ear = inv.brutal_earring,
        left_ring = inv.chirich_ring,
        right_ring = inv.crepuscular_ring,
        back = inv.null_shawl
    }

    -- Weapon Skills sets just add them by name.
    sets.WS = {
        head = inv.nyame_helm,
        hands = inv.jhakri_cuffs,
        body = inv.nyame_mail,
        neck = inv.republican_medal,
        legs = inv.nyame_legs,
        feet = inv.nyame_feet,
        ring1 = inv.corneilias_ring,
        ring2 = inv.epaminondas_ring,
        ear1 = inv.moonshade_earring,
        ear2 = inv.ishvara,
        waist = inv.fotia_belt,
        ammo = inv.oshashs_treastise,
    }

    sets.me["Shattersoul"] = {

    }
    sets.me["Myrkr"] = {

    }
    sets.me['Black Halo'] = black_halo

    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though

    ------------
    -- Buff Sets
    ------------	
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    -- Fill up following with your avaible pieces.
    sets.buff['Rapture'] = { head = inv.arbatel_bonnet }
    sets.buff['Perpetuance'] = { hands = inv.arbatel_bracers }
    sets.buff['Immanence'] = { hands = inv.arbatel_bracers }
    sets.buff['Penury'] = { legs = inv.arbatel_pants }
    sets.buff['Parsimony'] = { legs = inv.arbatel_pants }
    sets.buff['Celerity'] = { feet = inv.pedagogy_loafers }
    sets.buff['Alacrity'] = { feet = inv.pedagogy_loafers }
    sets.buff['Klimaform'] = { feet = inv.arbatel_loafers }
    -- Ebulience set empy now as we get better damage out of a good Merlinic head
    sets.buff['Ebullience'] = {} -- I left it there still if it becomes needed so the SCH.lua file won't need modification should you want to use this set



    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}        -- Leave this empty
    sets.midcast = {}        -- Leave this empty
    sets.aftercast = {}      -- Leave this empty
    sets.midcast.nuking = {} -- leave this empty
    sets.midcast.MB = {}     -- leave this empty
    ----------
    -- Precast
    ----------
    local fastcast = {
        head = inv.merlinic_fastcast_head,
        neck = inv.baetyl_pendant,
        body = inv.merlinic_fastcast_body,
        hands = inv.academics_bracers,
        left_ring = inv.weatherspoon_ring,
        right_ring = inv.kishar_ring,
        left_ear = inv.malignance_earring,
        right_ear = inv.loquacious_earring,
        waist = inv.embla_sash,
        legs = inv.agwus_slops,
        feet = inv.merlinc_fastcast_feet,
        back = inv.SCH_FASTCAST_CAPE,
        ammo = inv.sapience_orb,
    }
    sets.precast.FC = fastcast

    -- Generic Casting Set that all others take off of. Here you should add all your fast cast
    -- Grimoire: 10(cap:25) / rdm: 15
    sets.precast.casting = fastcast

    sets.precast["Stun"] = {

    }

    -- When spell school is aligned with grimoire, swap relevent pieces -- Can also use Arbatel +1 set here if you value 1% quickcast procs per piece. (2+ pieces)
    -- Dont set_combine here, as this is the last step of the precast, it will have sorted all the needed pieces already based on type of spell.
    -- Then only swap in what under this set after everything else.
    sets.precast.grimoire = {
        feet = inv.academics_loafers,
    }


    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting, {
    })

    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing, {
    })

    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting, {

    })

    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Tabula Rasa"] = { legs = inv.pedagogy_pants }
    sets.precast["Enlightenment"] = { body = inv.pedagogy_gown }
    sets.precast["Sublimation"] = { head = inv.academics_mortarboard, body = inv.pedagogy_gown }


    ----------
    -- Midcast
    ----------

    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
        waist = inv.hachirin_no_obi,
    }

    -----------------------------------------------------------------------------------------------
    -- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
    -- Pixie in DarkHelix
    -- Boots that aren't arbatel +1 (15% of small numbers meh, amalric+1 does more)
    -- Belt that isn't Obi.
    -----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = {
        head = inv.pixie_hairpin,
        sub = inv.culminus,
        right_ear = inv.arbatel_earring,
        waist = inv.refoccilation_stone,
        left_ring = inv.acrchon_ring,
        right_ring = inv.mallquis_ring,

    }


    sets.midcast.LightHelix = {
        main = inv.daybreak,
        sub = inv.culminus,
        right_ear = inv.arbatel_earring,
        waist = inv.refoccilation_stone,
        left_ring = inv.weatherspoon_ring,
        right_ring = inv.mallquis_ring,

    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
        head = inv.arbatel_bonnet,
        sub = inv.culminus,
        right_ear = inv.arbatel_earring,
        waist = inv.refoccilation_stone,
        right_ring = inv.mallquis_ring,
    }

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {

    }


    sets.midcast["Sublimation"] = { head = inv.academics_mortarboard, body = inv.pedagogy_gown }

    sets.midcast.nuking.normal = {
        main = inv.bunzi_rod,
        sub = inv.ammurapi_shield,
        ammo = inv.ghastly_tathlum,
        head = inv.arbatel_bonnet,
        hands = inv.arbatel_bracers,
        body = inv.arbatel_gown,
        legs = inv.arbatel_pants,
        feet = inv.arbatel_loafers,
        neck = inv.argute_stole,
        waist = inv.refoccilation_stone,
        left_ear = inv.malignance_earring,
        right_ear = inv.regal_earring,
        left_ring = inv.freke_ring,
        right_ring = inv.metamorph_ring,
        back = inv.SCH_MAB_CAPE,
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
        head = inv.pedagogy_mortarboard,
        neck = inv.arg,
        right_ring = inv.mujin_band,
        legs = inv.agwus_slops,
    })

    sets.midcast.nuking.acc = {

    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.normal, {

    })

    local enfeebling = {
        head = inv.arbatel_bonnet,
        body = inv.arbatel_gown,
        hands = inv.arbatel_bracers,
        legs = inv.arbatel_pants,
        feet = inv.arbatel_loafers,
        back = inv.null_shawl,
        neck = inv.argute_stole,
        waist = inv.null_belt,
        left_ring = inv.stikini_ring,
        right_ring = inv.kishar_ring,
        ear1 = inv.regal_earring,
        ear2 = inv.malignance_earring,
        ammo = inv.hydrocera,
    }
    -- Enfeebling
    sets.midcast["Stun"] = {

    }
    sets.midcast.IntEnfeebling = enfeebling
    sets.midcast.MndEnfeebling = enfeebling

    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting, {
        head = inv.amalric_coif,
        neck = inv.incanters_torque,
        body = inv.pedagogy_gown,
        hands = inv.arbatel_bracers,
        left_ring = inv.stikini_ring,
        right_ring = inv.stikini_ring2,
        left_ear = inv.mimir_earring,
        right_ear = inv.andoaa_earring,
        waist = inv.embla_sash,
        legs = inv.arbatel_pants,
        feet = inv.telchine_feet_enh_dur,
        back = inv.SCH_FASTCAST_CAPE,
    })
    sets.barstatus = set_combine(sets.midcast.enhancing, { neck = inv.sroda_necklace, })

    sets.midcast.storm = set_combine(sets.midcast.enhancing, {

    })
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing, {
        neck = inv.nodens_gorget,
        legs = inv.shedir_seraweels,
        left_ear = inv.earthcry_earring,
        waist = inv.siegel_sash,
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing, {
        head = inv.amalric_coif,
    })
    sets.midcast.aquaveil = set_combine(sets.midcast.refresh, {
        waist = inv.emphatikos_rope,
        legs = inv.shedir_seraweels,
    })

    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
        head = inv.pixie_hairpin,
        neck = "Erra Pendant",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]

    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting, {
        ammo = inv.staunch_tathlum,
        head = inv.vanya_hood,
        ear1 = inv.mendicants_earring,
        hands = inv.telchine_gloves_regen,
        waist = inv.gishdubar_sash,
        left_ring = inv.najis_loop,
        right_ring = inv.lebeche_ring,
        feet = inv.kaykaus_boots,
    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal, {
        waist = inv.hachirin_no_obi,

    })

    ---Bar status
    sets.midcast['Barpetrify'] = sets.barstatus
    sets.midcast['Barsilence'] = sets.barstatus
    sets.midcast['Barvirus'] = sets.barstatus
    sets.midcast['Barblind'] = sets.barstatus
    sets.midcast['Barsleep'] = sets.barstatus
    sets.midcast['Baramnesia'] = sets.barstatus
    sets.midcast['Barpoison'] = sets.barstatus
    sets.midcast['Barparalyze'] = sets.barstatus

    ------------
    -- Regen
    ------------	
    sets.midcast.regen = {} -- leave this empty
    -- Normal hybrid well rounded Regen
    sets.midcast.regen.hybrid = {
        main = inv.pedagogy_staff,
        sub = inv.enki_strap,
        head = inv.arbatel_bonnet,
        body = inv.telchine_body_regen,
        hands = inv.telchine_gloves_regen,
        legs = inv.telchine_legs_regen,
        feet = inv.telchine_feet_regen,
        back = inv.SCH_HELX_REGEN_CAPE,
        waist = inv.embla_sash,
    }
    -- Focus on Regen Duration 	
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid, {
        feet = inv.telchine_feet_enh_dur,

    })
    -- Focus on Regen Potency 	
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid, {
        hands = inv.telchine_gloves_regen,

    })

    ------------
    -- Aftercast
    ------------

    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
end
