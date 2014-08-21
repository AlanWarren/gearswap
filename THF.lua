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

    include('Mote-TreasureHunter')
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
	gear.default.weaponskill_waist = "Windbuffet Belt"

	-- Additional local binds
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind !- gs c cycle targetmode')

    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()

	send_command('unbind !-')
	send_command('unbind ^[')
	send_command('unbind ![')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	sets.TreasureHunter = {hands="Plunderer's Armlets +1", feet="Raider's Poulaines +2", waist="Chaac Belt"}
    sets.ExtraRegen = { head="Ocelomeh Headpiece +1" }
	
	sets.buff['Sneak Attack'] = {
		head="Uk'uxkaj Cap",
        neck="Moepapa Medal",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Qaaxo Harness",
        hands="Pillager's Armlets +2",
        ring1="Thundersoul Ring",
        ring2="Ramuh Ring",
		back="Atheling Mantle",
        waist="Chaac Belt",
        legs="Pillager's Culottes +1",
        feet="Raider's Poulaines +2"
    }

	sets.buff['Trick Attack'] = {
		head="Felistris Mask",
        neck="Moepapa Medal",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Qaaxo Harness",
        hands="Pillager's Armlets +1",
        ring1="Stormsoul Ring",
        ring2="Garuda Ring",
		back="Canny Cape",
        waist="Chaac Belt",
        legs="Pillager's Culottes +1",
        feet="Raider's Poulaines +2"
    }
    -- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {}
	sets.precast.JA['Accomplice'] = {}
	sets.precast.JA['Flee'] = { feet="Rogue's Poulaines" }
	sets.precast.JA['Hide'] = {}
	sets.precast.JA['Conspirator'] = {} -- {body="Raider's Vest +2"}
	sets.precast.JA['Steal'] = { 
        hands="Pillager's Armlets +1",
        legs="Pillager's Culottes +1" 
    }
	sets.precast.JA['Despoil'] = {}
	sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
	sets.precast.JA['Feint'] = {hands="Plunderer's Armlets +1"} -- {legs="Assassin's Culottes +2"}
	
	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",
		legs="Nahtirah Trousers",
        feet="Iuitl Gaiters +1"
    }
	-- TH actions
	sets.precast.Step = {
        head="Whirlpool Mask",
        heck="Iqabi Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        hands="Plunderer's Armlets +1",
        back="Canny Cape",
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        waist="Chaac Belt",
        legs="Pillager's Culottes +1",
        feet="Raider's Poulaines +2"
    }
	sets.precast.Flourish1 = sets.TreasureHunter
	sets.precast.JA.Provoke = sets.TreasureHunter

	-- Fast cast sets for spells
	sets.precast.FC = {
        head="Uk'uxkaj Cap",
        ear1="Loquacious Earring",
        hands="Buremte Gloves",
        ring1="Prolix Ring",
        legs="Kaabnax Trousers"
    }
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
            neck="Magoraga Beads"
    })

	-- Ranged snapshot gear
	sets.precast.RA = {
        head="Uk'uxkaj Cap",
        hands="Iuitl Wristbands +1",
        legs="Nahtirah Trousers", 
        feet="Wurrukatte Boots"
    }
    sets.midcast.RA = {
        head="Umbani Cap",
        neck="Iqabi Necklace",
        ear1="Volley Earring",
        ear2="Clearview Earring",
        body="Skadi's Cuirie +1",
        hands="Sigyn's Bazubands",
        ring1="Longshot Ring",
        ring2="Hajduk Ring",
        back="Libeccio Mantle",
        waist="Elanid Belt",
        legs="Aetosaur Trousers +1",
        feet="Iuitl Gaiters +1"
    }
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Windbuffet Belt"
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
        legs="Pillager's Culottes +1",
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
        head="Lithelimb Cap", 
        neck="Moepapa Medal",
        ear1="Trux Earring",
        ear2="Brutal Earring",
        ring1="Stormsoul Ring",
        ring2="Garuda Ring",
		legs="Quiahuiz Trousers", 
        waist="Elanid Belt",
        back="Canny Cape"
    })
	sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {
        hands="Plunderer's Armlets +1",
        ring1="Mars's Ring",
        ring2="Patricius Ring",
        back="Canny Cape"
    })
	sets.precast.WS['Exenterator'].Mod = set_combine(sets.precast.WS['Exenterator'], {waist="Thunder Belt"})
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'].Mod, {
        neck="Breeze Gorget", hands="Pillager's Armlets +1", legs="Pillager's Culottes +1", back="Rancorous Mantle"
    })
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'].Mod, {neck="Breeze Gorget",
        hands="Pillager's Armlets +1"
    })
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'].Mod, {neck="Breeze Gorget"})

	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {neck="Breeze Gorget", waist="Thunder Belt"})
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {head="Whirlpool Mask"})
	sets.precast.WS['Dancing Edge'].Mod = set_combine(sets.precast.WS['Dancing Edge'], {waist="Thunder Belt"})
	sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {neck="Breeze Gorget"})
	sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {neck="Breeze Gorget"})
	sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'].Mod, {neck="Breeze Gorget"})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        head="Uk'uxkaj Cap",
        neck="Moepapa Medal",
		ear1="Brutal Earring",
        ear2="Trux Earring",
        hands="Pillager's Armlets +1",
        ring1="Ramuh Ring",
        waist="Light Belt",
        legs="Pillager's Culottes +1",
        back="Atheling Mantle",
        feet="Plunderer's Poulaines"
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

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Uk'uxkaj Cap", neck="Breeze Gorget",
		ear1="Brutal Earring",ear2="Trux Earring", hands="Pillager's Armlegs +1", ring1="Ramuh Ring", ring2="Garuda Ring",
        legs="Pillager's Culottes +1"})
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
        ring2="Garuda Ring",
		back="Toro Cape",
        waist="Thunder Belt",
        legs="Shneddick Tights",
        feet="Iuitl Gaiters +1"
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
		waist="Hurch'lan Sash",
        legs="Kaabnax Trousers"
    }

	-- Ranged gear -- acc + TH
	sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)

	sets.midcast.RA.Acc = sets.midcast.RA
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		head="Ocelomeh Headpiece +1",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Kheper Jacket",
        hands="Iuitl Wristbands +1",
        ring1="Paguroidea Ring",
        ring2="Epona's Ring",
		back="Repulse Mantle",
        waist="Patentia Sash",
        legs="Pillager's Culottes +1",
        feet="Skadi's Jambeaux +1"
    }

	sets.idle.Town = set_combine(sets.idle, {
        head="Felistris Mask",
        body="Skadi's Cuirie +1",
        hands="Pillager's Armlets +1",
        back="Canny Cape",
        ring1="Oneiros Ring",
        ring2="Epona's Ring"
    })
	
	sets.idle.Weak = sets.idle

	-- Defense sets

	sets.defense.Evasion = {
		head="Felistris Mask",
        neck="Asperity Necklace",
		body="Qaaxo Harness",
        hands="Pillager's Armlets +1",
        ring1="Beeline Ring",
        ring2="Epona's Ring",
		back="Canny Cape",
        waist="Nusku's Sash",
        legs="Pillager's Culottes +1",
        feet="Qaaxo Leggings"
    }

	sets.defense.PDT = {
		head="Lithelimb Cap",
        neck="Twilight Torque",
		body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
		back="Repulse Mantle",
        waist="Patentia Sash",
        legs="Pillager's Culottes +1",
        feet="Iuitl Gaiters +1"
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
		body="Skadi's Cuirie +1",
        hands="Iuitl Wristbands +1",
        ring1="Oneiros Ring",
        ring2="Epona's Ring",
		back="Canny Cape",
        waist="Patentia Sash",
        legs="Pillager's Culottes +1",
        feet="Plunderer's Poulaines"
    }
	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Whirlpool Mask",
        neck="Iqabi Necklace",
		body="Qaaxo Harness",
        ring1="Patricius Ring",
        hands="Buremte Gloves",
        waist="Hurch'lan Sash",
        feet="Qaaxo Leggings"
    })
	sets.engaged.iLvl = set_combine(sets.engaged, {
		body="Qaaxo Harness",
    })
    sets.engaged.iLvl.PDT = set_combine(sets.engaged.iLvl, {
        head="Lithelimb Cap",
        ring1="Patricius Ring",
        feet="Iuitl Gaiters +1"
    })
	sets.engaged.Evasion = set_combine(sets.engaged, {
		body="Qaaxo Harness",
        ring1="Beeline Ring",
        hands="Pillager's Armlets +1",
        --feet="Qaaxo Leggings"
    })
    sets.engaged.iLvl.Evasion = sets.engaged.Evasion
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
        ring1="Patricius Ring",
        ring2="Epona's Ring",
		back="Repulse Mantle",
        waist="Patentia Sash",
        legs="Pillager's Culottes +1",
        feet="Qaaxo Leggings"
    }
	sets.engaged.Acc.PDT = sets.engaged.PDT
    
    -- Haste 43%
    sets.engaged.Haste_43 = set_combine(sets.engaged, {
        neck="Rancor Collar",
        ear1="Trux Earring",
        ear2="Brutal Earring",
        body="Thaumas Coat",
        back="Aethling Mantle",
        waist="Windbuffet Belt",
    })
    sets.engaged.Acc.Haste_43 = set_combine(sets.engaged.Haste_43, {
        head="Whirlpool Mask",
        body="Qaaxo Harness",
        neck="Rancor Collar",
        hands="Plunderer's Armlets +1",
        ring1="Mars's Ring",
        ring2="Patricius Ring",
        back="Canny Cape"
    })
    sets.engaged.iLvl.Haste_43 = set_combine(sets.engaged.Haste_43, { body="Qaaxo Harness" })
    sets.engaged.Evasion.Haste_43 = set_combine(sets.engaged.Haste_43, { body="Qaaxo Harness", ring1="Beeline Ring", feet="Qaaxo Leggings"})
    sets.engaged.PDT.Haste_43 = set_combine(sets.engaged.Haste_43, { head="Lithelimb Cap", neck="Twilight Torque", 
        body="Qaaxo Harness", ring1="Patricius Ring", ring2="Dark Ring", back="Repulse Mantle", feet="Iuitl Gaiters +1" })
    
     -- 40
    sets.engaged.Haste_40 = set_combine(sets.engaged.Haste_43, {
        ear1="Suppanomimi",
    })
    sets.engaged.Acc.Haste_40 = set_combine(sets.engaged.Acc.Haste_43, {
        ear1="Suppanomimi"
    })
    sets.engaged.iLvl.Haste_40 = set_combine(sets.engaged.Haste_40, { body="Qaaxo Harness" })
    sets.engaged.Evasion.Haste_40 = set_combine(sets.engaged.Haste_40, { body="Qaaxo Harness", ring1="Beeline Ring", feet="Qaaxo Leggings"})
    sets.engaged.PDT.Haste_40 = set_combine(sets.engaged.Haste_40, { head="Lithelimb Cap", neck="Twilight Torque", 
        body="Qaaxo Harness", ring1="Patricius Ring", ring2="Dark Ring", back="Repulse Mantle", feet="Iuitl Gaiters +1" })

     -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_40, {
        waist="Patentia Sash"
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Acc.Haste_40, {
        waist="Patentia Sash"
    })
    sets.engaged.iLvl.Haste_30 = set_combine(sets.engaged.Haste_30, { body="Qaaxo Harness" })
    sets.engaged.Evasion.Haste_30 = set_combine(sets.engaged.Haste_30, { body="Qaaxo Harness", ring1="Beeline Ring", feet="Qaaxo Leggings"})
    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, { head="Lithelimb Cap", neck="Twilight Torque", 
        body="Qaaxo Harness", ring1="Patricius Ring", ring2="Dark Ring", back="Repulse Mantle", feet="Iuitl Gaiters +1" })

     -- 25
    sets.engaged.Haste_25 = set_combine(sets.engaged.Haste_30, {
        ear1="Heartseeker Earring",
        ear2="Dudgeon Earring"
    })
    sets.engaged.Acc.Haste_25 = set_combine(sets.engaged.Acc.Haste_30, {
        ear1="Heartseeker Earring",
        ear2="Dudgeon Earring"
    })
    sets.engaged.iLvl.Haste_25 = set_combine(sets.engaged.Haste_25, { body="Qaaxo Harness" })
    sets.engaged.Evasion.Haste_25 = set_combine(sets.engaged.Haste_25, { body="Qaaxo Harness", ring1="Beeline Ring", feet="Qaaxo Leggings"})
    sets.engaged.PDT.Haste_25 = set_combine(sets.engaged.Haste_25, { head="Lithelimb Cap", neck="Twilight Torque", 
        body="Qaaxo Harness", ring1="Patricius Ring", ring2="Dark Ring", back="Repulse Mantle", feet="Iuitl Gaiters +1" })
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = true
	end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.english == 'Aeolian Edge' and state.TreasureMode ~= 'None' then
		equip(sets.TreasureHunter)
	elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
		if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.TreasureMode ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end

	-- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
	if spell.type == 'WeaponSkill' and not spell.interrupted then
		state.Buff['Sneak Attack'] = false
		state.Buff['Trick Attack'] = false
		state.Buff['Feint'] = false
	end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
	-- If Feint is active, put that gear set on on top of regular gear.
	-- This includes overlaying SATA gear.
	check_buff('Feint', eventArgs)
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
	local wsmode

	if state.Buff['Sneak Attack'] then
		wsmode = 'SA'
	end
	if state.Buff['Trick Attack'] then
		wsmode = (wsmode or '') .. 'TA'
	end

	return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
	-- Check that ranged slot is locked, if necessary
	check_range_lock()

	-- Check for SATA when equipping gear.  If either is active, equip
	-- that gear specifically, and block equipping default gear.
	check_buff('Sneak Attack', eventArgs)
	check_buff('Trick Attack', eventArgs)
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
-- General hooks for change events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march', 'madrigal','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
        handle_equipping_gear(player.status)
    end
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
end


-------------------------------------------------------------------------------------------------------------------
-- Various update events.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
	th_update(cmdParams, eventArgs)
	determine_haste_group()
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

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		if state.TreasureMode == 'SATA' or state.TreasureMode == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
		eventArgs.handled = true
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
    elseif (buffactive.haste and buffactive.march == 1) or (buffactive.march == 2 and buffactive['haste samba']) then
        add_to_chat(8, '-------------Haste 30%-------------')
        classes.CustomMeleeGroups:append('Haste_30')
    elseif buffactive.embrava or buffactive.march == 2 then
        add_to_chat(8, '-------------Haste 25%-------------')
        classes.CustomMeleeGroups:append('Haste_25')
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

