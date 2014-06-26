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

	determine_haste_group()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    options.OffenseModes = {'Normal', 'Mid', 'Acc', 'Proc'}
    options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
    options.WeaponskillModes = {'Normal', 'Mid', 'Acc'}
    options.CastingModes = {'Normal'}
    options.IdleModes = {'Normal'}
    options.RestingModes = {'Normal'}
    options.PhysicalDefenseModes = {'PDT'}
    options.MagicalDefenseModes = {'MDT'}
    
    enfeeblingNinjutsu = S{"yurin: ichi", "aisha: ichi", "dokumori: ichi", "kurayami: ni", "hojo: ni", "jubaku: ichi"}
    
    state.Defense.PhysicalMode = 'PDT'
    
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')

    select_default_macro_book()
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
    
    gear.ammo = select_ammo()

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = { legs="Mochizuki Hakama +1" }
    sets.precast.JA['Futae'] = { hands="Iga Tekko +1" }
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
    
    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {
    	head="Whirlpool Mask",
    	body="Mochizuki Chainmail +1",
        neck="Iqabi Necklace",
        hands="Umuthi Gloves",
    	back="Yokaze Mantle",
        waist="Hurch'lan Sash",
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
        hands="Hachiya Tekko",
        ring1="Longshot Ring",
        ring2="Paqichikaji Ring",
        back="Yokaze Mantle",
        --waist="Hurling Belt",
        legs="Hachiya Hakama +1",
        feet="Qaaxo Leggings"
    }
    sets.precast.JA.Sange = sets.midcast.RA
    
    -- Fast cast sets for spells
    sets.precast.FC = {
        head="Uk'uxkaj Cap",
        ear1="Loquacious Earring",
        ring1="Prolix Ring",
        feet="Mochizuki Kyahan +1"
    }
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Mochizuki Chainmail +1"})
    
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
    sets.precast.WS.Proc = set_combine(sets.precast.WS, {
        head="Hakke Hachimaki"
    })

    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        head="Whirlpool Mask",
        hands="Umuthi Gloves",
        back="Yokaze Mantle"
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        hands="Umuthi Gloves",
        legs="Hachiya Hakama +1",
        ring1="Mars's Ring"
    })
    
    -- BLADE: JIN
    sets.Jin = {
        head="Uk'uxkaj Cap",
        neck="Breeze Gorget",
        ring1="Thundersoul Ring",
        waist="Thunder Belt",
        back="Rancorous Mantle"
    }
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, sets.Jin)
    sets.precast.WS['Blade: Jin'].Mid = set_combine(sets.precast.WS.Mid, sets.Jin)
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS.Acc, sets.Jin)
    
    -- BLADE: HI
    sets.Hi = {
        head="Uk'uxkaj Cap",
        body="Mochizuki Chainmail +1",
        neck="Shadow gorget",
    	ring1="Stormsoul Ring",
        back="Rancorous Mantle",
        legs="Mochizuki Hakama +1",
        waist="Soil belt"
    }
    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, sets.Hi)
    sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {
        head="Whirlpool Mask",
        back="Yokaze Mantle",
        legs="Hachiya Hakama +1"
    })
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'], {
        head="Whirlpool Mask", 
        legs="Hachiya Hakama +1", 
        ring1="Mars's Ring",
        back="Yokaze Mantle"
    })

    -- BLADE: SHUN
    sets.Shun = {
        neck="Breeze Gorget",
        waist="Thunder Belt",
        ring1="Thundersoul Ring",
        ear1="Dawn Earring"
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
        waist="Soil Belt",
        ring1="Rajas Ring",
        ring2="Pyrosoul Ring",
    }
    sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, sets.Ku)
    sets.precast.WS['Blade: Ku'].Mid = set_combine(sets.precast.WS.Mid, sets.Ku)
    sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS.Acc, sets.Ku)
    
    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    	head="Umbani Cap",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        neck="Stoicheion Medal",
        ring1="Stormsoul Ring",
        ring2="Acumen Ring",
    	back="Toro Cape",
        legs="Shneddick Tights +1",
        waist="Thunder Belt",
        feet="Mochizuki Kyahan +1"
     })
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
    	head="Uk'uxkaj Cap",
    	body="Mochi. Chainmail +1",
        hands="Mochizuki Tekko +1",
        ear1="Loquacious Earring",
    	waist="Hurch'lan Sash",
        ring1="Prolix Ring",
        ring1="Diamond Ring",
        legs="Mochizuki Hakama +1",
        feet="Mochizuki Kyahan +1"
    }
    	
    -- any ninjutsu cast on self
    sets.midcast.SelfNinjutsu = sets.midcast.FastRecast
    
    sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Iga Kyahan +2"})
    
    -- Nuking Ninjutsu (skill & magic attack)
    sets.midcast.Ninjutsu = {
    	head="Umbani Cap",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        neck="Stoicheion Medal",
    	body="Mochizuki Chainmail +1",
        hands="Iga Tekko +1",
    	back="Toro Cape",
        ring1="Diamond Ring",
        ring2="Acumen Ring",
        waist="Hurch'lan Sash",
        legs="Shneddick Tights +1",
        feet="Mochizuki Kyahan +1"
    }
    -- Enfeebling Ninjutsu (skill)
    sets.midcast.EnfeebleNinjutsu = {
    	head="Hachiya Hatsuburi +1",
        ear1="Lifestorm Earring",
        ear2="Psystorm Earring",
        neck="Stoicheion Medal",
    	body="Mochizuki Chainmail +1",
        hands="Mochizuki Tekko +1",
    	back="Yokaze Mantle",
        ring1="Diamond Ring",
        ring2="Acumen Ring",
        waist="Hurch'lan Sash",
        legs="Mochizuki Hakama +1",
        feet="Mochizuki Kyahan +1"
    }
    --sets.midcast.Ninjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {ear1="Lifestorm Earring",ear2="Psystorm Earring"})
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {body="Kheper Jacket", ring2="Paguroidea Ring"}
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
    	head="Lithelimb Cap",
        neck="Agitator's Collar",
        ear1="Trux Earring",
        ear2="Dawn Earring",
    	body="Kheper Jacket",
        hands="Umuthi Gloves",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
    	back="Repulse Mantle",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1",
        feet="Danzo sune-ate"
    }
    
    sets.idle.Town = set_combine(sets.idle, {
        head="Hachiya Hatsuburi +1",
        neck="Agitator's Collar",
        body="Hachiya Chainmail +1",
        hands="Mochizuki Tekko +1",
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
        legs="Hachiya Hakama +1",
    	back="Yokaze Mantle"
    })
    
    sets.idle.Weak = sets.idle
    
    -- Defense sets
    
    sets.defense.PDT = {
    	head="Lithelimb Cap",
        neck="Agitator's Collar",
        hands="Umuthi Gloves",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
    	back="Repulse Mantle",
        feet="Otronif Boots +1"
    }
    
    sets.defense.MDT = set_combine(sets.defense.PDT, {
    	head="Felistris Mask",
        hands="Mochizuki Tekko +1",
    	back="Yokaze Mantle",
        feet="Hachiya Kyahan"
    })
    
    sets.DayMovement = {feet="Danzo sune-ate"}
    sets.NightMovement = {feet="Hachiya Kyahan"}
    
    sets.Kiting = select_movement()
    
    -- Engaged sets
    
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't available.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Yetshila",
    	head="Iga Zukin +2",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
    	body="Mochizuki Chainmail +1",
        hands="Mochizuki Tekko +1",
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
    	back="Atheling Mantle",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1",
        feet="Qaaxo Leggings"
        --feet="Otronif Boots +1"
    }
    sets.engaged.Proc = set_combine(sets.engaged, {
        head="Hakke hachimaki"
    })
    sets.engaged.TwoHanded = set_combine(sets.engaged, {
        head="Felistris Mask",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        legs="Hachiya Hakama +1"
    })
    -- serious event set
    sets.engaged.Mid = set_combine(sets.engaged, {
        ammo="Yetshila",
        neck="Agitator's Collar",
        body="Mochizuki Chainmail +1",
        hands="Umuthi Gloves",
        ring1="Mars's Ring",
        back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
    })
    -- wtf I can't hit anything set
    sets.engaged.Acc = {
        ammo=gear.ammo,
        head="Whirlpool Mask",
        neck="Agitator's Collar",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        body="Mochizuki Chainmail +1",
        hands="Umuthi Gloves",
        ring1="Mars's Ring",
        ring2="Patricius Ring",
        back="Yokaze Mantle",
        waist="Anguinus Belt",
        legs="Hachiya Hakama +1",
        feet="Mochizuki Kyahan +1"
    }

    sets.engaged.PDT = set_combine(sets.engaged, {
    	head="Lithelimb Cap",
        body="Hachiya Chainmail +1",
        neck="Agitator's Collar",
        hands="Umuthi Gloves",
        ring1="Patricius Ring",
        ring2="Dark Ring",
    	back="Repulse Mantle",
        legs="Mochizuki Hakama +1",
        feet="Otronif Boots +1"
    })
    
    sets.engaged.Evasion = set_combine(sets.engaged, {
    	head="Felistris Mask",
        neck="Iga Erimaki",
        body="Mochizuki Chainmail +1",
        hands="Umuthi Gloves",
        ring1="Beeline Ring",
        ring2="Epona's Ring",
        waist="Nusku's Sash",
    	back="Yokaze Mantle",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Mid.Evasion = set_combine(sets.engaged.Evasion, {
    	head="Whirlpool Mask"
    })
    sets.engaged.Acc.Evasion = set_combine(sets.engaged.Mid.Evasion, {
        ring2="Patricius Ring",
        waist="Anguinus Belt"
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
        head="Whirlpool Mask",
        neck="Asperity Necklace",
        hands="Umuthi Gloves",
        ring1="Mars's Ring",
    	back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
    }

    sets.engaged.HasteAcc = set_combine(sets.engaged.HasteMid, {
        ammo=gear.ammo,
        neck="Iqabi Necklace",
        body="Mochizuki Chainmail +1",
        ring2="Patricius Ring",
        waist="Anguinus Belt",
        legs="Hachiya Hakama +1"
    })

    sets.engaged.HasteEvasion = {
        head="Felistris Mask",
        body="Mochizuki Chainmail +1",
        neck="Iga Erimaki",
        ring1="Beeline Ring",
        ring2="Epona's Ring",
        back="Yokaze Mantle",
        waist="Nusku's Sash",
        feet="Qaaxo Leggings"
    }
    
    -- 43
    sets.engaged.Haste_43 = set_combine(sets.engaged, {
        ammo="Yetshila",
    	head="Felistris Mask",
        neck="Rancor Collar",
        ear1="Trux Earring",
        ear2="Brutal Earring",
        body="Thaumas Coat",
        waist="Windbuffet Belt",
        legs="Hachiya Hakama +1"
    })
    sets.engaged.Mid.Haste_43 = set_combine(sets.engaged.Haste_43, {
        head="Whirlpool Mask",
        body="Qaaxo Harness",
        neck="Asperity Necklace",
        hands="Umuthi Gloves",
        ring1="Mars's Ring",
    	back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Acc.Haste_43 = set_combine(sets.engaged.Mid.Haste_43, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_43 = set_combine(sets.engaged.Haste_43, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_43 = set_combine(sets.engaged.Haste_43, sets.engaged.PDT)
    
    -- 40
    sets.engaged.Haste_40 = set_combine(sets.engaged.Haste_43, {
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_40 = set_combine(sets.engaged.Haste_40, {
        head="Whirlpool Mask",
        body="Qaaxo Harness",
        neck="Asperity Necklace",
        hands="Umuthi Gloves",
        ring1="Mars's Ring",
    	back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Acc.Haste_40 = set_combine(sets.engaged.Mid.Haste_40, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_40 = set_combine(sets.engaged.Haste_40, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_40 = set_combine(sets.engaged.Haste_40, sets.engaged.PDT)
    
    -- 35
    sets.engaged.Haste_35 = set_combine(sets.engaged.Haste_43, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Haste_35, {
        head="Whirlpool Mask",
        body="Qaaxo Harness",
        neck="Asperity Necklace",
        hands="Umuthi Gloves",
        ring1="Mars's Ring",
    	back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.PDT)
    
    -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_43, {
        head="Iga Zukin +2",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Haste_30, {
        head="Whirlpool Mask",
        body="Qaaxo Harness",
        neck="Asperity Necklace",
        hands="Umuthi Gloves",
        ring1="Mars's Ring",
    	back="Yokaze Mantle",
        feet="Mochizuki Kyahan +1"
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HasteEvasion)
    sets.engaged.Haste_30.PDT = set_combine(sets.engaged.Haste_30, sets.engaged.PDT)
    
    -- 25
    sets.engaged.Haste_25 = set_combine(sets.engaged.Haste_43, {
    	body="Mochizuki Chainmail +1",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_25 = set_combine(sets.engaged.Haste_25, sets.engaged.HasteMid)
    sets.engaged.Acc.Haste_25 = set_combine(sets.engaged.Mid.Haste_25, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_25 = set_combine(sets.engaged.Haste_25, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_25 = set_combine(sets.engaged.Haste_25, sets.engaged.PDT)
    
    -- 20
    sets.engaged.Haste_20 = set_combine(sets.engaged.Haste_43, {
        head="Iga Zukin +2",
    	body="Mochizuki Chainmail +1",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        waist="Patentia Sash",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Mid.Haste_20 = set_combine(sets.engaged.Haste_20, sets.engaged.HasteMid)
    sets.engaged.Acc.Haste_20 = set_combine(sets.engaged.Mid.Haste_20, sets.engaged.HasteAcc)
    sets.engaged.Evasion.Haste_20 = set_combine(sets.engaged.Haste_20, sets.engaged.HasteEvasion)
    sets.engaged.PDT.Haste_20 = set_combine(sets.engaged.Haste_20, sets.engaged.PDT)
    
    sets.buff.Migawari = {body="Iga Ningi +2"}
    sets.Counter = { legs="Iga Hakama +2" }
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
    
    if spell.skill == "Ninjutsu" and enfeeblingNinjutsu:contains(spell.name:lower()) then
        classes.CustomClass = "EnfeebleNinjutsu"
    end
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
    gear.ammo = select_ammo()
	--if spell.type:lower() == 'weaponskill' then
    --    if state.OffenseMode == 'Proc' then
    --        equip(sets.precast.WS.Stave)
    --    end
    --end
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
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
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
    gear.ammo = select_ammo()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	idleSet = set_combine(idleSet, select_movement())
	if state.Buff.Migawari then
		idleSet = set_combine(idleSet, sets.buff.Migawari)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Migawari then
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
    if buff == 'Aftermath: Lv.3' and gain and player.equipment.main == 'Kannagi' then
        windower.send_command('wait 120;input /echo [AM3: WEARING OFF IN 60 SEC.];wait 30; input /echo [AM3: WEARING OFF IN 30 SEC.];wait 20;input /echo [AM3: WEARING OFF IN 10 SEC.]')
    end
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march', 'madrigal','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
        handle_equipping_gear(player.status)
    end
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end
end

function job_status_change(newStatus, oldStatus, eventArgs)
    state.CombatWeapon = get_combat_weapon()
    gear.ammo = select_ammo()
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	determine_haste_group()
    state.CombatWeapon = get_combat_weapon()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

function select_ammo()
	if world.time >= (17*60) or world.time <= (7*60) then
        if state.OffenseMode == 'Acc' then
            return "Fire Bomblet"
        else
		    return "Yetshila"
        end
    else
        return "Tengu-no-Hane"
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

function utsusemi_active()
    if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
        return true
    else
        return false
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

