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

    enfeeblingNinjutsu = S{"yurin: ichi", "aisha: ichi", "dokumori: ichi", "kurayami: ni", "hojo: ni", "jubaku: ichi"}

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
	sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Felistris Mask",
		body="Mochizuki Chainmail +1",
        hands="Otronif Gloves",
        legs="Nahtirah Trousers",
        feet="Otronif Boots +1"
    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {
		head="Whirlpool Mask",
		body="Mochizuki Chainmail +1",
        hands="Otronif Gloves",
		back="Yokaze Mantle",
        waist="Hurch'lan Sash",
        legs="Manibozho Brais",
        feet="Manibozho Boots"
    }

	-- Fast cast sets for spells
	sets.precast.FC = {}
	--sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
    
    --earrings for WS
    sets.WsEarNoMadrigal = {ear2="Trux Earring"}
    sets.WsEarMadrigal = {ear2="Kuwunga Earring"}
    --sets.earring = select_earring()
       
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
        feet="Otronif Boots +1"
    }

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {
        neck="Breeze gorget",
		waist="Thunder Belt"
    })
	sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS['Blade: Jin'], {
        head="Whirlpool Mask", 
        legs="Hachiya Hakama +1", 
        back="Yokaze Mantle"
    })

	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
        head="Uk'uxkaj Cap",
        neck="Shadow gorget",
		ring1="Stormsoul Ring",
        back="Rancorous Mantle",
        body="Iga Ningi +2",
        legs="Nahtirah Trousers",
        waist="Soil belt"
    })
	sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'], {
        head="Whirlpool Mask", 
        legs="Hachiya Hakama +1", 
        ring1="Mars's Ring",
        back="Yokaze Mantle"
    })
	sets.precast.WS['Blade: Hi'].Mod = set_combine(sets.precast.WS['Blade: Hi'], {waist="Soil Belt"})

	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
            neck="Breeze Gorget",
            waist="Thunder Belt",
            legs="Manibozho Brais",
            ring1="Thundersoul Ring"
    })

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
		body="Mochi. Chainmail +1",
        hands="Mochizuki Tekko +1",
		waist="Hurch'lan Sash",
        legs="Mochizuki Hakama +1",
        feet="Otronif Boots +1"
    }
		
	-- any ninjutsu cast on self
	sets.midcast.SelfNinjutsu = sets.midcast.FastRecast

	sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Iga Kyahan +2"})

	-- any ninjutsu cast on enemies
	sets.midcast.Ninjutsu = {
		head="Felistris Mask",
        ear1="Lifestorm Earring",
        ear2="Psystorm Earring",
        neck="Atzintli Necklace",
		body="Mochizuki Chainmail +1",
        hands="Mochizuki Tekko +1",
		back="Toro Cape",
        waist="Hurch'lan Sash",
        legs="Mochizuki Hakama +1",
        feet="Hachiya Kyahan"
    }
    sets.midcast.EnfeebleNinjutsu = {
		head="Felistris Mask",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        neck="Atzintli Necklace",
		body="Mochizuki Chainmail +1",
        hands="Mochizuki Tekko +1",
		back="Yokaze Mantle",
        waist="Hurch'lan Sash",
        legs="Mochizuki Hakama +1",
        feet="Hachiya Kyahan"
    }
	--sets.midcast.Ninjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {ear1="Lifestorm Earring",ear2="Psystorm Earring"})
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		head="Felistris Mask",
        neck="Twilight Torque",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Kheper Jacket",
        hands="Mochizuki Tekko +1",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
		back="Shadow Mantle",
        waist="Nusku's Sash",
        legs="Mochizuki Hakama +1",
        feet="Danzo sune-ate"
    }

	sets.idle.Town = set_combine(sets.idle, {
        neck="Rancor Collar",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Yokaze Mantle"
    })
	
	sets.idle.Weak = sets.idle
	
	-- Defense sets
	sets.defense.Evasion = {
		head="Felistris Mask",
        neck="Asperity Necklace",
		body="Qaaxo Harness",
        hands="Mochizuki Tekko +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Yokaze Mantle",
        waist="Nusku's Sash",
        legs="Mochizuki Hakama +1",
        feet="Otronif Boots +1"
    }

	sets.defense.PDT = set_combine(sets.defense.Evasion, {
		head="Whirlpool Mask",
        neck="Twilight Torque",
        hands="Otronif Gloves",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
		back="Shadow Mantle",
        legs="Nahtirah Trousers",
    })

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
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
        ammo="Qirmiz Tathlum",
		head="Iga Zukin +2",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Mochizuki Chainmail +1",
        hands="Mochizuki Tekko +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Nusku's Sash",
        legs="Mochizuki Hakama +1",
        feet="Manibozho Boots"
    }
	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Whirlpool Mask",
        neck="Iqabi Necklace",
		body="Mochizuki Chainmail +1", 
		back="Yokaze Mantle",
        waist="Hurch'lan Sash",
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        legs="Hachiya Hakama",
        feet="Manibozho Boots"
    })
	sets.engaged.PDT = set_combine(sets.engaged, {
		head="Lithelimb Cap",
        body="Qaaxo Harness",
        neck="Twilight Torque",
        ring1="Patricius Ring",
        ring2="Dark Ring",
		back="Shadow Mantle",
        legs="Nahtirah Trousers",
        feet="Otronif Boots +1"
    })
    -- I do salvage v2 on nin, and this set's only
    -- purpose is to NOT USE subtle blow, so the stupid
    -- ramparts will pop mobs. otherwise, it never happens
	sets.engaged.Att = set_combine(sets.engaged, {
        ear1="Brutal Earring",
        ear2="Suppanomimi",
		body="Mochizuki Chainmail +1",
        hands="Otronif Gloves",
        ring1="Thundersoul Ring",
        waist="Hurch'lan Sash"
    })

	sets.engaged.Evasion = set_combine(sets.engaged, {
		head="Felistris Mask",
		back="Yokaze Mantle",
        ring1="Patricius Ring",
        feet="Otronif Boots +1"
    })
	sets.engaged.Acc.Evasion = set_combine(sets.engaged.Evasion, {
		head="Whirlpool Mask",
        ring2="Mars's Ring",
        waist="Hurch'lan Sash"
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
		head="Whirlpool Mask",
		waist="Hurch'lan Sash",
        ring1="Patricius Ring",
        legs="Hachiya Hakama"
    })

    sets.engaged.Haste_43 = {}
    sets.engaged.Haste_40 = {}
    sets.engaged.Haste_35 = {}
    sets.engaged.Haste_30 = {}
    sets.engaged.Haste_25 = {}
    sets.engaged.Haste_20 = {}

    -- 43
    sets.engaged.Haste_43 = set_combine(sets.engaged, {
		head="Felistris Mask",
        neck="Rancor Collar",
        ear1="Trux Earring",
        ear2="Brutal Earring",
        body="Thaumas Coat",
        waist="Windbuffet Belt",
        legs="Hachiya Hakama"
    })
    sets.engaged.Haste_43.Acc = set_combine(sets.engaged.Haste_43, {
		head="Whirlpool Mask",
        body="Mochizuki Chainmail +1",
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        waist="Hurch'lan Sash",
		back="Yokaze Mantle"
    })
    sets.engaged.Haste_43.Evasion = set_combine(sets.engaged.Haste_43, {
        body="Mochizuki Chainmail +1",
        neck="Asperity Necklace",
		back="Yokaze Mantle",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
        feet="Otronif Boots +1"
    })

	sets.engaged.Haste_43.Acc.Evasion = set_combine(sets.engaged.Haste_43.Acc, sets.engaged.Haste_43.Evasion)
	sets.engaged.Haste_43.PDT = set_combine(sets.engaged.Haste_43, sets.engaged.PDT)
	sets.engaged.Haste_43.Acc.PDT = set_combine(sets.engaged.Haste_43.PDT, sets.engaged.Haste_43.Acc)

    -- 40
    sets.engaged.Haste_40 = set_combine(sets.engaged.Haste_43, {
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Haste_40.Acc = set_combine(sets.engaged.Haste_43.Acc, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        ring1="Patricius Ring",
        ring2="Mars's Ring"
    })
    sets.engaged.Haste_40.Evasion = set_combine(sets.engaged.Haste_43.Evasion, {
        legs="Mochizuki Hakama +1",
        ring2="Epona's Ring"
    })

	sets.engaged.Haste_40.Acc.Evasion = set_combine(sets.engaged.Haste_40.Acc, sets.engaged.Haste_40.Evasion)
	sets.engaged.Haste_40.PDT = set_combine(sets.engaged.Haste_40, sets.engaged.PDT)
	sets.engaged.Haste_40.Acc.PDT = set_combine(sets.engaged.Haste_40.PDT, sets.engaged.Haste_40.Acc)

    -- 35
    sets.engaged.Haste_35 = set_combine(sets.engaged.Haste_43, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Haste_35.Acc = set_combine(sets.engaged.Haste_43.Acc, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        ring1="Patricius Ring",
        ring2="Mars's Ring"
    })
    sets.engaged.Haste_35.Evasion = set_combine(sets.engaged.Haste_43.Evasion, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        legs="Mochizuki Hakama +1"
    })

	sets.engaged.Haste_35.Acc.Evasion = set_combine(sets.engaged.Haste_35.Acc, sets.engaged.Haste_35.Evasion)
	sets.engaged.Haste_35.PDT = set_combine(sets.engaged.Haste_35, sets.engaged.PDT)
	sets.engaged.Haste_35.Acc.PDT = set_combine(sets.engaged.Haste_35.PDT, sets.engaged.Haste_35.Acc)

    -- 30
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_43, {
        head="Iga Zukin +2",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        waist="Nusku's Sash",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Haste_30.Acc = set_combine(sets.engaged.Haste_43.Acc, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        ring1="Patricius Ring",
        ring2="Mars's Ring"
    })
    sets.engaged.Haste_30.Evasion = set_combine(sets.engaged.Haste_43.Evasion, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        legs="Mochizuki Hakama +1"
    })

	sets.engaged.Haste_30.Acc.Evasion = set_combine(sets.engaged.Haste_30.Acc, sets.engaged.Haste_30.Evasion)
	sets.engaged.Haste_30.PDT = set_combine(sets.engaged.Haste_30, sets.engaged.PDT)
	sets.engaged.Haste_30.Acc.PDT = set_combine(sets.engaged.Haste_30.PDT, sets.engaged.Haste_30.Acc)

    -- 25
    sets.engaged.Haste_25 = set_combine(sets.engaged.Haste_43, {
		body="Mochizuki Chainmail +1",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        waist="Nusku's Sash",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Haste_25.Acc = set_combine(sets.engaged.Haste_43.Acc, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        ring1="Patricius Ring",
        ring2="Mars's Ring"
    })
    sets.engaged.Haste_25.Evasion = set_combine(sets.engaged.Haste_43.Evasion, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        legs="Mochizuki Hakama +1"
    })

	sets.engaged.Haste_25.Acc.Evasion = set_combine(sets.engaged.Haste_25.Acc, sets.engaged.Haste_25.Evasion)
	sets.engaged.Haste_25.PDT = set_combine(sets.engaged.Haste_25, sets.engaged.PDT)
	sets.engaged.Haste_25.Acc.PDT = set_combine(sets.engaged.Haste_25.PDT, sets.engaged.Haste_25.Acc)

    -- 20
    sets.engaged.Haste_20 = set_combine(sets.engaged.Haste_43, {
        head="Iga Zukin +2",
		body="Mochizuki Chainmail +1",
        ear1="Brutal Earring",
        ear2="Suppanomimi",
        waist="Nusku's Sash",
        legs="Mochizuki Hakama +1"
    })
    sets.engaged.Haste_20.Acc = set_combine(sets.engaged.Haste_43.Acc, {
		body="Mochizuki Chainmail +1",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        ring1="Patricius Ring",
        ring2="Mars's Ring"
    })
    sets.engaged.Haste_20.Evasion = set_combine(sets.engaged.Haste_43.Evasion, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
		body="Mochizuki Chainmail +1",
        legs="Mochizuki Hakama +1"
    })

	sets.engaged.Haste_20.Acc.Evasion = set_combine(sets.engaged.Haste_20.Acc, sets.engaged.Haste_20.Evasion)
	sets.engaged.Haste_20.PDT = set_combine(sets.engaged.Haste_20, sets.engaged.PDT)
	sets.engaged.Haste_20.Acc.PDT = set_combine(sets.engaged.Haste_20.PDT, sets.engaged.Haste_20.Acc)

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

end

function job_post_precast(spell, action, spellMap, eventArgs)
    --sets.earring = select_earring()
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
    --sets.earring = select_earring()
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
    --sets.earring = select_earring()
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
    --meleeSet = set_combine(meleeSet, select_earring())
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
	if S{'haste','march', 'madrigal','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
    end
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end
    handle_equipping_gear(player.status)
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

function select_earring()
	if buffactive.madrigal and buffactive.march then
	    add_to_chat(8,'Madrigal + March Active - Using Special Earrings!')
        return sets.WsEarMadrigal
    else
        return sets.WsEarNoMadrigal
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

