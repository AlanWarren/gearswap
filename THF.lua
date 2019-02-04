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
    send_command('bind !- gs equip sets.crafting')

    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()

    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
end

function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    TaeonHands = {}
    TaeonHands.TA = {name="Taeon Gloves", augments={'DEX+6','Accuracy+17 Attack+17','"Triple Atk."+2'}}
    TaeonHands.Snap = {name="Taeon Gloves", augments={'Attack+22','"Snapshot"+8'}}

    HercFeet = {}
    HercFeet.TH = { name="Herculean Boots", augments={'AGI+1','Weapon Skill Acc.+3','"Treasure Hunter"+1','Accuracy+19 Attack+19','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
    --HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+4%','Mag. Acc.+14','"Mag.Atk.Bns."+13',}}
    HercFeet.MAB={ name="Herculean Boots", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Weapon skill damage +4%','Mag. Acc.+6','"Mag.Atk.Bns."+6',}}
    HercFeet.TP = { name="Herculean Boots", augments={'Accuracy+22 Attack+22','"Triple Atk."+3','STR+5','Attack+11',}}

    sets.TreasureHunter = {hands="Plunderer's Armlets +1", feet="Raider's Poulaines +2", waist="Chaac Belt"}
    sets.ExtraRegen = { head="Ocelomeh Headpiece +1" }
    sets.CapacityMantle = {back="Mecistopins Mantle"}

    sets.Organizer = {
        main="Odium",
        sub="Jugo Kukri",
        ammo="Izhiikoh",
        range="Raider's Boomerang"
    }

    sets.buff['Sneak Attack'] = {
        ammo="Yetshila",
        head="Meghanada Visor +2",
        neck="Moepapa Medal",
        body="Meghanada Cuirie +2",
        hands="Meghanada Gloves +2",
        ring1="Ilabrat Ring",
        ring2="Mummu Ring",
        waist="Chaac Belt",
        back="Toutatis's Cape", 
        legs="Samnuha Tights",
        feet="Mummu Gamashes +2"
    }

    sets.buff['Trick Attack'] = {
        ammo="Tengu-no-hane",
        head="Herculean Helm",
        neck="Moepapa Medal",
        ear1="Sherida Earring",
        body="Mummu Jacket +2",
        hands="Pillager's Armlets +1",
        ring1="Ilabrat Ring",
        ring2="Dingir Ring",
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
        legs="Pillager's Culottes +1" 
    }
    sets.precast.JA['Despoil'] = {feet="Raider's Poulaines +2"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {hands="Plunderer's Armlets +1"} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        body="Mekosuchinae Harness",
        legs="Nahtirah Trousers",
    }
    -- TH actions
    sets.precast.Step = {
        head="Herculean Helm",
        neck="Lissome Necklace",
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        back="Canny Cape",
        ring1="Ilabrat Ring",
        ring2="Cacoethic Ring +1",
        waist="Chaac Belt",
        legs="Samnuha Tights",
        feet="Raider's Poulaines +2"
    }
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter

    -- Fast cast sets for spells
    sets.precast.FC = {
        --ammo="Impatiens",
        head="Herculean Helm",
        ear1="Loquacious Earring",
        hands="Leyline Gloves",
        body="Dread Jupon",
        ring1="Prolix Ring",
        ring2="Kishar Ring",
        legs="Quiahuiz Trousers",
    }
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck="Magoraga Beads"
    })

    -- Ranged snapshot gear
    sets.precast.RA = {
        hands=TaeonHands.Snap,
        legs="Adhemar Kecks",
        feet="Meghanada Jambeaux +2" -- 8
    }
    sets.midcast.RA = {
        head="Meghanada Visor +2",
        neck="Iskur Gorget",
        ear1="Enervating Earring",
        ear2="Sherida Earring",
        body="Meghanada Cuirie +2",
        ring1="Dingir Ring",
        ring2="Mummu Ring",
        waist="Eschan Stone",
        legs="Adhemar Kecks",
        feet="Mummu Gamashes +2"
    }
    --sets.midcast['Enfeebling Magic'] = sets.midcast.RA

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Herculean Helm",
        neck="Moepapa Medal",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body="Herculean Vest",
        hands="Meghanada Gloves +2",
        ring1="Ilabrat Ring",
        ring2="Epona's Ring",
        back="Toutatis's Cape", 
        waist="Windbuffet Belt +1",
        legs="Meghanada Chausses +1",
        feet=HercFeet.TP
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ring2="Cacoethic Ring +1",
        back="Toutatis's Cape", 
        waist="Olseni Belt"
    })

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMid version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        head="Herculean Helm",
        neck="Moepapa Medal",
        ear1="Brutal Earring",
        ear2="Sherida Earring",
        legs="Samnuha Tights",
        waist="Elanid Belt",
        back="Toutatis's Cape", 
    })
    sets.precast.WS['Exenterator'].Mid = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'].Mid, {
        hands="Plunderer's Armlets +1",
        back="Toutatis's Cape", 
    })
    sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mid, {
        neck="Breeze Gorget", 
        body="Meghanada Cuirie +2",
        hands="Pillager's Armlets +1", 
        legs="Samnuha Tights",
    })
    sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mid, {
        neck="Breeze Gorget",
        hands="Pillager's Armlets +1"
    })
    sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].SA, {neck="Breeze Gorget"})

    sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {neck="Breeze Gorget", waist="Thunder Belt"})
    sets.precast.WS['Dancing Edge'].Mid = set_combine(sets.precast.WS['Dancing Edge'], {waist="Thunder Belt"})
    sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {head="Herculean Helm", waist="Olseni Belt"})
    sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})
    sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})
    sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        neck="Moepapa Medal",
        body="Mummu Jacket +1",
        ring1="Ilabrat Ring",
        ring2="Mummu Ring",
        waist="Windbuffet Belt",
        legs="Mummu Kecks +2",
        back="Toutatis's Cape", 
        feet="Mummu Gamashes +2"
    })
    sets.precast.WS['Evisceration'].Mid = set_combine(sets.precast.WS['Evisceration'], {
        back="Toutatis's Cape", 
    })
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        waist="Olseni Belt"
    })
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
        head="Herculean Helm",
        neck="Aqua Gorget",
        body="Herculean Vest",
        hands="Meghanada Gloves +2",
        ring1="Ilabrat Ring",
        ring2="Mummu Ring",
        waist="Snow Belt",
        back="Toutatis's Cape", 
        legs="Samnuha Tights",
        feet="Mummu Gamashes +2",
    })
    sets.precast.WS["Rudra's Storm"].Mid = set_combine(sets.precast.WS["Rudra's Storm"], {
        back="Toutatis's Cape", 
    })
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {
        waist="Olseni Belt"
    })
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {neck="Aqua Gorget", body="Meghanada Cuirie +2"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {neck="Aqua Gorget", body="Mummu Jacket +1"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {neck="Aqua Gorget"})

    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Herculean Helm", neck="Breeze Gorget",
    ear1="Brutal Earring",ear2="Trux Earring", hands="Pillager's Armlets +1", ring1="Ramuh Ring", ring2="Rajas Ring",
    legs="Samnuha Tights",
})
sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {head="Herculean Helm"})
sets.precast.WS['Shark Bite'].Mid = set_combine(sets.precast.WS['Shark Bite'], {waist="Thunder Belt"})
sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget", ring1="Ramuh Ring"})
sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget"})
sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget"})

sets.precast.WS['Aeolian Edge'] = {
    neck="Sanctity Necklace",
    ear1="Ishvara Earring",
    head="Herculean Helm",
    body="Samnuha Coat",
    hands="Leyline Gloves",
    ring1="Mummu Ring",
    ring2="Dingir Ring",
    back="Argochampsa Mantle",
    waist="Thunder Belt",
    legs="Limbo Trousers",
    feet=HercFeet.MAB
}

-- Midcast Sets
sets.midcast.FastRecast = {
    legs="Quiahuiz Trousers"
}

-- Specific spells
sets.midcast.Utsusemi = sets.midcast.FastRecast

-- Ranged gear -- acc + TH
sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)

sets.midcast.RA.Acc = sets.midcast.RA

-- Resting sets
sets.resting = {ring2="Paguroidea Ring"}

-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
sets.idle = {
    ammo="Yamarang",
    -- main="Taming Sari",
    head="Meghanada Visor +2",
    neck="Sanctity Necklace",
    ear1="Eabani Earring",
    ear2="Etiolation Earring",
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    ring1="Meghanada Ring",
    ring2="Paguroidea Ring",
    back="Solemnity Cape",
    waist="Flume Belt",
    legs="Meghanada Chausses +1",
    feet="Jute Boots +1"
}

sets.idle.Town = set_combine(sets.idle, {
    head="Meghanada Visor +2",
    back="Canny Cape",
    neck="Sanctity Necklace",
    body="Councilor's Garb",
    hands="Meghanada Gloves +2",
    ring1="Ilabrat Ring",
    ring2="Defending Ring",
    legs="Meghanada Chausses +1",
    waist="Windbuffet Belt +1",
})

sets.idle.Regen = set_combine(sets.idle, {
    head="Meghanada Visor +2",
    hands="Meghanada Gloves +2",
    body="Meghanada Cuirie +2",
    ring1="Meghanada Ring",
    ring2="Paguroidea Ring",
})

sets.idle.Weak = sets.idle

-- Defense sets

sets.defense.PDT = {
    head="Herculean Helm",
    neck="Twilight Torque",
    body="Emet Harness +1",
    hands="Herculean Gloves",
    ring1="Patricius Ring",
    ring2="Epona's Ring",
    back="Solemnity Cape",
    waist="Flume Belt",
    legs="Mummu Kecks +2",
}

sets.defense.MDT = {
    head="Meghanada Visor +1",
    neck="Twilight Torque",
    ear1="Etiolation Earring",
    body="Herculean Vest",
    hands="Herculean Gloves",
    ring1="Defending Ring",
    ring2="Epona's Ring",
    back="Solemnity Cape",
    legs="Mummu Kecks +2",
    feet=HercFeet.TP
}

sets.Kiting = {feet="Skadi's Jambeaux +1"}

-- Engaged sets

-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
-- sets if more refined versions aren't defined.
-- If you create a set with both offense and defense modes, the offense mode should be first.

-- Normal melee group
sets.engaged = {
    ammo="Yamarang",
    head="Herculean Helm",
    neck="Anu Torque",
    ear1="Eabani Earring",
    ear2="Suppanomimi",
    body="Herculean Vest",
    hands="Floral Gauntlets",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back="Canny Cape",
    waist="Patentia Sash",
    legs="Samnuha Tights",
    feet=HercFeet.TP
}
sets.engaged.Mid = set_combine(sets.engaged, {
    body="Mummu Jacket +2",
    legs="Mummu Kecks +2",
    feet="Mummu Gamashes +2"
})
sets.engaged.Acc = set_combine(sets.engaged.Mid, {
    neck="Lissome Necklace",
    ear1="Cessance Earring",
    ear2="Sherida Earring",
    body="Mummu Jacket +2",
    hands="Herculean Gloves",
    back="Grounded Mantle +1",
    ring1="Cacoethic Ring +1",
    waist="Olseni Belt",
    feet=HercFeet.TP
})
sets.engaged.PDT = set_combine(sets.engaged, {
    head="Meghanada Visor +1",
    neck="Twilight Torque",
    body="Meghanada Cuirie +2",
    hands="Meghanada Gloves +2",
    ring1="Patricius Ring",
    ring2="Defending Ring",
    back="Solemnity Cape",
    waist="Flume Belt",
    legs="Mummu Kecks +2",
    feet="Meghanada Jambeaux +1"
})
sets.engaged.Mid.PDT = set_combine(sets.engaged.PDT, {
    ring1="Patricius Ring",
    body="Emet Harness +1",
})
sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
    body="Emet Harness +1",
    waist="Olseni Belt"
})

-- Haste 43%
sets.engaged.Haste_43 = set_combine(sets.engaged, {
    head="Herculean Helm",
    neck="Anu Torque",
    ear1="Brutal Earring",
    ear2="Sherida Earring",
    body="Herculean Vest",
    hands="Herculean Gloves",
    ring1="Ilabrat Ring",
    ring2="Epona's Ring",
    back="Canny Cape",
    waist="Windbuffet Belt +1",
    legs="Meghanada Chausses +1",
    feet=HercFeet.TP
})
sets.engaged.Mid.Haste_43 = set_combine(sets.engaged.Haste_43, { 
    neck="Lissome Necklace",
    feet=HercFeet.TP
})
sets.engaged.Acc.Haste_43 = set_combine(sets.engaged.Haste_43, {
    neck="Lissome Necklace",
    hands="Herculean Gloves",
    ear1="Zennaroi Earring",
    ear2="Sherida Earring",
    ring1="Mummu Ring",
    waist="Olseni Belt",
    back="Grounded Mantle +1",
    legs="Mummu Kecks +2",
    feet="Mummu Gamashes +2"
})
sets.engaged.PDT.Haste_43 = set_combine(sets.engaged.Haste_43, {
    neck="Twilight Torque", 
    body="Herculean Vest", 
    ring1="Patricius Ring", 
    ring2="Defending Ring", 
    back="Solemnity Cape",
    feet=HercFeet.TP
})

-- 40
sets.engaged.Haste_40 = set_combine(sets.engaged.Haste_43, {
    body="Herculean Vest",
    ear1="Sherida Earring",
    ear2="Suppanomimi",
})
sets.engaged.Mid.Haste_40 = set_combine(sets.engaged.Haste_40, { body="Samnuha Coat" })

sets.engaged.Acc.Haste_40 = set_combine(sets.engaged.Acc.Haste_43, {
    ear1="Sherida Earring",
    ear2="Suppanomimi",
})
sets.engaged.PDT.Haste_40 = set_combine(sets.engaged.Haste_40, { 
    head="Lithelimb Cap", 
    neck="Twilight Torque", 
    body="Herculean Vest", 
    ring1="Patricius Ring", 
    ring2="Defending Ring", 
    legs="Mummu Kecks +2",
    back="Solemnity Cape",
    feet=HercFeet.TP
})

-- 30
sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_40, {
    body="Samnuha Coat",
    hands="Herculean Gloves",
    ear1="Eabani Earring",
    ear2="Suppanomimi",
    back="Canny Cape",
    feet=HercFeet.TP
})
sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, { 
    body="Herculean Vest",
})
sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_40, {
    waist="Patentia Sash",
    neck="Lissome Necklace",
    ear1="Sherida Earring",
    back="Grounded Mantle +1",
    feet=HercFeet.TP
})
sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, { 
    head="Lithelimb Cap", 
    neck="Twilight Torque", 
    body="Herculean Vest", 
    ring1="Patricius Ring", 
    ring2="Defending Ring", 
    back="Solemnity Cape",
    legs="Samnuha Tights",
    feet=HercFeet.TP
})

    -- 25
    sets.engaged.Haste_25 = set_combine(sets.engaged.Haste_30, {
        hands="Herculean Gloves",
        ear1="Eabani Earring",
        ear2="Suppanomimi",
    })
    sets.engaged.Acc.Haste_25 = set_combine(sets.engaged.Acc.Haste_30, {
        ear1="Eabani Earring",
        ear2="Suppanomimi",
    })
    sets.engaged.Mid.Haste_25 = set_combine(sets.engaged.Haste_25, { body="Samnuha Coat" })
    sets.engaged.PDT.Haste_25 = set_combine(sets.engaged.Haste_25, { 
        head="Lithelimb Cap", 
        neck="Twilight Torque", 
        body="Herculean Vest", 
        ring1="Patricius Ring", 
        ring2="Defending Ring", 
        back="Solemnity Cape",
        legs="Samnuha Tights",
        feet="Taeon Boots" })
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
        if S{'haste','march', 'madrigal','embrava','haste samba'}:contains(buff:lower()) then
            determine_haste_group()
            handle_equipping_gear(player.status)
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
        determine_haste_group()
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

    function determine_haste_group()

        classes.CustomMeleeGroups:clear()
        -- Haste (white magic) 15%
        -- Haste Samba (Sub) 5%
        -- Haste (Merited DNC) 10%
        -- Victory March +3/+4/+5     14%/15.6%/17.1%
        -- Advancing March +3/+4/+5   10.9%/12.5%/14%
        -- Embrava 25%
        if (buffactive.embrava or buffactive.haste) and buffactive.march == 2 then
            add_to_chat(8, '-------------Haste 43%-------------')
            classes.CustomMeleeGroups:append('Haste_43')
        elseif buffactive.embrava and buffactive.haste then
            add_to_chat(8, '-------------Haste 40%-------------')
            classes.CustomMeleeGroups:append('Haste_40')
        elseif (buffactive.haste ) or (buffactive.march == 2 and buffactive['haste samba']) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive.embrava or buffactive.march == 2 then
            add_to_chat(8, '-------------Haste 25%-------------')
            classes.CustomMeleeGroups:append('Haste_25')
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
                set_macro_page(4, 1)
            elseif player.sub_job == 'NIN' then
                set_macro_page(5, 2)
            else
                set_macro_page(5, 2)
            end
        end

