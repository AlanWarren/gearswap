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
	sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Felistris Mask",
		body="Hachiya Chainmail +1",
        hands="Otronif Gloves",
        legs="Nahtirah Trousers",
        feet="Otronif Boots"
    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {
		head="Whirlpool Mask",
		body="Manibozho Jerkin",
        hands="Otronif Gloves",
		back="Yokaze Mantle",
        waist="Hurch'lan Sash",
        legs="Manibozho Brais",
        feet="Manibozho Boots"
    }

	-- Fast cast sets for spells
	sets.precast.FC = {}
	--sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Trux Earring",
		body="Hachiya chainmail +1",
        hands="Mochizuki Tekko +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Manibozho Brais",
        feet="Otronif Boots"
    }

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {
        neck="Breeze gorget",
		waist="Thunder Belt"
    })
	sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS['Blade: Jin'], {
        head="Whirlpool Mask", 
        legs="Hachiya Hakama", 
        back="Yokaze Mantle"
    })

	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
        head="Uk'uxkaj Cap",
        neck="Shadow gorget",
        body="Iga Ningi +2",
		ring1="Stormsoul Ring",
        legs="Nahtirah Trousers",
        waist="Soil belt"
    })
	sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'], {
        head="Whirlpool Mask", 
        legs="Hachiya Hakama", 
        back="Yokaze Mantle"
    })
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
		body="Hachiya Chainmail +1",
        hands="Mochizuki Tekko +1",
		waist="Twilight Belt",
        legs="Mochizuki Hakama",
        feet="Otronif Boots"
    }
		
	-- any ninjutsu cast on self
	sets.midcast.SelfNinjutsu = sets.midcast.FastRecast

	sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Iga Kyahan +2"})

	-- any ninjutsu cast on enemies
	sets.midcast.Ninjutsu = {
		head="Felistris Mask",
        ear1="Lifestorm Earring",
        ear2="Psystorm Earring",
		body="Hachiya Chainmail +1",
        hands="Mochizuki Tekko +1",
		back="Yokaze Mantle",
        waist="Twilight Belt",
        legs="Hachiya Hakama",
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
		body="Hachiya Chainmail +1",
        hands="Mochizuki Tekko +1",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
		back="Shadow Mantle",
        waist="Nusku's Sash",
        legs="Mochizuki Hakama",
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
		body="Hachiya Chainmail +1",
        hands="Mochizuki Tekko +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Yokaze Mantle",
        waist="Nusku's Sash",
        legs="Mochizuki Hakama",
        feet="Otronif Boots"
    }

	sets.defense.PDT = set_combine(sets.defense.Evasion, {
		head="Whirlpool Mask",
        neck="Twilight Torque",
        hands="Otronif Gloves",
        ring1="Dark Ring",
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
		body="Hachiya Chainmail +1",
        hands="Mochizuki Tekko +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
		back="Atheling Mantle",
        waist="Nusku's Sash",
        legs="Mochizuki Hakama",
        feet="Manibozho Boots"
    }
	sets.engaged.Acc = set_combine(sets.engaged, {
		head="Whirlpool Mask",
        neck="Rancor Collar",
		body="Hachiya Chainmail +1", -- temp until Mochizuki chainmail
        hands="Otronif Gloves",
		back="Yokaze Mantle",
        waist="Hurch'lan Sash",
        legs="Hachiya Hakama",
        feet="Manibozho Boots"
    })
    -- I do salvage v2 on nin, and this set's only
    -- purpose is to NOT USE subtle blow, so the stupid
    -- ramparts will pop mobs. otherwise, it never happens
	sets.engaged.Att = set_combine(sets.engaged, {
        ear1="Brutal Earring",
        ear2="Suppanomimi",
		body="Thaumas Coat",
        hands="Otronif Gloves",
        ring1="Dark Ring",
        waist="Cetl Belt"
    })

	sets.engaged.Evasion = set_combine(sets.engaged, {
		head="Felistris Mask",
		back="Yokaze Mantle",
        feet="Otronif Boots"
    })
	sets.engaged.Acc.Evasion = set_combine(sets.engaged.Evasion, {
		head="Whirlpool Mask",
        hands="Otronif Gloves",
        waist="Hurch'lan Sash",
    })
	sets.engaged.PDT = set_combine(sets.engaged, {
		head="Felistris Mask",
        neck="Twilight Torque",
		body="Otronif Harness",
        hands="Otronif Gloves",
        ring1="Dark Ring",
		back="Shadow Mantle",
        legs="Otronif Brais",
        feet="Otronif Boots"
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.PDT, {
		head="Whirlpool Mask",
		waist="Hurch'lan Sash",
        legs="Hachiya Hakama"
    })

	-- Custom melee group: High Haste (~20% DW)
	sets.engaged.HighHaste = set_combine(sets.engaged, {
		head="Felistris Mask",
        neck="Asperity Necklace"
    })
    sets.engaged.HighHasteMad = set_combine(sets.engaged.HighHaste, {
        ear1="Suppanomimi",
        ear2="Kuwunga Earring"
    })
	sets.engaged.Acc.HighHaste = set_combine(sets.engaged.HighHaste, {
		head="Whirlpool Mask",
        neck="Rancor Collar",
        hands="Otronif Gloves",
        legs="Hachiya Hakama",
		back="Yokaze Mantle"
    })
	sets.engaged.Acc.HighHasteMad = set_combine(sets.engaged.Acc.HighHaste, {
        ear1="Suppanomimi",
        ear2="Kuwunga Earring"
    })
	sets.engaged.Evasion.HighHaste = set_combine(sets.engaged.HighHaste, {
		head="Felistris Mask",
		back="Yokaze Mantle",
        feet="Otronif Boots"
    })

	sets.engaged.Evasion.HighHasteMad = set_combine(sets.engaged.Evasion.HighHaste, {
        ear1="Suppanomimi",
        ear2="Kuwunga Earring"
    })
	sets.engaged.Acc.Evasion.HighHaste = set_combine(sets.engaged.Acc.HighHaste, {
        feet="Otronif Boots"
    })

	sets.engaged.PDT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.PDT)

	sets.engaged.Acc.PDT.HighHaste = set_combine(sets.engaged.PDT.HighHaste, sets.engaged.Acc.HighHaste)

	-- Custom melee group: Embrava Haste (7% DW)
	sets.engaged.EmbravaHaste = set_combine(sets.engaged.HighHaste, {
        ear1="Brutal Earring",
        ear2="Trux Earring",
		body="Thaumas Coat",
        waist="Windbuffet Belt",
        legs="Mochizuki Hakama",
    })
	sets.engaged.EmbravaHasteMad = set_combine(sets.engaged.EmbravaHaste, {
        ear1="Trux Earring",
        ear2="Kuwunga Earring"
    })
	sets.engaged.Acc.EmbravaHaste = set_combine(sets.engaged.EmbravaHaste, {
		head="Whirlpool Mask",
        hands="Otronif Gloves",
        neck="Rancor Collar",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		back="Yokaze Mantle",
        waist="Hurch'lan Sash"
    })
	sets.engaged.Acc.EmbravaHasteMad = set_combine(sets.engaged.Acc.EmbravaHaste, 
            sets.engaged.EmbravaHasteMad)

	sets.engaged.Evasion.EmbravaHaste = set_combine(sets.engaged.EmbravaHaste, {
		body="Hachiya Chainmail +1",
		back="Yokaze Mantle",
        feet="Otronif Boots"
    })
	sets.engaged.Evasion.EmbravaHaste = set_combine(sets.engaged.Evasion.EmbravaHaste, 
            sets.engaged.EmbravaHasteMad)

	sets.engaged.Acc.Evasion.EmbravaHaste = set_combine(sets.engaged.Acc.EmbravaHaste, {
		body="Manibozho Jerkin"
    })
	sets.engaged.PDT.EmbravaHaste = set_combine(sets.engaged.EmbravaHaste, sets.engaged.PDT)

	sets.engaged.Acc.PDT.EmbravaHaste = set_combine(sets.engaged.PDT.EmbravaHaste, sets.engaged.Acc.EmbravaHaste)

	-- Custom melee group: Max Haste (0% DW)
	sets.engaged.MaxHaste = set_combine(sets.engaged.EmbravaHaste, {
        legs="Hachiya Hakama"
    })
	sets.engaged.MaxHasteMad = set_combine(sets.engaged.MaxHaste, {
        ear1="Trux Earring",
        ear2="Kuwunga Earring"
    })
	sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        head="Whirlpool Mask",
        neck="Rancor Collar",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        back="Yokaze Mantle",
        waist="Hurch'lan Sash"
    })
	sets.engaged.Acc.MaxHasteMad = set_combine(sets.engaged.Acc.MaxHaste, 
            sets.engaged.MaxHasteMad)

	sets.engaged.Evasion.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        body="Manibozho Jerkin",
        back="Yokaze Mantle",
        feet="Otronif Boots"
    })
	sets.engaged.Evasion.MaxHasteMad = set_combine(sets.engaged.Evasion.MaxHaste, 
            sets.engaged.MaxHasteMad)
	sets.engaged.Acc.Evasion.MaxHaste = set_combine(sets.engaged.Evasion.MaxHaste, {
        head="Whirlpool Mask",
        waist="Hurch'lan Sash",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring"
    })
	sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.PDT)

	sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, sets.engaged.PDT.MaxHaste)


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
	if S{'haste','march', 'madrigal','embrava','haste samba'}:contains(buff:lower()) then
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
	
	classes.CustomMeleeGroups:clear()
	
	if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
	    add_to_chat(121,'Max Haste Mode! - Embrava + BRD Songs + Haste')
        if buffactive.madrigal then
		    classes.CustomMeleeGroups:append('MaxHaste')
        else
		    classes.CustomMeleeGroups:append('MaxHaste')
        end
	elseif buffactive.march == 2 and buffactive.haste then
	    add_to_chat(121,'Max Haste Mode! - BRD Songs + Haste')
        if buffactive.madrigal then
            classes.CustomMeleeGroups:append('MaxHasteMad')
        else
		    classes.CustomMeleeGroups:append('MaxHaste')
        end
	elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
	    add_to_chat(121,'Embrava Haste Mode! - Embrava + BRD Songs OR Haste')
        if buffactive.madrigal then
		    classes.CustomMeleeGroups:append('EmbravaHasteMad')
        else
		    classes.CustomMeleeGroups:append('EmbravaHaste')
        end
	elseif buffactive.haste and buffactive.march == 1 then
	    add_to_chat(121,'High Haste Mode! - 1 March + Haste Spell')
        if buffactive.madrigal then
		    classes.CustomMeleeGroups:append('HighHasteMad')
        else
		    classes.CustomMeleeGroups:append('HighHaste')
        end
	elseif buffactive.march and (buffactive.haste or buffactive['haste samba']) then
	    add_to_chat(121,'High Haste Mode! - March 1 AND Haste OR Samba')
        if buffactive.madrigal then
		    classes.CustomMeleeGroups:append('HighHasteMad')
        else
		    classes.CustomMeleeGroups:append('HighHaste')
        end
	elseif buffactive.march == 2 then
	    add_to_chat(121,'High Haste Mode! - March 2')
        if buffactive.madrigal then
		    classes.CustomMeleeGroups:append('HighHasteMad')
        else
		    classes.CustomMeleeGroups:append('HighHaste')
        end
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

