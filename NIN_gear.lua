-- Define sets and vars used by this job file.
-- visualized at http://www.ffxiah.com/node/194
-- Happo
-- Hachiya
-- sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.HybridMode][classes.CustomMeleeGroups (any number)

-- Ninjutsu tips
-- To stick Slow (Hojo) lower earth resist with Raiton: Ni
-- To stick poison (Dokumori) or Attack down (Aisha) lower resist with Katon: Ni
-- To stick paralyze (Jubaku) lower resistence with Huton: Ni

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
    sets.precast.JA.Sange = { ammo=gear.SangeAmmo, body="Mochizuki Chainmail +1" }
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Uk'uxkaj Cap",
        body="Dread Jupon",
        hands="Umuthi Gloves",
        waist="Chaac Belt",
        legs="Nahtirah Trousers",
        feet="Mochizuki Kyahan +1"
    }
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.TreasureHunter = { waist="Chaac Belt" }
    sets.CapacityMantle = { back="Mecistopins Mantle" }
    sets.WSDayBonus     = { head="Gavialis Helm" }
    sets.WSBack         = { back="Trepidity Mantle" }
    sets.Rajas          = { ring1="Rajas Ring" }

    sets.RegularAmmo    = { ammo=gear.RegularAmmo }
    sets.SangeAmmo      = { ammo=gear.SangeAmmo }
    
    sets.NightAccAmmo   = { ammo="Ginsen" }
    sets.DayAccAmmo     = { ammo="Tengu-no-Hane" }

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        head="Gavialis Helm",
        body="Mes'yohi Haubergeon",
        neck="Iqabi Necklace",
        ear1="Zennaroi Earring",
        hands="Sasuke Tekko +1",
        back="Yokaze Mantle",
        ring1="Ramuh Ring +1",
        waist="Olseni Belt",
        legs="Wukong's Hakama +1",
        feet="Mochizuki Kyahan +1"
    }
    -- Ranged
    sets.precast.RA = {
        head="Uk'uxkaj Cap",
        hands="Manibozho Gloves",
        legs="Nahtirah Trousers",
        feet="Wurrukatte Boots"
    }
    sets.midcast.RA = {
        head="Umbani Cap",
        neck="Iqabi Necklace",
        body="Mochizuki Chainmail +1",
        hands="Hachiya Tekko +1",
        --ring1="Longshot Ring",
        ring2="Hajduk Ring",
        back="Yokaze Mantle",
        --waist="Hurling Belt",
        legs="Hachiya Hakama +1",
        feet="Scopuli Nails +1"
    }
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        body="Mekosuchinae Harness"
    })
    sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)
    
    -- Fast cast sets for spells
    sets.precast.FC = {
        --head="Uk'uxkaj Cap",
        ammo="Impatiens",
        ear1="Loquacious Earring",
        ring1="Prolix Ring",
        hands="Buremte Gloves",
        body="Dread Jupon",
        legs="Kaabnax Trousers",
        feet="Mochizuki Kyahan +1" -- special enhancement for casting ninjutsu III
    }
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads", body="Mochizuki Chainmail +1" })
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Impatiens",
        head="Uk'uxkaj Cap",
        body="Dread Jupon",
        ear1="Loquacious Earring",
        ring1="Prolix Ring",
        legs="Wukong's Hakama +1",
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
        neck="Stoicheion Medal",
        --neck="Ardor Pendant +1",
        body="Mekosuchinae Harness",
        hands="Mochizuki Tekko +1",
        ring1="Sangoma Ring",
        ring2="Perception Ring",
        back="Yokaze Mantle",
        waist="Koga Sarashi",
        legs="Wukong's Hakama +1",
        feet="Mochizuki Kyahan +1"
    }
    -- Nuking Ninjutsu (skill & magic attack)
    sets.midcast.ElementalNinjutsu = {
        head="Mochizuki Hatsuburi +1",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        neck="Stoicheion Medal",
        body="Mekosuchinae Harness",
        hands="Mochizuki Tekko +1",
        back="Aput Mantle",
        ring1="Sangoma Ring",
        ring2="Acumen Ring",
        waist="Caudata Belt",
        legs="Shneddick Tights +1",
        feet="Hachiya Kyahan +1"
    }
    
    sets.idle = {
        ammo=gear.RegularAmmo,
        head="Ptica Headgear",
        neck="Twilight Torque",
        ear1="Zennaroi Earring",
        ear2="Trux Earring",
        body="Hachiya Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Dark Ring",
        ring2="Patricius Ring",
    	back="Repulse Mantle",
        waist="Windbuffet Belt +1",
        legs="Hachiya Hakama +1",
        feet="Danzo Sune-ate"
     }

    sets.idle.Regen = set_combine(sets.idle, {
        head="Ocelomeh Headpiece +1",
        body="Kheper Jacket",
        ring2="Paguroidea Ring"
    })
    
    sets.idle.Town = set_combine(sets.idle, {
        neck="Hope Torque",
        ring1="Ramuh Ring +1",
        ring2="Epona's Ring",
        body="Mes'yohi Haubergeon",
        back="Yokaze Mantle"
    })
    
    sets.idle.Weak = sets.idle

    -- Defense sets
    sets.defense.PDT = {
        head="Otronif Mask +1",
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
        head="Ptica Headgear",
        neck="Twilight Torque",
        hands="Otronif Gloves +1",
        feet="Otronif Boots +1"
    })
    
    sets.DayMovement = {feet="Danzo sune-ate"}
    sets.NightMovement = {feet="Hachiya Kyahan +1"}

    -- Normal melee group without buffs
    sets.engaged = {
        ammo=gear.RegularAmmo,
        head="Ptica Headgear",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        body="Hachiya Chainmail +1",
        hands="Onimusha-no-kote",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Vellaunus' Mantle +1",
        waist="Shetal Stone",
        legs="Mochizuki Hakama +1",
        feet="Otronif Boots +1"
    }

    sets.engaged.Low = set_combine(sets.engaged, {
        body="Mochizuki Chainmail +1",
        neck="Rancor Collar",
        hands="Otronif Gloves +1",
        back="Yokaze Mantle",
        feet="Qaaxo Leggings"
    })

    sets.engaged.Mid = set_combine(sets.engaged.Low, {
        hands="Sasuke Tekko +1",
        ring1="Ramuh Ring +1",
        legs="Mochizuki Kyahan +1"
    })

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        neck="Iqabi Necklace",
        ring2="Mars's Ring",
        waist="Olseni Belt",
    })

    sets.engaged.LowDef = set_combine(sets.engaged, {
        hands="Otronif Gloves +1",
        ring1="Oneiros Ring"
    })
    sets.engaged.LowDef.Low = set_combine(sets.engaged.Low, {
        ring1="Oneiros Ring"
    })
    sets.engaged.LowDef.Mid = sets.engaged.Mid
    sets.engaged.LowDef.Acc = sets.engaged.Acc

    sets.engaged.NormalPDT = {
        head="Otronif Mask +1",
        body="Otronif Harness +1",
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        ring1="Patricius Ring",
        back="Repulse Mantle",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }
    sets.engaged.AccPDT = {
        head="Lithelimb Cap",
        body="Otronif Harness +1",
        neck="Agitator's Collar",
        hands="Umuthi Gloves",
        ring1="Patricius Ring",
        feet="Otronif Boots +1"
    }

    sets.engaged.PDT = set_combine(sets.engaged, sets.engaged.NormalPDT)
    sets.engaged.Low.PDT = set_combine(sets.engaged.Low, sets.engaged.NormalPDT)
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.engaged.NormalPDT)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.engaged.AccPDT)

    sets.engaged.LowDef.PDT = sets.engaged.PDT
    sets.engaged.LowDef.Low.PDT = sets.engaged.Low.PDT
    sets.engaged.LowDef.Mid.PDT = sets.engaged.Mid.PDT
    sets.engaged.LowDef.Acc.PDT = sets.engaged.Acc.PDT

    sets.engaged.HastePDT = {
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        body="Otronif Harness +1",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }

    -- Delay Cap from spell + songs alone
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
        head="Felistris Mask",
        ear1="Brutal Earring",
        ear2="Trux Earring",
        neck="Asperity Necklace",
        body="Mes'yohi Haubergeon",
        hands="Onimusha-no-kote",
        ring1="Rajas Ring",
        back="Bleating Mantle",
        waist="Windbuffet Belt +1",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    })
    sets.engaged.Low.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        head="Whirlpool Mask",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        neck="Rancor Collar",
        back="Yokaze Mantle",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, {
        hands="Sasuke Tekko +1",
        ring1="Ramuh Ring +1",
        legs="Wukong's Hakama +1",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {
        head="Gavialis Helm",
        neck="Iqabi Necklace",
        ear1="Zennaroi Earring",
        ear2="Trux Earring",
        ring2="Mars's Ring",
        waist="Olseni Belt"
    })
   
    -- Low monster defense (attack near cap)
    sets.engaged.LowDef.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        body="Thaumas Coat",
        hands="Otronif Gloves +1",
        ring1="Oneiros Ring"
    })
    sets.engaged.LowDef.Low.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, {
        body="Thaumas Coat",
        hands="Otronif Gloves +1",
        ring1="Oneiros Ring",
        feet="Otronif Boots +1"
    })
    sets.engaged.LowDef.Mid.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {
        feet="Qaaxo Leggings"
    })
    sets.engaged.LowDef.Acc.MaxHaste = sets.engaged.Acc.MaxHaste

    -- Defensive sets
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.NormalPDT)
    sets.engaged.Low.PDT.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, sets.engaged.NormalPDT)
    sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, sets.engaged.NormalPDT)
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, sets.engaged.AccPDT)
    
    sets.engaged.LowDef.PDT.MaxHaste = sets.engaged.PDT.MaxHaste
    sets.engaged.LowDef.Low.PDT.MaxHaste = sets.engaged.Low.PDT.MaxHaste
    sets.engaged.LowDef.Mid.PDT.MaxHaste = sets.engaged.Mid.PDT.MaxHaste
    sets.engaged.LowDef.Acc.PDT.MaxHaste = sets.engaged.Acc.PDT.MaxHaste

    -- Haste 40 to 43%
    sets.engaged.Haste_40 = set_combine(sets.engaged.MaxHaste, {
        ear1="Brutal Earring",
        ear2="Trux Earring",
        legs="Hachiya Hakama +1",
    })
    sets.engaged.Low.Haste_40 = set_combine(sets.engaged.Low.MaxHaste, {
        legs="Hachiya Hakama +1"
    })
    sets.engaged.Mid.Haste_40 = set_combine(sets.engaged.Mid.MaxHaste, {
        legs="Hachiya Hakama +1"
    })
    sets.engaged.Acc.Haste_40 = set_combine(sets.engaged.Acc.MaxHaste, { 
        legs="Hachiya Hakama +1"
    })

    -- attack capped sets 
    sets.engaged.LowDef.Haste_40 = set_combine(sets.engaged.LowDef.MaxHaste, {
        legs="Hachiya Hakama +1"
    })
    sets.engaged.LowDef.Low.Haste_40 = set_combine(sets.engaged.LowDef.Low.MaxHaste, {
        legs="Hachiya Hakama +1"
    })
    sets.engaged.LowDef.Mid.Haste_40 = sets.engaged.Mid.Haste_40
    sets.engaged.LowDef.Acc.Haste_40 = sets.engaged.Acc.Haste_40

    sets.engaged.PDT.Haste_40 = set_combine(sets.engaged.Haste_40, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_40 = set_combine(sets.engaged.Low.Haste_40, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_40 = set_combine(sets.engaged.Mid.Haste_40, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_40 = set_combine(sets.engaged.Acc.Haste_40, sets.engaged.AccPDT)
     
    sets.engaged.LowDef.PDT.Haste_40 = sets.engaged.PDT.Haste_40
    sets.engaged.LowDef.Low.PDT.Haste_40 = sets.engaged.Low.PDT.Haste_40
    sets.engaged.LowDef.Mid.PDT.Haste_40 = sets.engaged.Mid.PDT.Haste_40
    sets.engaged.LowDef.Acc.PDT.Haste_40 = sets.engaged.Acc.PDT.Haste_40

    -- 35% Haste
    sets.engaged.Haste_35 = set_combine(sets.engaged.Haste_40, {
        head="Ptica Headgear",
        legs="Mochizuki Hakama +1",
    })
    sets.engaged.Low.Haste_35 = set_combine(sets.engaged.Low.Haste_40, {
        head="Ptica Headgear",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Mid.Haste_40, {
        head="Ptica Headgear",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Acc.Haste_40, {
        head="Ptica Headgear",
        ear1="Zennaroi Earring",
        ear2="Steelflash Earring",
        legs="Hachiya Hakama +1"
    })
    
    sets.engaged.LowDef.Haste_35 = set_combine(sets.engaged.LowDef.Haste_40, {
        head="Ptica Headgear",
        neck="Asperity Necklace",
        back="Bleating Mantle",
        legs="Mochizuki Hakama +1",
        feet="Otronif Boots +1"
    })
    sets.engaged.LowDef.Low.Haste_35 = set_combine(sets.engaged.LowDef.Low.Haste_40, {
        head="Ptica Headgear",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.LowDef.Mid.Haste_35 = sets.engaged.Mid.Haste_35
    sets.engaged.LowDef.Acc.Haste_35 = sets.engaged.Acc.Haste_35

    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_35 = set_combine(sets.engaged.Low.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, sets.engaged.AccPDT)
    
    sets.engaged.LowDef.PDT.Haste_35 = sets.engaged.PDT.Haste_35
    sets.engaged.LowDef.Low.PDT.Haste_35 = sets.engaged.Low.PDT.Haste_35
    sets.engaged.LowDef.Mid.PDT.Haste_35 = sets.engaged.Mid.PDT.Haste_35
    sets.engaged.LowDef.Acc.PDT.Haste_35 = sets.engaged.Acc.PDT.Haste_35

    -- 30% Haste
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {
        head="Ptica Headgear",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Trux Earring",
        body="Mochizuki Chainmail +1",
        hands="Onimusha-no-kote",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Bleating Mantle",
        waist="Windbuffet Belt +1",
        legs="Mochizuki Hakama +1",
        feet="Otronif Boots +1",
    })
    sets.engaged.Low.Haste_30 = set_combine(sets.engaged.Low.Haste_35, {
        body="Mochizuki Chainmail +1"
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Mid.Haste_35, {
        body="Mochizuki Chainmail +1"
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_35, {
        ear1="Suppanomimi",
        ear2="Zennaroi Earring",
        body="Mochizuki Chainmail +1",
        legs="Hachiya Hakama +1"
    })
    
    sets.engaged.LowDef.Haste_30 = set_combine(sets.engaged.LowDef.Haste_35, {
        body="Mochizuki Chainmail +1",
    })
    sets.engaged.LowDef.Low.Haste_30 = set_combine(sets.engaged.LowDef.Low.Haste_35, {
        body="Mochizuki Chainmail +1",
    })
    sets.engaged.LowDef.Mid.Haste_30 = sets.engaged.Mid.Haste_30
    sets.engaged.LowDef.Acc.Haste_30 = sets.engaged.Acc.Haste_30

    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_30 = set_combine(sets.engaged.Low.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, sets.engaged.AccPDT)
    
    sets.engaged.LowDef.PDT.Haste_30 = sets.engaged.PDT.Haste_30
    sets.engaged.LowDef.Low.PDT.Haste_30 = sets.engaged.Low.PDT.Haste_30
    sets.engaged.LowDef.Mid.PDT.Haste_30 = sets.engaged.Mid.PDT.Haste_30
    sets.engaged.LowDef.Acc.PDT.Haste_30 = sets.engaged.Acc.PDT.Haste_30

    -- 25% Haste
    sets.engaged.Haste_25 = set_combine(sets.engaged.Haste_30, {
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        body="Mochizuki Chainmail +1",
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Low.Haste_25 = set_combine(sets.engaged.Low.Haste_30, {
        ear1="Brutal Earring",
        ear2="Suppanomimi"
    })
    sets.engaged.Mid.Haste_25 = set_combine(sets.engaged.Mid.Haste_30, {
        ear1="Brutal Earring",
        ear2="Suppanomimi"
    })
    sets.engaged.Acc.Haste_25 = set_combine(sets.engaged.Acc.Haste_30, {
        legs="Hachiya Hakama +1"
    })
    
    sets.engaged.LowDef.Haste_25 = set_combine(sets.engaged.LowDef.Haste_30, {
        ear2="Suppanomimi"
    })
    sets.engaged.LowDef.Low.Haste_25 = set_combine(sets.engaged.LowDef.Low.Haste_30, {
        ear2="Suppanomimi"
    })
    sets.engaged.LowDef.Mid.Haste_25 = sets.engaged.Mid.Haste_25
    sets.engaged.LowDef.Acc.Haste_25 = sets.engaged.Acc.Haste_25

    sets.engaged.PDT.Haste_25 = set_combine(sets.engaged.Haste_25, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_25 = set_combine(sets.engaged.Low.Haste_25, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_25 = set_combine(sets.engaged.Mid.Haste_25, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_25 = set_combine(sets.engaged.Acc.Haste_25, sets.engaged.AccPDT)
    
    sets.engaged.LowDef.PDT.Haste_25 = sets.engaged.PDT.Haste_25
    sets.engaged.LowDef.Low.PDT.Haste_25 = sets.engaged.Low.PDT.Haste_25
    sets.engaged.LowDef.Mid.PDT.Haste_25 = sets.engaged.Mid.PDT.Haste_25
    sets.engaged.LowDef.Acc.PDT.Haste_25 = sets.engaged.Acc.PDT.Haste_25
    
    -- 5 - 20% Haste 
    sets.engaged.Haste_20 = set_combine(sets.engaged.Haste_25, {
        back="Vellaunus' Mantle +1",
        waist="Patentia Sash"
    })
    sets.engaged.Low.Haste_20 = set_combine(sets.engaged.Low.Haste_25, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        back="Vellaunus' Mantle +1",
        waist="Patentia Sash"
    })
    sets.engaged.Mid.Haste_20 = set_combine(sets.engaged.Mid.Haste_25, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        waist="Patentia Sash"
    })
    sets.engaged.Acc.Haste_20 = set_combine(sets.engaged.Acc.Haste_25, {
        legs="Mochizuki Hakama +1"
    })
    
    sets.engaged.LowDef.Haste_20 = set_combine(sets.engaged.LowDef.Haste_25, {
        back="Vellaunus' Mantle +1",
        waist="Patentia Sash"
    })
    sets.engaged.LowDef.Low.Haste_20 = set_combine(sets.engaged.LowDef.Low.Haste_25, {
        back="Vellaunus' Mantle +1",
        waist="Patentia Sash"
    })
    sets.engaged.LowDef.Mid.Haste_20 = sets.engaged.Mid.Haste_20
    sets.engaged.LowDef.Acc.Haste_20 = sets.engaged.Acc.Haste_20

    sets.engaged.PDT.Haste_20 = set_combine(sets.engaged.Haste_20, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_20 = set_combine(sets.engaged.Low.Haste_20, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_20 = set_combine(sets.engaged.Mid.Haste_20, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_20 = set_combine(sets.engaged.Acc.Haste_20, sets.engaged.AccPDT)
    
    sets.engaged.LowDef.PDT.Haste_20 = sets.engaged.PDT.Haste_20
    sets.engaged.LowDef.Low.PDT.Haste_20 = sets.engaged.Low.PDT.Haste_20
    sets.engaged.LowDef.Mid.PDT.Haste_20 = sets.engaged.Mid.PDT.Haste_20
    sets.engaged.LowDef.Acc.PDT.Haste_20 = sets.engaged.Acc.PDT.Haste_20
    
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
        back="Yokaze Mantle",
        waist="Windbuffet Belt +1",
        legs="Manibozho Brais",
        feet="Mochizuki Kyahan +1"
    }

    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        head="Whirlpool Mask",
        hands="Sasuke Tekko +1",
        back="Yokaze Mantle",
    })
    sets.precast.WS.Low = sets.precast.WS.Mid
    
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        legs="Wukong's Hakama +1",
        ring1="Ramuh Ring +1"
    })

    sets.Kamu = {
        ammo="Ginsen",
        neck="Breeze Gorget",
        body="Dread Jupon",
        ring1="Ifrit Ring",
        back="Yokaze Mantle",
        waist="Windbuffet Belt +1",
        legs="Wukong's Hakama +1"
    }
    sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Low = set_combine(sets.precast.WS.Low, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Mid = set_combine(sets.precast.WS.Mid, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Acc = set_combine(sets.precast.WS.Acc, sets.Kamu, {waist="Caudata Belt"})
    
    -- BLADE: JIN
    sets.Jin = {
        ammo="Yetshila",
        neck="Breeze Gorget",
        waist="Thunder Belt",
        back="Yokaze Mantle",
    }
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, sets.Jin)
    sets.precast.WS['Blade: Jin'].Low = set_combine(sets.precast.WS.Low, sets.Jin)
    sets.precast.WS['Blade: Jin'].Mid = set_combine(sets.precast.WS.Mid, sets.Jin)
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS.Acc, sets.Jin)
    
    -- BLADE: HI

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
        ammo="Yetshila",
        neck="Shadow Gorget",
        head="Uk'uxkaj Cap",
        body="Dread Jupon",
        hands="Sasuke Tekko +1",
        ring1="Garuda Ring",
        back="Rancorous Mantle",
        legs="Otronif Brais +1",
        waist="Windbuffet Belt +1",
        feet="Mochizuki Kyahan +1"
    })

    sets.precast.WS['Blade: Hi'].Low = set_combine(sets.precast.WS['Blade: Hi'], {
        neck="Rancor Collar",
        back="Yokaze Mantle"
    })
    sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {
        head="Ptica Headgear",
        neck="Shadow Gorget",
        back="Yokaze Mantle",
        legs="Wukong's Hakama +1",
    })

    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'].Mid, {
        ear1="Trux Earring",
        waist="Soil Belt"
    })

    -- BLADE: SHUN
    sets.Shun = {
        head="Gavialis Helm",
        neck="Flame Gorget",
        waist="Light Belt",
        back="Yokaze Mantle",
        ring1="Ramuh Ring +1",
    }
    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, sets.Shun)
    sets.precast.WS['Blade: Shun'].Low = set_combine(sets.precast.WS.Low, sets.Shun)
    sets.precast.WS['Blade: Shun'].Mid = set_combine(sets.precast.WS.Mid, sets.Shun)
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, sets.Shun)
    
    -- BLADE: Rin
    sets.Rin = {
        neck="Rancor Collar",
        ring1="Rajas Ring",
        waist="Windbuffet Belt +1",
        back="Yokaze Mantle",
    }
    sets.precast.WS['Blade: Rin'] = set_combine(sets.precast.WS, sets.Rin)
    sets.precast.WS['Blade: Rin'].Low = set_combine(sets.precast.WS.Low, sets.Rin)
    sets.precast.WS['Blade: Rin'].Mid = set_combine(sets.precast.WS.Mid, sets.Rin)
    sets.precast.WS['Blade: Rin'].Acc = set_combine(sets.precast.WS.Acc, sets.Rin, {waist="Light Belt"})
    
    -- BLADE: KU 
    sets.Ku = {
        head="Gavialis Helm",
        ear2="Trux Earring",
        neck="Shadow Gorget",
        waist="Soil Belt",
    }
    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, sets.Ku)
    sets.precast.WS['Blade: Ku'].Low = set_combine(sets.precast.WS.Low, sets.Ku)
    sets.precast.WS['Blade: Ku'].Mid = set_combine(sets.precast.WS.Mid, sets.Ku)
    sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS.Acc, sets.Ku)
    
    sets.Ten = {
        head="Whirlpool Mask",
        ear2="Trux Earring",
        neck="Shadow Gorget",
        waist="Windbuffet Belt +1",
    }

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, sets.Ten)
    sets.precast.WS['Blade: Ten'].Low = set_combine(sets.precast.WS.Low, sets.Ten)
    sets.precast.WS['Blade: Ten'].Mid = set_combine(sets.precast.WS.Mid, sets.Ten)
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS.Acc, sets.Ten)
    
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        head="Umbani Cap",
        ear1="Crematio Earring",
        ear2="Moonshade Earring",
        neck="Stoicheion Medal",
        ring1="Garuda Ring",
        ring2="Acumen Ring",
        back="Argochampsa Mantle",
        legs="Shneddick Tights +1",
        waist="Thunder Belt",
        feet="Mochizuki Kyahan +1"
     })
    sets.precast.WS['Blade: Chi'] = sets.precast.WS['Aeolian Edge']
    sets.precast.WS['Blade: To'] = sets.precast.WS['Aeolian Edge']

end

