-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--Ionis Zones
--Anahera Blade (4 hit): 52
--Tsurumaru (4 hit): 49
--Kogarasumaru (or generic 450 G.katana) (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Non Ionis Zones:
--Anahera Blade (4 hit): 52
--Tsurumaru (5 hit): 24
--Kogarasumaru (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Aftermath sets
-- Koga AM1/AM2 = sets.engaged.Kogarasumaru.AM
-- Koga AM3 = sets.engaged.Kogarasumaru.AM3
-- Amano AM = sets.engaged.Amanomurakumo.AM
-- Using Namas Arrow while using Amano will cancel STPAM set

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
    get_combat_form()
    --get_combat_weapon()
    update_melee_groups()
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    state.YoichiAM = M(false, 'Cancel Yoichi AM Mode')
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Tachi: Fudo', 'Tachi: Shoha'}

    gear.RAarrow = {name="Eminent Arrow"}
    LugraWSList = S{'Tachi: Fudo', 'Tachi: Shoha', 'Namas Arrow'}

    state.Buff.Sekkanoki = buffactive.sekkanoki or false
    state.Buff.Sengikori = buffactive.sengikori or false
    state.Buff['Third Eye'] = buffactive['Third Eye'] or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    -- Additional local binds
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    send_command('bind != gs c toggle CapacityMode')
    
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^[')
    send_command('unbind !=')
    send_command('unbind ![')
end

--[[
-- SC's
Rana > Shoha > Fudo > Kasha > Shoha > Fudo - light
Rana > Shoha > Fudo > Kasha > Rana > Fudo - dark

Kasha > Shoha > Fudo
Fudo > Kasha > Shoha > fudo
Shoha > Fudo > Kasha > Shoha > Fudo

--]]
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    Acro = {}
    Acro.Hands = {}
    Acro.Feet = {}
    
    Acro.Hands.Haste = {name="Acro gauntlets", augments={'STR+3 AGI+3','Accuracy+18 Attack+18','Haste+2'}} 
    Acro.Hands.STP = {name="Acro gauntlets", augments={'Accuracy+19 Attack+19','"Store TP"+5','Weapon skill damage +3%'}}

    Acro.Feet.STP = {name="Acro Leggings", augments={'STR+7 AGI+7','Accuracy+17 Attack+17','"Store TP"+6'}} 
    Acro.Feet.WSD = {name="Acro Leggings", augments={'Accuracy+18 Attack+18','"Dbl. Atk."+3','Weapon skill damage +2%'}} 
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {
        head="Wakido Kabuto",
        hands="Saotome Kote +2",
        back="Takaha Mantle",
    }
    sets.precast.JA.Seigan = {head="Unkai Kabuto +2"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto"}
    sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate"}
    --sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    sets.Organizer = {
        main="Tsurumaru",
        sub="Bloodrain Strap",
        range="Yoichinoyumi",
        ammo="Cibitshavore",
        hands="Acro Gauntlets",
        feet="Acro Leggings",
        back="Takaha Mantle"
    }
    	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.CapacityMantle  = { back="Mecistopins Mantle" }
    --sets.Berserker       = { neck="Berserker's Torque" }
    sets.WSDayBonus      = { head="Gavialis Helm" }
    sets.LugraMoonshade  = { ear1="Lugra Earring +1", ear2="Moonshade Earring" }
    sets.BrutalMoonshade = { ear1="Brutal Earring", ear2="Moonshade Earring" }
    sets.LugraFlame      = { ear1="Lugra Earring +1", ear2="Flame Pearl" }
    sets.FlameFlame      = { ear1="Flame Pearl", ear2="Flame Pearl" }
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        --ammo="Paeapua",
        head="Rao Kabuto",
        neck="Ganesha's Mala",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
        body="Acro Surcoat",
        hands="Mikinaak Gauntlets",
        ring1="Karieyh Ring",
        ring2="Ifrit Ring +1",
        back="Buquwik Cape",
        waist="Windbuffet Belt +1",
        legs="Scuffler's Cosciales",
        feet=Acro.Feet.WSD
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        head="Rao Kabuto",
        body="Sakonji Domaru +1",
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        ring2="Mars's Ring",
        hands="Mikinaak Gauntlets"
    })
    
    sets.precast.WS['Namas Arrow'] = {
        ammo=gear.RAarrow,
        head="Sakonji Kabuto +1",
        neck="Aqua Gorget",
        ear1="Flame Pearl",
        ear2="Flame Pearl",
        body="Acro Surcoat",
        hands=Acro.Hands.STP,
        back="Buquwik Cape",
        ring1="Karieyh Ring",
        ring2="Ifrit Ring +1",
        waist="Metalsinger Belt",
        legs="Wakido Haidate +1",
        feet="Wakido Sune-ate +1"
    }
    sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS['Namas Arrow'], {
        body="Kyujutsugi",
    })
    sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'].Mid, {
        ring2="Hajduk Ring"
    })
    
    sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS['Namas Arrow'], {
        neck="Breeze Gorget",
        body="Kyujutsugi",
        ring2="Garuda Ring"
    })
    sets.precast.WS['Apex Arrow'].Mid = sets.precast.WS['Apex Arrow']
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {
        ring2="Longshot Ring"
    })
    
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
        neck="Aqua Gorget",
        body="Phorcys Korazin",
        hands=Acro.Hands.STP,
        waist="Metalsinger Belt",
        legs="Kasuga Haidate +1",
    })
    sets.precast.WS['Tachi: Fudo'].Mid = set_combine(sets.precast.WS['Tachi: Fudo'], {
        head="Rao Kabuto",
        body="Acro Surcoat",
        --waist="Light Belt"
    })
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'].Mid, {
        body="Acro Surcoat",
        back="Takaha Mantle"
    })
    
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
        neck="Breeze Gorget",
   	    body="Acro Surcoat",
        waist="Thunder Belt"
    })
    sets.precast.WS['Tachi: Shoha'].Mid = set_combine(sets.precast.WS.Acc, {
        head="Rao Kabuto",
        neck="Breeze Gorget",
        waist="Thunder Belt"
    })
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS['Tachi: Shoha'].Mid, {
        body="Sakonji Domaru +1",
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
        head="Rao Kabuto",
        neck="Defiant Collar",
        --body="Unkai Domaru +2",
        hands="Wakido Kote +1",
        ring2="Ifrit Ring +1",
        back="Buquwik Cape",
        waist="Soil Belt",
        legs="Wakido Haidate +1",
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
        head="Rao Kabuto",
        neck="Ganesha's Mala",
        ear1="Lugra Earring +1",
        ear2="Tripudio Earring",
        body="Councilor's Garb",
        hands="Ryuo Tekko",
        ring1="Karieyh Ring",
        ring2="Ifrit Ring +1",
        back="Bleating Mantle",
        waist="Windbuffet Belt +1",
        legs="Kasuga Haidate +1",
        feet="Danzo Sune-ate"
    }
    sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {
        body="Councilor's Garb"
    })
    
    sets.idle.Field = set_combine(sets.idle.Town, {
        neck="Lissome Necklace",
        ring2="Patricius Ring",
        ear1="Zennaroi Earring",
        ear2="Lugra Earring +1",
   	    body="Founder's Breastplate",
        hands="Crusher Gauntlets",
        back="Engulfer Cape +1",
        waist="Flume Belt",
        feet="Danzo Sune-ate"
    })

    sets.idle.Regen = set_combine(sets.idle.Town, {
        neck="Twilight Torque",
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
        head="Otronif Mask +1",
        neck="Agitator's Collar",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
   	    body="Founder's Breastplate",
        hands="Otronif Gloves +1",
        ring1="Dark Ring",
        ring2="Patricius Ring",
        back="Repulse Mantle",
        waist="Flume Belt",
        legs="Otronif Brais +1",
        feet="Otronif Boots +1"
    }
    
    sets.defense.Reraise = set_combine(sets.defense.PDT, {
    	head="Twilight Helm",
    	body="Twilight Mail"
    })
    
    sets.defense.MDT = set_combine(sets.defense.PDT, {
         neck="Twilight Torque",
         back="Engulfer Cape +1"
    })
    
    sets.Kiting = {feet="Danzo Sune-ate"}
    
    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
    
    -- Engaged sets
    
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- I generally use Anahera outside of Adoulin areas, so this set aims for 47 STP + 5 from Anahera (52 total)
    -- Note, this set assumes use of Cibitshavore (hence the arrow as ammo)
    sets.engaged = {
        sub="Bloodrain Grip",
        ammo=gear.RAarrow,
        head="Otomi Helm",
        neck="Ganesha's Mala",
        ear1="Brutal Earring",
        ear2="Lugra Earring +1",
        body="Vatic Byrnie",
        hands=Acro.Hands.STP,
        ring1="Rajas Ring", 
        ring2="K'ayres Ring", 
        back="Takaha Mantle",
        waist="Windbuffet Belt +1",
        legs="Kasuga Haidate +1",
        feet=Acro.Feet.STP
    }
    
    sets.engaged.Mid = set_combine(sets.engaged, {
        head="Acro Helm",
        body="Acro Surcoat",
        hands="Ryuo Tekko",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        feet="Loyalist Sabatons"
    })
    
    sets.engaged.Acc = set_combine(sets.engaged.Mid, { 
        head="Gavialis Helm",
        neck="Lissome Necklace",
        body="Mes'yohi Haubergeon",
        ear1="Zennaroi Earring",
        ring1="Mars's Ring",
        legs="Acro Breeches",
    })
    
    sets.engaged.Yoichi = set_combine(sets.engaged, { 
        sub="Bloodrain Strap",
        ammo=gear.RAarrow
    })
    
    sets.engaged.Yoichi.Mid = set_combine(sets.engaged.Yoichi, {
        head="Acro Helm",
        back="Takaha Mantle",
        neck="Lissome Necklace",
        hands=Acro.Hands.Haste
    })
    
    sets.engaged.Yoichi.Acc = set_combine(sets.engaged.Yoichi.Mid, {
        neck="Lissome Necklace",
        ear1="Zennaroi Earring",
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        legs="Acro Breeches",
        feet=Acro.Feet.WSD
    })
    
    sets.engaged.PDT = set_combine(sets.engaged, { 
        head="Otronif Mask +1", 
   	    body="Founder's Breastplate",
        neck="Agitator's Collar",
        hands="Crusher Gauntlets",
        ring1="Patricius Ring",
        back="Repulse Mantle",
        waist="Flume Belt",
        feet="Loyalist Sabatons"
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
        neck="Ganesha's Mala", -- 3
        ear1="Brutal Earring", -- 1 
        ear2="Trux Earring", -- 1
        body="Acro Surcoat", -- 3
        hands=Acro.Hands.STP,
        ring1="Rajas Ring", -- 5
        ring2="Oneiros Ring", 
        back="Takaha Mantle",
        waist="Windbuffet Belt +1",
        legs="Kasuga Haidate +1",
        feet=Acro.Feet.WSD
    }
    sets.engaged.Adoulin.Mid = set_combine(sets.engaged.Adoulin, { -- 840.5 accuracy
        head="Acro Helm",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        hands=Acro.Hands.Haste,
    })
    
    sets.engaged.Adoulin.Acc = set_combine(sets.engaged.Adoulin.Mid, { 
        head="Acro Helm",
        neck="Defiant Collar",
        ring2="Mars's Ring",
        hands=Acro.Hands.Haste,
        waist="Olseni Belt",
        back="Takaha Mantle",
        legs="Acro Breeches",
        feet=Acro.Feet.STP
    })
    
    sets.engaged.Adoulin.PDT = set_combine(sets.engaged.Adoulin, {
        head="Otronif Mask +1",
        neck="Agitator's Collar",
   	    body="Founder's Breastplate",
        hands="Otronif Gloves +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
        back="Repulse Mantle",
        legs="Otronif Brais +1",
        feet="Loyalist Sabatons"
    })
    
    sets.engaged.Adoulin.Acc.PDT = set_combine(sets.engaged.Adoulin.Acc, {
        head="Lithelimb Cap",
        neck="Agitator's Collar",
        ring1="Patricius Ring",
        legs="Otronif Brais +1",
        feet="Loyalist Sabatons"
    })
    
    -- Tsurumaru 4-hit 19% DA, 28% haste 
    sets.engaged.Adoulin.Yoichi = {
        --sub="Bloodrain Strap",
        ammo=gear.RAarrow,
        head="Otomi Helm",
        neck="Asperity Necklace", -- 3
        ear1="Bladeborn Earring", -- 1 
        ear2="Steelflash Earring", -- 1
        body="Acro Surcoat", -- 8
        hands="Wakido Kote +1", -- 5
        ring1="Rajas Ring", -- 5
        ring2="K'ayres Ring", -- 5
        back="Takaha Mantle",
        waist="Windbuffet Belt +1", 
        legs="Otronif Brais +1", -- 6
        feet="Otronif Boots +1" -- 7
    }
    
    sets.engaged.Adoulin.Yoichi.Mid = set_combine(sets.engaged.Adoulin.Yoichi, 
    {
        ammo=gear.RAarrow,
   	    body="Mes'yohi Haubergeon",
        head="Yaoyotl Helm",
        legs="Acro Breeches",
        boots="Ejekamal Boots"
    })
    
    sets.engaged.Adoulin.Yoichi.Acc = set_combine(sets.engaged.Adoulin.Yoichi.Mid, {
        ammo=gear.RAarrow,
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        back="Takaha Mantle",
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
    sets.seigan = {hands="Otronif Gloves +1"}
    sets.bow = {ammo=gear.RAarrow}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		-- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
		if player.equipment.main =='Nativus Halberd' or player.equipment.main =='Quint Spear' then
			if spell.english:startswith("Tachi:") then
				send_command('@input /ws "Stardiver" '..spell.target.raw)
				eventArgs.cancel = true
			end
		end
	end
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    --if spell.english == 'Third Eye' and not buffactive.Seigan then
    --    cancel_spell()
    --    send_command('@wait 0.5;input /ja Seigan <me>')
    --    send_command('@wait 1;input /ja "Third Eye" <me>')
    --end
end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        if is_sc_element_today(spell) then
            if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
            else
                equip(sets.WSDayBonus)
            end
        end
        if LugraWSList:contains(spell.english) then
            if world.time >= (17*60) or world.time <= (7*60) then
                if spell.english:lower() == 'namas arrow' then
                    equip(sets.LugraFlame)
                else
                    equip(sets.LugraMoonshade)
                end
            else
                if spell.english:lower() == 'namas arrow' then
                    equip(sets.FlameFlame)
                else
                    equip(sets.BrutalMoonshade)
                end
            end
        end
		if state.Buff['Meikyo Shisui'] then
			equip(sets.buff['Meikyo Shisui'])
		end
	end
    if spell.english == "Seigan" then
        -- Third Eye gearset is only called if we're in PDT mode
        if state.HybridMode.value == 'PDT' or state.PhysicalDefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
    update_am_type(spell)
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Effectively lock these items in place.
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
    	    meleeSet = set_combine(meleeSet, sets.thirdeye)
        else
            meleeSet = set_combine(meleeSet, sets.seigan)
        end
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if player.equipment.range == 'Yoichinoyumi' then
        meleeSet = set_combine(meleeSet, sets.bow)
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        if player.inventory['Eminent Arrow'] then
            gear.RAarrow.name = 'Eminent Arrow'
        elseif player.inventory['Tulfaire Arrow'] then
            gear.RAarrow.name = 'Tulfaire Arrow'
        elseif player.equipment.ammo == 'empty' then
            add_to_chat(122, 'No more Arrows!')
        end
    elseif newStatus == 'Idle' then
        determine_idle_group()
    end
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end

    if S{'aftermath'}:contains(buff:lower()) then
        classes.CustomMeleeGroups:clear()
       
        if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
            classes.CustomMeleeGroups:clear()
        elseif player.equipment.main == 'Kogarasumaru'  then
            if buff == "Aftermath: Lv.3" and gain or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
            end
        elseif buff == "Aftermath" and gain or buffactive.Aftermath then
            classes.CustomMeleeGroups:append('AM')
        end
    end
    
    if not midaction() then
        handle_equipping_gear(player.status)
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	get_combat_form()
    update_melee_groups()
    --get_combat_weapon()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--function get_combat_weapon()
--    if player.equipment.range == 'Yoichinoyumi' then
--        if player.equipment.main == 'Amanomurakumo' then
--            state.CombatWeapon:set('AmanoYoichi')
--        else
--            state.CombatWeapon:set('Yoichi')
--        end
--    else
--        state.CombatWeapon:set(player.equipment.main)
--    end
--end
-- Handle zone specific rules
windower.register_event('Zone change', function(new,old)
    determine_idle_group()
end)

function determine_idle_group()
    classes.CustomIdleGroups:clear()
    if areas.Adoulin:contains(world.area) then
    	classes.CustomIdleGroups:append('Adoulin')
    end
end

function get_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
    	state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

function seigan_thirdeye_active()
    return state.Buff['Seigan'] or state.Buff['Third Eye']
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()

    if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
        -- prevents using Amano AM while overriding it with Yoichi AM
        classes.CustomMeleeGroups:clear()
    elseif player.equipment.main == 'Kogarasumaru' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    else
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
    end
end
-- call this in job_post_precast() 
function update_am_type(spell)
    if spell.type == 'WeaponSkill' and spell.skill == 'Archery' and spell.english == 'Namas Arrow' then
        if player.equipment.main == 'Amanomurakumo' then
            -- Yoichi AM overwrites Amano AM
            state.YoichiAM:set(true)
        end
    else
        state.YoichiAM:set(false)
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
    	set_macro_page(1, 2)
    else
    	set_macro_page(1, 1)
    end
end

