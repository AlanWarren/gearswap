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

	tag_with_th = false	
	tp_on_engage = 0
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'iLvl'}
	options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
	options.RangedModes = {'Normal', 'TH', 'Acc'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'Evasion', 'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.RangedMode = 'TH'
	state.Defense.PhysicalMode = 'Evasion'

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
	
	sets.TreasureHunter = {hands="Plunderer's Armlets", feet="Raider's Poulaines +2"}
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {}
	sets.precast.JA['Accomplice'] = {}
	sets.precast.JA['Flee'] = {}
	sets.precast.JA['Hide'] = {}
	sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
	sets.precast.JA['Steal'] = {}
	sets.precast.JA['Despoil'] = {}
	sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets"}
	sets.precast.JA['Feint'] = {hands="Plunderer's Armlets"} -- {legs="Assassin's Culottes +2"}
	
	sets.precast.JA['Sneak Attack'] = {
		head="Uk'uxkaj Cap",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Manibozho Jerkin",hands="Raider's Armlets +2",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Twilight Belt",legs="Manibozho Brais",feet="Iuitl Gaiters"}

	sets.precast.JA['Trick Attack'] = {
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Manibozho Jerkin",hands="Iuitl Wristbands",ring1="Stormsoul Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Nusku's Sash",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",
		legs="Nahtirah Trousers",feet="Iuitl Gaiters"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Ranged snapshot gear
	sets.precast.RangedAttack = {hands="Iuitl Wristbands",legs="Nahtirah Trousers"}

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Cetl Belt"
	sets.precast.WS = {
		head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Cetl Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {neck="Breeze Gorget",ring1="Stormsoul Ring",
		legs="Nahtirah Trousers", wasit="Thunder Belt"})
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {head="Whirlpool Mask"})
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

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {head="Uk'uxkaj Cap",neck="Shadow Gorget",
		ear1="Brutal Earring",ear2="Trux Earring",waist="Light Belt"})
	sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {head="Whirlpool Mask"})
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
		neck="Atzintli Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Manibozho Jerkin",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Stormsoul Ring",
		back="Toro Cape",waist="Thunder Belt",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	
        -- Midcast Sets
	sets.midcast.FastRecast = {
		head="Felistris Mask",
		body="Iuitl Vest",hands="Iuitl Wristbands",
		waist="Twilight Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		head="Felistris Mask",
		body="Iuitl Vest",hands="Iuitl Wristbands",
		waist="Twilight Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	-- Ranged gear -- acc + TH
	sets.midcast.RangedAttack = {
		head="Uk'uxkaj Cap",neck="Huani Collar",ear1="Clearview Earring",ear2="Volley Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Hajduk Ring",
		back="Libeccio Mantle",waist="Aquiline Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

	sets.midcast.RangedAttack.TH = set_combine(sets.midcast.RangedAttack, set.TreasureHunter)

	sets.midcast.RangedAttack.Acc = sets.midcast.RangedAttack
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Thaumas Coat",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Nusku's Sash",legs="Nahtirah Trousers",feet="Trotter Boots"}

	sets.idle.Town = {main="Izhiikoh", sub="Eminent Dagger",ranged="Raider's Boomerang",
		head="Felistris Mask",neck="Rancor Collar",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Thaumas Coat",hands="Raider's Armlets +2",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Nusku's Sash",legs="Manibozho Brais",feet="Trotter Boots"}
	
	sets.idle.Weak = sets.idle
	
	sets.ExtraRegen = {ring2="Paguroidea Ring"}

	-- Defense sets

	sets.defense.Evasion = {
		head="Felistris Mask",neck="Asperity Necklace",
		body="Manibozho Jerkin",hands="Iuitl Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Nusku's Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}

	sets.defense.PDT = {
		head="Lithelimb Cap",neck="Twilight Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Nusku's Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}

	sets.defense.MDT = {
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Twilight Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters"}

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
        hands="Plunderer's Armlets",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Nusku's Sash",
        legs="Manibozho Brais",
        feet="Plunderer's Poulaines"
    }
	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Whirlpool Mask",
        neck="Rancor Collar",
        waist="Hurch'lan Sash",
        feet="Manibozho Boots"
    })
	sets.engaged.iLvl = {
		head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Thaumas Coat",
        hands="Plunderer's Armlets",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Nusku's Sash",
        legs="Manibozho Brais",
        feet="Plunderer's Poulaines"
    }
	sets.engaged.Evasion = {
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Manibozho Jerkin",hands="Plunderer's Armlets",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Nusku's Sash",legs="Iuitl Tights",feet="Plunderer's Poulaines"}
	sets.engaged.Acc.Evasion = set_combine(sets.engaged.Evasion, {
		head="Whirlpool Mask",waist="Hurch'lan Sash"})
	sets.engaged.PDT = {
		head="Lithelimb Cap",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Nusku's Sash",legs="Iuitl Tights",feet="Iuitl Gaiters"}
	sets.engaged.Acc.PDT = sets.engaged.PDT

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'Waltz' then
		refine_waltz(spell, action, spellMap, eventArgs)
	end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
end


-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'Step' or spell.type == 'Flourish1' then
		if state.TreasureMode ~= 'None' then
			equip(sets.TreasureHunter)
		end
	elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
		if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' or tag_with_th then
			equip(sets.TreasureHunter)
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	-- Update the state of certain buff JAs if the action wasn't interrupted.
	if not spell.interrupted then
		if state.Buff[spell.name] ~= nil then
			state.Buff[spell.name] = true
		end
		
		-- Don't let aftercast revert gear set for SA/TA/Feint
		if S{'Sneak Attack', 'Trick Attack', 'Feint'}:contains(spell.english) then
			eventArgs.handled = true
		end
		
		-- If this wasn't an action that would have used up SATA/Feint, make sure to put gear back on.
		if spell.type:lower() ~= 'weaponskill' and spell.type:lower() ~= 'step' then
			-- If SA/TA/Feint are active, put appropriate gear back on (including TH gear).
			if state.Buff['Sneak Attack'] then
				equip(sets.precast.JA['Sneak Attack'])
				if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' or tag_with_th then
					equip(sets.TreasureHunter)
				end
				eventArgs.handled = true
			elseif state.Buff['Trick Attack'] then
				equip(sets.precast.JA['Trick Attack'])
				if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' or tag_with_th then
					equip(sets.TreasureHunter)
				end
				eventArgs.handled = true
			elseif state.Buff['Feint'] then
				equip(sets.precast.JA['Feint'])
				if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' or tag_with_th then
					equip(sets.TreasureHunter)
				end
				eventArgs.handled = true
			end
		end
		
		if spell.target and spell.target.type == 'Enemy' then
			tag_with_th = false
			tp_on_engage = 0
		elseif (spell.type == 'Waltz' or spell.type == 'Samba') and tag_with_th then
			-- Update current TP if we spend TP before we actually hit the mob
			tp_on_engage = player.tp
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets construction.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, action, spellMap)
	local wsmode = ''
	if state.Buff['Sneak Attack'] then
		wsmode = 'SA'
	end
	if state.Buff['Trick Attack'] then
		wsmode = wsmode .. 'TA'
	end
	
	if wsmode ~= '' then
		return wsmode
	end
end

function customize_idle_set(idleSet)
	if player.hpp < 80 then
		idleSet = set_combine(idleSet, sets.ExtraRegen)
	end
	
	return idleSet
end

function customize_melee_set(meleeSet)
	if state.TreasureMode == 'Fulltime' or tag_with_th then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
	
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	check_range_lock()
	
	-- If engaging, put on TH gear.
	-- If disengaging, turn off TH tagging.
	if newStatus == 'Engaged' and state.TreasureMode ~= 'None' then
		equip(sets.TreasureHunter)
		tag_with_th = true
		tp_on_engage = player.tp
		send_command('wait 3;gs c update th')
	elseif oldStatus == 'Engaged' then
		tag_with_th = false
		tp_on_engage = 0
	end

	-- If SA/TA/Feint are active, don't change gear sets
	if satafeint_active() then
		eventArgs.handled = true
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain

		if not satafeint_active() then
			handle_equipping_gear(player.status)
		end
	end
end

-- Called when the player's subjob changes.
function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for TH mode handling.
-------------------------------------------------------------------------------------------------------------------

-- Request job-specific mode tables.
-- Return true on the third returned value to indicate an error: that we didn't recognize the requested field.
function job_get_mode_list(field)
	if field == 'Treasure' then
		return options.TreasureModes, state.TreasureMode
	end
end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)
	if field == 'Treasure' then
		state.TreasureMode = val
		return true
	end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	check_range_lock()

	if state.TreasureMode == 'None' then
		tag_with_th = false
		tp_on_engage = 0
	elseif tag_with_th and player.tp ~= tp_on_engage then
		tag_with_th = false
		tp_on_engage = 0
	elseif cmdParams[1] == 'th' and player.status == 'Engaged' then
		send_command('wait 3;gs c update th')
	end
	
	-- Update the current state of state.Buff, in case buff_change failed
	-- to update the value.
	state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
	state.Buff['Trick Attack'] = buffactive['trick attack'] or false
	state.Buff['Feint'] = buffactive['feint'] or false

	-- Don't allow normal gear equips if SA/TA/Feint is active.
	if satafeint_active() then
		eventArgs.handled = true
	end
end


-- Handle notifications of general user state change.
function job_state_change(stateField, newValue)
	if stateField == 'TreasureMode' then
		local prevRangedMode = state.RangedMode
		
		if newValue == 'Tag' or newValue == 'SATA' then
			state.RangedMode = 'TH'
		elseif state.OffenseMode == 'Acc' then
			state.RangedMode = 'Acc'
		else
			state.RangedMode = 'Normal'
		end
		
		if state.RangedMode ~= prevRangedMode then
			add_to_chat(121,'Ranged mode is now '..state.RangedMode)
		end
	elseif stateField == 'OffenseMode' then
		if state.TreasureMode == 'None' or state.TreasureMode == 'Fulltime' then
			local prevRangedMode = state.RangedMode

			if newValue == 'Acc' then
				state.RangedMode = 'Acc'
			else
				state.RangedMode = 'Normal'
			end
			
			if state.RangedMode ~= prevRangedMode then
				add_to_chat(121,'Ranged mode is now '..state.RangedMode)
			end
		end
	elseif stateField == 'Reset' then
		state.RangedMode = 'TH'
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

-- Function to indicate if any buffs have been activated that we don't want to equip gear over.
function satafeint_active()
	return state.Buff['Sneak Attack'] or state.Buff['Trick Attack'] or state.Buff['Feint']
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

