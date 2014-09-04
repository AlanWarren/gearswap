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

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
    state.CombatForm = get_combat_form()
    state.CombatWeapon = get_combat_weapon()
    
    state.Buff.Sekkanoki = buffactive.sekkanoki or false
    state.Buff.Sengikori = buffactive.sengikori or false
    state.Buff['Third Eye'] = buffactive['Third Eye'] or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    options.OffenseModes = {'Normal', 'Mid', 'Acc'}
    options.DefenseModes = {'Normal', 'PDT', 'Reraise'}
    options.WeaponskillModes = {'Normal', 'Mid', 'Acc'}
    options.CastingModes = {'Normal'}
    options.IdleModes = {'Normal'}
    options.RestingModes = {'Normal'}
    options.PhysicalDefenseModes = {'PDT', 'Reraise'}
    options.MagicalDefenseModes = {'MDT'}
    
    state.Defense.PhysicalMode = 'PDT'
    
    gear.RAarrow = "Tulfaire Arrow"
    
    -- Additional local binds
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
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto",hands="Saotome Kote +2"}
    sets.precast.JA.Seigan = {head="Unkai Kabuto +2"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto"}
    sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate"}
    --sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
       
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
        waist="Windbuffet Belt",
        legs="Scuffler's Cosciales",
        feet="Ejekamal Boots"
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        head="Yaoyotl Helm",
        body="Sakonji Domaru +1"
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
        waist="Metalsinger Belt"
    })
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'].Mid, {
        body="Sakonji Domaru +1",
        waist="Light Belt",
        feet="Wakido Sune-Ate +1"
    })
    
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
        neck="Breeze Gorget",
        feet="Ejekamal Boots",
        legs="Otronif Brais +1"
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
    
    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Aqua Gorget",waist="Windbuffet Belt"})
    
    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Breeze Gorget",waist="Windbuffet Belt"})
    
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
        body="Usukane Haramaki +1",
        hands="Wakido Kote +1",
        ring1="Oneiros Ring",
        ring2="Patricius Ring",
        back="Takaha Mantle",
        waist="Windbuffet Belt",
        legs="Wakido Haidate +1",
        feet="Danzo Sune-ate"
    }
    
    sets.idle.Field = set_combine(sets.idle.Town, {
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
        waist="Windbuffet Belt",
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
        back="Takaha Mantle", 
        waist="Windbuffet Belt",
        legs="Wakido Haidate +1",
        feet="Otronif boots +1"
    }
    
    sets.engaged.Mid = set_combine(sets.engaged, {
        head="Yaoyotl Helm",
        body="Sakonji Domaru +1",
        neck="Agitator's Collar",
        ring2="Patricius Ring",
        waist="Dynamic Belt"
    })
    
    sets.engaged.Acc = set_combine(sets.engaged.Mid, { 
        head="Sakonji Kabuto +1",
        ring2="Mars's Ring",
        feet="Wakido Sune-Ate +1",
        legs="Xaddi Cuisses",
        back="Takaha Mantle"
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
        body="Sakonji Domaru +1",
        waist="Dynamic Belt",
        back="Takaha Mantle"
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
        ring2="Oneiros Ring", 
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Wakido Haidate +1", -- 6
        feet="Otronif Boots +1" --7
    }
    sets.engaged.Adoulin.Mid = set_combine(sets.engaged.Adoulin, { -- 840.5 accuracy
        body="Sakonji Domaru +1",
        head="Yaoyotl Helm",
        back="Takaha Mantle",
        legs="Xaddi Cuisses",
        feet="Ejekamal Boots"
    })
    
    sets.engaged.Adoulin.Acc = set_combine(sets.engaged.Adoulin.Mid, { 
        sub="Bloodrain Strap",
        body="Xaddi Mail", 
        neck="Agitator's Collar",
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        waist="Dynamic Belt",
        back="Takaha Mantle",
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
        back="Takaha Mantle",
        waist="Windbuffet Belt", 
        legs="Otronif Brais +1", -- 6
        feet="Otronif Boots +1" -- 7
    }
    
    sets.engaged.Adoulin.Yoichi.Mid = set_combine(sets.engaged.Adoulin.Yoichi, 
    {
        ammo=gear.RAarrow,
        head="Yaoyotl Helm",
        waist="Dynamic Belt",
        legs="Xaddi Cuisses",
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
    
    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}
    
    sets.thirdeye = {head="Unkai Kabuto +2", legs="Sakonji Haidate"}
    sets.bow = {ammo=gear.RAarrow}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		-- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
		if player.equipment.main=='Eminent Lance' or player.equipment.main=='Quint Spear' then
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
		--if state.Buff.Sengikori then
		--	equip(sets.buff.Sengikori)
		--end
		if state.Buff['Meikyo Shisui'] then
			equip(sets.buff['Meikyo Shisui'])
		end
	end
    if spell.english == "Seigan" then
        -- Third Eye gearset is only called if we're in PDT mode
        if state.DefenseMode == 'PDT' then
            equip(sets.thirdeye)
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
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
	if state.DefenseMode == 'Reraise' or
		(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
		equip(sets.Reraise)
	end
    if state.Buff['Seigan'] then
        if state.DefenseMode == 'PDT' then
            equip(sets.thirdeye)
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
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff['Seigan'] then
        if state.DefenseMode == 'PDT' then
    	    meleeSet = set_combine(meleeSet, sets.thirdeye)
        end
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
    if newStatus == 'Engaged' and state.DefenseMode == 'PDT' then
        if state.Buff['Seigan'] then
            equip(sets.thirdeye)
        end
    end
    -- prevents equipping gear
    --if seigan_thirdeye_active() then
        --eventArgs.handled = true
    --end
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --if S{'madrigal','march'}:contains(buff:lower()) then
    	--handle_equipping_gear(player.status)
    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
        -- if seign or TE is up, don't swap
        if not seigan_thirdeye_active() then
            handle_equipping_gear(player.status)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	state.CombatForm = get_combat_form()
    state.CombatWeapon = get_combat_weapon()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_weapon()
    if player.equipment.range == 'Yoichinoyumi' then
        if player.equipment.main == 'Amanomurakumo' then
            return 'AmanoYoichi'
        else
            return 'Yoichi'
        end
    else
        return player.equipment.main
    end
end

function get_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
    	return 'Adoulin'
    end
end

function seigan_thirdeye_active()
    return state.Buff['Seigan'] or state.Buff['Third Eye']
end

function determine_bow()
    classes.CustomMeleeGroups:clear()
    if player.equipment.range == 'Yoichinoyumi' then
        add_to_chat(121,'Yoichinoyumi Equipped!')
    	classes.CustomMeleeGroups:append('Yoichi')
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

