-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- gs c toggle hastemode -- Toggles whether or not you're getting Haste II

function get_sets()
    mote_include_version = 2
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
	state.Buff.Migawari = buffactive.migawari or false
    
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')

    -- used for aby proc's, etc. 
    get_combat_weapon()

	state.HasteMode = M(false, "Haste Mode")

    state.DayOrNightAmmo = M{['description']='Day or Night Ammo', 'Fire Bomblet', 'Tengu-No-Hane', }
    gear.Ammo = {name="Fire Bomblet"}
    select_static_ammo()

    state.CapacityMode = M(false, 'Capacity Point Mantle')

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
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')

    select_default_macro_book()
    
	send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^- gs c toggle HasteMode')
end


function file_unload()
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind ^-')
    send_command('unbind !-')
    send_command('unbind ^=')
    send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    -- gear located in NIN_gear.lua
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    --if state.Buff[spell.english] ~= nil then
    --    state.Buff[spell.english] = true
    --end
    if (spell.type:endswith('Magic') or spell.type == "Ninjutsu") and buffactive.silence then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

    --Aftermath for Kannagi
    aw_custom_aftermath_timers_precast(spell)
    
	if spell.skill == "Ninjutsu" and spell.target.type:lower() == 'self' and spellMap ~= "Utsusemi" then
		classes.CustomClass = "SelfNinjutsu"
	end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
    -- cancel utsusemi if shadows are up already
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            cancel_spell()
            add_to_chat(123, spell.english .. ' Canceled: [3+ Images]')
            return
        end
    end

end

function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
		equip(sets.TreasureHunter)
	elseif spell.type == 'WeaponSkill' then
		if state.TreasureMode.value == 'Fulltime' then
			equip(sets.TreasureHunter)
		end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
    if spell.english == "Monomi: Ichi" then
        if buffactive['Sneak'] then
            send_command('@wait 1.7;cancel sneak')
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    get_combat_weapon()
	if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
		equip(sets.TreasureHunter)
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Aftermath timer creation
    aw_custom_aftermath_timers_aftercast(spell)
    -- If spell is not interrupted. This also applies when you try using a JA with it's timer down.
    -- If the recast timer isn't ready, aftercast is called with spell.interrupted == true
    -- We check if state.Buff.spell is defined, so we don't created variable instances for every action taken
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
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.PhysicalDefenseMode.value ~= 'PDT' then
	    idleSet = set_combine(idleSet, select_movement())
    end
	if state.Buff.Migawari and state.HybridMode.value == 'PDT' then
		idleSet = set_combine(idleSet, sets.buff.Migawari)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
	if state.Buff.Migawari and state.HybridMode.value == 'PDT' then
		meleeSet = set_combine(meleeSet, sets.buff.Migawari)
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
	if S{'haste','march', 'madrigal','embrava','haste samba', 'geo-haste'}:contains(buff:lower()) then
		determine_haste_group()
        handle_equipping_gear(player.status)
    elseif state.Buff[buff] ~= nil then
		--state.Buff[buff] = gain
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
end

function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Idle' then
        sets.Kiting = select_movement()
    end
    select_static_ammo()
    get_combat_weapon()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    select_static_ammo()
    get_combat_weapon()
	th_update(cmdParams, eventArgs)
	determine_haste_group()
    sets.Kiting = select_movement()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
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

function select_static_ammo()
    if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'Mid' then
	    if world.time >= (18*60) or world.time <= (6*60) then
            state.DayOrNightAmmo:cycle()
            gear.Ammo.name = state.DayOrNightAmmo.value
        else
            state.DayOrNightAmmo:cycleback()
            gear.Ammo.name = state.DayOrNightAmmo.value
	    end
    end
end

function get_combat_weapon()
    if player.equipment.main == 'Taimakuniyuki' or player.equipment.main == 'Ark Scythe' then
        state.CombatWeapon:set('TwoHanded')
    else
        state.CombatWeapon:reset()
    end
end

function determine_haste_group()
	
	classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10%
    -- Victory March +3/+4/+5     14%/15.6%/17.1%
    -- Advancing March +3/+4/+5   10.9%/12.5%/14%
    -- Embrava 25%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    if ((state.HasteMode.value and buffactive.haste) and buffactive.march) then
        add_to_chat(8, '-------------Max-Haste 45%++--------------')
        classes.CustomMeleeGroups:append('Haste_43')
    elseif ( (buffactive.embrava or buffactive.haste) and buffactive.march == 2 ) then
        add_to_chat(8, '-------------Haste 43%-------------')
        classes.CustomMeleeGroups:append('Haste_43')
    elseif buffactive.embrava and buffactive.haste then
        add_to_chat(8, '-------------Haste 40%-------------')
        classes.CustomMeleeGroups:append('Haste_40')
    elseif buffactive.haste and buffactive['haste samba'] and buffactive.march == 1 then
        add_to_chat(8, '-------------Haste 35%-------------')
        classes.CustomMeleeGroups:append('Haste_35')
    elseif (buffactive.haste and buffactive.march == 1) or (buffactive.march == 2 and buffactive['haste samba']) or (state.HasteMode.value and buffactive.haste) then
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

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Capacity Point Mantle' then
        gear.Back = newValue
        --add_to_chat(122, "Ammo: "..gear.Ammo)
    end
end

--- Custom spell mapping.
--function job_get_spell_map(spell, default_spell_map)
--    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
--        return 'HighTierNuke'
--    end
--end

function utsusemi_active()
    if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
        return true
    else
        return false
    end
end

-- Call from job_precast() to setup aftermath information for custom timers.
function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}
        
        local empy_ws = "Blade: Hi"
        
        info.aftermath.weaponskill = empy_ws
        info.aftermath.duration = 0
        
        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end
        
        if spell.english == empy_ws and player.equipment.main == 'Kannagi' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end
            
            -- duration is based on aftermath level
            info.aftermath.duration = 30 * info.aftermath.level
        end
    end
end
-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
       info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 2)
	elseif player.sub_job == 'WAR' then
		set_macro_page(2, 1)
	else
		set_macro_page(2, 2)
	end
end

