-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
	state.Buff.Migawari = buffactive.migawari or false
    state.CombatWeapon = get_combat_weapon()
    include('Mote-TreasureHunter')
    state.TreasureMode = 'Tag'

	determine_haste_group()
	-- For th_action_check():
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    options.OffenseModes = {'Normal', 'Mid', 'Acc'}
    options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
    options.WeaponskillModes = {'Normal', 'Mid', 'Acc'}
    options.CastingModes = {'Normal'}
    options.IdleModes = {'Normal'}
    options.RestingModes = {'Normal'}
    options.PhysicalDefenseModes = {'PDT'}
    options.MagicalDefenseModes = {'MDT'}

    state.Defense.PhysicalMode = 'PDT'
   
    select_default_macro_book()
    
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^[')
    send_command('unbind ![')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = { legs="Mochizuki Hakama +1" }
    sets.precast.JA['Futae'] = { hands="Iga Tekko +2" }
    sets.precast.JA['Provoke'] = { 
        ear1="Trux Earring", 
        ear2="Friomisi Earring",
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
    
	sets.TreasureHunter = {waist="Chaac Belt"}
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
        hands="Manibozho Gloves",
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
        feet="Qaaxo Leggings"
    }
    sets.precast.JA.Sange = sets.midcast.RA
	sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)
    
    -- Fast cast sets for spells
    sets.precast.FC = {
        head="Uk'uxkaj Cap",
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
        hands="Mochizuki Tekko +1",
        ear1="Loquacious Earring",
        waist="Hurch'lan Sash",
        ring1="Prolix Ring",
        ring2="Diamond Ring",
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
        ring1="Diamond Ring",
        ring2="Sangoma Ring",
        waist="Chaac Belt",
        legs="Kabnaax Trousers",
        feet="Mochizuki Kyahan +1"
    }
    -- Nuking Ninjutsu (skill & magic attack)
    sets.midcast.ElementalNinjutsu = {
    	head="Umbani Cap",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        neck="Stoicheion Medal",
    	body="Mochizuki Chainmail +1",
        hands="Iga Tekko +2",
    	back="Toro Cape",
        ring1="Sangoma Ring",
        ring2="Acumen Ring",
        waist="Hurch'lan Sash",
        legs="Shneddick Tights +1",
        feet="Mochizuki Kyahan +1"
    }
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {body="Kheper Jacket", ring2="Paguroidea Ring"}
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
    	head="Ocelomeh Headpiece +1",
        neck="Agitator's Collar",
        ear1="Trux Earring",
        ear2="Brutal Earring",
    	body="War Shinobi Gi",
        hands="Otronif Gloves +1",
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
        body="Usukane Haramaki",
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
    sets.NightMovement = {feet="Hachiya Kyahan"}

    sets.NightAccAmmo = {ammo="Fire Bomblet"}
    sets.DayAccAmmo = {ammo="Tengu-no-Hane"}
    sets.RegularAmmo = {ammo="Yetshila"}
    
    sets.Kiting = select_movement()
    sets.Ammo = select_static_ammo() 
    -- Engaged sets
    
    -- Normal melee group without buffs
    -- mochi hands, asperity, otronif boots, hach body
    sets.engaged = {
        ammo="Yetshila",
    	head="Ptica Headgear",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
    	body="Hachiya Chainmail +1",
        hands="Mochizuki Tekko +1",
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
        legs="Otronif Brais +1",
        feet="Qaaxo Leggings"
    })
    -- serious event set
    sets.engaged.Mid = set_combine(sets.engaged, {
        ammo="Yetshila",
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1",
        ring1="Mars's Ring",
        feet="Mochizuki Kyahan +1"
    })

    sets.engaged.Acc = {
        ammo="Yetshila",
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
        ring1="Mars's Ring",
        waist="Anguinus Belt",
        feet="Mochizuki Kyahan +1"
    }

    sets.engaged.HasteAcc = set_combine(sets.engaged.HasteMid, {
        ammo="Yetshila",
        neck="Asperity Necklace",
        body="Mochizuki Chainmail +1",
        ring2="Patricius Ring",
        hands="Umuthi Gloves",
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
        ammo="Yetshila",
    	head="Felistris Mask",
        ear1="Trux Earring",
        ear2="Brutal Earring",
        body="Thaumas Coat",
        waist="Windbuffet Belt",
        legs="Hachiya Hakama +1"
    })
    sets.engaged.Mid.Haste_43 = set_combine(sets.engaged.Haste_43, {
        head="Ptica Headgear",
        body="Qaaxo Harness",
        hands="Otronif Gloves +1",
        ring1="Mars's Ring",
    	waist="Anguinus Belt",
        feet="Mochizuki Kyahan +1"
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
        ring1="Mars's Ring",
    	waist="Anguinus Belt",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Acc.Haste_40 = set_combine(sets.engaged.Mid.Haste_40, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_40 = set_combine(sets.engaged.Haste_40, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_40 = set_combine(sets.engaged.Haste_40, sets.engaged.HastePDT)
    
    -- 35
    sets.engaged.Haste_35 = set_combine(sets.engaged.Haste_43, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Haste_35, {
        head="Ptica Headgear",
        body="Mochizuki Chainmail +1",
        ring1="Mars's Ring",
    	back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HastePDT)
    
    -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged, {
        head="Ptica Headgear",
        body="Thaumas Coat",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, {
        head="Ptica Headgear",
        body="Mochizuki Chainmail +1",
    	back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
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
        ear2="Trux Earring",
    	body="Mochizuki chainmail +1",
        hands="Mochizuki Tekko +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
    	back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Manibozho Brais",
        feet="Mochizuki Kyahan +1"
    }

    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        head="Ptica Headgear",
        hands="Umuthi Gloves",
        back="Yokaze Mantle"
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        hands="Buremte Gloves",
        ring1="Mars's Ring"
    })
    
    -- BLADE: JIN
    sets.Jin = {
        head="Ptica Headgear",
        neck="Breeze Gorget",
        ring1="Ramuh Ring",
        waist="Thunder Belt",
        back="Rancorous Mantle"
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
        legs="Mochizuki Hakama +1",
        waist="Windbuffet Belt",
        feet="Mochizuki Kyahan +1"
    }
    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, sets.Hi)
    sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {
        body="Mochizuki Chainmail +1",
        hands="Otronif Gloves +1"
    })
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'].Mid, {
        head="Ptica Headgear", 
        legs="Hachiya Hakama +1", 
        ring2="Mars's Ring",
        back="Yokaze Mantle"
    })

    -- BLADE: SHUN
    sets.Shun = {
        neck="Breeze Gorget",
        waist="Anguinus Belt",
        ring1="Ramuh Ring",
        ring2="Thundersoul Ring",
    }
    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, sets.Shun)
    sets.precast.WS['Blade: Shun'].Mid = set_combine(sets.precast.WS.Mid, sets.Shun)
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, sets.Shun)
    
    -- BLADE: Rin
    sets.Rin = {
        neck="Asperity Necklace",
        waist="Windbuffet Belt",
        ring1="Oneiros Ring",
    }
    sets.precast.WS['Blade: Rin'] = set_combine(sets.precast.WS, sets.Rin)
    sets.precast.WS['Blade: Rin'].Mid = set_combine(sets.precast.WS.Mid, sets.Rin)
    sets.precast.WS['Blade: Rin'].Acc = set_combine(sets.precast.WS.Acc, sets.Rin)
    
    -- BLADE: KU 
    sets.Ku = {
        neck="Shadow Gorget",
        waist="Anguinus Belt",
        ring1="Rajas Ring",
        ring2="Ifrit Ring",
    }
    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, sets.Ku)
    sets.precast.WS['Blade: Ku'].Mid = set_combine(sets.precast.WS.Mid, sets.Ku)
    sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS.Acc, sets.Ku)
    
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    	head="Umbani Cap",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        neck="Stoicheion Medal",
        ring1="Garuda Ring",
        ring2="Acumen Ring",
    	back="Toro Cape",
        legs="Shneddick Tights +1",
        waist="Thunder Belt",
        feet="Mochizuki Kyahan +1"
     })

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

    --Aftermath for Kannagi
    aw_custom_aftermath_timers_precast(spell)
    
	if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' and spellMap ~= "Utsusemi" then
		classes.CustomClass = "SelfNinjutsu"
	end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
    -- cancel utsusemi if shadows are up already
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            cancel_spell()
            add_to_chat(123, spell.english .. ' Canceled: [3+ Images]')
            return
        end
    end

end

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.english == 'Aeolian Edge' and state.TreasureMode ~= 'None' then
		equip(sets.TreasureHunter)
	elseif spell.type == 'WeaponSkill' then
		if state.TreasureMode == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
        if spell.english ~= 'Blade: Hi' then
            equip(sets.Ammo)
        end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
    if spell.english == "Monomi: Ichi" then
        if buffactive['Sneak'] then
            send_command('@wait 1.7;cancel sneak')
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    state.CombatWeapon = get_combat_weapon()
	if state.TreasureMode ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Aftermath timer creation
    aw_custom_aftermath_timers_aftercast(spell)
    -- If spell is not interrupted. This also applies when you try using a JA with it's timer down.
    -- If the recast timer isn't ready, aftercast is called with spell.interrupted == true
    -- We check if state.Buff.spell is defined, so we don't created variable instances for every action taken
    if state.Buff[spell.english] ~= nil then
    -- We need to set the spell being used to true, but only if the spell is not Yonin.
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
	sets.Kiting = select_movement()
    sets.Ammo = select_static_ammo()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.PhysicalDefenseMode ~= 'PDT' then
	    idleSet = set_combine(idleSet, select_movement())
    end
	if state.Buff.Migawari and state.DefenseMode == 'PDT' then
		idleSet = set_combine(idleSet, sets.buff.Migawari)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    meleeSet = set_combine(meleeSet, sets.Ammo)
	if state.TreasureMode == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
	if state.Buff.Migawari and state.DefenseMode == 'PDT' then
		meleeSet = set_combine(meleeSet, sets.buff.Migawari)
	end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march', 'madrigal','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
end

function job_status_change(newStatus, oldStatus, eventArgs)
    sets.Ammo = select_static_ammo()
    if newStatus == 'Idle' then
        sets.Kiting = select_movement()
    end
    state.CombatWeapon = get_combat_weapon()
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    state.CombatWeapon = get_combat_weapon()
	th_update(cmdParams, eventArgs)
	determine_haste_group()
    sets.Kiting = select_movement()
    sets.Ammo = select_static_ammo()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		if state.TreasureMode == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
		eventArgs.handled = true
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

function select_movement()
	-- world.time is given in minutes into each day
	-- 7:00 AM would be 420 minutes
	-- 17:00 PM would be 1020 minutes
	if world.time >= (17*60) or world.time <= (7*60) then
		return sets.NightMovement
	else
		return sets.DayMovement
	end
end

function select_static_ammo()
    if state.OffenseMode == 'Acc' or state.OffenseMode == 'Mid' then
	    if world.time >= (18*60) or world.time <= (6*60) then
            return sets.NightAccAmmo
        else
            return sets.DayAccAmmo
	    end
    else
        return sets.RegularAmmo
    end
end

function get_combat_weapon()
    if player.equipment.main == 'Taimakuniyuki' or player.equipment.main == 'Ark Scythe' then
        return 'TwoHanded'
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
    elseif buffactive.haste and buffactive['haste samba'] and buffactive.march == 1 then
        add_to_chat(8, '-------------Haste 35%-------------')
        classes.CustomMeleeGroups:append('Haste_35')
    elseif (buffactive.haste and buffactive.march == 1) or (buffactive.march == 2 and buffactive['haste samba']) then
        add_to_chat(8, '-------------Haste 30%-------------')
        classes.CustomMeleeGroups:append('Haste_30')
    elseif buffactive.embrava or buffactive.march == 2 then
        add_to_chat(8, '-------------Haste 25%-------------')
        classes.CustomMeleeGroups:append('Haste_25')
    elseif buffactive.haste or buffactive['haste samba'] then
        add_to_chat(8, '-------------Haste 20%-------------')
        classes.CustomMeleeGroups:append('Haste_20')
    end

end

--- Custom spell mapping.
--function job_get_spell_map(spell, default_spell_map)
--    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
--        return 'HighTierNuke'
--    end
--end

function utsusemi_active()
    if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
        return true
    else
        return false
    end
end

-- Call from job_precast() to setup aftermath information for custom timers.
function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}
        
        local empy_ws = "Blade: Hi"
        
        info.aftermath.weaponskill = empy_ws
        info.aftermath.duration = 0
        
        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end
        
        if spell.english == empy_ws and player.equipment.main == 'Kannagi' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end
            
            -- duration is based on aftermath level
            info.aftermath.duration = 30 * info.aftermath.level
        end
    end
end
-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
       info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'WAR' then
		set_macro_page(2, 1)
	else
		set_macro_page(2, 2)
	end
end

