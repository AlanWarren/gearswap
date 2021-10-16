-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- 1000
-- 1000
-- 2000
-- 2000
-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

--[[
    gs c toggle luzaf -- Toggles use of Luzaf Ring on and off
    
    Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
    for ranged weaponskills, but not actually meleeing.
    Acc on offense mode (which is intended for melee) will currently use .Acc weaponskill
    mode for both melee and ranged weaponskills.  Need to fix that in core.
--]]

---------------------------- SET ORDER OF PRECEDENCE ----------------------------------
-- sets.engaged.[CombatForm][CombatWeapon][Offense or HybridMode][CustomMeleeGroups or CustomClass]
-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    mote_include_version = 2
    include('Mote-Include.lua')
    include('organizer-lib')
end

-- Setup vars that are user-independent.
function job_setup()
    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(false, "Luzaf's Ring")
    state.warned = M(false)
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    state.FlurryMode = M{['description']='Flurry Mode', 'Normal', 'Hi'}
    state.HasteMode = M{['description']='Haste Mode', 'Hi', 'Low'}
    
    state.Buff['Triple Shot'] = buffactive['Triple Shot'] or false

    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    
    state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }
    state.GunSelector = M{['description']='Gun Selector', 'DeathPenalty', 'Fomalhaut', 'Armageddon', 'Anarchy'}
    state.FightingMode = M{['description']='Fighting Mode', 'Default', 'Melee', 'Sword', 'DualSword'}
    state.ShootingMode = M{['description']='Shooting Mode', 'Default', 'Standard', 'Magic', 'Single'}

    cor_sub_weapons = S{"Nusku Shield"}
    auto_gun_ws = "Leaden Salute"
    
    define_roll_values()
    determine_haste_group()
    get_combat_form()
    initialize_weapons()
    get_custom_ranged_groups()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.RangedMode:options('Normal', 'Mid', 'Acc')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT' )
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')

    
    gear.RAbullet = "Chrono Bullet"
    gear.Accbullet = "Devastating Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Hauksbok Bullet"
    --gear.QDbullet = "Adlivun Bullet"
    options.ammo_warning_limit = 15

    -- Additional local binds
    -- Cor doesn't use hybrid defense mode; using that for ranged mode adjustments.
    send_command('bind f9 gs c cycle OffenseMode')
    send_command('bind !f9 gs c toggle FightingMode')
    send_command('bind @f9 gs c cycle GunSelector')
    send_command('bind ^` input /ja "Double-up" <me>')
    send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind @= gs c cycle FlurryMode')
    send_command('bind ^- gs c cycle AutoRA')
    select_default_macro_book()
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind !`')
    send_command('unbind ^-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
    
    sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
    --sets.precast.JA['Snake Eye'] = {legs="Commodore Culottes +1"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
    --sets.precast.JA['Fold'] = {hands="Commodore Gants +2"}} 
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    
    TaeonHead = {}
    TaeonHead.Snap = { name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Snapshot"+5','"Snapshot"+4',}}

    Camulus = {}
    Camulus.STP  =  { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    Camulus.WSD  =  { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
    Camulus.Snap =  { name="Camulus's Mantle", augments={'"Snapshot"+10',}}
    Camulus.MAB  =  { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
    Camulus.DA  =  { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}

    HercFeet = {}
    HercHead = {}
    HercLegs = {}
    HercHands = {}
    HercBody = {}

    HercHands.R = { name="Herculean Gloves", augments={'AGI+9','Accuracy+3','"Refresh"+1',}}
    HercHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+4','Mag. Acc.+8','"Mag.Atk.Bns."+13',}}
    
    HercBody.MAB = { name="Herculean Vest", augments={'Haste+1','"Mag.Atk.Bns."+27','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
    HercBody.WSD = { name="Herculean Vest", augments={'"Blood Pact" ability delay -4','AGI+3','Weapon skill damage +9%','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}
    
    HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+30','"Mag.Atk.Bns."+25','Accuracy+3 Attack+3','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
    HercFeet.TP = { name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','DEX+8',}}
    
    HercHead.MAB = {name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','INT+1','Mag. Acc.+3','"Mag.Atk.Bns."+8',}}
    HercHead.TP = { name="Herculean Helm", augments={'Accuracy+25','"Triple Atk."+4','AGI+6','Attack+14',}}
    HercHead.DM = { name="Herculean Helm", augments={'Pet: STR+9','Mag. Acc.+10 "Mag.Atk.Bns."+10','Weapon skill damage +9%','Accuracy+12 Attack+12',}}

    HercLegs.MAB = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+14',}}
    HercLegs.TH = { name="Herculean Trousers", augments={'Phys. dmg. taken -1%','VIT+10','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+19 "Mag.Atk.Bns."+19',}} 

    
    AdhemarLegs = {}
    AdhemarLegs.Snap = { name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}}
    AdhemarLegs.TP = { name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}}

    sets.precast.CorsairRoll = {
        main={name="Rostam", bag="Wardrobe 4", priority=1},
        sub={name="Tauret", priority=2},
        range="Compensator",
        head="Lanun Tricorne +3",
        hands="Chasseur's Gants +1",
        ear2="Etiolation Earring",
        neck="Regal Necklace",
        body="Malignance Tabard",
        ring1="Defending Ring",
        ring2="Dark Ring",
        back=Camulus.STP,
        legs="Malignance Tights",
        feet="Lanun Bottes +3"
    }
    
    sets.TreasureHunter = { head="White Rarab Cap +1", waist="Chaac Belt", legs=HercLegs.TH }
    --sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +1"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
    --sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +1"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants +3"}

    sets.Melee = {
        --main={name="Lanun Knife", bag="Wardrobe 4", priority=2},
        main={name="Lanun Knife", bag="Wardrobe 4", priority=1},
        sub={name="Blurred Knife +1", bag="Wardrobe 4", priority=2},
        ranged=state.GunSelector.current
    }
    sets.Melee.engaged = sets.Melee
    
    sets.Sword = { 
        main={name="Naegling", bag="Wardrobe 4", priority=1},
        sub={name="Nusku Shield", priority=2},
    }
    sets.Sword.engaged = sets.Sword
    
    sets.DualSword = { 
        main={name="Naegling", bag="Wardrobe 4", priority=1},
        sub={name="Blurred Knife +1", bag="Wardrobe 4", priority=2},
    }
    sets.DualSword.engaged = sets.DualSword
    
    sets.Magic = {
        --main={name="Lanun Knife", bag="Wardrobe 4", priority=2},
        main={name="Lanun Knife", bag="Wardrobe 4", priority=1},
        sub={name="Tauret", bag="Wardrobe 4", priority=2},
        ranged=state.GunSelector.current
    }
    sets.Magic.engaged = set_combine(sets.Magic, {
       head="Malignance Chapeau",
       hands="Malignance Gloves",
       body="Malignance Tabard",
       legs="Malignance Tights", 
       ring1="Defending Ring",
       feet="Malignance Boots"
    })

    sets.DeathPenalty = {
        range="Death Penalty"
    }
    sets.Armageddon = {
        range="Armageddon"
    }
    sets.Fomalhaut = {
        range="Fomalhaut"
    }
    sets.Anarchy = {
        range="Anarchy"
    }
    sets.Standard = {
        main={name="Lanun Knife", bag="Wardrobe 4", priority=2},
        sub={name="Rostam", bag="Wardrobe 4", priority=1},
    }
    sets.Standard.engaged = set_combine(sets.Standard, {
       head="Malignance Chapeau",
       hands="Malignance Gloves",
       body="Malignance Tabard",
       legs="Malignance Tights", 
       ring1="Defending Ring",
       feet="Malignance Boots"
    })

    sets.Single = {
        main={name="Rostam", bag="Wardrobe 4", priority=1},
        sub={name="Nusku Shield", priority=2},
    }
    sets.Single.engaged = set_combine(sets.Single, {
        head="Malignance Chapeau",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        legs="Malignance Tights", 
        ring1="Defending Ring",
        feet="Malignance Boots"
    })
    -- this allows you to equip any weapon in main + sub without this code forcing other weapons
    sets.Default = {
        ranged=state.GunSelector.current
    } -- do nothing. useful for equipping whateveer you want
    sets.precast.CorsairShot = { head="Laksamana's Tricorne +2" }
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Mummu Bonnet +2",
        hands="Meghanada Gloves +2",
        legs=AdhemarLegs.TP,
    }

    sets.Organizer = {
        main="Fettering Blade",
        sub="Odium",
        ear2="Reraise Earring",
        range="Doomsday",
        hands="Compensator",
        ammo="Nusku Shield",
        back="Linkpearl",
        legs="Laksamana's Trews +1"
    }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        --ammo="Impatiens",
        head=HercHead.TP,
        ear1="Loquacious Earring",
        ear2="Etiolation Earring",
        body="Dread Jupon",
        hands="Leyline Gloves",
        ring1="Weatherspoon Ring",
        ring2="Kishar Ring",
        legs="Quiahuiz Trousers",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    sets.precast.RA = {
        ammo=gear.RAbullet,
        head=TaeonHead.Snap, -- 9
        neck="Commodore Charm +2", -- 3
        hands="Carmine Finger Gauntlets +1", -- 8 / 11 rapid
        back=Camulus.Snap, -- 10 
        body="Oshosi Vest", -- 12
        ring2="Crepuscular Ring", -- 3
        waist="Impulse Belt", -- 2
        legs=AdhemarLegs.Snap, -- 9  / 10 rapid
        feet="Meghanada Jambeaux +2" -- 10 
    }
    sets.precast.RA.F1 = set_combine(sets.precast.RA, {
        body="Laksamana's Frac +3"
    })
    sets.precast.RA.F2 = set_combine(sets.precast.RA.F1, {
        body="Laksamana's Frac +3"
        -- waist="Yemaya Belt",
        -- feet="Pursuer's Gaiters"
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head=HercHead.DM,
        --neck="Iskur Gorget",
        neck="Commodore Charm +2",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body="Laksamana's Frac +3",
        hands="Meghanada Gloves +2",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back=Camulus.WSD,
        waist="Kwahu Kachina Belt",
        legs="Meghanada Chausses +2",
        feet="Lanun Bottes +3"
    }

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        head=HercHead.DM,
        neck="Breeze Gorget",
        body="Laksamana's Frac +3",
        hands="Meghanada Gloves +2",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Ifrit Ring",
        waist="Sailfi Belt +1",
        waist="Thunder Belt",
        feet="Lanun Bottes +3"
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, { 
        head="Adhemar Bonnet +1",
        ear1="Odr Earring",
        ear2="Moonshade Earring",
        body="Adhemar Jacket +1",
        neck="Shadow Gorget",
        hands="Mummu Wrists +2",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Soil Belt",
        legs="Meghanada Chausses +2",
        feet="Lanun Bottes +3"
    })

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {legs="Samnuha Tights"})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        head="Adhemar Bonnet +1",
        body="Adhemar Jacket +1",
        neck="Shadow Gorget",
        ear1="Telos Earring",
        ear2="Moonshade Earring",
        hands="Meghanada Gloves +2",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Soil Belt",
    })

    sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
        ammo=gear.WSbullet,
        head="Lanun Tricorne +3",
        neck="Aqua Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body="Laksamana's Frac +3",
        ring1="Regal Ring",
        ring2="Dingir Ring",
        waist="Light Belt",
        feet="Lanun Bottes +3"
    })
    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        ammo=gear.WSbullet,
        head="Lanun Tricorne +3",
        ear1="Beyla Earring",
        ear2="Moonshade Earring",
        back=Camulus.WSD,
        legs="Meghanada Chausses +2",
        feet="Lanun Bottes +3"
    })

    sets.precast.WS['Wildfire'] = {
        ammo=gear.MAbullet,
        head=HercHead.DM,
        neck="Commodore Charm +2",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body="Lanun Frac +3",
        hands="Carmine Finger Gauntlets +1",
        ring1="Regal Ring",
        ring2="Dingir Ring",
        back=Camulus.MAB,
        waist="Sveltesse Gouriz +1",
        legs=HercLegs.MAB,
        feet="Lanun Bottes +3"
    }
    sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {
        head=HercHead.MAB,
        body="Lanun Frac +3",
        hands=HercHands.MAB
    })

    sets.precast.WS['Leaden Salute'] = { 
        ammo=gear.MAbullet,
        head="Pixie Hairpin +1", 
        neck="Commodore Charm +2",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        body="Lanun Frac +3",
        hands="Carmine Finger Gauntlets +1",
        ring1="Archon Ring",
        ring2="Dingir Ring",
        back=Camulus.MAB,
        waist="Sveltesse Gouriz +1",
        legs=HercLegs.MAB,
        feet="Lanun Bottes +3"
    }
    sets.precast.WS['Leaden Salute'].Mid = set_combine(sets.precast.WS['Leaden Salute'], { 
        body="Lanun Frac +3",
        hands=HercHands.MAB,
        feet="Lanun Bottes +3"
    })
    sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], { 
        body="Lanun Frac +3",
        hands=HercHands.MAB,
        feet="Lanun Bottes +3"
    })
    sets.precast.WS['Hot Shot'] = set_combine(sets.precast.WS['Wildfire'], {
        ear2="Moonshade Earring"
    })
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {
        ear2="Moonshade Earring"
    })
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Malignance Chapeau",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        back=Camulus.STP,
        ring1="Weatherspoon Ring",
        ring2="Kishar Ring",
        legs="Malignance Tights",
        feet="Malignance Boots"
    }
        
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {
        ammo=gear.QDbullet,
        --head=HercHead.MAB,
        head="Laksamana's Tricorne +2",
        neck="Commodore Charm +2",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body="Lanun Frac +3",
        hands="Carmine Finger Gauntlets +1",
        ring1="Regal Ring", 
        ring2="Dingir Ring",
        back=Camulus.MAB,
        waist="Eschan Stone",
        --waist="Chaac Belt",
        legs=HercLegs.MAB,
        feet="Lanun Bottes +3"
    }

    sets.midcast.CorsairShot.Acc = set_combine(sets.midcast.CorsairShot, {
        body="Lanun Frac +3",
        head="Laksamana's Tricorne +2",
        ear1="Crepuscular Earring",
        feet="Malignance Boots"
    })

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Acc
    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.RAbullet,
        head="Malignance Chapeau",
        neck="Iskur Gorget",
        --neck="Commodore Charm +1",
        ear1="Telos Earring",
        ear2="Dedition Earring",
        body="Nisroch Jerkin",
        hands="Malignance Gloves",
        ring1="Crepuscular Ring",
        ring2="Ilabrat Ring",
        back=Camulus.STP,
        waist="Kwahu Kachina Belt",
        legs="Malignance Tights", 
        feet="Malignance Boots"
    }
    sets.midcast.RA.AME = set_combine(sets.midcast.RA, {
        head="Meghanada Visor +2",
        body="Nisroch Jerkin",
        hands="Mummu Wrists +2",
        waist="Kwahu Kachina Belt",
    })
    sets.midcast.RA.Mid = set_combine(sets.midcast.RA, {
        ear2="Crepuscular Earring",
        body="Malignance Tabard",
    })
    sets.midcast.RA.Mid.AME = set_combine(sets.midcast.RA.Mid, {
        head="Meghanada Visor +2",
        body="Nisroch Jerkin",
        waist="Kwahu Kachina Belt",
    })

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Mid, {
        --ring1="Hajduk Ring",
        ammo=gear.Accbullet,
        ear2="Beyla Earring",
        neck="Commodore Charm +2",
        body="Laksamana's Frac +3",
        ring1="Crepuscular Ring",
        ring2="Regal Ring", 
        feet="Malignance Boots"
    })
    sets.midcast.RA.Acc.AME = set_combine(sets.midcast.RA.Acc, {
        head="Meghanada Visor +2",
        waist="Kwahu Kachina Belt",
    })

    sets.midcast.RA.TripleShot = set_combine(sets.midcast.RA, {
        head="Oshosi Mask",
        body="Chasseur's Frac +1",
        hands="Lanun Gants +3",
        --ring1="Regal Ring",
        legs="Oshosi Trousers",
        feet="Oshosi Leggings"
    })
    sets.midcast.RA.TripleShot.Mid = set_combine(sets.midcast.RA.Mid, {
        head="Oshosi Mask",
        body="Oshosi Vest",
        hands="Lanun Gants +3",
        --ring1="Regal Ring",
        legs="Oshosi Trousers",
        feet="Oshosi Leggings"
    })
    sets.midcast.RA.TripleShot.Acc = set_combine(sets.midcast.RA.Acc, {
        ammo=gear.Accbullet,
        head="Malignance Chapeau",
        body="Oshosi Vest",
        hands="Lanun Gants +3",
        --ring1="Regal Ring",
        feet="Malignance Boots"
    })
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {ring2="Paguroidea Ring"}

    -- Idle sets
    sets.idle = {
        ammo=gear.RAbullet,
        --range="Fomalhaut",
        head="Malignance Chapeau",
        neck="Sanctity Necklace",
        --neck="Commodore Charm +1",
        ear1="Genmei Earring",
        ear2="Etiolation Earring",
        --body="Mekosuchinae Harness",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Roller's Ring",
        back=Camulus.STP,
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Malignance Boots"
    }
    sets.idle.Regen = set_combine(sets.idle, {
        head="Meghanada Visor +2",
        neck="Sanctity Necklace",
        hands="Meghanada Gloves +2",
        ear1="Infused Earring",
        --neck="Commodore Charm +1",
        body="Nyame Mail",
        ring1="Meghanada Ring",
        ring2="Paguroidea Ring"
    })

    sets.idle.Town = {
        ammo=gear.MAbullet,
        head="Malignance Chapeau",
        neck="Commodore Charm +2",
        ear1="Telos Earring",
        ear2="Crepuscular Earring",
        body="Nisroch Jerkin",
        hands="Malignance Gloves",
        ring1="Crepuscular Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        waist="Windbuffet Belt +1",
        legs="Carmine Cuisses +1",
        feet="Malignance Boots"
    }
    sets.idle.PDT = set_combine(sets.idle.Town, {
        head="Malignance Chapeau",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        legs="Malignance Tights", 
        ring2="Defending Ring",
        feet="Malignance Boots"
    })
    
    -- Defense sets
    sets.defense.PDT = set_combine(sets.idle, {
        head="Malignance Chapeau",
        neck="Twilight Torque",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        ring1="Patricius Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        waist="Flume Belt",
        legs="Malignance Tights", 
        feet="Malignance Boots"
    })

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {legs="Carmine Cuisses +1"}

    -- Engaged sets
    -- now cater to melee role. If you equip Nusku shield (or anything specified in cor_sub_weapons) 
    -- "Ranged" mode will be triggered, which assumes you want DT + MEVA
    
    sets.engaged = {
        ammo=gear.RAbullet,
        --range="Fomalhaut",
        head="Adhemar Bonnet +1",
        ear1="Eabani Earring",
        ear2="Suppanomimi",
        neck="Iskur gorget",
        --neck="Commodore Charm +1",
        hands="Floral Gauntlets",
        body="Adhemar Jacket +1",
        legs="Carmine Cuisses +1",
        ring1="Petrov Ring",
        ring2="Epona's Ring",
        waist="Shetal Stone",
        back=Camulus.DA,
        feet=HercFeet.TP
    }
    -- sets.engaged.Single = set_combine(sets.engaged, {
    --     ear1="Brutal Earring",
    --     ear2="Cessance Earring",
    --     hands="Adhemar Wristbands +1",
    --     waist="Windbuffet Belt +1",
    --     legs="Samnuha Tights",
    --     feet=HercFeet.TP
    -- })
    -- sets.engaged.Single.Haste_15 = sets.engaged.Single
    -- sets.engaged.Single.Haste_30 = sets.engaged.Single
    -- sets.engaged.Single.MaxHaste = sets.engaged.Single

    sets.engaged.Ranged = {
        ammo=gear.RAbullet,
        head="Malignance Chapeau",
        neck="Iskur Gorget",
        ear1="Telos Earring",
        ear2="Crepuscular Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Crepuscular Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        waist="Flume Belt",
        legs="Malignance Tights", 
        feet="Malignance Boots"
    }
    sets.engaged.PDT = set_combine(sets.engaged, sets.defense.PDT)
        
    sets.engaged.Haste_15 = sets.engaged
    sets.engaged.Haste_30 = set_combine(sets.engaged, {
       hands="Adhemar Wristbands +1",
       feet=HercFeet.TP
    })
    sets.engaged.MaxHaste = set_combine(sets.engaged.Haste_30, {
        ear1="Telos Earring",
        ear2="Suppanomimi",
        legs="Meghanada Chausses +2",
        back=Camulus.DA,
        waist="Windbuffet Belt +1"
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        ring2="Defending Ring",
        feet="Malignance Boots"
    })
    sets.engaged.PDT.Haste_15 = sets.engaged.PDT
    sets.engaged.PDT.Haste_30 = sets.engaged.PDT
    sets.engaged.PDT.MaxHaste = sets.engaged.PDT

    sets.engaged.Mid = set_combine(sets.engaged, {
        neck="Lissome Necklace",
        ring2="Ilabrat Ring"
    })
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.defense.PDT)
    
    sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Mid, {
        feet=HercFeet.TP
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Mid.Haste_15, {
        hands="Adhemar Wristbands +1",
    })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.Mid.Haste_30, {
        ear1="Telos Earring",
        ear2="Suppanomimi",
        legs="Meghanada Chausses +2",
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        ring2="Defending Ring",
        feet="Malignance Boots"
    })
    sets.engaged.Mid.PDT.Haste_15 = sets.engaged.PDT
    sets.engaged.Mid.PDT.Haste_30 = sets.engaged.PDT
    sets.engaged.Mid.PDT.MaxHaste = sets.engaged.PDT
    

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        neck="Lissome Necklace",
        ear1="Telos Earring",
        ear2="Suppanomimi",
        hands="Adhemar Wristbands +1",
        back=Camulus.DA
    })

    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.defense.PDT)

    sets.engaged.Acc.Haste_15 = set_combine(sets.engaged.Acc, {
        feet=HercFeet.TP
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_15, {
        hands="Adhemar Wristbands +1",
    })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Acc.Haste_30, {
        ear1="Telos Earring",
        ear2="Cessance Earring",
        waist="Olseni Belt",
    })
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        ring2="Defending Ring"
    })
    sets.engaged.Acc.PDT.Haste_15 = sets.engaged.PDT
    sets.engaged.Acc.PDT.Haste_30 = sets.engaged.PDT
    sets.engaged.Acc.PDT.MaxHaste = sets.engaged.PDT
end

function get_cor_gearset()
    local set = {}
    if state.FightingMode.current ~= 'Default' then 
        ---------------------------------------
        set = set_combine(sets[state.FightingMode.current], sets[state.GunSelector.current])
        ---------------------------------------
    elseif state.ShootingMode.current ~= 'Default' then 
        ---------------------------------------
        set = set_combine(sets[state.ShootingMode.current], sets[state.GunSelector.current])
        ---------------------------------------
    end
    return set
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' then
        if state.OffenseMode.current ~= 'Normal' and state.RangedMode:contains(state.OffenseMode.current) then
            state.RangedMode:set(state.OffenseMode.current)
        end
        if player.tp >= 1000 and state.AutoRA.value == 'WS' and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)

        if state.OffenseMode.current ~= 'Normal' and state.RangedMode:contains(state.OffenseMode.current) then
            state.RangedMode:set(state.OffenseMode.current)
        end
    end

    if spell.type:lower() == 'weaponskill' then
        if player.tp < 1000 then
            eventArgs.cancel = true
            return
        end
        if ((spell.target.distance >8 and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
            -- Cancel Action if distance is too great, saving TP
            add_to_chat(122,"Outside WS Range! /Canceling")
            eventArgs.cancel = true
            return
        
        elseif state.DefenseMode.value ~= 'None' then
            -- Don't gearswap for weaponskills when Defense is on.
            eventArgs.handled = true
        end
    end
    -- gear sets
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
        equip(sets.precast.LuzafRing)
    elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
        classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
    end
    local gearset = get_cor_gearset()
    equip(gearset)
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' or spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
    if state.AutoRA.value ~= 'Normal' then
        use_ra(spell)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, default_wsmode)
    --if buffactive['Transcendancy'] then
    --	return 'Brew'
    --end
end

function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    local gearset = get_cor_gearset()
    return set_combine(idleSet, gearset)
end

function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    local gearset = get_cor_gearset()
    return set_combine(meleeSet, gearset)
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        get_combat_form()
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    if not gain and player.equipment.ring1 == 'Warp Ring' then
        equip({ring1="Warp Ring"})
    end
   
    if buff == 'Triple Shot' and gain then
        windower.send_command('wait 90;input /echo **TRIPLE SHOT OFF**;wait 210;input /echo **TRIPLE SHOT READY**')
    end

    -- DoubleShot CombatForm
    if (buff == 'Triple Shot' and gain or buffactive['Triple Shot']) then
        state.CombatForm:set('TripleShot')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        state.CombatForm:reset()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
    if (( string.find(buff:lower(), 'flurry') and gain ) or buff:startswith('Aftermath')) then
        get_custom_ranged_groups()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        if player.equipment.range == 'Armageddon' then
            classes.CustomRangedGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Armageddon AM3 UP-------------')
            end
            if (buff == "Aftermath: Lv.2" and gain) or buffactive['Aftermath: Lv.2'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Armageddon AM2 UP-------------')
            end
            if (buff == "Aftermath: Lv.1" and gain) or buffactive['Aftermath: Lv.1'] then
                classes.CustomRangedGroups:append('AME')
                add_to_chat(8, '-------------Armageddon AM1 UP-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            classes.CustomRangedGroups:clear()

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
end

function update_combat_form()
    state.CombatForm:reset()
    if state.Buff['Triple Shot'] then
        state.CombatForm:set('TripleShot')
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_custom_ranged_groups()
end

function get_custom_ranged_groups()
    classes.CustomRangedGroups:clear()
    -- Flurry I = 265, Flurry II = 581
    if buffactive['Flurry'] then
        if state.FlurryMode.value == 'Hi' then
            classes.CustomRangedGroups:append('F2')
        else
            classes.CustomRangedGroups:append('F1')
        end
    end

    if player.equipment.range == 'Armageddon' then
        if buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath Lv.3'] then
            classes.CustomRangedGroups:append('AME')
        end
    else
    -- relic aftermath is just "Aftermath", while empy + mythic are numbered
    -- cor has no relic, so we ignore that one
        if buffactive['Aftermath: Lv.1'] then
            classes.CustomRangedGroups:append('AM1')
        elseif buffactive['Aftermath: Lv.2'] then
            classes.CustomRangedGroups:append('AM2')
        elseif buffactive['Aftermath: Lv.3'] then
            classes.CustomRangedGroups:append('AM2')
        end
    end
end
-- Job-specific toggles.
function job_toggle_state(field)
    if field:lower() == 'luzaf' then
        state.LuzafRing:toggle()
        return "Use of Luzaf Ring", state.LuzafRing.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'RA: '..state.RangedMode.current
    if state.FightingMode.current ~= 'Default' then 
        msg = msg .. ', Fighting: '..state.FightingMode.current
    end
    if state.ShootingMode.current ~= 'Default' then 
        msg = msg .. ', Shooting: '..state.ShootingMode.current
    end
    msg = msg .. ', Gun: '..state.GunSelector.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end

    msg = msg .. ', Roll Sz: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    add_to_chat(122, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    state.CombatForm:reset()
    --if player.equipment.main == gear.Stave then
    -- if cor_sub_weapons:contains(player.equipment.sub) then
    --     if not state.RAMode.value then
    --         state.CombatForm:set("Single")
    --     else
    --         state.CombatForm:set("Ranged")
    --     end
    -- end
    if state.Buff['Triple Shot'] then
        state.CombatForm:set('Triple')
    end
end

function initialize_weapons()
    if player.equipment.range == 'Death Penalty' then
        state.GunSelector:set('DeathPenalty')
    elseif player.equipment.range == 'Fomalhaut' then
        state.GunSelector:set('Fomalhaut')
    elseif player.equipment.range == 'Anarchy' then
        state.GunSelector:set('Anarchy')
    elseif player.equipment.range == 'Armageddon' then
        state.GunSelector:set('Armageddon')
    end
    -- SJ
    --if player.sub_job ~= 'DNC' and player.sub_job ~= 'NIN' then
    --    if state.FightingMode.current == 'Sword' then 
    --        state.FightingMode:set('Sword')
    --    else 
    --        state.ShootingMode:set('Single')
    --    end
    --end
end

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
                ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
                ( buffactive.march == 2 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                ( buffactive.march == 1 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
            ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
            ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
            ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
            ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            ( buffactive[580] ) or  -- geo haste
            ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end

end

function define_roll_values()
    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = 'Small'
    if state.LuzafRing then
        rollsize = 'Large'
    end
    if rollinfo then
        add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
        add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
    end
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    -- cateogry == 2  -- any ranged attack
    if (category == 2) or 
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then 
            return true
    end
end
-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1
    
    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.element == 'None' then
                -- physical weaponskills
                bullet_name = gear.WSbullet
            else
                -- magical weaponskills
                bullet_name = gear.MAbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end
    
    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
    
    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end
    
    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end
    
    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and not state.warned
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '**** LOW AMMO WARNING: '..bullet_name..' ****'
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)
        state.warned = true
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned = false
    end
end

function use_weaponskill()
    send_command('input /ws "'..auto_gun_ws..'" <t>')
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    -- reset these when toggled
    elseif stateField == 'Shooting Mode' then
        state.FightingMode:set('Default')
    elseif stateField == 'Fighting Mode' then
        state.ShootingMode:set('Default')
    --elseif stateField == 'Gun Selector' then
        --equip({range=state.GunSelector.current})
    end
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- GUN 
    if spell.type:lower() == 'weaponskill' then
        delay = '2.25' 
    else
        if buffactive["Courser's Roll"] then
            delay = '0.7' -- MAKE ADJUSTMENT HERE
        elseif buffactive['Flurry II'] then
            delay = '0.5'
        else
            delay = '1.05' -- MAKE ADJUSTMENT HERE
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function select_default_macro_book()
    set_macro_page(6, 1)
end
