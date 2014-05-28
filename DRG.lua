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
--	state.CombatForm = get_combat_form()
	
	state.Buff = {}
  end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'STP'}
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

	select_default_macro_book(1, 16)
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
	sets.precast.JA.Angon = {ammo="Angon",hands="Wyrm Finger Gauntlets +2"}
	sets.precast.JA.Jump = {
        ammo="Hagneia Stone",
		head="Quauhpilli helm",
        neck="Asperity Necklace",
        ear1="Steelflash Earring",
        ear2="Bladeborn Earring",
		body="Lncr. Plackart +2",
        hands="Cizin Mufflers",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Cizin Breeches",
        feet="Cizin Greaves"
    }

	sets.precast.JA['Ancient Circle'] = {}

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Wyrm Brais +2"
    }) 
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Lancer's Cuissots +2"
    })
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
        feet="Lancer's Schynbalds +2"
    })
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {hands="Lnc. Vmbrc. +1"}
	sets.precast.JA['Call Wyvern'] = {body="Wyrm Mail"}
	sets.precast.JA['Deep Breathing'] = {hands="Wyrm Armet"}
	sets.precast.JA['Spirit Surge'] = { --body="Wyrm Mail +2"
    }

	
	-- Healing Breath sets
	sets.HB = {
        ammo="Hagneia Stone",
		head="Wyrm Armet",
        neck="Lancer's Torque",
        ear1="Steelflash Earring",
        ear2="Bladeborn Earring",
		body="Cizin Mail",
        hands="Cizin Mufflers",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Cizin Breeches",
        feet="Mikinaak Greaves"
    }
	sets.HB.Pre = {}
	sets.HB.Mid = sets.HB		

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Yaoyotl Helm",
		body="Mikinaak Breastplate",hands="Cizin Mufflers",ring1="Rajas Ring",
		back="Atheling Mantle",legs="Cizin Breeches",feet="Whirlpool Greaves"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.midcast.Breath = 
	set_combine(
		sets.midcast.FastRecast, 
		{ head="Wyrm Armet" })
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {head="Cizin Helm"}
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Lithelimb Cap",
		body="Mikinaak Breastplate",hands="Cizin Mufflers",
		legs="Cizin Breeches",feet="Whirlpool Greaves",waist="Zoran's Belt"}	
		
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

	sets.precast.WS = {
        ammo="Thew Bomblet",
		head="Yaoyotl Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Trux Earring",
		body="Mikiknaak Breastplate",
        hands="Cizin Mufflers",
        ring1="Rajas Ring",
        ring2="Pyrosoul Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Cizin Breeches",
        feet="Whirlpool Greaves"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {neck="Shadow Gorget",waist="Soil Belt"})
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {neck="Shadow Gorget",waist="Soil Belt"})
	sets.precast.WS['Stardiver'].Mod = set_combine(sets.precast.WS['Stardiver'], {neck="Shadow Gorget",waist="Soil Belt"})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {neck="Light Gorget"})
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {neck="Light Gorget"})
	sets.precast.WS['Drakesbane'].Mod = set_combine(sets.precast.WS['Drakesbane'], {waist="Light Belt"})

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
        head="Twilight Helm",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Twilight Mail",
        hands="Cizin Mufflers",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
		back="Shadow Mantle",
        waist="Zoran's Belt",
        legs="Crimson Cuisses",
        feet="Whirlpool Greaves"
    }
	

	-- Idle sets
	sets.idle = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {
        ammo="Thew Bomblet",
		head="Yaoyotl Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
		body="Lancer's plackart +2",
        hands="Cizin Mufflers",
        ring1="Rajas Ring",
        ring2="Paguroidea Ring",
		back="Atheling Mantle",
        waist="Cetl Belt",
        legs="Crimson Cuisses",
        feet="Whirlpool Greaves"
    }
	
	sets.idle.Field = set_combine(sets.idle.Town, {
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Cizin Mail",
        ring1="Dark Ring"
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
		head="Twilight Helm",
		body="Twilight Mail",
		legs="Cizin Breeches"
    })
	
	-- Defense sets
	sets.defense.PDT = {
        ammo="Hagneia Stone",
		head="Lithelimb Cap",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Cizin Mail",
        hands="Cizin Mufflers",
        ring1="Rajas Ring",
        ring2="Dark Ring",
		back="Atheling Mantle",
        waist="Cetl Belt",
        legs="Cizin Breeches",
        feet="Cizin Greaves"
    }

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.defense.MDT = sets.defense.PDT

	sets.Kiting = {legs="Crimson Cuisses"}

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
        ammo="Hagneia Stone",
		head="Yaoyotl Helm",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Lncr. Plackart +2",
        hands="Cizin Mufflers",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
		back="Atheling Mantle",
        waist="Cetl Belt",
        legs="Cizin Breeches",
        feet="Mikinaak Greaves"
    }

	sets.engaged.Acc = set_combine(sets.engaged, {
        body="Mikinaak Breastplate",
        hands="Mikinaak Gauntlets",
        waist="Dynamic Belt",
        feet="Whirlpool Greaves"
    })

	sets.engaged.STP = set_combine(sets.engaged, {
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
        legs="Phorcys Dirs"
    })

	sets.engaged.STP.PDT = set_combine(sets.engaged.STP, {
        body="Cizin Mail",
        legs="Cizin Breeches"
        ring2="Dark Ring"
        back="Repulse Mantle"
    })
    
    sets.engaged.PDT = set_combine(sets.engaged, {
        body="Cizin Mail",
        ring2="Dark Ring",
        back="Repulse Mantle"
    })

	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        body="Cizin Mail",
        hands="Cizin Mufflers",
        legs="Cizin Breeches",
        ring2="Dark Ring"
    })

	sets.engaged.Reraise = set_combine(sets.engaged, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.engaged.Acc.Reraise = sets.engaged.Reraise
		

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	equip(sets.precast.FC)
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    classes.CustomClass:clear()
	if player.hpp < 51 then
		classes.CustomClass = "Breath" -- This would cause it to look for sets.midcast.Breath 
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	    classes.CustomClass:clear()
		if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
		if player.hpp < 51 then
			classes.CustomClass = "Breath" -- This would cause it to look for sets.midcast.Breath 
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	
--	if state.DefenseMode == 'Reraise' or
--		(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
--		equip(sets.Reraise)
--	end
end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' then
		equip(sets.HB.Mid)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
if state.DefenseMode == 'Reraise' or
		(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

end

function job_update(cmdParams, eventArgs)
	--state.CombatForm = get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

--function get_combat_form()
--	if areas.Adoulin:contains(world.area) and buffactive.ionis then
--		return 'Adoulin'
--	end
--end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	classes.CustomMeleeGroups:clear()
	--if areas.Adoulin:contains(world.area) and buffactive.ionis then
	--	classes.CustomMeleeGroups:append('Adoulin')
	--end
end

-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function select_default_macro_book()
	set_macro_page(1, 16)
end
