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
	state.CombatForm = get_combat_form()
	
	state.Buff.Sekkanoki = buffactive.sekkanoki or false
	state.Buff.Sengikori = buffactive.sengikori or false
    state.Buff['Third Eye'] = buffactive['Third Eye'] or false
	state.Buff['Meikyou Shisui'] = buffactive['Meikyou Shisui'] or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'STP', 'Bow'}
	options.DefenseModes = {'Normal', 'PDT', 'Reraise'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Reraise'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end

	send_command('unbind ^`')
	send_command('unbind !-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Meditate = {head="Wakido Kabuto",hands="Saotome Kote +2"}
	sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto"}
    sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate",ear1="Brutal Earring",ear2="Unkai Mimikazari"}
	--sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
        ammo="Hagnia Stone",
		head="Yaoyotl Helm",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Phorcys Korazin",
        hands="Mikinaak Gauntlets",
        ring1="Rajas Ring",
        ring2="Pyrosoul Ring",
		back="Buquwik Cape",
        waist="Windbuffet Belt",
        legs="Wakido Haidate +1",
        feet="Sakonji Sune-ate"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {legs="Mikinaak Cuisses"})

	sets.precast.WS.Bow = set_combine(sets.precast.WS, {ammo="Demo Arrow"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {neck="Aqua Gorget", waist="Light Belt"})
	sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {})

	sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {neck="Breeze Gorget"})
	sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {neck="Breeze Gorget"})
	sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {waist="Thunder Belt"})

	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
	sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
	sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {waist="Snow Belt"})

	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Flame Gorget",waist="Light Belt"})

	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Aqua Gorget",waist="Windbuffet Belt"})

	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Breeze Gorget",waist="Windbuffet Belt"})

	sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {neck="Shadow Gorget",waist="Soil Belt"})

	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Shadow Gorget",waist="Soil Belt"})


	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Yaoyotl Helm",
		body="Otronif Harness",hands="Otronif Gloves",
		legs="Phorcys Dirs",feet="Whirlpool Greaves"}

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {
        --main="Anahera Blade", 
        --sub="Pole Grip",
		head="Yaoyotl Helm",
        neck="Justice Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Wakido Domaru +1",
        hands="Wakido Kote +1",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Wakido Haidate +1",
        feet="Danzo Sune-ate"
    }
	
	sets.idle.Field = set_combine(sets.idle.Town, {
		neck="Twilight Torque",
		ring2="Paguroidea Ring",
		back="Shadow Mantle",
        feet="Danzo Sune-ate"
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
		head="Twilight Helm",
		body="Twilight Mail"
    })
	sets.idle.Bow = set_combine(sets.idle.Field, {
        range="Speleogen bow",
		ammo="Demon Arrow"
    })
	
	-- Defense sets
	sets.defense.PDT = {
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Wakido Domaru +1",hands="Wakido Kote +1",ring1="K'ayres Ring",ring2="Dark Ring",
		back="Shadow Mantle",waist="Windbuffet Belt",legs="Wakido Haidate +1",feet="Otronif Boots"}

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
    -- Tsurumaru = 49 stp w/ ionis 
    -- Anahera = 52 stp anywhere
	sets.engaged = { -- 48 stp / 54 with bloodrain
        ammo="Hagneia Stone",
		head="Yaoyotl Helm",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Wakido Domaru +1",
        hands="Wakido Kote +1",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Wakido Haidate +1",
        feet="Sakonji Sune-ate"
    }

	sets.engaged.Acc = set_combine(sets.engaged, { 
        neck="Justice Torque", 
        hands="Miki. Gauntlets",
        feet="Whirlpool Greaves", 
        waist="Dynamic Belt", 
        legs="Unkai Haidate +2"
    })

	sets.engaged.Bow = set_combine(sets.engaged, { 
        range="Speleogen bow",
		ammo="Demon Arrow"
    })

	sets.engaged.STP = set_combine(sets.engaged, { back="Misuuchi Kappa" })

	sets.engaged.PDT = set_combine(sets.engaged, { 
        head="Lithelimb Cap", 
        neck="Twilight Torque",
        ring1="Dark Ring",
        back="Shadow Mantle",
        feet="Whirlpool Greaves"
    })

	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, { waist="Dynamic Belt" })

	sets.engaged.Reraise = set_combine(sets.engaged.PDT, {
        head="Twilight Helm", 
        body="Twilight Mail",
        ring2="Paguroidea Ring"
    })

	sets.engaged.Acc.Reraise = set_combine(sets.engaged.Reraise, {
        hands="Miki. Gauntlets",
        ring1="Beeline Ring",
        feet="Whirlpool Greaves", 
        waist="Dynamic Belt"
    })
		
	-- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
	-- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
	sets.engaged.Adoulin = {
        ammo="Hagneia Stone",
		head="Yaoyotl Helm",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Wakido Domaru +1",
        hands="Wakido Kote +1",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Wakido Haidate +1",
        feet="Sakonji Sune-ate" -- this is 48 STP total, with Anahera Blade. Tsu needs either goading or Bloodrain, or Kappa
    }
	sets.engaged.Adoulin.Acc = set_combine(sets.engaged.Adoulin, {
		body="Unkai Domaru +2",hands="Otronif Gloves",
	    waist="Dynamic Belt",legs="Unkai Haidate +2",
        feet="Whirlpool Greaves"
    })
	sets.engaged.Adoulin.PDT = set_combine(sets.engaged.Adoulin, {
		neck="Twilight Torque",
        ring1="Dark Ring",
		back="Shadow Mantle"
    })

	sets.engaged.Adoulin.STP = set_combine(sets.engaged.Adoulin, { back="Misuuchi Kappa" })

	sets.engaged.Adoulin.Acc.PDT = set_combine(sets.engaged.Adoulin.PDT, { waist="Dynamic Belt" })

	sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Adoulin, {
		head="Twilight Helm",
		body="Twilight Mail",
    })
	sets.engaged.Adoulin.Acc.Reraise = set_combine(sets.engaged.Adoulin.Acc, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.buff.Sekkanoki = {hands="Unkai Kote +1"}
	sets.buff.Sengikori = {}
	sets.buff['Meikyou Shisui'] = {feet="Sakonji Sune-ate"}

	sets.thirdeye = {legs="Sakonji Haidate"}
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
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
		if state.Buff.Sengikori then
			equip(sets.buff.Sengikori)
		end
		if state.Buff['Meikyou Shisui'] then
			equip(sets.buff['Meikyou Shisui'])
		end
	end
    if spell.english == "Third Eye" then
        -- Third Eye gearset is only called if we're in PDT mode
        if state.DefenseMode == 'PDT' then
            equip(sets.thirdeye)
        end
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
    if state.Buff['Third Eye'] then
        if state.DefenseMode == 'PDT' then
            equip(sets.thirdeye)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if state.Buff[spell.english] ~= nil then
			state.Buff[spell.english] = true
		end

	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.Buff['Third Eye'] then
        if state.DefenseMode == 'PDT' then
		    idleSet = set_combine(idleSet, sets.thirdeye)
        end
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff['Third Eye'] then
        if state.DefenseMode == 'PDT' then
		    meleeSet = set_combine(meleeSet, sets.thirdeye)
        end
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
	    if state.Buff['Third Eye'] then
            equip(sets.thirdeye)
        end
    end
    if seigan_thirdeye_active() then
        eventArgs.handled = true
    end
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
	    state.Buff[buff] = gain

        if not seigan_thirdeye_active() then
            handle_equipping_gear(player.status)
        end
	end
    --if state.Buff['Third Eye'] then
    --    if gain then
    --        send_command('@wait .5;gs disable legs')
    --    else
    --        enable('legs')
    --    end
    --end

end

-- Called when the player's subjob changes.
function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	state.CombatForm = get_combat_form()
    -- may need to check for seign/TE here
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_form()
	if areas.Adoulin:contains(world.area) and buffactive.ionis then
		return 'Adoulin'
	end
end

function seigan_thirdeye_active()
	return state.Buff['Seigan'] or state.Buff['Third Eye']
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

