-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()
	state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
	state.Buff['Trick Attack'] = buffactive['trick attack'] or false
	state.Buff['Feint'] = buffactive['feint'] or false

    include('Mote-TreasureHunter')
	determine_haste_group()
	
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	-- For th_action_check():
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Acc', 'iLvl')
	state.HybridMode:options('Normal', 'Evasion', 'PDT')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('Evasion', 'PDT')
	state.MagicalDefenseMode:options('MDT')
	state.RangedMode:options('Normal')
	
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Windbuffet Belt"

	-- Additional local binds
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind !- gs c cycle targetmode')
    send_command('bind != gs c toggle CapacityMode')

    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')

	select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()

	send_command('unbind !-')
	send_command('unbind !=')
	send_command('unbind ^[')
	send_command('unbind ![')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    -- gear located in THF_gear.lua
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
	if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
		equip(sets.TreasureHunter)
	elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
	end
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
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
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
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
    local msg = 'Melee'
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end

    msg = msg .. ': '
    msg = msg .. state.OffenseMode.value

    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value

    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', TH: ' .. state.TreasureMode.value
    add_to_chat(122, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
	if state.Buff[buff_name] then
		equip(sets.buff[buff_name] or {})
		if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
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

