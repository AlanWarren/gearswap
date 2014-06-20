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
	state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
	state.Buff['Trick Attack'] = buffactive['trick attack'] or false
	state.Buff['Feint'] = buffactive['feint'] or false
	
	-- TH mode handling
	options.TreasureModes = {'None','Tag','SATA','Fulltime'}
	state.TreasureMode = 'Tag'

	-- Tracking vars for TH.
	tagged_mobs = T{}
	state.th_gear_is_locked = false
	state.show_th_message = false
	
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.u_ja_ids = S{201, 202, 203, 205, 207}
	
	-- Register events to allow us to manage TH application.
	windower.register_event('target change', on_target_change)
	windower.raw_register_event('action', on_action)
	windower.raw_register_event('action message', on_action_message)
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'iLvl'}
	options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
	options.RangedModes = {'Normal', 'Acc'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'Evasion', 'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.RangedMode = 'Normal'
	state.Defense.PhysicalMode = 'Evasion'
	
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Caudata Belt"

	-- Additional local binds
	send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind !- gs c cycle targetmode')

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
	
	sets.TreasureHunter = {hands="Plunderer's Armlets +1", feet="Raider's Poulaines +2"}
	
	sets.buff['Sneak Attack'] = {
		head="Uk'uxkaj Cap",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Qaaxo Harness",
        hands="Raider's Armlets +2",
        ring1="Thundersoul Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Cetl Belt",
        legs="Manibozho Brais",
        feet="Qaaxo Leggings"
    }

	sets.buff['Trick Attack'] = {
		head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Stormsoul Ring",
        ring2="Epona's Ring",
		back="Canny Cape",
        waist="Elanid Belt",
        legs="Nahtirah Trousers",
        feet="Iuitl Gaiters"
    }
    -- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {}
	sets.precast.JA['Accomplice'] = {}
	sets.precast.JA['Flee'] = {}
	sets.precast.JA['Hide'] = {}
	sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
	sets.precast.JA['Steal'] = {}
	sets.precast.JA['Despoil'] = {}
	sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
	sets.precast.JA['Feint'] = {hands="Plunderer's Armlets +1"} -- {legs="Assassin's Culottes +2"}
	
	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",
		legs="Nahtirah Trousers",
        feet="Iuitl Gaiters"
    }
	-- TH actions
	sets.precast.Step = {
        head="Whirlpool Mask",
        heck="Rancor Collar",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        hands="Plunderer's Armlets +1",
        back="Canny Cape",
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        waist="Anguinus Belt",
        legs="Manibozho Brais",
        feet="Raider's Poulaines +2"

    }
	sets.precast.Flourish1 = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

	-- Fast cast sets for spells
	sets.precast.FC = {ring1="Prolix Ring"}
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Ranged snapshot gear
	sets.precast.RA = {head="Uk'uxkaj Cap",hands="Iuitl Wristbands +1",legs="Nahtirah Trousers", feet="Wurrukatte Boots"}
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Cetl Belt"
	sets.precast.WS = {
		head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Elanid Belt",
        legs="Nahtirah Trousers",
        feet="Qaaxo Leggings"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
            head="Whirlpool Mask",
            hands="Plunderer's Armlets +1",
            ring1="Mars's Ring",
            ring2="Patricius Ring",
            back="Canny Cape"
    })

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
            neck="Breeze Gorget",
            ring1="Stormsoul Ring",
		    legs="Nahtirah Trousers", 
            waist="Elanid Belt"
    })
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {
            head="Whirlpool Mask",
            hands="Plunderer's Armlets +1",
            ring1="Mars's Ring",
            ring2="Patricius Ring",
            back="Canny Cape"
    })
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {neck="Breeze Gorget"})
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {neck="Breeze Gorget"})
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {neck="Breeze Gorget"})

	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {neck="Breeze Gorget", waist="Thunder Belt"})
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {head="Whirlpool Mask"})
	sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist="Thunder Belt"})
	sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {neck="Breeze Gorget"})
	sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {neck="Breeze Gorget"})
	sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {neck="Breeze Gorget"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
            head="Uk'uxkaj Cap",
            neck="Shadow Gorget",
		    ear1="Brutal Earring",
            ear2="Trux Earring",
            ring1="Thundersoul Ring",
            waist="Light Belt",
            back="Rancorous Mantle"
    })
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
            head="Whirlpool Mask",
            hands="Plunderer's Armlets +1",
            ring1="Mars's Ring",
            ring2="Patricius Ring",
            back="Canny Cape"
    })
	sets.precast.WS['Evisceration'].Mod = set_combine(sets.precast.WS['Evisceration'], {waist="Soil Belt"})
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Mod, {neck="Shadow Gorget"})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Mod, {neck="Shadow Gorget"})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Mod, {neck="Shadow Gorget"})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {neck="Breeze Gorget",
		ear1="Brutal Earring",ear2="Trux Earring"})
	sets.precast.WS['Shark Bite'].Acc = set_combine(sets.precast.WS['Shark Bite'], {head="Whirlpool Mask"})
	sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {waist="Thunder Belt"})
	sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {neck="Breeze Gorget"})
	sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {neck="Breeze Gorget"})
	sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {neck="Breeze Gorget"})

	sets.precast.WS['Aeolian Edge'] = {
		neck="Stoicheion Medal",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        head="Umbani Cap",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Acumen Ring",
        ring2="Stormsoul Ring",
		back="Toro Cape",
        waist="Thunder Belt",
        legs="Shneddick Tights",
        feet="Iuitl Gaiters"
    }
	
        -- Midcast Sets
	sets.midcast.FastRecast = {
		head="Felistris Mask",
        hands="Iuitl Wristbands +1",
		waist="Hurch'lan Sash"
    }
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Felistris Mask",
        hands="Iuitl Wristbands +1",
		waist="Hurch'lan Sash"
    }

	-- Ranged gear -- acc + TH
	sets.midcast.RA = {
		head="Uk'uxkaj Cap",
        neck="Huani Collar",
        ear1="Clearview Earring",
        ear2="Volley Earring",
		body="Thaumas Coat",
        hands="Iuitl Wristbands +1",
        ring1="Rajas Ring",
        ring2="Hajduk Ring",
		back="Libeccio Mantle",
        waist="Aquiline Belt",
        legs="Nahtirah Trousers",
        feet="Iuitl Gaiters"
    }

	sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)

	sets.midcast.RA.Acc = sets.midcast.RA
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {
		head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Shadow Mantle",
        waist="Patentia Sash",
        legs="Nahtirah Trousers",
        feet="Trotter Boots"
    }

	sets.idle.Town = set_combine(sets.idle, {
        ring1="Patricius Ring",
		back="Canny Cape"
    })
	
	sets.idle.Weak = sets.idle.Town
	
	sets.ExtraRegen = {ring2="Paguroidea Ring"}

	-- Defense sets

	sets.defense.Evasion = {
		head="Felistris Mask",
        neck="Asperity Necklace",
		body="Qaaxo Harness",
        hands="Plunderer's Armlets +1",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
		back="Canny Cape",
        waist="Patentia Sash",
        legs="Iuitl Tights",
        feet="Qaaxo Leggings"
    }

	sets.defense.PDT = {
		head="Lithelimb Cap",
        neck="Twilight Torque",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
		back="Shadow Mantle",
        waist="Patentia Sash",
        legs="Iuitl Tights",
        feet="Qaaxo Leggings"
    }

	sets.defense.MDT = {
		head="Whirlpool Mask",
        neck="Twilight Torque",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Dark Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Hurch'lan Sash",
        legs="Nahtirah Trousers",
        feet="Qaaxo Leggings"
    }

	sets.Kiting = {feet="Trotter Boots"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
		head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Thaumas Coat",
        hands="Iuitl Wristbands +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Canny Cape",
        waist="Patentia Sash",
        legs="Manibozho Brais",
        feet="Plunderer's Poulaines"
    }
	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Whirlpool Mask",
        neck="Iqabi Necklace",
        ring1="Patricius Ring",
        hands="Plunderer's Armlets +1",
        waist="Hurch'lan Sash",
        feet="Qaaxo Leggings"
    })
	sets.engaged.iLvl = set_combine(sets.engaged, {
		body="Qaaxo Harness",
        ring1="Patricius Ring"
    })
	sets.engaged.Evasion = set_combine(sets.engaged, {
		body="Qaaxo Harness",
        ring1="Patricius Ring",
        hands="Plunderer's Armlets +1",
        feet="Qaaxo Leggings"
    })
    sets.engaged.Evasion.iLvl = sets.engaged.Evasion
	sets.engaged.Acc.Evasion = set_combine(sets.engaged.Evasion, {
		head="Whirlpool Mask",
        waist="Hurch'lan Sash"
    })
	sets.engaged.PDT = {
		head="Lithelimb Cap",
        neck="Twilight Torque",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Dark Ring",
        ring2="Epona's Ring",
		back="Shadow Mantle",
        waist="Patentia Sash",
        legs="Iuitl Tights",
        feet="Qaaxo Leggings"
    }
	sets.engaged.Acc.PDT = sets.engaged.PDT

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	refine_waltz(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = true
	end
end


-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'Step' or spell.type == 'Flourish1' then
		if state.TreasureMode ~= 'None' then
			equip(sets.TreasureHunter)
		end
	elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
		if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.TreasureMode ~= 'None' then
		if (spell.action_type == 'Ranged Attack' or spell.action_type == 'Magic') and spell.target.type == 'MONSTER' then
			equip(sets.TreasureHunter)
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end

	-- Update the state of certain buff JAs if the action wasn't interrupted.
	if not spell.interrupted then
		-- If this wasn't an action that would have used up SATA/Feint, make sure to keep gear on.
		if spell.type ~= 'WeaponSkill' and spell.type ~= 'Step' then
			-- If SA/TA/Feint are active, put appropriate gear back on (including TH gear).
			check_buff('Sneak Attack', eventArgs)
			check_buff('Trick Attack', eventArgs)
			check_buff('Feint', eventArgs)
		end
	end
end

-- Refactor buff checks from aftercast
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
		eventArgs.handled = true
	end
end
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets construction.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
	local wsmode
	
	if state.Buff['Sneak Attack'] then
		wsmode = 'SA'
	end
	if state.Buff['Trick Attack'] then
		wsmode = (wsmode or '') .. 'TA'
	end
	
	if spell.english == 'Aeolian Edge' and state.TreasureMode ~= 'None' then
		wsmode = 'TH'
	end

	return wsmode
end

function customize_idle_set(idleSet)
	if player.hpp < 80 then
		idleSet = set_combine(idleSet, sets.ExtraRegen)
	end
	
	return idleSet
end

function customize_melee_set(meleeSet)
	if state.TreasureMode == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
	
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called if we change any user state fields.
function job_state_change(stateField, newValue, oldValue)
	if stateField == 'TreasureMode' then
		if newValue == 'None' then
			if state.show_th_message then add_to_chat(123,'TH Mode set to None. Unlocking gear.') end
			unlock_TH()
		elseif oldValue == 'None' then
			TH_for_first_hit()
		end
	end
end

-- On engaging a mob, attempt to add TH gear.  For any other status change, unlock TH gear slots.
function job_status_change(newStatus, oldStatus, eventArgs)
	if newStatus == 'Engaged' then
		if state.show_th_message then add_to_chat(123,'Engaging '..player.target.id..'.') end
		TH_for_first_hit()
	else
		if state.show_th_message then add_to_chat(123,'Disengaging. Unlocking TH.') end
		unlock_TH()
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
end

-- On changing targets, attempt to add TH gear.
function on_target_change(target_index)
	-- Only care about changing targets while we're engaged, either manually or via current target death.
	if player.status == 'Engaged' then
		-- If current player.target.index isn't the same as the target_index parameter,
		-- that indicates that the sub-target cursor is being used.  Ignore it.
		if player.target.index == target_index then
			if state.show_th_message then add_to_chat(123,'Changing target to '..player.target.id..'.') end
			TH_for_first_hit()
			handle_equipping_gear(player.status)
		end
	end
end

-- Clear out the entire tagged mobs table when zoning.
function on_zone_change(new_zone, old_zone)
	if state.show_th_message then add_to_chat(123,'Zoning. Clearing tagged mobs table.') end
	tagged_mobs:clear()
end


-------------------------------------------------------------------------------------------------------------------
-- Various update events.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	if player.status ~= 'Engaged' or cmdParams[1] == 'tagged' then
		unlock_TH()
	end
	
	if state.show_th_message and cmdParams[1] == 'user' then
		print_set(tagged_mobs, 'Tagged mobs')
	end
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
	-- Check that ranged slot is locked, if necessary
	check_range_lock()
	
	-- Don't allow normal gear equips if SA/TA/Feint is active.
	if state.Buff['Sneak Attack'] or state.Buff['Trick Attack'] or state.Buff['Feint'] then
		eventArgs.handled = true
	end
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
	local defenseString = ''
	if state.Defense.Active then
		local defMode = state.Defense.PhysicalMode
		if state.Defense.Type == 'Magical' then
			defMode = state.Defense.MagicalMode
		end

		defenseString = 'Defense: '..state.Defense.Type..' '..defMode..'  '
	end
	
	add_to_chat(122,'Melee: '..state.OffenseMode..'/'..state.DefenseMode..'  WS: '..state.WeaponskillMode..'  '..
		defenseString..'Kiting: '..on_off_names[state.Kiting]..'  TH: '..state.TreasureMode)

	eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
	if player.equipment.range ~= 'empty' then
		disable('range', 'ammo')
	else
		enable('range', 'ammo')
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(5, 2)
	elseif player.sub_job == 'WAR' then
		set_macro_page(5, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 5)
	else
		set_macro_page(5, 2)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Functions and events to support TH handling.
-------------------------------------------------------------------------------------------------------------------

-- Set locked TH flag to true, and disable relevant gear slots.
function lock_TH()
	state.th_gear_is_locked = true
	for slot,item in pairs(sets.TreasureHunter) do
		disable(slot)
	end
end

-- Set locked TH flag to false, and enable relevant gear slots.
function unlock_TH()
	state.th_gear_is_locked = false
	for slot,item in pairs(sets.TreasureHunter) do
		enable(slot)
	end
end

-- For any active TH mode, if we haven't already tagged this target, equip TH gear and lock slots until we manage to hit it.
function TH_for_first_hit()
	if state.TreasureMode ~= 'None' and not tagged_mobs[player.target.id] then
		if state.show_th_message then add_to_chat(123,'Prepping for first hit on '..player.target.id..'.') end
		equip(sets.TreasureHunter)
		lock_TH()
	else
		if state.show_th_message then add_to_chat(123,'Prepping for first hit on '..player.target.id..'.  Has already been tagged. Unlocking TH.') end
		unlock_TH()
	end
end


-- On any action event, mark mobs that we tag with TH.  Also, update the last time tagged mobs were acted on.
function on_action(action)
	--add_to_chat(123,'cat='..action.category..',param='..action.param)
	-- If player takes action, adjust TH tagging information
	if action.actor_id == player.id and state.TreasureMode ~= 'None' then
		-- category == 1=melee, 2=ranged, 3=weaponskill, 4=spell, 6=job ability, 14=unblinkable JA
		if state.TreasureMode == 'Fulltime' or
		   (state.TreasureMode == 'SATA' and (state.Buff['Sneak Attack'] or state.Buff['Trick Attack']) and (action.category == 1 or action.category == 3)) or
		   (state.TreasureMode == 'Tag' and action.category == 1 and state.th_gear_is_locked) or -- Tagging with a melee hit
		   (action.category == 2 or action.category == 4) or -- Any ranged or magic action
		   (action.category == 3 and action.param == 30) or -- Aeolian Edge
		   (action.category == 6 and info.ja_ids:contains(action.param)) or -- Provoke, Animated Flourish
		   (action.category == 14 and info.u_ja_ids:contains(action.param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		   then
			for index,target in pairs(action.targets) do
				if not tagged_mobs[target.id] and state.show_th_message then
					add_to_chat(123,'Mob '..target.id..' hit. Adding to tagged mobs table.')
				end
				tagged_mobs[target.id] = os.time()
			end

			if state.th_gear_is_locked then
				send_command('gs c update tagged')
			end
		end
	elseif tagged_mobs[action.actor_id] then
		-- If mob acts, keep an update of last action time for TH bookkeeping
		tagged_mobs[action.actor_id] = os.time()
	else
		-- If anyone else acts, check if any of the targets are our tagged mobs
		for index,target in pairs(action.targets) do
			if tagged_mobs[target.id] then
				tagged_mobs[target.id] = os.time()
			end
		end
	end

	cleanup_tagged_mobs()
end


-- If we're notified of a mob's death, remove it from the list of tagged mobs.
function on_action_message(actor_id, target_id, actor_index, target_index, message_id, param_1, param_2, param_3)
	-- Remove mobs that die from our tagged mobs list.
	if tagged_mobs[target_id] then
		-- 6 == actor defeats target
		-- 20 == target falls to the ground
		if message_id == 6 or message_id == 20 then
			if state.show_th_message then add_to_chat(123,'Mob '..target_id..' died. Removing from tagged mobs table.') end
			tagged_mobs[target_id] = nil
		end
	end
end
-- Remove mobs that we've marked as tagged with TH if we haven't seen any activity from or on them
-- for over 3 minutes.  This is to handle deagros, player deaths, or other random stuff where the
-- mob is lost, but doesn't die.
function cleanup_tagged_mobs()
	-- If it's been more than 3 minutes since an action on or by a tagged mob,
	-- remove them from the tagged mobs list.
	local current_time = os.time()
	local remove_mobs = S{}
	-- Search list and flag old entries.
	for target_id,action_time in pairs(tagged_mobs) do
		local time_since_last_action = current_time - action_time
		if time_since_last_action > 180 then
			remove_mobs:add(target_id)
			if state.show_th_message then add_to_chat(123,'Over 3 minutes since last action on mob '..target_id..'. Removing from tagged mobs list.') end
		end
	end
	-- Clean out mobs flagged for removal.
	for mob_id,_ in pairs(remove_mobs) do
		tagged_mobs[mob_id] = nil
	end
end

