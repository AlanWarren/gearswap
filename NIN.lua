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
	state.Buff.Doomed = buffactive.doomed or false

	determine_haste_group()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	options.OffenseModes = {'Normal', 'Acc', 'Att'}
	options.DefenseModes = {'Normal', 'Evasion', 'PDT'}
	options.WeaponskillModes = {'Normal', 'Acc', 'Att', 'Mod'}
	options.CastingModes = {'Normal'}
	options.IdleModes = {'Normal'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT', 'Evasion'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	if binds_on_unload then
		binds_on_unload()
	end
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Precast sets to enhance JAs
	sets.precast.JA['Mijin Gakure'] = {legs="Koga Hakama +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Felistris Mask",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",
        legs="Nahtirah Trousers",feet="Otronif Boots"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {
		head="Whirlpool Mask",
		body="Manibozho Jerkin",hands="Otronif Gloves",
		back="Yokaze Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet="Manibozho Boots"}

	-- Fast cast sets for spells
	
	sets.precast.FC = {}

	--sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Felistris Mask",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Trux Earring",
		body="Hachiya chainmail +1",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {neck="Breeze gorget",ear1="Brutal Earring",ear2="Trux Earring",
		waist="Thunder Belt"})

	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {neck="Shadow gorget",ear1="Brutal Earring",ear2="Trux Earring",
		ring1="Stormsoul Ring",legs="Nahtirah Trousers",waist="Soil belt"})
	sets.precast.WS['Blade: Hi'].Mod = set_combine(sets.precast.WS['Blade: Hi'], {waist="Soil Belt"})

	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {neck="Breeze Gorget",waist="Thunder Belt"})

	sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {neck="Thunder Gorget"})
	sets.precast.WS['Blade: Kamu'].Mod = set_combine(sets.precast.WS['Blade: Kamu'], {waist="Thunder Belt"})

	sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, {neck="Shadow Gorget"})
	sets.precast.WS['Blade: Ku'].Mod = set_combine(sets.precast.WS['Blade: Ku'], {waist="Soil Belt"})

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		neck="Breeze gorget",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
	    ring2="Stormsoul Ring",
		back="Toro Cape",
        waist="Thunder Belt"
     })
	
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Felistris Mask",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",
		waist="Twilight Belt",legs="Mochizuki Hakama",feet="Otronif Boots"}
		
	-- any ninjutsu cast on self
	sets.midcast.SelfNinjutsu = set_combine(sets.midcast.FastRecast, {})

	sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Iga Kyahan +2"})

	-- any ninjutsu cast on enemies
	sets.midcast.Ninjutsu = {
		head="Felistris Mask",ear1="Lifestorm Earring",ear2="Psystorm Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",
		back="Toro Cape",waist="Twilight Belt",legs="Nahtirah Troursers",feet="Hachiya Kyahan"}

	--sets.midcast.Ninjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {ear1="Lifestorm Earring",ear2="Psystorm Earring"})

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Danzo sune-ate"}

	sets.idle.Town = {main="Raimitsukane",sub="Kaitsuburi",ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Danzo sune-ate"}
	
	sets.idle.Weak = {
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Shadow Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Danzo sune-ate"}
	
	-- Defense sets
	sets.defense.Evasion = {
		head="Felistris Mask",neck="Asperity Necklace",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Manibozho Boots"}

	sets.defense.PDT = {
		head="Whirlpool Mask",neck="Twilight Torque",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Nusku's Sash",legs="Nahtirah Trousers",feet="Otronif Boots"}

	sets.defense.MDT = {
		head="Felistris Mask",neck="Asperity Necklace",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Otronif Boots"}


	sets.DayMovement = {feet="Danzo sune-ate"}

	sets.NightMovement = {feet="Hachiya Kyahan"}

	sets.Kiting = select_movement()


	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {ammo="Qirmiz Tathlum",
		head="Iga Zukin +2",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Manibozho Boots"}
	sets.engaged.Acc = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Rancor Collar",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
	sets.engaged.Att = {ammo="Qirmiz Tathlum",
		head="Iga Zukin +2",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Suppanomimi",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Cetl Belt",legs="Mochizuki Hakama",feet="Manibozho Boots"}
	sets.engaged.Evasion = {ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Otronif Boots"}
	sets.engaged.Acc.Evasion = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.PDT = {ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Iximulew Cape",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Otronif Boots"}
	sets.engaged.Acc.PDT = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}

	-- Custom melee group: High Haste (~20% DW)
	sets.engaged.HighHaste = {ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Manibozho Boots"}
	sets.engaged.Acc.HighHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Manibozho Boots"}
	sets.engaged.Evasion.HighHaste = {ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Otronif Boots"}
	sets.engaged.Acc.Evasion.HighHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.PDT.HighHaste = {ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Nusku's Sash",legs="Mochizuki Hakama",feet="Otronif Boots"}
	sets.engaged.Acc.PDT.HighHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}

	-- Custom melee group: Embrava Haste (7% DW)
	sets.engaged.EmbravaHaste = {ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Thaumas Coat",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.Acc.EmbravaHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.Evasion.EmbravaHaste = {ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Windbuffet Belt",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.Acc.Evasion.EmbravaHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.PDT.EmbravaHaste = {ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.Acc.PDT.EmbravaHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}

	-- Custom melee group: Max Haste (0% DW)
	sets.engaged.MaxHaste = {ammo="Qirmiz Tathlum",
		head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Atheling Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.Acc.MaxHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Thaumas Coat",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Manibozho Boots"}
	sets.engaged.Evasion.MaxHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Hachiya Chainmail +1",hands="Mochizuki Tekko +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Windbuffet Belt",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.Acc.Evasion.MaxHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Hachiya Hakama",feet="Otronif Boots"}
	sets.engaged.PDT.MaxHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Shadow Mantle",waist="Windbuffet Belt",legs="Manibozho Brais",feet="Otronif Boots"}
	sets.engaged.Acc.PDT.MaxHaste = {ammo="Qirmiz Tathlum",
		head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Hachiya Chainmail +1",hands="Otronif Gloves",ring1="Dark Ring",ring2="Epona's Ring",
		back="Yokaze Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Otronif Boots"}


	sets.buff.Migawari = {body="Iga Ningi +2"}
	sets.buff.Doomed = {}
	sets.buff.Yonin = {}
	sets.buff.Innin = {}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	refine_waltz(spell, action, spellMap, eventArgs)
	if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' and spellMap ~= "Utsusemi" then
		classes.CustomClass = "SelfNinjutsu"
	end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.Buff.Doomed then
		equip(sets.buff.Doomed)
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted and spell.english == "Migawari: Ichi" then
		state.Buff.Migawari = true
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
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	idleSet = set_combine(idleSet, select_movement())
	if state.Buff.Migawari then
		idleSet = set_combine(idleSet, sets.buff.Migawari)
	end
	if state.Buff.Doomed then
		idleSet = set_combine(idleSet, sets.buff.Doomed)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Migawari then
		meleeSet = set_combine(meleeSet, sets.buff.Migawari)
	end
	if state.Buff.Doomed then
		meleeSet = set_combine(meleeSet, sets.buff.Doomed)
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
	if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
		handle_equipping_gear(player.status)
	end
end

-- Called when the player's subjob changes.
function sub_job_change(newSubjob, oldSubjob)
	select_default_macro_book()
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	determine_haste_group()
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

function determine_haste_group()
	-- We have three groups of DW in gear: Hachiya body/legs, Iga head + Nusku's Sash, and DW earrings
	
	-- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

	-- For high haste, we want to be able to drop one of the 10% groups.
	-- Basic gear hits capped delay (roughly) with:
	-- 1 March + Haste
	-- 2 March
	-- Haste + Haste Samba
	-- 1 March + Haste Samba
	-- Embrava
	
	-- High haste buffs:
	-- 2x Marches + Haste Samba == 19% DW in gear
	-- 1x March + Haste + Haste Samba == 22% DW in gear
	-- Embrava + Haste or 1x March == 7% DW in gear
	
	-- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
	-- Max haste buffs:
	-- Embrava + Haste+March or 2x March
	-- 2x Marches + Haste
	
	-- So we want four tiers:
	-- Normal DW
	-- 20% DW -- High Haste
	-- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
	-- 0 DW - Max Haste
	
	classes.CustomMeleeGroups:clear()
	
	if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.march == 2 and buffactive.haste then
		classes.CustomMeleeGroups:append('MaxHaste')
	elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
		classes.CustomMeleeGroups:append('EmbravaHaste')
	elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
		classes.CustomMeleeGroups:append('HighHaste')
	elseif buffactive.march == 2 then
		classes.CustomMeleeGroups:append('HighHaste')
	elseif buffactive.march == 2 then
		classes.CustomMeleeGroups:append('HighHaste')
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'THF' then
		set_macro_page(5, 3)
	else
		set_macro_page(2, 1)
	end
end

