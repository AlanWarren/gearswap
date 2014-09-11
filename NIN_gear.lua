-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = { legs="Mochizuki Hakama +1" }
    sets.precast.JA['Futae'] = { hands="Iga Tekko +2" }
    sets.precast.JA['Provoke'] = { 
        ear1="Friomisi Earring",
        ear2="Trux Earring", 
        feet="Mochizuki Kyahan +1"
    }
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
    	head="Felistris Mask",
    	body="Mochizuki Chainmail +1",
        hands="Mochizuki Tekko +1",
        legs="Nahtirah Trousers",
        feet="Otronif Boots +1"
    }
    	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
	sets.TreasureHunter = {waist="Chaac Belt", back="Mecistopins Mantle"}
    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
    	head="Whirlpool Mask",
    	body="Mochizuki Chainmail +1",
        neck="Iqabi Necklace",
        hands="Umuthi Gloves",
    	back="Yokaze Mantle",
        waist="Chaac Belt",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1"
    }
    -- Ranged
    sets.precast.RA = {
        head="Uk'uxkaj Cap",
        --hands="Manibozho Gloves",
        legs="Nahtirah Trousers",
        feet="Wurrukatte Boots"
    }
    sets.midcast.RA = {
        head="Umbani Cap",
        neck="Iqabi Necklace",
        body="Mochizuki Chainmail +1",
        hands="Hachiya Tekko +1",
        ring1="Longshot Ring",
        ring2="Paqichikaji Ring",
        back="Yokaze Mantle",
        waist="Chaac Belt",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1"
    }
    sets.precast.JA.Sange = sets.midcast.RA
	sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)
    
    -- Fast cast sets for spells
    sets.precast.FC = {
        --head="Uk'uxkaj Cap",
        ear1="Loquacious Earring",
        ring1="Prolix Ring",
        hands="Buremte Gloves",
        legs="Kaabnax Trousers",
        feet="Mochizuki Kyahan +1" -- special enhancement for casting ninjutsu III
    }
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads", body="Mochizuki Chainmail +1" })
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
    	head="Uk'uxkaj Cap",
    	body="Mochizuki Chainmail +1",
        ear1="Loquacious Earring",
        waist="Hurch'lan Sash",
        ring1="Prolix Ring",
        legs="Kaabnax Trousers",
        feet="Mochizuki Kyahan +1"
    }
    	
    -- any ninjutsu cast on self
    sets.midcast.SelfNinjutsu = sets.midcast.FastRecast
    
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Iga Kyahan +2"})

    -- skill ++ 
    sets.midcast.Ninjutsu = {
    	head="Hachiya Hatsuburi +1",
        ear1="Lifestorm Earring",
        ear2="Psystorm Earring",
    	body="Mochizuki Chainmail +1",
        hands="Mochizuki Tekko +1",
    	back="Yokaze Mantle",
        ring1="Perception Ring",
        ring2="Sangoma Ring",
        waist="Chaac Belt",
        legs="Kaabnax Trousers",
        feet="Mochizuki Kyahan +1"
    }
    -- Nuking Ninjutsu (skill & magic attack)
    sets.midcast.ElementalNinjutsu = {
    	head="Mochizuki Hatsuburi +1",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        neck="Stoicheion Medal",
    	body="Hachiya Chainmail +1",
        hands="Iga Tekko +2",
    	back="Toro Cape",
        ring1="Sangoma Ring",
        ring2="Acumen Ring",
        waist="Caudata Belt",
        legs="Shneddick Tights +1",
        feet="Hachiya Kyahan +1"
    }
    
    -- Sets to return to when not performing an action.
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        --ammo="Yetshila",
    	head="Ptica Headgear",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Trux Earring",
    	body="Hachiya Chainmail +1",
        hands="Hachiya Tekko +1",
        ring1="Paguroidea Ring",
        ring2="Epona's Ring",
    	back="Atheling Mantle",
        waist="Patentia Sash",
        legs="Hachiya Hakama +1",
        feet="Danzo sune-ate"
     }

    sets.idle.Regen = {
    	head="Ocelomeh Headpiece +1",
        neck="Agitator's Collar",
        ear1="Brutal Earring",
        ear2="Trux Earring",
    	body="Kheper Jacket",
        hands="Mochizuki Tekko +1",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
    	back="Repulse Mantle",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1",
        feet="Danzo sune-ate"
    }
    
    sets.idle.Town = set_combine(sets.idle, {
        head="Ptica Headgear",
        neck="Hope Torque",
        body="Usukane Haramaki +1",
        hands="Mochizuki Tekko +1",
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
        legs="Mochizuki Hakama +1",
    	back="Yokaze Mantle"
    })
    
    sets.idle.Weak = sets.idle
    
    -- Defense sets
    
    sets.defense.PDT = {
    	head="Lithelimb Cap",
        neck="Twilight Torque",
        body="Otronif Harness +1",
        hands="Otronif Gloves +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
    	back="Repulse Mantle",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }
    
    sets.defense.MDT = set_combine(sets.defense.PDT, {
    	head="Felistris Mask",
        neck="Twilight Torque",
        hands="Otronif Gloves +1",
        feet="Otronif Boots +1"
    })
    
    sets.DayMovement = {feet="Danzo sune-ate"}
    sets.NightMovement = {feet="Hachiya Kyahan +1"}

    sets.NightAccAmmo = {ammo="Fire Bomblet"}
    sets.DayAccAmmo = {ammo="Tengu-no-Hane"}
    sets.RegularAmmo = {ammo="Yetshila"}
    
    sets.Kiting = select_movement()
    -- Engaged sets
    
    -- Normal melee group without buffs
    -- STP actually matters 20 is goal for DPS
    sets.engaged = {
        ammo="Yetshila",
    	head="Ptica Headgear",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
    	body="Hachiya Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
    	back="Atheling Mantle",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1",
        feet="Otronif Boots +1"
    }
    sets.engaged.TwoHanded = set_combine(sets.engaged, {
        head="Felistris Mask",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        waist="Windbuffet Belt",
        legs="Otronif Brais +1",
        feet="Qaaxo Leggings"
    })
    -- serious event set
    sets.engaged.Mid = set_combine(sets.engaged, {
        ammo=state.DayOrNightAmmo.value,
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Rajas Ring",
        feet="Qaaxo Leggings",
        back="Yokaze Mantle"
    })

    sets.engaged.Acc = {
        ammo=state.DayOrNightAmmo.value,
        head="Ptica Headgear",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Mars's Ring",
        ring2="Epona's Ring",
        back="Yokaze Mantle",
        waist="Anguinus Belt",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1"
    }

    sets.engaged.PDT = set_combine(sets.engaged, {
    	head="Lithelimb Cap",
        body="Otronif Harness +1",
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        ring1="Patricius Ring",
    	back="Repulse Mantle",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    })
    
    sets.engaged.Evasion = set_combine(sets.engaged, {
    	head="Felistris Mask",
        neck="Iga Erimaki",
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Beeline Ring",
        ring2="Epona's Ring",
        waist="Nusku's Sash",
    	back="Yokaze Mantle",
        feet="Qaaxo Leggings"
    })

    sets.engaged.Mid.Evasion = set_combine(sets.engaged.Evasion, {
    	head="Ptica Headgear"
    })

    sets.engaged.Acc.Evasion = set_combine(sets.engaged.Mid.Evasion, {
        ring2="Patricius Ring",
        waist="Anguinus Belt",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1"
    })

    sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, sets.engaged.Acc)
    
    sets.engaged.Haste_43 = {}
    sets.engaged.Haste_40 = {}
    sets.engaged.Haste_35 = {}
    sets.engaged.Haste_30 = {}
    sets.engaged.Haste_25 = {}
    sets.engaged.Haste_20 = {}

    -- These sets are included in each haste level. 
    -- The goal is to "TRY" to replace slots that don't affect haste/dw
    -- with accuracy and evasion gear. It tends to be the same
    -- regardless of haste recieved, so I made one set for each.

    sets.engaged.HasteMid = {
        head="Ptica Headgear",
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Rajas Ring",
        waist="Anguinus Belt",
        feet="Mochizuki Kyahan +1"
    }

    sets.engaged.HasteAcc = set_combine(sets.engaged.HasteMid, {
        ammo=state.DayOrNightAmmo.value,
        body="Mochizuki Chainmail +1",
        ring1="Mars's Ring",
        hands="Otronif Gloves +1",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1",
    })

    sets.engaged.HasteEvasion = {
        head="Ptica Headgear",
        body="Mochizuki Chainmail +1",
        neck="Iga Erimaki",
        hands="Otronif Gloves +1",
        ring1="Beeline Ring",
        ring2="Epona's Ring",
        back="Yokaze Mantle",
        waist="Nusku's Sash",
        feet="Qaaxo Leggings"
    }
    sets.engaged.HastePDT = {
        head="Lithelimb Cap",
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }
    
    -- 43
    sets.engaged.Haste_43 = set_combine(sets.engaged, {
    	head="Felistris Mask",
        ear1="Brutal Earring",
        ear2="Trux Earring",
        hands="Otronif Gloves +1",
        body="Thaumas Coat",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        waist="Windbuffet Belt",
        legs="Hachiya Hakama +1",
        feet="Otronif Boots +1"
    })
    sets.engaged.Mid.Haste_43 = set_combine(sets.engaged.Haste_43, {
        head="Ptica Headgear",
        body="Qaaxo Harness",
    	back="Rancorous Mantle",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Acc.Haste_43 = set_combine(sets.engaged.Mid.Haste_43, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_43 = set_combine(sets.engaged.Haste_43, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_43 = set_combine(sets.engaged.Haste_43, sets.engaged.HastePDT)
    
    -- 40
    sets.engaged.Haste_40 = set_combine(sets.engaged.Haste_43, {
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_40 = set_combine(sets.engaged.Haste_40, {
        head="Ptica Headgear",
        body="Qaaxo Harness",
    	waist="Anguinus Belt",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Acc.Haste_40 = set_combine(sets.engaged.Mid.Haste_40, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_40 = set_combine(sets.engaged.Haste_40, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_40 = set_combine(sets.engaged.Haste_40, sets.engaged.HastePDT)
    
    -- 35
    sets.engaged.Haste_35 = set_combine(sets.engaged.Haste_43, {
        head="Felistris Mask",
        ear1="Brutal Earring",
        ear2="Trux Earring",
        body="Thaumas Coat",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Haste_35, {
        head="Ptica Headgear",
        body="Mochizuki Chainmail +1",
        ring1="Mars's Ring",
    	back="Rancorous Mantle",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HastePDT)
    
    -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged, {
        head="Felistris Mask",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        waist="Windbuffet Belt",
        legs="Mochizuki Hakama +1",
        feet="Otronif Boots +1"
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, {
        ring1="Mars's Ring",
        hands="Mochizuki Tekko +1",
        back="Rancorous Mantle",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HastePDT)
    
    -- 25
    sets.engaged.Haste_25 = set_combine(sets.engaged, {
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        body="Mochizuki Chainmail +1",
        waist="Windbuffet Belt",
    })
    sets.engaged.Mid.Haste_25 = set_combine(sets.engaged.Haste_25, {
        waist="Anguinus Belt",
        back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Acc.Haste_25 = set_combine(sets.engaged.Mid.Haste_25, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_25 = set_combine(sets.engaged.Haste_25, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_25 = set_combine(sets.engaged.Haste_25, sets.engaged.HastePDT)
    
    -- 20
    sets.engaged.Haste_20 = set_combine(sets.engaged, {
    	body="Mochizuki Chainmail +1",
    })
    sets.engaged.Mid.Haste_20 = set_combine(sets.engaged.Haste_20, sets.engaged.HasteMid)
    sets.engaged.Acc.Haste_20 = set_combine(sets.engaged.Mid.Haste_20, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_20 = set_combine(sets.engaged.Haste_20, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_20 = set_combine(sets.engaged.Haste_20, sets.engaged.HastePDT)
    
    sets.buff.Migawari = {body="Iga Ningi +2"}
    
    -- Weaponskills 
    
    sets.precast.WS = {
    	head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
    	body="Qaaxo Harness",
        hands="Mochizuki Tekko +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
    	back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Manibozho Brais",
        feet="Qaaxo Leggings"
    }

    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        head="Ptica Headgear",
        hands="Otronif Gloves +1",
        body="Mochizuki Chainmail +1",
        back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        hands="Buremte Gloves",
        ring1="Mars's Ring"
    })
    
    -- BLADE: JIN
    sets.Jin = {
        neck="Breeze Gorget",
        waist="Thunder Belt",
        back="Rancorous Mantle",
        feet="Mochizuki Kyahan +1"
    }
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, sets.Jin)
    sets.precast.WS['Blade: Jin'].Mid = set_combine(sets.precast.WS.Mid, sets.Jin)
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS.Acc, sets.Jin)
    
    -- BLADE: HI
    sets.Hi = {
        ammo="Yetshila",
        head="Uk'uxkaj Cap",
        body="Qaaxo Harness",
        neck="Hope Torque",
        hands="Hachiya Tekko +1",
    	ring1="Garuda Ring",
        back="Rancorous Mantle",
        legs="Otronif Brais +1",
        waist="Windbuffet Belt",
        feet="Mochizuki Kyahan +1"
    }
    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, sets.Hi)
    sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {
        head="Ptica Headgear",
        body="Mochizuki Chainmail +1",
        neck="Shadow Gorget",
        waist="Soil Belt",
    })
    sets.precast.WS['Blade: Hi'].Acc = sets.precast.WS['Blade: Hi'].Mid

    -- BLADE: SHUN
    sets.Shun = {
        neck="Flame Gorget",
        waist="Light Belt",
        ring1="Ramuh Ring",
    }
    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, sets.Shun)
    sets.precast.WS['Blade: Shun'].Mid = set_combine(sets.precast.WS.Mid, sets.Shun)
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, sets.Shun)
    
    -- BLADE: Rin
    sets.Rin = {
        neck="Asperity Necklace",
        waist="Metalsinger Belt",
        ring1="Oneiros Ring",
    }
    sets.precast.WS['Blade: Rin'] = set_combine(sets.precast.WS, sets.Rin)
    sets.precast.WS['Blade: Rin'].Mid = set_combine(sets.precast.WS.Mid, sets.Rin)
    sets.precast.WS['Blade: Rin'].Acc = set_combine(sets.precast.WS.Acc, sets.Rin)
    
    -- BLADE: KU 
    sets.Ku = {
        neck="Shadow Gorget",
        body="Mochizuki Chainmail +1",
        waist="Soil Belt",
        ring1="Rajas Ring",
        feet="Mochizuki Kyahan +1"
    }
    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, sets.Ku)
    sets.precast.WS['Blade: Ku'].Mid = set_combine(sets.precast.WS.Mid, sets.Ku)
    sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS.Acc, sets.Ku)
    
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    	head="Umbani Cap",
        ear1="Crematio Earring",
        ear2="Moonshade Earring",
        neck="Stoicheion Medal",
        ring1="Garuda Ring",
        ring2="Acumen Ring",
    	back="Toro Cape",
        legs="Shneddick Tights +1",
        waist="Thunder Belt",
        feet="Mochizuki Kyahan +1"
     })
    sets.precast.WS['Blade: Chi'] = sets.precast.WS['Aeolian Edge']
    sets.precast.WS['Blade: To'] = sets.precast.WS['Aeolian Edge']

end

