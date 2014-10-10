function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {
        head="Wakido Kabuto",
        hands="Saotome Kote +2",
        back={name="Takaha Mantle", augments={'STR+1','"Store TP"+1','"Zanshin"+1','Meditate eff. dur. +4'}},
    }
    sets.precast.JA.Seigan = {head="Unkai Kabuto +2"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto"}
    sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate"}
    --sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    sets.Berserker = {neck="Berserker's Torque"}
    sets.WSDayBonus     = { head="Gavialis Helm" }
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        --ammo="Paeapua",
        head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
        body="Phorcys Korazin",
        hands="Boor Bracelets",
        ring1="Ifrit Ring",
        ring2="Pyrosoul Ring",
        back="Buquwik Cape",
        waist="Windbuffet Belt +1",
        legs="Scuffler's Cosciales",
        feet="Ejekamal Boots"
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        head="Yaoyotl Helm",
        body="Sakonji Domaru +1"
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        ring2="Mars's Ring",
   	    body="Mes'yohi Haubergeon",
        hands="Mikinaak Gauntlets"
    })
    
    sets.precast.WS['Namas Arrow'] = {
        ammo=gear.RAarrow,
        head="Sakonji Kabuto +1",
        neck="Aqua Gorget",
        ear1="Flame Pearl",
        ear2="Flame Pearl",
        body="Phorcys Korazin",
        hands="Unkai Kote +2",
        back="Buquwik Cape",
        ring1="Ifrit Ring",
        ring2="Pyrosoul Ring",
        waist="Metalsinger Belt",
        legs="Wakido Haidate +1",
        feet="Wakido Sune-ate +1"
    }
    sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS['Namas Arrow'], {
        body="Kyujutsugi",
    })
    sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'].Mid, {
        ring1="Longshot Ring",
        ring2="Hajduk Ring"
    })
    
    sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS['Namas Arrow'], {
        neck="Breeze Gorget",
        body="Kyujutsugi",
        ring1="Stormsoul Ring",
        ring2="Garuda Ring"
    })
    sets.precast.WS['Apex Arrow'].Mid = sets.precast.WS['Apex Arrow']
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {
        ring1="Hajduk Ring",
        ring2="Longshot Ring"
    })
    
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
        neck="Aqua Gorget",
        waist="Metalsinger Belt"
    })
    sets.precast.WS['Tachi: Fudo'].Mid = set_combine(sets.precast.WS['Tachi: Fudo'], {
        head="Yaoyotl Helm",
        ring2="Mars's Ring",
   	    body="Mes'yohi Haubergeon",
        waist="Metalsinger Belt"
    })
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'].Mid, {
        body="Sakonji Domaru +1",
        waist="Light Belt",
        legs="Wukong's Hakama +1",
        feet="Wakido Sune-Ate +1"
    })
    
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
        neck="Breeze Gorget",
   	    body="Mes'yohi Haubergeon",
        feet="Ejekamal Boots",
        waist="Thunder Belt"
    })
    sets.precast.WS['Tachi: Shoha'].Mid = set_combine(sets.precast.WS.Acc, {
        head="Yaoyotl Helm",
        neck="Breeze Gorget",
        waist="Thunder Belt"
    })
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS['Tachi: Shoha'].Mid, {
        body="Sakonji Domaru +1",
        ring1="Mars's Ring",
        feet="Wakido Sune-Ate +1"
    })
    
    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        ear1="Bladeborn Earring",
   	    body="Mes'yohi Haubergeon",
        ear2="Steelflash Earring",
        hands="Mikinaak Gauntlets",
        waist="Soil Belt",
        feet="Sakonji Sune-Ate +1"
    })
    sets.precast.WS['Tachi: Rana'].Mid = set_combine(sets.precast.WS['Tachi: Rana'], {
        body="Sakonji Domaru +1"
    })
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {
        neck="Shadow Gorget",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        waist="Soil Belt",
        feet="Wakido Sune-Ate +1"
    })
    -- CHR Mod
    sets.precast.WS['Tachi: Ageha'] = {
        head="Sakonji Kabuto +1",
        neck="Justice Torque",
        body="Unkai Domaru +2",
        hands="Wakido Kote +1",
        ring1="Sangoma Ring",
        ring2="Ifrit Ring",
        back="Buquwik Cape",
        waist="Soil Belt",
        legs="Wakido Haidate +1",
        feet="Scamp's Sollerets"
    }
    sets.precast.WS['Tachi: Jinpu'] = sets.precast.WS['Tachi: Ageha']
    
    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Flame Gorget",waist="Light Belt"})
    
    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Aqua Gorget",waist="Windbuffet Belt +1"})
    
    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Breeze Gorget",waist="Windbuffet Belt +1"})
    
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Shadow Gorget",waist="Soil Belt"})
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
    	head="Otomi Helm",
        body="Kyujutsugi",
    	legs="Wakido Haidate +1",
        feet="Ejekamal Boots"
    }
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        head="Twilight Helm",
        body="Twilight Mail",
        ring2="Paguroidea Ring"
    }
    
    sets.idle.Town = {
        --main="Anahera Blade", 
        --sub="Pole Grip",
        head="Ptica Headgear",
        neck="Agitator's Collar",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
   	    body="Mes'yohi Haubergeon",
        hands="Wakido Kote +1",
        ring1="Oneiros Ring",
        ring2="Patricius Ring",
        back={name="Takaha Mantle", augments={'STR+3','"Store TP"+2','"Zanshin"+3'}},
        waist="Windbuffet Belt +1",
        legs="Scuffler's Cosciales",
        feet="Danzo Sune-ate"
    }
    
    sets.idle.Field = set_combine(sets.idle.Town, {
        neck="Twilight Torque",
        ring1="Patricius Ring",
        ring2="Paguroidea Ring",
        head="Ptica Headgear",
   	    body="Mes'yohi Haubergeon",
        back="Repulse Mantle",
        feet="Danzo Sune-ate"
    })

    sets.idle.Regen = set_combine(sets.idle.Town, {
        neck="Twilight Torque",
        ring1="Patricius Ring",
        ring2="Paguroidea Ring",
        head="Twilight Helm",
        body="Kumarbi's Akar",
        back="Repulse Mantle",
        feet="Danzo Sune-ate"
    })
    
    sets.idle.Weak = set_combine(sets.idle.Field, {
        head="Twilight Helm",
    	body="Twilight Mail"
    })
    sets.idle.Yoichi = set_combine(sets.idle.Field, {
    	ammo=gear.RAarrow
    })
    
    -- Defense sets
    sets.defense.PDT = {
        head="Lithelimb Cap",
        neck="Agitator's Collar",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Otronif Harness +1",
        hands="Otronif Gloves +1",
        ring1="Dark Ring",
        ring2="Patricius Ring",
        back="Repulse Mantle",
        waist="Windbuffet Belt +1",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }
    
    sets.defense.Reraise = set_combine(sets.defense.PDT, {
    	head="Twilight Helm",
    	body="Twilight Mail"
    })
    
    sets.defense.MDT = sets.defense.PDT
    
    sets.Kiting = {feet="Danzo Sune-ate"}
    
    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
    
    -- Engaged sets
    
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group 
    -- 4-hit
    -- Tsurumaru needs 49 stp w/ ionis 
    -- Anahera needs 52 stp anywhere 
    
    -- I generally use Anahera outside of Adoulin areas, so this set aims for 47 STP + 5 from Anahera (52 total)
    -- Note, this set assumes use of Cibitshavore (hence the arrow as ammo)
    sets.engaged = {
        --sub="Bloodrain Grip",
        ammo=gear.RAarrow,
        head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Sakonji Domaru +1",
        hands="Wakido Kote +1",
        ring1="Rajas Ring", 
        ring2="Oneiros Ring", 
        back={name="Takaha Mantle", augments={'STR+3','"Store TP"+2','"Zanshin"+3'}},
        waist="Windbuffet Belt +1",
        legs="Wakido Haidate +1",
        feet="Otronif boots +1"
    }
    
    sets.engaged.Mid = set_combine(sets.engaged, {
        head="Yaoyotl Helm",
   	    body="Mes'yohi Haubergeon",
        neck="Agitator's Collar",
        ring2="Ramuh Ring +1",
        feet="Sakonji Sune-Ate +1"
    })
    
    sets.engaged.Acc = set_combine(sets.engaged.Mid, { 
        head="Sakonji Kabuto +1",
        ear1="Zennaroi Earring",
        ring1="Mars's Ring",
        feet="Wakido Sune-Ate +1",
        legs="Xaddi Cuisses",
        back={name="Takaha Mantle", augments={'STR+3','"Store TP"+2','"Zanshin"+3'}},
    })
    
    sets.engaged['Anahera Blade'] = set_combine(sets.engaged, {
        body="Sakonji Domaru +1",
        ring2="Oneiros Ring"
    })
    sets.engaged['Anahera Blade'].Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged['Anahera Blade'].Acc = set_combine(sets.engaged.Acc, {})
    
    sets.engaged.Yoichi = set_combine(sets.engaged, { 
        sub="Bloodrain Strap",
        ammo=gear.RAarrow
    })
    
    sets.engaged.Yoichi.Mid = set_combine(sets.engaged.Yoichi, {
        head="Yaoyotl Helm",
   	    body="Mes'yohi Haubergeon",
        waist="Dynamic Belt",
        back={name="Takaha Mantle", augments={'STR+3','"Store TP"+2','"Zanshin"+3'}},
    })
    
    sets.engaged.Yoichi.Acc = set_combine(sets.engaged.Yoichi.Mid, {
        ring1="Oneiros Ring",
        ring2="Mars's Ring",
        feet="Wakido Sune-Ate +1"
    })
    
    sets.engaged.PDT = set_combine(sets.engaged, { 
        head="Lithelimb Cap", 
        neck="Agitator's Collar",
        ring1="Patricius Ring",
        back="Repulse Mantle",
        feet="Otronif boots +1"
    })
    
    sets.engaged.Yoichi.PDT = set_combine(sets.engaged.PDT,  {
        sub="Bloodrain Strap",
        ammo=gear.RAarrow
    })
    
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, { 
         head="Lithelimb Cap",
         neck="Agitator's Collar",
         ring1="Patricius Ring",
         ring2="Dark Ring"
    })
    
    sets.engaged.Reraise = set_combine(sets.engaged.PDT, {
        head="Twilight Helm", 
        body="Twilight Mail",
        ring2="Paguroidea Ring"
    })
    
    sets.engaged.Reraise.Yoichi = set_combine(sets.engaged.Reraise, {
        sub="Bloodrain Strap",
        ammo=gear.RAarrow
    })
    
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Reraise, {
        hands="Miki. Gauntlets",
        ring1="Patricius Ring",
        feet="Wakido Sune-Ate +1", 
        waist="Dynamic Belt"
    })
    
    sets.engaged.Acc.Reraise.Yoichi = set_combine(sets.engaged.Acc.Reraise, {
        sub="Bloodrain Strap",
        ammo=gear.RAarrow
    })
    	
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills and 1% gear haste. 
    -- Game flipped upside down. 31 STP needed to 4-hit?
    
    -- This set aims for Tsurumaru 4-hit. 21% DA, 4% TA, 1% QA 27% haste
    -- Assumes use of Cibitshavore
    sets.engaged.Adoulin = {
        --sub="Pole Grip",
        ammo=gear.RAarrow,
        head="Otomi Helm",
        neck="Asperity Necklace", -- 3
        ear1="Bladeborn Earring", -- 1 
        ear2="Steelflash Earring", -- 1
        body="Xaddi Mail", -- 3
        hands="Wakido Kote +1", -- 5
        ring1="Rajas Ring", -- 5
        ring2="K'ayres Ring", 
        back="Atheling Mantle",
        waist="Windbuffet Belt +1",
        legs="Wakido Haidate +1", -- 6
        feet="Otronif Boots +1" --7
    }
    sets.engaged.Adoulin.Mid = set_combine(sets.engaged.Adoulin, { -- 840.5 accuracy
        head="Yaoyotl Helm",
   	    body="Mes'yohi Haubergeon",
        ring1="Ramuh Ring +1",
        back={name="Takaha Mantle", augments={'STR+3','"Store TP"+2','"Zanshin"+3'}},
        legs="Xaddi Cuisses",
        feet="Ejekamal Boots"
    })
    
    sets.engaged.Adoulin.Acc = set_combine(sets.engaged.Adoulin.Mid, { 
        sub="Bloodrain Strap",
   	    body="Mes'yohi Haubergeon",
        neck="Agitator's Collar",
        ring2="Mars's Ring",
        waist="Olseni Belt",
        back={name="Takaha Mantle", augments={'STR+3','"Store TP"+2','"Zanshin"+3'}},
        legs="Xaddi Cuisses",
        feet="Wakido Sune-Ate +1"
    })
    
    sets.engaged.Adoulin.PDT = set_combine(sets.engaged.Adoulin, {
        head="Lithelimb Cap",
        neck="Agitator's Collar",
        body="Otronif Harness +1",
        hands="Otronif Gloves +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
        back="Repulse Mantle",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    })
    
    sets.engaged.Adoulin.Acc.PDT = set_combine(sets.engaged.Adoulin.Acc, {
        head="Lithelimb Cap",
        body="Otronif Harness +1",
        neck="Agitator's Collar",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    })
    
    -- Tsurumaru 4-hit 19% DA, 28% haste 
    sets.engaged.Adoulin.Yoichi = {
        --sub="Bloodrain Strap",
        ammo=gear.RAarrow,
        head="Otomi Helm",
        neck="Asperity Necklace", -- 3
        ear1="Bladeborn Earring", -- 1 
        ear2="Steelflash Earring", -- 1
        body="Xaddi Mail", -- 8
        hands="Wakido Kote +1", -- 5
        ring1="Rajas Ring", -- 5
        ring2="K'ayres Ring", -- 5
        back={name="Takaha Mantle", augments={'STR+3','"Store TP"+2','"Zanshin"+3'}},
        waist="Windbuffet Belt +1", 
        legs="Otronif Brais +1", -- 6
        feet="Otronif Boots +1" -- 7
    }
    
    sets.engaged.Adoulin.Yoichi.Mid = set_combine(sets.engaged.Adoulin.Yoichi, 
    {
        ammo=gear.RAarrow,
   	    body="Mes'yohi Haubergeon",
        head="Yaoyotl Helm",
        waist="Dynamic Belt",
        legs="Xaddi Cuisses",
        boots="Ejekamal Boots"
    })
    
    sets.engaged.Adoulin.Yoichi.Acc = set_combine(sets.engaged.Adoulin.Yoichi.Mid, {
        ammo=gear.RAarrow,
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        back={name="Takaha Mantle", augments={'STR+3','"Store TP"+2','"Zanshin"+3'}},
        feet="Wakido Sune-Ate +1"
    })
    
    sets.engaged.Adoulin.Yoichi.PDT = set_combine(sets.engaged.Adoulin.PDT, {
        sub="Bloodrain Strap",
        ammo=gear.RAarrow
    })
    
    sets.engaged.Adoulin.Yoichi.Acc.PDT = set_combine(sets.engaged.Adoulin.Yoichi.Acc, { 
        head="Lithelimb Cap",
        neck="Agitator's Collar",
        ring2="Dark Ring"
    })
    
    sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Adoulin, {
        head="Twilight Helm",
        body="Twilight Mail",
    })
    sets.engaged.Adoulin.Yoichi.Reraise = set_combine(sets.engaged.Adoulin.Reraise, {
        ammo=gear.RAarrow
    })
    sets.engaged.Adoulin.Acc.Reraise = set_combine(sets.engaged.Adoulin.Acc, {
        head="Twilight Helm",
        body="Twilight Mail"
    })
    sets.engaged.Adoulin.Yoichi.Acc.Reraise = set_combine(sets.engaged.Adoulin.Acc.Reraise, {
        ammo=gear.RAarrow
    })
    
    sets.engaged.Amanomurakumo = set_combine(sets.engaged, {
    })
    sets.engaged.Amanomurakumo.AM = set_combine(sets.engaged, {
    })
    
    sets.engaged.Adoulin.Amanomurakumo = set_combine(sets.engaged.Adoulin, {
    })
    sets.engaged.Adoulin.Amanomurakumo.AM = set_combine(sets.engaged.Adoulin, {
    })
    
    sets.engaged.Kogarasumaru = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM3 = set_combine(sets.engaged, {
    })
    
    sets.engaged.Adoulin.Kogarasumaru = set_combine(sets.engaged.Adoulin, {
    })
    sets.engaged.Adoulin.Kogarasumaru.AM = set_combine(sets.engaged.Adoulin, {
    })
    sets.engaged.Adoulin.Kogarasumaru.AM3 = set_combine(sets.engaged.Adoulin, {
    })
    
    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}
    
    sets.thirdeye = {head="Unkai Kabuto +2", legs="Sakonji Haidate"}
    sets.bow = {ammo=gear.RAarrow}
end
