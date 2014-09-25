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
    
    sets.TreasureHunter = { waist="Chaac Belt" }
    sets.CapacityMantle = { back="Mecistopins Mantle" }
    sets.WSDayBonus     = { head="Gavialis Helm" }
    sets.Katanas = {main="Kannagi", sub="Taikogane"}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        head="Ptica Headgear",
        body="Mochizuki Chainmail +1",
        neck="Iqabi Necklace",
        hands="Buremte Gloves",
        back="Yokaze Mantle",
        waist="Anguinus Belt",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1"
    }
    -- Ranged
    sets.precast.RA = {
        head="Uk'uxkaj Cap",
        hands="Buremte Gloves",
        legs="Nahtirah Trousers",
        feet="Wurrukatte Boots"
    }
    sets.midcast.RA = {
        head="Umbani Cap",
        neck="Iqabi Necklace",
        body="Mochizuki Chainmail +1",
        hands="Hachiya Tekko +1",
        ring1="Longshot Ring",
        ring2="Hajduk Ring",
        back="Yokaze Mantle",
        --waist="Hurling Belt",
        legs="Hachiya Hakama +1",
        feet="Scopuli Nails +1"
    }
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        body="Mekosuchinae Harness"
    })
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
        body="Mekosuchinae Harness",
        hands="Mochizuki Tekko +1",
        ring1="Perception Ring",
        ring2="Sangoma Ring",
        back="Yokaze Mantle",
        waist="Chaac Belt",
        legs="Kaabnax Trousers",
        feet="Mochizuki Kyahan +1"
    }
    -- Nuking Ninjutsu (skill & magic attack)
    sets.midcast.ElementalNinjutsu = {
        ammo="Dosis Tathlum",
        head="Mochizuki Hatsuburi +1",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        neck="Stoicheion Medal",
        body="Mekosuchinae Harness",
        hands="Iga Tekko +2",
        back="Aput Mantle",
        ring1="Sangoma Ring",
        ring2="Acumen Ring",
        waist="Caudata Belt",
        legs="Shneddick Tights +1",
        feet="Hachiya Kyahan +1"
    }
    
    sets.idle = {
        --ammo="Yetshila",
        head="Ptica Headgear",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Trux Earring",
    	body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Dark Ring",
        ring2="Patricius Ring",
    	back="Vellaunus' Mantle +1",
        waist="Windbuffet Belt +1",
        legs="Hachiya Hakama +1",
        feet="Danzo Sune-ate"
     }

    sets.idle.Regen = {
        head="Ocelomeh Headpiece +1",
        neck="Agitator's Collar",
        ear1="Brutal Earring",
        ear2="Trux Earring",
        body="War Shinobi Gi",
        hands="Mochizuki Tekko +1",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
        back="Repulse Mantle",
        waist="Windbuffet Belt +1",
        legs="Mochizuki Hakama +1",
        feet="Danzo Sune-ate"
    }
    
    sets.idle.Town = set_combine(sets.idle, {
        head="Ptica Headgear",
        neck="Hope Torque",
        body="Mes'yohi Haubergeon",
        hands="Mochizuki Tekko +1",
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
        legs="Hachiya Hakama +1",
        back="Vellaunus' Mantle +1"
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
    
    --sets.Kiting = select_movement()
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
        back="Vellaunus' Mantle +1",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1",
        feet="Otronif Boots +1"
    }
    sets.engaged.TwoHanded = set_combine(sets.engaged, {
        head="Felistris Mask",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        waist="Windbuffet Belt +1",
        back="Atheling Mantle",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    })
    -- serious event set
    sets.engaged.Mid = set_combine(sets.engaged, {
        ammo="Yetshila",
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Rajas Ring",
        back="Yokaze Mantle",
        feet="Qaaxo Leggings",
    })

    sets.engaged.Acc = {
        head="Ptica Headgear",
        neck="Rancor Collar",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        body="Mochizuki Chainmail +1", 
        hands="Buremte Gloves",
        ring1="Mars's Ring",
        ring2="Epona's Ring",
        back="Yokaze Mantle",
        waist="Windbuffet Belt +1",
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
        head="Mochizuki Hatsuburi +1",
        neck="Iga Erimaki",
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Beeline Ring",
        ring2="Epona's Ring",
        back="Yokaze Mantle",
        waist="Nusku's Sash",
        legs="Hachiya Hakama +1",
        feet="Qaaxo Leggings"
    })

    sets.engaged.Mid.Evasion = set_combine(sets.engaged.Evasion, {
        head="Ptica Headgear"
    })

    sets.engaged.Acc.Evasion = set_combine(sets.engaged.Mid.Evasion, {
        ring2="Patricius Ring",
        waist="Anguinus Belt",
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
    -- with acc/eva/pdt gear

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
        body="Otronif Harness +1",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }

    -- 43
    sets.engaged.Haste_43 = set_combine(sets.engaged, {
        head="Felistris Mask",
        ear1="Brutal Earring",
        ear2="Trux Earring",
        body="Thaumas Coat",
        ring1="Rajas Ring",
        back="Rancorous Mantle",
        waist="Windbuffet Belt +1",
        legs="Hachiya Hakama +1"
    })
    sets.engaged.Mid.Haste_43 = set_combine(sets.engaged.Haste_43, {
        body="Mes'yohi Haubergeon",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        back="Yokaze Mantle",
        legs="Hachiya Hakama +1",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Acc.Haste_43 = set_combine(sets.engaged.Mid.Haste_43, { 
        head="Ptica Headgear",
        neck="Rancor Collar",
        ear1="Zennaroi Earring",
        ear2="Trux Earring",
        ring1="Mars's Ring",
        hands="Buremte Gloves",
        feet="Mochizuki Kyahan +1",
    })
    sets.engaged.Evasion.Haste_43 = set_combine(sets.engaged.Haste_43, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_43 = set_combine(sets.engaged.Haste_43, {
        head="Ptica Headgear",
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        body="Otronif Harness +1",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    })
     
    -- Max Haste is down here because it inherits Haste_43 
    sets.engaged.MaxHaste = set_combine(sets.engaged.Haste_43, {
        legs="Otronif Brais +1"
    })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.Mid.Haste_43, {
        legs="Hachiya Hakama +1"
    })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Acc.Haste_43, {})
    sets.engaged.Evasion.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.HasteEvasion)
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        head="Ptica Headgear",
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        body="Otronif Harness +1",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
     })
    
    -- 40
    sets.engaged.Haste_40 = set_combine(sets.engaged.Haste_43, {
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_40 = set_combine(sets.engaged.Haste_40, {
        body="Mes'yohi Haubergeon",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        back="Yokaze Mantle",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Acc.Haste_40 = set_combine(sets.engaged.Mid.Haste_40, {
        head="Ptica Headgear",
        neck="Rancor Collar",
        ring1="Mars's Ring",
        hands="Buremte Gloves",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1",
    })
    sets.engaged.Evasion.Haste_40 = set_combine(sets.engaged.Haste_40, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_40 = set_combine(sets.engaged.Haste_40, {
        head="Ptica Headgear",
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        body="Otronif Harness +1",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    })
    
    -- 35
    sets.engaged.Haste_35 = set_combine(sets.engaged.Haste_43, {
        ear1="Brutal Earring",
        ear2="Trux Earring",
        body="Thaumas Coat",
        back="Rancorous Mantle",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Haste_35, {
        body="Mochizuki Chainmail +1",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        back="Yokaze Mantle",
        legs="Hachiya Hakama +1",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, {
        head="Ptica Headgear",
        neck="Rancor Collar",
        body="Mes'yohi Haubergeon",
        hands="Buremte Gloves",
        feet="Mochizuki Kyahan +1",
    })
    sets.engaged.Evasion.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, {
        head="Ptica Headgear",
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        body="Otronif Harness +1",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    })
    
    -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged, {
        head="Ptica Headgear",
        ear1="Brutal Earring",
        ear2="Trux Earring",
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        waist="Windbuffet Belt +1",
        back="Rancorous Mantle",
        feet="Otronif Boots +1"
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, {
        ear2="Suppanomimi",
        back="Yokaze Mantle",
        legs="Hachiya Hakama +1",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        neck="Rancor Collar",
        ring1="Mars's Ring",
        hands="Buremte Gloves",
        waist="Anguinus Belt",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Evasion.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HastePDT)
    
    -- 25
    sets.engaged.Haste_25 = set_combine(sets.engaged, {
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        body="Mochizuki Chainmail +1",
        back="Rancorous Mantle",
        waist="Windbuffet Belt +1",
    })
    sets.engaged.Mid.Haste_25 = set_combine(sets.engaged.Haste_25, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        back="Yokaze Mantle",
        legs="Hachiya Hakama +1",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Acc.Haste_25 = set_combine(sets.engaged.Mid.Haste_25, {
        neck="Rancor Collar",
        hands="Buremte Gloves",
        ring1="Mars's Ring",
        waist="Anguinus Belt",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Evasion.Haste_25 = set_combine(sets.engaged.Haste_25, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_25 = set_combine(sets.engaged.Haste_25, sets.engaged.HastePDT)
    
    -- 20
    sets.engaged.Haste_20 = set_combine(sets.engaged, {
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        body="Mochizuki Chainmail +1",
        back="Vellaunus' Mantle +1"
    })
    sets.engaged.Mid.Haste_20 = set_combine(sets.engaged.Haste_20, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        back="Yokaze Mantle",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Acc.Haste_20 = set_combine(sets.engaged.Mid.Haste_20, {
        neck="Rancor Collar",
        hands="Buremte Gloves",
        ring1="Mars's Ring",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Evasion.Haste_20 = set_combine(sets.engaged.Haste_20, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_20 = set_combine(sets.engaged.Haste_20, sets.engaged.HastePDT)
    
    sets.buff.Migawari = {body="Iga Ningi +2"}
    
    -- Weaponskills 
    
    sets.precast.WS = {
        head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
        body="Mes'yohi Haubergeon",
        hands="Mochizuki Tekko +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt +1",
        legs="Manibozho Brais",
        feet="Mochizuki Kyahan +1"
    }

    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        head="Ptica Headgear",
        back="Yokaze Mantle",
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        hands="Buremte Gloves",
        ring1="Mars's Ring"
    })
    
    -- BLADE: JIN
    sets.Jin = {
        ammo="Yetshila",
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
        neck="Shadow Gorget",
        hands="Hachiya Tekko +1",
        ring1="Garuda Ring",
        back="Rancorous Mantle",
        legs="Otronif Brais +1",
        --legs="Mochizuki Hakama +1",
        waist="Windbuffet Belt +1",
        feet="Mochizuki Kyahan +1"
    }
    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, sets.Hi)

    sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {
        body="Mochizuki Chainmail +1",
        neck="Shadow Gorget",
        waist="Soil Belt"
    })
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'].Mid, {
        head="Ptica Headgear"
    })

    -- BLADE: SHUN
    sets.Shun = {
        ammo="Jukukik Feather",
        neck="Flame Gorget",
        waist="Light Belt",
        ring1="Ramuh Ring",
    }
    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, sets.Shun)
    sets.precast.WS['Blade: Shun'].Mid = set_combine(sets.precast.WS.Mid, sets.Shun)
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, sets.Shun)
    
    -- BLADE: Rin
    sets.Rin = {
        ammo="Aqreqaq Bomblet",
        neck="Asperity Necklace",
        waist="Metalsinger Belt",
    }
    sets.precast.WS['Blade: Rin'] = set_combine(sets.precast.WS, sets.Rin)
    sets.precast.WS['Blade: Rin'].Mid = set_combine(sets.precast.WS.Mid, sets.Rin)
    sets.precast.WS['Blade: Rin'].Acc = set_combine(sets.precast.WS.Acc, sets.Rin)
    
    -- BLADE: KU 
    sets.Ku = {
        ammo="Aqreqaq Bomblet",
        neck="Shadow Gorget",
        waist="Soil Belt",
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

