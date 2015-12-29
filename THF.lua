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
	state.HybridMode:options('Normal', 'Evasion', 'PDT')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('Evasion', 'PDT')
	state.MagicalDefenseMode:options('MDT')
	state.RangedMode:options('Normal')

	-- Additional local binds
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind !- gs c cycle targetmode')
    send_command('bind != gs c toggle CapacityMode')

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
		head="Uk'uxkaj Cap",
        neck="Moepapa Medal",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Dread Jupon",
        hands="Pillager's Armlets +1",
        ring1="Ramuh Ring",
        ring2="Rajas Ring",
        back="Grounded Mantle +1",
        waist="Chaac Belt",
        legs="Samnuha Tights",
        feet="Raider's Poulaines +2"
    }

	sets.buff['Trick Attack'] = {
		head="Uk'uxkaj Cap",
        neck="Moepapa Medal",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Dread Jupon",
        hands="Pillager's Armlets +1",
        ring2="Garuda Ring",
		back="Canny Cape",
        waist="Chaac Belt",
        legs="Adhemar Kecks",
        feet="Raider's Poulaines +2"
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
	sets.precast.JA['Despoil'] = {}
	sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
	sets.precast.JA['Feint'] = {hands="Plunderer's Armlets +1"} -- {legs="Assassin's Culottes +2"}
	
	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",
        body="Mekosuchinae Harness",
		legs="Nahtirah Trousers",
    }
	-- TH actions
	sets.precast.Step = {
        head="Teon Chapeau",
        neck="Lissome Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        hands=TaeonHands.TA,
        back="Canny Cape",
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        waist="Chaac Belt",
        legs="Samnuha Tights",
        feet="Raider's Poulaines +2"
    }
	sets.precast.Flourish1 = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

	-- Fast cast sets for spells
	sets.precast.FC = {
        --ammo="Impatiens",
        head="Teon Chapeau",
        ear1="Loquacious Earring",
        hands="Buremte Gloves",
        body="Dread Jupon",
        ring1="Prolix Ring",
        legs="Limbo Trousers",
    }
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck="Magoraga Beads"
    })

	-- Ranged snapshot gear
	sets.precast.RA = {
        head="Uk'uxkaj Cap",
        hands=TaeonHands.Snap,
        legs="Nahtirah Trousers", 
        feet="Wurrukatte Boots"
    }
    sets.midcast.RA = {
        head="Umbani Cap",
        neck="Ocachi Gorget",
        ear1="Tripudio Earring",
        ear2="Enervating Earring",
        body="Mekosuchinae Harness",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
        waist="Patentia Sash",
        legs="Samnuha Tights",
        feet="Scopuli Nails +1"
    }
    --sets.midcast['Enfeebling Magic'] = sets.midcast.RA
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Taeon Chapeau",
        neck="Moepapa Medal",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
		body="Rawhide Vest",
        hands="Taeon Gloves",
        ring1="Karieyh Ring",
        ring2="Epona's Ring",
		back="Bleating Mantle",
        waist="Elanid Belt",
        legs="Samnuha Tights",
        feet="Taeon Boots"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        hands="Plunderer's Armlets +1",
        ring2="Patricius Ring",
        back="Canny Cape",
        waist="Olseni Belt"
    })

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMid version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        head="Teon Chapeau",
        neck="Moepapa Medal",
        ear1="Brutal Earring",
        ear2="Trux Earring",
        ring1="Garuda Ring",
        legs="Samnuha Tights",
        waist="Elanid Belt",
        back="Canny Cape"
    })
	sets.precast.WS['Exenterator'].Mid = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'].Mid, {
        hands="Plunderer's Armlets +1",
        back="Canny Cape"
    })
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mid, {
        neck="Breeze Gorget", 
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
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {head="Taeon Chapeau", waist="Olseni Belt"})
	sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})
	sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})
	sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        head="Uk'uxkaj Cap",
        neck="Moepapa Medal",
        hands="Pillager's Armlets +1",
        ring1="Ramuh Ring",
        waist="Light Belt",
        legs="Samnuha Tights",
        back="Bleating Mantle",
        feet="Plunderer's Poulaines"
    })
	sets.precast.WS['Evisceration'].Mid = set_combine(sets.precast.WS['Evisceration'], {back="Canny Cape"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        head="Teon Chapeau",
        hands="Plunderer's Armlets +1",
        ring1="Rajas Ring",
        ring2="Ramuh Ring",
        back="Canny Cape",
        waist="Olseni Belt"
    })
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
	
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
        head="Taeon Chapeau",
        neck="Moepapa Medal",
        hands=TaeonHands.TA,
        ring1="Ramuh Ring",
        ring2="Karieyh Ring",
        waist="Windbuffet Belt +1",
        legs="Samnuha Tights",
        back="Kayapa Cape",
        feet="Plunderer's Poulaines"
    })
	sets.precast.WS["Rudra's Storm"].Mid = set_combine(sets.precast.WS["Rudra's Storm"], {back="Canny Cape"})
	sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {
        head="Teon Chapeau",
        ring1="Rajas Ring",
        ring2="Ramuh Ring",
        back="Canny Cape",
        waist="Olseni Belt"
    })
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {neck="Aqua Gorget"})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {neck="Aqua Gorget"})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Mid, {neck="Aqua Gorget"})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Uk'uxkaj Cap", neck="Breeze Gorget",
		ear1="Brutal Earring",ear2="Trux Earring", hands="Pillager's Armlets +1", ring1="Ramuh Ring", ring2="Rajas Ring",
        legs="Samnuha Tights",
        })
	sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {head="Taeon Chapeau"})
	sets.precast.WS['Shark Bite'].Mid = set_combine(sets.precast.WS['Shark Bite'], {waist="Thunder Belt"})
	sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget", ring1="Ramuh Ring"})
	sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget"})
	sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget"})

	sets.precast.WS['Aeolian Edge'] = {
        neck="Sanctity Necklace",
        ear1="Crematio Earring",
        head="Umbani Cap",
		body="Samnuha Coat",
        hands="Leyline Gloves",
        ring1="Acumen Ring",
        ring2="Garuda Ring",
		back="Argochampsa Mantle",
        waist="Thunder Belt",
        legs="Limbo Trousers",
        feet="Taeon Boots"
    }
	
        -- Midcast Sets
	sets.midcast.FastRecast = {
		head="Felistris Mask",
        hands="Iuitl Wristbands +1",
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
		head="Iuitl Headgear +1",
        neck="Sanctity Necklace",
        ear1="Zennaroi Earring",
        ear2="Trux Earring",
        body="Emet Harness +1",
        hands="Iuitl Wristbands +1",
        ring1="Karieyh Ring",
        ring2="Defending Ring",
    	back="Solemnity Cape",
        waist="Flume Belt",
        legs="Samnuha Tights",
        feet="Skadi's Jambeaux +1"
    }

	sets.idle.Town = set_combine(sets.idle, {
        head="Lithelimb Cap",
        back="Canny Cape",
        neck="Sanctity Necklace",
        body="Councilor's Garb",
        hands="Leyline Gloves",
        ring1="Karieyh Ring",
        ring2="Defending Ring",
        legs="Samnuha Tights",
        waist="Windbuffet Belt +1",
    })

    sets.idle.Regen = set_combine(sets.idle, {
        head="Ocelomeh Headpiece +1",
        body="Kheper Jacket",
        ring2="Paguroidea Ring",
    })
	
	sets.idle.Weak = sets.idle

	-- Defense sets
	sets.defense.Evasion = {
		head="Felistris Mask",
        neck="Defiant Collar",
		body="Rawhide Vest",
        hands="Pillager's Armlets +1",
        ring1="Beeline Ring",
        ring2="Epona's Ring",
		back="Canny Cape",
        legs="Samnuha Tights",
        feet="Taeon Boots"
    }

	sets.defense.PDT = {
		head="Iuitl Headgear +1",
        neck="Twilight Torque",
		body="Emet Harness +1",
        hands="Iuitl Wristbands +1",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
    	back="Solemnity Cape",
        waist="Flume Belt",
        legs="Iuitl Tights +1",
    }

	sets.defense.MDT = {
		head="Whirlpool Mask",
        neck="Twilight Torque",
		body="Rawhide Vest",
        hands="Iuitl Wristbands +1",
        ring1="Defending Ring",
        ring2="Epona's Ring",
    	back="Solemnity Cape",
        legs="Nahtirah Trousers",
        feet="Taeon Boots"
    }

	sets.Kiting = {feet="Skadi's Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		head="Taeon Chapeau",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		--body="Skadi's Cuirie +1",
		body="Samnuha Coat",
        hands="Floral Gauntlets",
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
		back="Canny Cape",
        waist="Patentia Sash",
        legs="Samnuha Tights",
        feet="Taeon Boots"
    }
    sets.engaged.Mid = set_combine(sets.engaged, {
        neck="Lissome Necklace",
        ring1="Rajas Ring",
    })
	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
		body="Samnuha Coat",
        hands=TaeonHands.TA,
        neck="Lissome Necklace",
        ear1="Zennaroi Earring",
        ear2="Steelflash Earring",
        back="Grounded Mantle +1",
        ring1="Patricius Ring",
        waist="Olseni Belt",
        feet="Taeon Boots"
    })
	sets.engaged.Evasion = set_combine(sets.engaged, {
		body="Rawhide Vest",
        ring1="Beeline Ring",
        feet="Taeon Boots"
    })
    sets.engaged.Mid.Evasion = sets.engaged.Evasion
	sets.engaged.Acc.Evasion = set_combine(sets.engaged.Evasion, {
		head="Whirlpool Mask",
        ring1="Patricius Ring",
        waist="Olseni Belt"
    })
	sets.engaged.PDT = set_combine(sets.engaged, {
		head="Iuitl Headgear +1",
        neck="Twilight Torque",
		body="Emet Harness +1",
        ring1="Patricius Ring",
    	back="Solemnity Cape",
        waist="Flume Belt",
        legs="Iuitl Tights +1",
    })
	sets.engaged.Mid.PDT = set_combine(sets.engaged.PDT, {
        ring1="Patricius Ring",
		body="Emet Harness +1",
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
        head="Whirlpool Mask",
		body="Emet Harness +1",
        ring2="Mars's Ring",
        waist="Olseni Belt"
    })
    
    -- Haste 43%
    sets.engaged.Haste_43 = set_combine(sets.engaged, {
        head="Taeon Chapeau",
        ear1="Trux Earring",
        ear2="Brutal Earring",
        body="Rawhide Vest",
        hands=TaeonHands.TA,
        back="Canny Cape",
        waist="Windbuffet Belt +1",
        legs="Samnuha Tights",
        feet="Taeon Boots"
    })
    sets.engaged.Mid.Haste_43 = set_combine(sets.engaged.Haste_43, { 
        body="Rawhide Vest",
        ring1="Patricius Ring",
        feet="Taeon Boots"
    })
    sets.engaged.Acc.Haste_43 = set_combine(sets.engaged.Haste_43, {
        body="Rawhide Vest",
        neck="Lissome Necklace",
        hands="Leyline Gloves",
        ear1="Zennaroi Earring",
        ear2="Steelflash Earring",
        ring1="Mars's Ring",
        ring2="Patricius Ring",
        waist="Olseni Belt",
        back="Grounded Mantle +1"
    })
    sets.engaged.Evasion.Haste_43 = set_combine(sets.engaged.Haste_43, { body="Rawhide Vest", ring1="Beeline Ring", feet="Taeon Boots"})
    sets.engaged.PDT.Haste_43 = set_combine(sets.engaged.Haste_43, {
		    head="Iuitl Headgear +1",
            neck="Twilight Torque", 
            body="Rawhide Vest", 
            ring1="Patricius Ring", 
            ring2="Defending Ring", 
    	    back="Solemnity Cape",
            legs="Iuitl Tights +1", 
            feet="Taeon Boots" 
    })
    
     -- 40
    sets.engaged.Haste_40 = set_combine(sets.engaged.Haste_43, {
		body="Samnuha Coat",
        ear1="Suppanomimi",
    })
    sets.engaged.Mid.Haste_40 = set_combine(sets.engaged.Haste_40, { body="Samnuha Coat" })

    sets.engaged.Acc.Haste_40 = set_combine(sets.engaged.Acc.Haste_43, {
        ear1="Suppanomimi"
    })
    sets.engaged.Evasion.Haste_40 = set_combine(sets.engaged.Haste_40, {
            body="Rawhide Vest", 
            ring1="Beeline Ring", 
            feet="Taeon Boots"
    })
    sets.engaged.PDT.Haste_40 = set_combine(sets.engaged.Haste_40, { 
            head="Lithelimb Cap", 
            neck="Twilight Torque", 
            body="Rawhide Vest", 
            ring1="Patricius Ring", 
            ring2="Defending Ring", 
    	    back="Solemnity Cape",
            legs="Iuitl Tights +1", 
            feet="Taeon Boots" 
    })

     -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_40, {
        waist="Patentia Sash",
		body="Samnuha Coat",
        hands=TaeonHands.TA,
        back="Canny Cape",
        feet="Taeon Boots"
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, { 
		body="Samnuha Coat",
        feet="Taeon Boots"
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_40, {
        waist="Patentia Sash",
        back="Grounded Mantle +1",
        feet="Taeon Boots"
    })
    sets.engaged.Evasion.Haste_30 = set_combine(sets.engaged.Haste_30, { body="Samnuha Coat", ring1="Beeline Ring", feet="Taeon Boots"})
    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, { 
            head="Lithelimb Cap", 
            neck="Twilight Torque", 
            body="Rawhide Vest", 
            ring1="Patricius Ring", 
            ring2="Defending Ring", 
    	    back="Solemnity Cape",
            legs="Iuitl Tights +1", 
            feet="Taeon Boots" })

     -- 25
    sets.engaged.Haste_25 = set_combine(sets.engaged.Haste_30, {
        hands=TaeonHands.TA,
        ear1="Heartseeker Earring",
        ear2="Dudgeon Earring"
    })
    sets.engaged.Acc.Haste_25 = set_combine(sets.engaged.Acc.Haste_30, {
        ear1="Heartseeker Earring",
        ear2="Dudgeon Earring"
    })
    sets.engaged.Mid.Haste_25 = set_combine(sets.engaged.Haste_25, { body="Samnuha Coat" })
    sets.engaged.Evasion.Haste_25 = set_combine(sets.engaged.Haste_25, { body="Samnuha Coat", ring1="Beeline Ring", feet="Taeon Boots"})
    sets.engaged.PDT.Haste_25 = set_combine(sets.engaged.Haste_25, { 
            head="Lithelimb Cap", 
            neck="Twilight Torque", 
            body="Rawhide Vest", 
            ring1="Patricius Ring", 
            ring2="Defending Ring", 
    	    back="Solemnity Cape",
            legs="Iuitl Tights +1", 
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
		equip(sets.TreasureHunter)
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
    elseif (buffactive.haste and buffactive.march == 1) or (buffactive.march == 2 and buffactive['haste samba']) then
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
		set_macro_page(5, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 1)
	else
		set_macro_page(5, 2)
	end
end

