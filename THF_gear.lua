function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	sets.TreasureHunter = {hands="Plunderer's Armlets +1", feet="Raider's Poulaines +2", waist="Chaac Belt"}
    sets.ExtraRegen = { head="Ocelomeh Headpiece +1" }
    sets.CapacityMantle = {back="Mecistopins Mantle"}
	
	sets.buff['Sneak Attack'] = {
		head="Uk'uxkaj Cap",
        neck="Moepapa Medal",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Dread Jupon",
        hands="Pillager's Armlets +1",
        ring1="Ramuh Ring",
        ring2="Ramuh Ring +1",
		back="Atheling Mantle",
        waist="Chaac Belt",
        legs="Pillager's Culottes +1",
        feet="Raider's Poulaines +2"
    }

	sets.buff['Trick Attack'] = {
		head="Uk'uxkaj Cap",
        neck="Moepapa Medal",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Dread Jupon",
        hands="Pillager's Armlets +1",
        ring1="Stormsoul Ring",
        ring2="Garuda Ring",
		back="Canny Cape",
        waist="Chaac Belt",
        legs="Pillager's Culottes +1",
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
        feet="Iuitl Gaiters +1"
    }
	-- TH actions
	sets.precast.Step = {
        head="Whirlpool Mask",
        neck="Iqabi Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        hands="Plunderer's Armlets +1",
        back="Canny Cape",
        ring1="Ramuh Ring +1",
        ring2="Mars's Ring",
        waist="Chaac Belt",
        legs="Pillager's Culottes +1",
        feet="Raider's Poulaines +2"
    }
	sets.precast.Flourish1 = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

	-- Fast cast sets for spells
	sets.precast.FC = {
        --head="Uk'uxkaj Cap",
        ear1="Loquacious Earring",
        hands="Buremte Gloves",
        body="Dread Jupon",
        ring1="Prolix Ring",
        legs="Kaabnax Trousers"
    }
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck="Magoraga Beads"
    })

	-- Ranged snapshot gear
	sets.precast.RA = {
        head="Uk'uxkaj Cap",
        hands="Iuitl Wristbands +1",
        legs="Nahtirah Trousers", 
        feet="Wurrukatte Boots"
    }
    sets.midcast.RA = {
        head="Umbani Cap",
        neck="Iqabi Necklace",
        ear1="Volley Earring",
        ear2="Clearview Earring",
        body="Mekosuchinae Harness",
        hands="Sigyn's Bazubands",
        ring1="Longshot Ring",
        ring2="Hajduk Ring",
        waist="Elanid Belt",
        legs="Aetosaur Trousers +1",
        feet="Scopuli Nails +1"
    }
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Felistris Mask",
        neck="Moepapa Medal",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Elanid Belt",
        legs="Pillager's Culottes +1",
        feet="Qaaxo Leggings"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        head="Whirlpool Mask",
        hands="Plunderer's Armlets +1",
		body="Dread Jupon",
        ring1="Mars's Ring",
        ring2="Ramuh Ring +1",
        back="Canny Cape",
        waist="Olseni Belt"
    })

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMid version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        head="Felistris Mask", 
        neck="Moepapa Medal",
        ear1="Brutal Earring",
        ear2="Trux Earring",
        ring1="Garuda Ring",
		legs="Quiahuiz Trousers", 
        waist="Elanid Belt",
        back="Canny Cape"
    })
	sets.precast.WS['Exenterator'].Mid = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'].Mid, {
        hands="Plunderer's Armlets +1",
        ring1="Mars's Ring",
        back="Canny Cape"
    })
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mid, {
        neck="Breeze Gorget", 
        hands="Pillager's Armlets +1", 
        legs="Pillager's Culottes +1"
    })
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mid, {
        neck="Breeze Gorget",
        hands="Pillager's Armlets +1"
    })
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].SA, {neck="Breeze Gorget"})

	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {neck="Breeze Gorget", waist="Thunder Belt"})
	sets.precast.WS['Dancing Edge'].Mid = set_combine(sets.precast.WS['Dancing Edge'], {waist="Thunder Belt"})
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {head="Whirlpool Mask", waist="Olseni Belt"})
	sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})
	sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})
	sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mid, {neck="Breeze Gorget"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        head="Uk'uxkaj Cap",
        neck="Moepapa Medal",
        hands="Pillager's Armlets +1",
        ring1="Ramuh Ring +1",
        waist="Light Belt",
        legs="Pillager's Culottes +1",
        back="Atheling Mantle",
        feet="Plunderer's Poulaines"
    })
	sets.precast.WS['Evisceration'].Mid = set_combine(sets.precast.WS['Evisceration'], {back="Canny Cape"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        head="Whirlpool Mask",
        hands="Plunderer's Armlets +1",
        ring1="Rajas Ring",
        ring2="Ramuh Ring +1",
        back="Canny Cape",
        waist="Olseni Belt"
    })
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mid, {neck="Shadow Gorget"})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Uk'uxkaj Cap", neck="Breeze Gorget",
		ear1="Brutal Earring",ear2="Trux Earring", hands="Pillager's Armlets +1", ring1="Ramuh Ring +1", ring2="Rajas Ring",
        legs="Pillager's Culottes +1"})
	sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {head="Whirlpool Mask"})
	sets.precast.WS['Shark Bite'].Mid = set_combine(sets.precast.WS['Shark Bite'], {waist="Thunder Belt"})
	sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget", ring1="Ramuh Ring +1"})
	sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget"})
	sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mid, {neck="Breeze Gorget"})

	sets.precast.WS['Aeolian Edge'] = {
		neck="Stoicheion Medal",
        ear1="Crematio Earring",
        head="Umbani Cap",
		body="Mekosuchinae Harness",
        hands="Iuitl Wristbands +1",
        ring1="Acumen Ring",
        ring2="Garuda Ring",
		back="Argochampsa Mantle",
        waist="Thunder Belt",
        legs="Shneddick Tights",
        feet="Iuitl Gaiters +1"
    }
	
        -- Midcast Sets
	sets.midcast.FastRecast = {
		head="Felistris Mask",
        hands="Iuitl Wristbands +1",
		waist="Hurch'lan Sash"
    }
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Felistris Mask",
        hands="Iuitl Wristbands +1",
		waist="Hurch'lan Sash",
        legs="Kaabnax Trousers"
    }

	-- Ranged gear -- acc + TH
	sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)

	sets.midcast.RA.Acc = sets.midcast.RA
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		head="Ocelomeh Headpiece +1",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Kheper Jacket",
        hands="Iuitl Wristbands +1",
        ring1="Paguroidea Ring",
        ring2="Epona's Ring",
		back="Repulse Mantle",
        waist="Patentia Sash",
        legs="Pillager's Culottes +1",
        feet="Skadi's Jambeaux +1"
    }

	sets.idle.Town = set_combine(sets.idle, {
        head="Felistris Mask",
        body="Skadi's Cuirie +1",
        hands="Pillager's Armlets +1",
        back="Canny Cape",
        ring1="Ramuh Ring +1",
        ring2="Epona's Ring",
        waist="Windbuffet Belt +1",
    })
	
	sets.idle.Weak = sets.idle

	-- Defense sets
	sets.defense.Evasion = {
		head="Felistris Mask",
        neck="Asperity Necklace",
		body="Qaaxo Harness",
        hands="Pillager's Armlets +1",
        ring1="Beeline Ring",
        ring2="Epona's Ring",
		back="Canny Cape",
        waist="Nusku's Sash",
        legs="Pillager's Culottes +1",
        feet="Qaaxo Leggings"
    }

	sets.defense.PDT = {
		head="Lithelimb Cap",
        neck="Twilight Torque",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
		back="Repulse Mantle",
        waist="Patentia Sash",
        legs="Iuitl Tights +1",
        feet="Iuitl Gaiters +1"
    }

	sets.defense.MDT = {
		head="Whirlpool Mask",
        neck="Twilight Torque",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Dark Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Hurch'lan Sash",
        legs="Nahtirah Trousers",
        feet="Qaaxo Leggings"
    }

	sets.Kiting = {feet="Trotter Boots"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Skadi's Cuirie +1",
        hands="Iuitl Wristbands +1",
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
		back="Canny Cape",
        waist="Patentia Sash",
        legs="Pillager's Culottes +1",
        feet="Plunderer's Poulaines"
    }
	sets.engaged.Mid = set_combine(sets.engaged, {
        ring1="Ramuh Ring +1",
		body="Qaaxo Harness",
    })
	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Whirlpool Mask",
        neck="Iqabi Necklace",
		body="Dread Jupon",
        ring1="Ramuh Ring +1",
        hands="Buremte Gloves",
        waist="Olseni Belt",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        head="Lithelimb Cap",
        ring1="Patricius Ring",
        legs="Iuitl Tights +1",
        feet="Iuitl Gaiters +1"
    })
	sets.engaged.Evasion = set_combine(sets.engaged, {
		body="Qaaxo Harness",
        ring1="Beeline Ring",
        hands="Pillager's Armlets +1",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Mid.Evasion = sets.engaged.Evasion
	sets.engaged.Acc.Evasion = set_combine(sets.engaged.Evasion, {
		head="Whirlpool Mask",
        ring1="Ramuh Ring +1",
        waist="Olseni Belt"
    })
	sets.engaged.PDT = {
		head="Lithelimb Cap",
        neck="Twilight Torque",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
		back="Repulse Mantle",
        waist="Patentia Sash",
        legs="Iuitl Tights +1",
        feet="Iuitl Gaiters +1"
    }
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
        head="Whirlpool Mask",
        ring2="Ramuh Ring +1",
        waist="Olseni Belt"
    })
    
    -- Haste 43%
    sets.engaged.Haste_43 = set_combine(sets.engaged, {
        ear1="Trux Earring",
        ear2="Brutal Earring",
        body="Thaumas Coat",
        back="Rancorous Mantle",
        waist="Windbuffet Belt +1",
    })
    sets.engaged.Mid.Haste_43 = set_combine(sets.engaged.Haste_43, { 
        body="Qaaxo Harness",
        ring1="Ramuh Ring +1"
    })
    sets.engaged.Acc.Haste_43 = set_combine(sets.engaged.Haste_43, {
        head="Whirlpool Mask",
        body="Qaaxo Harness",
        neck="Rancor Collar",
        hands="Plunderer's Armlets +1",
        ring1="Mars's Ring",
        ring2="Ramuh Ring +1",
        waist="Olseni Belt",
        back="Canny Cape"
    })
    sets.engaged.Evasion.Haste_43 = set_combine(sets.engaged.Haste_43, { body="Qaaxo Harness", ring1="Beeline Ring", feet="Qaaxo Leggings"})
    sets.engaged.PDT.Haste_43 = set_combine(sets.engaged.Haste_43, { head="Lithelimb Cap", neck="Twilight Torque", 
        body="Qaaxo Harness", ring1="Patricius Ring", ring2="Dark Ring", back="Repulse Mantle", legs="Iuitl Tights +1", feet="Iuitl Gaiters +1" })
    
     -- 40
    sets.engaged.Haste_40 = set_combine(sets.engaged.Haste_43, {
        ear1="Suppanomimi",
    })
    sets.engaged.Mid.Haste_40 = set_combine(sets.engaged.Haste_40, { body="Qaaxo Harness" })

    sets.engaged.Acc.Haste_40 = set_combine(sets.engaged.Acc.Haste_43, {
        ear1="Suppanomimi"
    })
    sets.engaged.Evasion.Haste_40 = set_combine(sets.engaged.Haste_40, { body="Qaaxo Harness", ring1="Beeline Ring", feet="Qaaxo Leggings"})
    sets.engaged.PDT.Haste_40 = set_combine(sets.engaged.Haste_40, { head="Lithelimb Cap", neck="Twilight Torque", 
        body="Qaaxo Harness", ring1="Patricius Ring", ring2="Dark Ring", back="Repulse Mantle", legs="Iuitl Tights +1", feet="Iuitl Gaiters +1" })

     -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_40, {
        waist="Patentia Sash",
        back="Canny Cape"
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, { 
        body="Qaaxo Harness",
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_40, {
        waist="Patentia Sash",
        back="Canny Cape"
    })
    sets.engaged.Evasion.Haste_30 = set_combine(sets.engaged.Haste_30, { body="Qaaxo Harness", ring1="Beeline Ring", feet="Qaaxo Leggings"})
    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, { head="Lithelimb Cap", neck="Twilight Torque", 
        body="Qaaxo Harness", ring1="Patricius Ring", ring2="Dark Ring", back="Repulse Mantle", legs="Iuitl Tights +1", feet="Iuitl Gaiters +1" })

     -- 25
    sets.engaged.Haste_25 = set_combine(sets.engaged.Haste_30, {
        ear1="Heartseeker Earring",
        ear2="Dudgeon Earring"
    })
    sets.engaged.Acc.Haste_25 = set_combine(sets.engaged.Acc.Haste_30, {
        ear1="Heartseeker Earring",
        ear2="Dudgeon Earring"
    })
    sets.engaged.Mid.Haste_25 = set_combine(sets.engaged.Haste_25, { body="Qaaxo Harness" })
    sets.engaged.Evasion.Haste_25 = set_combine(sets.engaged.Haste_25, { body="Qaaxo Harness", ring1="Beeline Ring", feet="Qaaxo Leggings"})
    sets.engaged.PDT.Haste_25 = set_combine(sets.engaged.Haste_25, { head="Lithelimb Cap", neck="Twilight Torque", 
        body="Qaaxo Harness", ring1="Patricius Ring", ring2="Dark Ring", back="Repulse Mantle", legs="Iuitl Tights +1", feet="Iuitl Gaiters +1" })
end
