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
    TaeonHands = {}
    TaeonHands.TA = {name="Taeon Gloves", augments={'STR+9','Accuracy+22','"Triple Atk."+2'}}
    TaeonHands.DW = {name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}}

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = { legs="Mochizuki Hakama +1" }
    sets.precast.JA['Futae'] = { hands="Iga Tekko +2" }
    sets.precast.JA['Provoke'] = { 
        ear1="Friomisi Earring",
        ear2="Trux Earring", 
        body="Emet Harness +1",
        feet="Mochizuki Kyahan +1"
    }
    sets.precast.JA.Sange = { ammo=gear.SangeAmmo, body="Mochizuki Chainmail +1" }
    
    sets.reive = {neck="Ygnas's Resolve +1"}
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
    sets.BrutalLugra    = { ear1="Brutal Earring", ear2="Lugra Earring +1" }
    sets.BrutalTrux     = { ear1="Brutal Earring", ear2="Trux Earring" }
    sets.BrutalMoon     = { ear1="Brutal Earring", ear2="Moonshade Earring" }
    sets.Rajas          = { ring1="Rajas Ring" }

    sets.RegularAmmo    = { ammo=gear.RegularAmmo }
    sets.SangeAmmo      = { ammo=gear.SangeAmmo }
    
    sets.NightAccAmmo   = { ammo="Ginsen" }
    sets.DayAccAmmo     = { ammo="Tengu-no-Hane" }

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
        head="Gavialis Helm",
        body="Hattori Ningi +1",
        neck="Defiant Collar",
        ear1="Zennaroi Earring",
        hands="Sasuke Tekko +1",
        back="Yokaze Mantle",
        ring1="Mars's Ring",
        waist="Olseni Belt",
        legs="Taeon Tights",
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
        head="Taeon Chapeau",
        neck="Iqabi Necklace",
        body="Mochizuki Chainmail +1",
        hands="Hachiya Tekko +1",
        --ring1="Longshot Ring",
        ring2="Hajduk Ring",
        back="Yokaze Mantle",
        --waist="Hurling Belt",
        legs="Hachiya Hakama +1",
        feet="Taeon Boots"
    }
    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        body="Mekosuchinae Harness"
    })
    sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)
    
    -- Fast cast sets for spells
    sets.precast.FC = {
        head="Ejekamal Mask",
        ammo="Impatiens",
        ear1="Loquacious Earring",
        ring1="Prolix Ring",
        hands="Buremte Gloves",
        body="Dread Jupon",
        legs="Quiahuiz Trousers",
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
        feet="Mochizuki Kyahan +1"
    }
    -- Nuking Ninjutsu (skill & magic attack)
    sets.midcast.ElementalNinjutsu = {
        head="Mochizuki Hatsuburi +1",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        neck="Stoicheion Medal",
        body="Mekosuchinae Harness",
        hands=TaeonHands.TA,
        back="Aput Mantle",
        ring1="Shiva Ring",
        ring2="Acumen Ring",
        waist="Caudata Belt",
        legs="Shneddick Tights +1",
        feet="Hachiya Kyahan +1"
    }

    -- Effusions
    sets.precast.Effusion = {}
    sets.precast.Effusion.Lunge = sets.midcast.ElementalNinjutsu
    sets.precast.Effusion.Swipe = sets.midcast.ElementalNinjutsu
    
    sets.idle = {
        ammo=gear.RegularAmmo,
        head="Ptica Headgear",
        neck="Twilight Torque",
        ear1="Zennaroi Earring",
        ear2="Trux Earring",
        body="Emet Harness +1",
        hands="Otronif Gloves +1",
        ring1="Karieyh Ring",
        ring2="Dark Ring",
    	back="Engulfer Cape +1",
        waist="Flume Belt",
        legs="Otronif Brais +1",
        feet="Danzo Sune-ate"
     }

    sets.idle.Regen = set_combine(sets.idle, {
        head="Ocelomeh Headpiece +1",
        body="Kheper Jacket",
        ring2="Paguroidea Ring"
    })
    
    sets.idle.Town = set_combine(sets.idle, {
        head="Hattori Zukin +1",
        neck="Defiant Collar",
        ear1="Lugra Earring +1",
        ring1="Karieyh Ring",
        hands={name="Taeon Gloves", augments={'STR+9','Accuracy+22','"Triple Atk."+2'}},
        ring2="Ifrit Ring +1",
        body="Hattori Ningi +1",
        legs="Mochizuki Hakama +1",
        back="Yokaze Mantle",
        waist="Windbuffet Belt +1"
    })
    sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {
        body="Councilor's Garb"
    })
    
    sets.idle.Weak = sets.idle

    -- Defense sets
    sets.defense.PDT = {
        head="Otronif Mask +1",
        neck="Twilight Torque",
        body="Emet Harness +1",
        hands="Otronif Gloves +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
        back="Repulse Mantle",
        waist="Flume Belt",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }
    
    sets.defense.MDT = set_combine(sets.defense.PDT, {
        head="Ptica Headgear",
        neck="Twilight Torque",
        hands="Otronif Gloves +1",
        back="Engulfer Cape +1",
        feet="Otronif Boots +1"
    })
    
    sets.DayMovement = {feet="Danzo sune-ate"}
    sets.NightMovement = {feet="Hachiya Kyahan +1"}

    -- Normal melee group without buffs
    sets.engaged = {
        ammo=gear.RegularAmmo,
        head="Ptica Headgear",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        body="Mochizuki Chainmail +1",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
        back="Bleating Mantle",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1",
        feet="Taeon Boots"
    }
    -- assumptions made about target, Rancor no longer "OK" 
    sets.engaged.Low = set_combine(sets.engaged, {
        neck="Defiant Collar",
        ear1="Trux Earring",
        back="Yokaze Mantle"
    })

    sets.engaged.Mid = set_combine(sets.engaged.Low, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        ring1="Patricius Ring"
    })

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        hands={name="Taeon Gloves", augments={'STR+9','Accuracy+22','"Triple Atk."+2'}},
        ring2="Mars's Ring",
        waist="Olseni Belt",
    })
    
    sets.engaged.Innin = set_combine(sets.engaged, {
        head="Hattori Zukin +1",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        waist="Windbuffet Belt +1",
    })
    sets.engaged.Innin.Low = set_combine(sets.engaged.Innin, {
        back="Yokaze Mantle"
    })
    sets.engaged.Innin.Mid = set_combine(sets.engaged.Innin.Low, {
        ring1="Patricius Ring"
    })
    sets.engaged.Innin.Acc = sets.engaged.Acc

    -- Defenseive sets
    sets.NormalPDT = {
        head="Otronif Mask +1",
        body="Emet Harness +1",
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }
    sets.AccPDT = {
        head="Lithelimb Cap",
        body="Emet Harness +1",
        neck="Agitator's Collar",
        hands="Umuthi Gloves",
        ring1="Patricius Ring",
        feet="Otronif Boots +1"
    }

    sets.engaged.PDT = set_combine(sets.engaged, sets.NormalPDT)
    sets.engaged.Low.PDT = set_combine(sets.engaged.Low, sets.NormalPDT)
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.NormalPDT)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.AccPDT)

    sets.engaged.Innin.PDT = set_combine(sets.engaged.Innin, sets.NormalPDT, {head="Hattori Zukin +1"})
    sets.engaged.Innin.Low.PDT = set_combine(sets.engaged.Innin.Low, sets.NormalPDT, {head="Hattori Zukin +1"})
    sets.engaged.Innin.Mid.PDT = set_combine(sets.engaged.Innin.Mid, sets.NormalPDT, {head="Hattori Zukin +1"})
    sets.engaged.Innin.Acc.PDT = set_combine(sets.engaged.Innin.Acc, sets.AccPDT)

    sets.engaged.HastePDT = {
        neck="Agitator's Collar",
        hands="Otronif Gloves +1",
        body="Emet Harness +1",
        waist="Flume Belt",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }

    -- Delay Cap from spell + songs alone
    sets.engaged.MaxHaste = set_combine(sets.engaged, {
        head="Taeon Chapeau",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
        neck="Asperity Necklace",
        body="Hattori Ningi +1",
        hands="Otronif Gloves +1",
        ring1="Oneiros Ring",
        back="Bleating Mantle",
        waist="Windbuffet Belt +1",
        legs="Taeon Tights",
        feet="Taeon Boots"
    })
    -- Base set for hard content
    sets.engaged.Low.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        neck="Defiant Collar",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        ring1="Rajas Ring",
        hands={name="Taeon Gloves", augments={'STR+9','Accuracy+22','"Triple Atk."+2'}},
    })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, {
        ring1="Patricius Ring",
        back="Yokaze Mantle",
    })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {
        head="Gavialis Helm",
        ear1="Zennaroi Earring",
        ear2="Trux Earring",
        ring2="Mars's Ring",
        waist="Olseni Belt"
    })
    -- do nothing here
    sets.engaged.Innin.MaxHaste     = sets.engaged.MaxHaste
    sets.engaged.Innin.Low.MaxHaste = sets.engaged.Low.MaxHaste
    sets.engaged.Innin.Mid.MaxHaste = sets.engaged.Mid.MaxHaste
    sets.engaged.Innin.Acc.MaxHaste = sets.engaged.Acc.MaxHaste
   
    -- Defensive sets
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.NormalPDT)
    sets.engaged.Low.PDT.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, sets.NormalPDT)
    sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, sets.NormalPDT)
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, sets.AccPDT)
    
    sets.engaged.Innin.PDT.MaxHaste = set_combine(sets.engaged.Innin.MaxHaste, sets.NormalPDT)
    sets.engaged.Innin.Low.PDT.MaxHaste = set_combine(sets.engaged.Innin.Low.MaxHaste, sets.NormalPDT)
    sets.engaged.Innin.Mid.PDT.MaxHaste = set_combine(sets.engaged.Innin.Mid.MaxHaste, sets.NormalPDT)
    sets.engaged.Innin.Acc.PDT.MaxHaste = sets.engaged.Acc.PDT.MaxHaste
    
    -- 35% Haste 
    sets.engaged.Haste_35 = set_combine(sets.engaged.MaxHaste, {
        head="Ptica Headgear",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        hands={name="Taeon Gloves", augments={'STR+9','Accuracy+22','"Triple Atk."+2'}},
    })
    sets.engaged.Low.Haste_35 = set_combine(sets.engaged.Low.MaxHaste, {
        head="Ptica Headgear",
        neck="Defiant Collar",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Mid.MaxHaste, {
        head="Ptica Headgear",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Acc.MaxHaste, {
        head="Ptica Headgear",
        ear1="Zennaroi Earring",
        ear2="Steelflash Earring",
    })

    sets.engaged.Innin.Haste_35 = set_combine(sets.engaged.Haste_35, {
        head="Hattori Zukin +1",
    })
    sets.engaged.Innin.Low.Haste_35 = set_combine(sets.engaged.Low.Haste_35, {
        head="Hattori Zukin +1",
    })
    sets.engaged.Innin.Mid.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, {
        head="Hattori Zukin +1",
    })
    sets.engaged.Innin.Acc.Haste_35 = sets.engaged.Acc.Haste_35
    
    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_35 = set_combine(sets.engaged.Low.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, sets.engaged.AccPDT)
    
    sets.engaged.Innin.PDT.Haste_35 = set_combine(sets.engaged.Innin.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Innin.Low.PDT.Haste_35 = set_combine(sets.engaged.Innin.Low.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Innin.Mid.PDT.Haste_35 = set_combine(sets.engaged.Innin.Mid.Haste_35, sets.engaged.HastePDT)
    sets.engaged.Innin.Acc.PDT.Haste_35 = sets.engaged.Acc.PDT.Haste_35
    
    -- 30% Haste
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {
        head="Ptica Headgear",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        body="Mochizuki Chainmail +1",
        hands={name="Taeon Gloves", augments={'STR+9','Accuracy+22','"Triple Atk."+2'}},
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
        back="Bleating Mantle",
        waist="Windbuffet Belt +1",
        legs="Taeon Tights",
        feet="Taeon Boots"
    })
    sets.engaged.Low.Haste_30 = set_combine(sets.engaged.Low.Haste_35, {
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        neck="Defiant Collar",
        body="Mochizuki Chainmail +1",
        hands={name="Taeon Gloves", augments={'STR+9','Accuracy+22','"Triple Atk."+2'}},
        back="Yokaze Mantle"
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Mid.Haste_35, {
        ear1="Trux Earring",
        body="Mochizuki Chainmail +1",
        back="Yokaze Mantle"
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_35, {
        ear2="Suppanomimi",
        ear1="Zennaroi Earring",
        body="Mochizuki Chainmail +1",
        ring1="Patricius Ring",
        legs="Hachiya Hakama +1"
    })

    sets.engaged.Innin.Haste_30 = set_combine(sets.engaged.Haste_30, {
        head="Hattori Zukin +1",
        body="Hattori Ningi +1",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
    })
    sets.engaged.Innin.Low.Haste_30 = set_combine(sets.engaged.Low.Haste_30, {
        head="Hattori Zukin +1",
        body="Hattori Ningi +1",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
    })
    sets.engaged.Innin.Mid.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
        head="Hattori Zukin +1",
        body="Hattori Ningi +1",
        waist="Patentia Sash"
    })
    sets.engaged.Innin.Acc.Haste_30 = sets.engaged.Acc.Haste_30
    
    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_30 = set_combine(sets.engaged.Low.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, sets.engaged.AccPDT)
    
    sets.engaged.Innin.PDT.Haste_30 = set_combine(sets.engaged.Innin.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Innin.Low.PDT.Haste_30 = set_combine(sets.engaged.Innin.Low.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Innin.Mid.PDT.Haste_30 = set_combine(sets.engaged.Innin.Mid.Haste_30, sets.engaged.HastePDT)
    sets.engaged.Innin.Acc.PDT.Haste_30 = sets.engaged.Acc.PDT.Haste_30
    

    -- 5 - 20% Haste 
    sets.engaged.Haste_15 = set_combine(sets.engaged.Haste_30, {
        head="Ptica Headgear",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
        back="Bleating Mantle",
        waist="Patentia Sash",
    })
    sets.engaged.Low.Haste_15 = set_combine(sets.engaged.Low.Haste_30, {
        back="Yokaze Mantle",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
        waist="Patentia Sash"
    })
    sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Mid.Haste_30, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
        waist="Patentia Sash"
    })
    sets.engaged.Acc.Haste_15 = set_combine(sets.engaged.Acc.Haste_30, {
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
        legs="Taeon Tights",
        waist="Patentia Sash"
    })
    
    sets.engaged.Innin.Haste_15 = set_combine(sets.engaged.Haste_15, {
        head="Hattori Zukin +1",
    })
    sets.engaged.Innin.Low.Haste_15 = set_combine(sets.engaged.Low.Haste_15, {
        head="Hattori Zukin +1",
    })
    sets.engaged.Innin.Mid.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, {
        head="Hattori Zukin +1",
    })
    sets.engaged.Innin.Acc.Haste_15 = sets.engaged.Acc.Haste_15
    
    sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Low.PDT.Haste_15 = set_combine(sets.engaged.Low.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Acc.Haste_15, sets.engaged.AccPDT)
    
    sets.engaged.Innin.PDT.Haste_15 = set_combine(sets.engaged.Innin.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Innin.Low.PDT.Haste_15 = set_combine(sets.engaged.Innin.Low.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Innin.Mid.PDT.Haste_15 = set_combine(sets.engaged.Innin.Mid.Haste_15, sets.engaged.HastePDT)
    sets.engaged.Innin.Acc.PDT.Haste_15 = sets.engaged.Acc.PDT.Haste_15
    
    sets.buff.Migawari = {body="Hattori Ningi +1"}
    
    -- Weaponskills 
    sets.precast.WS = {
        head="Taeon Chapeau",
        neck="Defiant Collar",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
        body="Hattori Ningi +1",
        hands={name="Taeon Gloves", augments={'STR+9','Accuracy+22','"Triple Atk."+2'}},
        ring1="Karieyh Ring",
        ring2="Epona's Ring",
        back="Yokaze Mantle",
        waist="Windbuffet Belt +1",
        legs="Taeon Tights",
        feet="Taeon Boots"
    }

    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        head="Gavialis Helm",
    })
    sets.precast.WS.Low = sets.precast.WS.Mid
    
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        legs="Taeon Tights",
    })

    sets.Kamu = {
        ammo="Ginsen",
        neck="Breeze Gorget",
        body="Dread Jupon",
        ring1="Karieyh Ring",
        ring2="Ifrit Ring +1",
        back="Yokaze Mantle",
        waist="Windbuffet Belt +1",
    }
    sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Low = set_combine(sets.precast.WS.Low, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Mid = set_combine(sets.precast.WS.Mid, sets.Kamu)
    sets.precast.WS['Blade: Kamu'].Acc = set_combine(sets.precast.WS.Acc, sets.Kamu, {waist="Caudata Belt"})
    
    -- BLADE: JIN
    sets.Jin = {
        head="Taeon Chapeau",
        ammo="Yetshila",
        neck="Rancor Collar",
        body="Dread Jupon",
        ring1="Ifrit Ring +1",
        waist="Windbuffet Belt +1",
        back="Yokaze Mantle",
    }
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, sets.Jin)
    sets.precast.WS['Blade: Jin'].Low = set_combine(sets.precast.WS['Blade: Jin'], {
        neck="Breeze Gorget",
        waist="Thunder Belt",
    })
    sets.precast.WS['Blade: Jin'].Mid = set_combine(sets.precast.WS['Blade: Jin'].Low, {
        head="Gavialis Helm",
        body="Mes'yohi Haubergeon"
    })
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS['Blade: Jin'].Mid, {
        ring1="Karieyh Ring",
        legs="Taeon Tights",
    })
    
    -- BLADE: HI
    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
        ammo="Yetshila",
        head="Uk'uxkaj Cap",
        neck="Hope Torque",
        body="Hattori Ningi +1",
        hands="Sasuke Tekko +1",
        ring1="Karieyh Ring",
        back="Rancorous Mantle",
        waist="Windbuffet Belt +1",
        feet="Taeon Boots"
    })

    sets.precast.WS['Blade: Hi'].Low = set_combine(sets.precast.WS['Blade: Hi'], {
        neck="Shadow Gorget",
        back="Yokaze Mantle"
    })
    sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {
        head="Ptica Headgear",
        neck="Shadow Gorget",
        waist="Caudata Belt",
        back="Yokaze Mantle",
    })

    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'].Mid, {
        ear1="Trux Earring",
        legs="Taeon Tights",
    })
    
    -- BLADE: SHUN
    sets.Shun = {
        head="Gavialis Helm",
        neck="Flame Gorget",
        ear2="Trux Earring",
        hands="Mochizuki Tekko +1",
        ring1="Ramuh Ring",
        back="Yokaze Mantle",
        waist="Light Belt",
        legs="Taeon Tights",
        feet="Taeon Boots"
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
        head="Felistris Mask",
        ear2="Trux Earring",
        body="Dread Jupon",
        neck="Shadow Gorget",
        waist="Metalsinger Belt",
    }
    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, sets.Ku)
    sets.precast.WS['Blade: Ku'].Low = set_combine(sets.precast.WS['Blade: Ku'], {
        head="Gavialis Helm",
        body="Hattori Ningi +1",
        waist="Soil Belt"
    })
    sets.precast.WS['Blade: Ku'].Mid = sets.precast.WS['Blade: Ku'].Low
    sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS['Blade: Ku'].Mid, {
        legs="Taeon Tights",
        feet="Mochizuki Kyahan +1"
    })
    
    sets.Ten = {
        head="Felistris Mask",
        neck="Shadow Gorget",
        body="Dread Jupon",
        waist="Metalsinger Belt",
    }

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, sets.Ten)
    sets.precast.WS['Blade: Ten'].Low = set_combine(sets.precast.WS['Blade: Ten'], {
        head="Gavialis Helm",
        body="Mes'yohi Haubergeon",
    })
    sets.precast.WS['Blade: Ten'].Mid = set_combine(sets.precast.WS['Blade: Ten'].Low, {
        waist="Caudata Belt"
    })
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'].Mid, {
        legs="Taeon Tights",
        feet="Mochizuki Kyahan +1"
    })
    
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        head="Mochizuki Hatsuburi +1",
        ear1="Friomisi Earring",
        neck="Stoicheion Medal",
        body="Mekosuchinae Harness",
        ring1="Garuda Ring",
        ring2="Acumen Ring",
        back="Argochampsa Mantle",
        legs="Shneddick Tights +1",
        waist="Thunder Belt",
        feet="Hachiya Kyahan +1"
     })
    sets.precast.WS['Blade: Chi'] = set_combine(sets.precast.WS['Aeolian Edge'], {
        ring1="Shiva Ring",
        ring2="Acumen Ring",
        waist="Caudata Belt",
        legs="Shneddick Tights +1",
        back="Toro Cape",
        feet="Hachiya Kyahan +1"
    })
    sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']

end

