-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    mote_include_version = 2
    include('Mote-Include.lua')
    include('organizer-lib')
end

-- Setup vars that are user-independent.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
    state.Runes = M{['description']='Runes', "Ignis", "Gelus", "Flabra", "Tellus", "Sulpor", "Unda", "Lux", "Tenebrae"}
    state.UseRune = M(false, 'Use Rune')

    include('Mote-TreasureHunter')
    determine_haste_group()

    state.CapacityMode = M(false, 'Capacity Point Mantle')
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.RangedMode:options('Normal')

    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')
    send_command('bind != gs c toggle CapacityMode')
    -- send_command('bind !- gs equip sets.crafting')
    send_command('bind @[ gs c cycle Runes')
    send_command('bind ^] gs c toggle UseRune')

    send_command('bind @f9 gs c cycle HasteMode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()

    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind @f9')
    send_command('unbind ![')
end

function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    TaeonHands = {}
    TaeonHands.TA = {name="Taeon Gloves", augments={'DEX+6','Accuracy+17 Attack+17','"Triple Atk."+2'}}
    TaeonHands.Snap = {name="Taeon Gloves", augments={'Attack+22','"Snapshot"+8'}}

    TaeonHead = {}
    TaeonHead.Snap = { name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Snapshot"+5','"Snapshot"+4',}}

    HercFeet = {}
    HercHead = {}
    HercLegs = {}
    HercHands = {}

    HercHands.R = { name="Herculean Gloves", augments={'AGI+9','Accuracy+3','"Refresh"+1',}}
    HercHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+4','Mag. Acc.+8','"Mag.Atk.Bns."+13',}}
    
    HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+30','"Mag.Atk.Bns."+25','Accuracy+3 Attack+3','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
    HercFeet.TP = { name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','DEX+8',}}
    --HercFeet.TH = { name="Herculean Boots", augments={'AGI+1','Weapon Skill Acc.+3','"Treasure Hunter"+1','Accuracy+19 Attack+19','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
    HercHead.MAB = {name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','INT+1','Mag. Acc.+3','"Mag.Atk.Bns."+8',}}
    HercHead.TP = { name="Herculean Helm", augments={'Accuracy+25','"Triple Atk."+4','AGI+6','Attack+14',}}
    HercHead.DM = { name="Herculean Helm", augments={'Pet: STR+9','Mag. Acc.+10 "Mag.Atk.Bns."+10','Weapon skill damage +9%','Accuracy+12 Attack+12',}}

    HercLegs.MAB = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+14',}}
    HercLegs.TH = { name="Herculean Trousers", augments={'Phys. dmg. taken -1%','VIT+10','"Treasure Hunter"+2','Accuracy+10 Attack+10','Mag. Acc.+19 "Mag.Atk.Bns."+19',}} 

    Toutatis = {}
    Toutatis.STP = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    Toutatis.WSD = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}

    sets.TreasureHunter = { head="White Rarab Cap +1", hands="Plunderer's Armlets +1", feet="Raider's Poulaines +2", waist="Chaac Belt", legs=HercLegs.TH }
    sets.TreasureHunterRA = { hands="Plunderer's Armlets +1", waist="Chaac Belt" }
    sets.ExtraRegen = { head="Ocelomeh Headpiece +1" }
    sets.CapacityMantle = { back="Mecistopins Mantle" }

    sets.Organizer = {
        main="Odium",
        sub="Jugo Kukri",
        ammo="Izhiikoh",
        range="Raider's Boomerang"
    }

    sets.buff['Sneak Attack'] = {
        ammo="Yetshila",
        head="Adhemar Bonnet +1",
        neck="Assassin's Gorget +1",
        body="Meghanada Cuirie +2",
        hands="Malignance Gloves",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        -- waist="Chaac Belt",
        back=Toutatis.WSD,
        legs="Pillager's Culottes +3",
        feet="Mummu Gamashes +2"
    }

    sets.buff['Trick Attack'] = {
        ammo="Tengu-no-hane",
        head="Adhemar Bonnet +1",
        neck="Assassin's Gorget +1",
        ear2="Sherida Earring",
        body="Mummu Jacket +2",
        hands="Pillager's Armlets +1",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back="Canny Cape",
        waist="Chaac Belt",
        legs="Mummu Kecks +2",
        feet="Mummu Gamashes +2"
    }
    -- Precast Sets

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {}
    sets.precast.JA['Accomplice'] = {}
    sets.precast.JA['Flee'] = { feet="Rogue's Poulaines" }
    sets.precast.JA['Hide'] = {}
    sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
    sets.precast.JA['Steal'] = { 
        hands="Pillager's Armlets +1",
        legs="Pillager's Culottes +3" 
    }
    sets.precast.JA['Despoil'] = {feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {hands="Plunderer's Armlets +1"} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Mummu Bonnet +2"
        --body="Mekosuchinae Harness",
        --legs="Nahtirah Trousers",
    }
    -- TH actions
    sets.precast.Step = {
        head="Adhemar Bonnet +1",
        neck="Assassin's Gorget +1",
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        back=Toutatis.WSD,
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Chaac Belt",
        legs="Pillager's Culottes +3",
        feet="Raider's Poulaines +2"
    }
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter

    -- Fast cast sets for spells
    sets.precast.FC = {
        --ammo="Impatiens",
        head=HercHead.TP,
        ear1="Loquacious Earring",
        hands="Leyline Gloves",
        body="Dread Jupon",
        ring1="Weatherspoon Ring",
        ring2="Kishar Ring",
        legs="Quiahuiz Trousers",
    }
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
            neck="Magoraga Beads"
        })

    -- Ranged snapshot gear
    sets.precast.RA = {
        head=TaeonHead.Snap,
        hands=TaeonHands.Snap,
        legs="Adhemar Kecks",
        feet="Meghanada Jambeaux +2" -- 8
    }
    sets.midcast.RA = {
        head="Malignance Chapeau",
        neck="Iskur Gorget",
        ear1="Enervating Earring",
        ear2="Telos Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Dingir Ring",
        ring2="Cacoethic Ring +1",
        waist="Eschan Stone",
        back="Quarrel Mantle",
        legs="Malignance Tights", 
        feet="Meghanada Jambeaux +2" -- 8
    }
    --sets.midcast['Enfeebling Magic'] = sets.midcast.RA

    sets.midcast['Enfeebling Magic'] = set_combine(sets.TreasureHunter, {
        body="Malignance Tabard",
        neck="Assassin's Gorget +1",
        ear1="Lempo Earring",
        ear2="Gwati Earring",
        legs="Malignance Tights", 
        ring1="Sangoma Ring",
        ring2="Weatherspoon Ring"
    })
    -- Weaponskill setkks
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head=HercHead.DM,
        neck="Assassin's Gorget +1",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        body="Herculean Vest",
        hands="Meghanada Gloves +2",
        ring1="Regal Ring",
        ring2="Gere Ring",
        back=Toutatis.WSD,
        waist="Windbuffet Belt +1",
        legs="Pillager's Culottes +3",
        feet=HercFeet.TP
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ring2="Cacoethic Ring +1",
        back=Toutatis.WSD,
        waist="Olseni Belt"
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMid version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        head=HercHead.DM,
        neck="Breeze Gorget", 
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        ring2="Ilabrat Ring",
        legs="Meghanada Chausses +2",
        waist="Breeze Belt",
        back=Toutatis.WSD,
    })
    sets.precast.WS['Exenterator'].Mid = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'].Mid, {
        back=Toutatis.WSD,
    })
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mid, {
        neck="Breeze Gorget", 
        body="Meghanada Cuirie +2",
        --hands="Pillager's Armlets +1", 
        legs="Pillager's Culottes +3",
    })
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mid, {
        neck="Breeze Gorget",
        --hands="Pillager's Armlets +1"
    })
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].SA, {neck="Breeze Gorget"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {neck="Breeze Gorget", waist="Thunder Belt"})
    sets.precast.WS['Dancing Edge'].Mid = set_combine(sets.precast.WS['Dancing Edge'], {waist="Thunder Belt"})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {
        head="Pillager's bonnet +3",
        waist="Olseni Belt"
    })
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Yetshila",
        neck="Shadow Gorget",
        head="Pillager's bonnet +3",
        body="Pillager's Vest +3",
        ear1="Odr Earring",
        ear2="Sherida Earring",
        ring1="Regal Ring",
        ring2="Mummu Ring",
        hands="Mummu Wrists +2",
        waist="Soil Belt",
        legs="Pillager's culottes +3",
        back=Toutatis.WSD,
        feet="Mummu Gamashes +2"
    })
    sets.precast.WS['Evisceration'].Mid = set_combine(sets.precast.WS['Evisceration'], {
        hands="Adhemar Wristbands +1",
        back=Toutatis.WSD,
    })
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        waist="Olseni Belt",
        neck="Assassin's Gorget +1",
    })
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
    
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ammo="Seething Bomblet +1",
        neck="Breeze Gorget",
        head=HercHead.DM,
        body="Herculean Vest",
        ear1="Moonshade Earring",
        ear2="Sherida Earring",
        ring1="Regal Ring",
        ring2="Gere Ring",
        hands="Meghanada Gloves +2",
        waist="Metalsinger Belt",
        legs="Meghanada Chausses +2",
        back=Toutatis.WSD,
        feet=HercFeet.TP
    })
-- Testing italics
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
        ammo="Seething Bomblet +1",
        neck="Assassin's Gorget +1",
        ear1="Moonshade Earring",
        ear2="Odr Earring",
        body="Herculean Vest",
        --body="Meghanada Cuirie +2",
        hands="Meghanada Gloves +2",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Snow Belt",
        back=Toutatis.WSD,
        feet=HercFeet.TP
    })
    sets.precast.WS["Rudra's Storm"].Mid = set_combine(sets.precast.WS["Rudra's Storm"], {
        ear2="Odr Earring",
        body="Meghanada Cuirie +2",
        back=Toutatis.WSD,
    })
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {
        legs="Pillager's culottes +3",
        head="Pillager's bonnet +3",
        body="Pillager's Vest +3",
        waist="Olseni Belt"
    })
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {
        ammo="Yetshila",
        head="Pillager's bonnet +3",
        neck="Assassin's Gorget +1",
        body="Meghanada Cuirie +2"
    })
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {
        neck="Assassin's Gorget +1",
        body="Herculean Vest",
    })
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {
        body="Meghanada Cuirie +2",
        neck="Assassin's Gorget +1",
    })

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
        head=HercHead.DM,
        neck="Assassin's Gorget +1",
        ear1="Brutal Earring",
        ear2="Sherida Earring", 
        hands="Pillager's Armlets +1", 
        ring1="Regal Ring",
        ring2="Ilabrat Ring", 
    })
    sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {
        head="Pillager's bonnet +3",
    })
    sets.precast.WS['Shark Bite'].Mid = set_combine(sets.precast.WS['Shark Bite'], {waist="Thunder Belt"})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget", ring1="Ramuh Ring"})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget"})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget"})

    sets.precast.WS['Aeolian Edge'] = {
        ammo="Seething Bomblet +1",
        neck="Sanctity Necklace",
        head=HercHead.DM, 
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        body="Herculean Vest",
        hands=HercHands.MAB,
        ring1="Dingir Ring",
        ring2="Mummu Ring",
        back="Toro Cape",
        waist="Thunder Belt",
        legs=HercLegs.MAB,
        feet=HercFeet.MAB
    }

    -- Midcast Sets
    sets.midcast.FastRecast = {
        legs="Quiahuiz Trousers"
    }

    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    -- Ranged gear -- acc + TH
    -- sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)

    sets.midcast.RA.Acc = sets.midcast.RA

    -- Resting sets
    sets.resting = {ring2="Paguroidea Ring"}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        ammo="Staunch Tathlum",
        -- main="Taming Sari",
        head="Turms Cap",
        neck="Sanctity Necklace",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Meghanada Ring",
        ring2="Paguroidea Ring",
        back=Toutatis.STP,
        waist="Flume Belt",
        legs="Malignance Tights", 
        feet="Jute Boots +1"
    }

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        neck="Assassin's Gorget +1",
        ear1="Telos Earring",
        ear2="Sherida Earring",
        body="Adhemar Jacket +1",
        hands="Adhemar Wristbands +1",
        ring1="Regal Ring",
        ring2="Gere Ring",
        legs="Pillager's culottes +3",
        back=Toutatis.STP,
        waist="Windbuffet Belt +1",
    })

    sets.idle.Regen = set_combine(sets.idle, {
        head="Turms Cap",
        hands="Meghanada Gloves +2",
        body="Meghanada Cuirie +2",
        ring1="Meghanada Ring",
        ring2="Paguroidea Ring",
    })
    sets.idle.PDT = set_combine(sets.idle, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        legs="Malignance Tights", 
        ring1="Defending Ring",
        ring2="Dark Ring"
    })

    sets.idle.Weak = sets.idle

    -- Defense sets

    sets.defense.PDT = {
        ammo="Staunch Tathlum",
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back=Toutatis.STP,
        waist="Flume Belt",
        legs="Malignance Tights", 
    }

    sets.defense.MDT = {
        ammo="Staunch Tathlum",
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        ear1="Etiolation Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back="Solemnity Cape",
        legs="Malignance Tights", 
        feet=HercFeet.TP
    }

    sets.Kiting = {feet="Jute Boots +1"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.

    -- Normal melee group
    sets.engaged = {
        ammo="Yamarang",
        head="Adhemar Bonnet +1",
        neck="Assassin's Gorget +1",
        ear1="Eabani Earring",
        ear2="Suppanomimi",
        body="Adhemar Jacket +1",
        hands="Floral Gauntlets",
        ring1="Hetairoi Ring",
        ring2="Gere Ring",
        back=Toutatis.STP,
        waist="Patentia Sash",
        legs="Pillager's culottes +3",
        feet=HercFeet.TP
    }
    sets.engaged.Mid = set_combine(sets.engaged, {
        head="Adhemar Bonnet +1",
        ammo="Yamarang",
        --ring1="Petrov Ring",
        legs="Pillager's culottes +3",
        -- feet="Mummu Gamashes +2"
    })
    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        head="Pillager's Bonnet +3",
        neck="Assassin's Gorget +1",
        ear1="Telos Earring",
        ear2="Odr Earring",
        body="Adhemar Jacket +1",
        hands="Floral Gauntlets",
        back=Toutatis.STP,
        ring1="Regal Ring",
        waist="Olseni Belt",
        feet=HercFeet.TP
    })
    sets.engaged.PDT = set_combine(sets.engaged, {
        ammo="Staunch Tathlum",
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back=Toutatis.STP,
        legs="Malignance Tights", 
        feet=HercFeet.TP
    })
    sets.engaged.Mid.PDT = set_combine(sets.engaged.PDT, {
        body="Pillager's Vest +3",
        --ring1="Patricius Ring",
        back="Canny Cape",
    })
    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
        body="Pillager's Vest +3",
        back="Canny Cape",
        waist="Olseni Belt"
    })
   
    -- Haste sets 
    sets.engaged.Haste_15 = set_combine(sets.engaged, {
        body="Adhemar Jacket +1",
    })
    sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Mid, { 
        body="Adhemar Jacket +1",
        neck="Assassin's Gorget +1",
    })
    sets.engaged.Acc.Haste_15 = set_combine(sets.engaged.Acc, {
        hands="Adhemar Wristbands +1",
    })
    sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, { 
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back=Toutatis.STP,
        legs="Malignance Tights",
        feet="Taeon Boots" 
    })
    sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.PDT.Haste_15, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring2="Patricius Ring",
        legs="Malignance Tights",
        back="Canny Cape",
    })
    sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Mid.PDT.Haste_15, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        back="Canny Cape",
        legs="Malignance Tights",
        waist="Olseni Belt"
    })
    
    -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged, {
        body="Pillager's Vest +3",
        hands="Adhemar Wristbands +1",
        -- hands="Regal Gloves",
        -- ear1="Sherida Earring",
        -- ear2="Suppanomimi",
        back=Toutatis.STP,
        feet=HercFeet.TP
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, { 
        body="Pillager's Vest +3",
        ear1="Telos Earring",
        neck="Assassin's Gorget +1",
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
        head="Pillager's bonnet +3",
        waist="Patentia Sash",
        body="Pillager's Vest +3",
        neck="Assassin's Gorget +1",
        ear1="Telos Earring",
        ear2="Odr Earring",
        back=Toutatis.STP,
        feet="Mummu Gamashes +2"
    })
    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, { 
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        body="Malignance Tabard",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back=Toutatis.STP,
        hands="Malignance Gloves",
        legs="Malignance Tights",
        feet=HercFeet.TP
    })
    sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.PDT.Haste_30, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        ring2="Patricius Ring",
        hands="Malignance Gloves",
        legs="Malignance Tights",
        back=Toutatis.STP,
    })
    sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Mid.PDT.Haste_30, {
        head="Malignance Chapeau",
        body="Malignance Tabard",
        back=Toutatis.STP,
        hands="Malignance Gloves",
        legs="Malignance Tights",
        waist="Olseni Belt"
    })

    -- Haste 43%
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
        head="Adhemar Bonnet +1",
        neck="Assassin's Gorget +1",
        ear1="Dedition Earring",
        ear2="Sherida Earring",
        body="Pillager's Vest +3",
        hands="Adhemar Wristbands +1",
        ring1="Hetairoi Ring",
        ring2="Gere Ring",
        back=Toutatis.STP,
        waist="Windbuffet Belt +1",
        legs="Pillager's culottes +3",
        feet=HercFeet.TP
    })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.MaxHaste, { 
        head="Adhemar Bonnet +1",
        ear1="Telos Earring",
        body="Pillager's Vest +3",
        ring1="Regal Ring",
        feet=HercFeet.TP
    })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.MaxHaste.Mid, {
        head="Pillager's bonnet +3",
        neck="Assassin's Gorget +1",
        hands="Adhemar Wristbands +1",
        ear1="Telos Earring",
        ear2="Odr Earring",
        waist="Olseni Belt",
        back=Toutatis.STP,
        legs="Pillager's culottes +3",
        feet="Mummu Gamashes +2"
    })
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        head="Malignance Chapeau",
        neck="Assassin's Gorget +1",
        hands="Malignance Gloves",
        body="Malignance Tabard",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back=Toutatis.STP,
        legs="Malignance Tights",
        feet=HercFeet.TP
    })
    sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.PDT.MaxHaste, {
        body="Pillager's Vest +3",
        ring2="Patricius Ring",
        back=Toutatis.STP,
    })
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Mid.PDT.MaxHaste, {
        body="Pillager's Vest +3",
        back=Toutatis.STP,
        waist="Olseni Belt"
    })
    


end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        --equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end

    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.value == 'PDT' then
        idleSet = set_combine(idleSet, sets.idle.PDT)
    end
    return idleSet
end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for change events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

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
end


-------------------------------------------------------------------------------------------------------------------
-- Various update events.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
    --determine_haste_group()
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Capacity Point Mantle' then
        gear.Back = newValue
    elseif stateField == 'Runes' then
        local msg = ''
        if newValue == 'Ignis' then
            msg = msg .. 'Increasing resistence against ICE and deals FIRE damage.'
        elseif newValue == 'Gelus' then
            msg = msg .. 'Increasing resistence against WIND and deals ICE damage.'
        elseif newValue == 'Flabra' then
            msg = msg .. 'Increasing resistence against EARTH and deals WIND damage.'
        elseif newValue == 'Tellus' then
            msg = msg .. 'Increasing resistence against LIGHTNING and deals EARTH damage.'
        elseif newValue == 'Sulpor' then
            msg = msg .. 'Increasing resistence against WATER and deals LIGHTNING damage.'
        elseif newValue == 'Unda' then
            msg = msg .. 'Increasing resistence against FIRE and deals WATER damage.'
        elseif newValue == 'Lux' then
            msg = msg .. 'Increasing resistence against DARK and deals LIGHT damage.'
        elseif newValue == 'Tenebrae' then
            msg = msg .. 'Increasing resistence against LIGHT and deals DARK damage.'
        end
        add_to_chat(123, msg)
   -- elseif stateField == 'moving' then
   --     if state.Moving.value then
   --         local res = require('resources')
   --         local info = windower.ffxi.get_info()
   --         local zone = res.zones[info.zone].name
   --         if zone:match('Adoulin') then
   --             equip(sets.Adoulin)
   --         end
   --         equip(select_movement())
   --     end
        
    elseif stateField == 'Use Rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    elseif stateField == 'Use Warp' then
        add_to_chat(8, '------------WARPING-----------')
        --equip({ring1="Warp Ring"})
        send_command('input //gs equip sets.Warp;@wait 10.0;input /item "Warp Ring" <me>;')
    end
end
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    msg = msg .. ': '
    msg = msg .. state.OffenseMode.value

    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.HasteMode.value ~= 'Normal' then
        msg = msg .. ', Haste: '..state.HasteMode.current
    else
        msg = msg .. ', Haste: '..state.HasteMode.current
    end

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', TH: ' .. state.TreasureMode.value
    add_to_chat(122, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

-- function determine_haste_group()

--     classes.CustomMeleeGroups:clear()
--     -- Haste (white magic) 15%
--     -- Haste Samba (Sub) 5%
--     -- Haste (Merited DNC) 10%
--     -- Victory March +3/+4/+5     14%/15.6%/17.1%
--     -- Advancing March +3/+4/+5   10.9%/12.5%/14%
--     -- Embrava 25%
--     if (buffactive.embrava or buffactive.haste) and buffactive.march == 2 then
--         add_to_chat(8, '-------------Haste 43%-------------')
--         classes.CustomMeleeGroups:append('Haste_43')
--     elseif buffactive.embrava and buffactive.haste then
--         add_to_chat(8, '-------------Haste 40%-------------')
--         classes.CustomMeleeGroups:append('Haste_40')
--     elseif (buffactive.haste ) or (buffactive.march == 2 and buffactive['haste samba']) then
--         add_to_chat(8, '-------------Haste 30%-------------')
--         classes.CustomMeleeGroups:append('Haste_30')
--     elseif buffactive.embrava or buffactive.march == 2 then
--         add_to_chat(8, '-------------Haste 25%-------------')
--         classes.CustomMeleeGroups:append('Haste_25')
--     end

-- end

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

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end


-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 2)
    elseif player.sub_job == 'WAR' then
        set_macro_page(5, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(5, 2)
    elseif player.sub_job == 'RUN' then
        set_macro_page(5, 9)
    else
        set_macro_page(5, 2)
    end
end

