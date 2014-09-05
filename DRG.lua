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
    include('Mote-TreasureHunter')
    state.TreasureMode = 'Tag'
	
	state.Buff = {}
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
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

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')

	select_default_macro_book(1, 16)
	send_command('bind ^= gs c cycle treasuremode')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end

	send_command('unbind ^`')
	send_command('unbind ^=')
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
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
		body="Lancer's Plackart +2",
        hands="Lancer's Vambraces +2",
        ring1="Rajas Ring",
        ring2="Oneiros Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Ares' Flanchard +1",
        feet="Cizin Greaves +1"
    }

	sets.precast.JA['Ancient Circle'] = {}
	sets.TreasureHunter = {waist="Chaac Belt"}

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {
    }) 
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Lancer's Cuissots +2"
    })
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Lancer's Cuissots +2"
        --feet="Lancer's Schynbalds +2"
    })
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {hands="Lancer's Vambraces +2"}
	sets.precast.JA['Call Wyvern'] = {body="Wyrm Mail"}
	sets.precast.JA['Deep Breathing'] = {--head="Wyrm Armet +1"
    }
	sets.precast.JA['Spirit Surge'] = { --body="Wyrm Mail +2"
    }
	
	-- Healing Breath sets
	sets.HB = {
        ammo="Hagneia Stone",
		head="Wyrm Armet",
        neck="Lancer's Torque",
        ear1="Steelflash Earring",
        ear2="Bladeborn Earring",
		body="Xaddi Mail",
        hands="Cizin Mufflers +1",
        ring1="Dark Ring",
        ring2="K'ayres Ring",
		back="Updraft Mantle",
        waist="Glassblower's Belt",
        legs="Xaddi Cuisses",
        feet="Wyrm Greaves +2"
    }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Yaoyotl Helm",
		body="Mikinaak Breastplate",hands="Cizin Mufflers +1",ring1="Rajas Ring",
		back="Atheling Mantle",legs="Xaddi Cuisses",feet="Whirlpool Greaves"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
        head="Cizin Helm", 
        ear1="Loquacious Earring", 
        hands="Buremte Gloves",
        ring1="Prolix Ring"
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Otomi Helm",
        hands="Cizin Mufflers +1",
		legs="Xaddi Cuisses",
        feet="Ejekamal Boots",
        waist="Zoran's Belt"
    }	
		
	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { head="Wyrm Armet", waist="Glassblower's Belt" })
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	sets.precast.WS = {
        ammo="Thew Bomblet",
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
		body="Gorney Haubert +1",
        hands="Mikinaak Gauntlets",
        ring1="Ifrit Ring",
        ring2="Pyrosoul Ring",
		back="Buquwik Cape",
        waist="Windbuffet Belt",
        legs="Scuffler's Cosciales",
        feet="Ejekamal Boots"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        head="Yaoyotl Helm",
        legs="Xaddi Cuisses"
    })
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        back="Buquwik Cape",
        waist="Soil Belt"
    })
	sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {
        head="Yaoyotl Helm",
        feet="Mikinaak Greaves"
    })
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {neck="Shadow Gorget",waist="Soil Belt"})

    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
        neck="Breeze Gorget",
        body="Phorcys Korazin",
        back="Buquwik Cape",
        waist="Metalsinger Belt",
        feet="Whirlpool Greaves"
    })
	sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {
        head="Yaoyotl Helm", 
        ear1="Bladeborn Earring", 
        ear2="Steelflash Earring", 
        back="Updraft Mantle"
    })
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
        neck="Flame Gorget", 
        hands="Cizin Mufflers +1",
        waist="Light Belt",
        ring2="Pyrosoul Ring",
        legs="Lancer's Cuissots +2"
    })
	sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {head="Yaoyotl Helm"})
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {hands="Mikinaak Gauntlets"})

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
        head="Twilight Helm",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Twilight Mail",
        hands="Cizin Mufflers +1",
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
        ammo="Hagneia Stone",
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
		body="Ares' Cuirass +1",
        hands="Ares' Gauntlets +1",
        ring1="Patricius Ring",
        ring2="Oneiros Ring",
		back="Atheling Mantle",
        waist="Cetl Belt",
        legs="Crimson Cuisses",
        feet="Ejekamal Boots"
    }
	
	sets.idle.Field = set_combine(sets.idle.Town, {
        head="Twilight Helm",
        neck="Twilight Torque",
		body="Ares' Cuirass +1",
        ring2="Paguroidea Ring",
        back="Repulse Mantle"
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
		head="Twilight Helm",
		body="Twilight Mail",
    })
	
	-- Defense sets
	sets.defense.PDT = {
        ammo="Hagneia Stone",
		head="Ighwa Cap",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Cizin Mail +1",
        hands="Cizin Mufflers +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
		back="Repulse Mantle",
        waist="Cetl Belt",
        legs="Cizin Breeches +1",
        feet="Cizin Greaves +1"
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
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
		body="Xaddi Mail",
        hands="Cizin Mufflers +1",
        ring1="Rajas Ring",
        ring2="Oneiros Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Xaddi Cuisses",
        feet="Ejekamal Boots"
    }

	sets.engaged.Mid = set_combine(sets.engaged, {
        head="Yaoyotl Helm",
        back="Updraft Mantle",
        hands="Xaddi Gauntlets",
        ring2="K'ayres Ring",
        feet="Ejekamal Boots"
    })

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        neck="Iqabi Necklace",
        hands="Mikinaak Gauntlets",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        ring1="Patricius Ring"
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
        head="Ighwa Cap",
        neck="Twilight Torque",
        body="Cizin Mail +1",
        ring1="Rajas Ring",
        ring2="Patricius Ring",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
        feet="Cizin Greaves +1"
    })
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        head="Ighwa Cap",
        ring2="Patricius Ring",
        body="Cizin Mail +1",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        head="Ighwa Cap",
        ring2="Patricius Ring",
        body="Cizin Mail +1",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
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
    if spell.english == "Spirit Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command('Jump')
        end
    elseif spell.english == "Soul Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command("High Jump")
        end
    end

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    custom_aftermath_timers_precast(spell)
	if spell.action_type == 'Magic' then
	equip(sets.precast.FC)
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if player.hpp < 51 then
		classes.CustomClass = "Breath" -- This would cause it to look for sets.midcast.Breath 
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
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
if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' or spell.english == 'Steady Wing' or spell.english == 'Smiting Breath' then
		equip(sets.HB)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    custom_aftermath_timers_aftercast(spell)
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
	if state.TreasureMode == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
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
	classes.CustomMeleeGroups:clear()
	th_update(cmdParams, eventArgs)
	state.CombatForm = get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
	if areas.Adoulin:contains(world.area) and buffactive.ionis then
		return 'Adoulin'
	end
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
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(8, 1)
    elseif player.sub_job == 'WHM' then
    	set_macro_page(8, 2)
    else
    	set_macro_page(8, 1)
    end
end
