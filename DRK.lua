--[[     
 === Notes ===
 -- Set format is as follows:
    sets.engaged.[CombatForm][CombatWeapon][Offense or DefenseMode]
    CombatForm = War
    CombatWeapon = Scythe

    The default sets are for Sam subjob with a Greatsword.
    The above set format allows you to build sets for war and sam sub with either scythe or gs
--]]
--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    -- SE can be used full time, or after WS then cancel
    state.SouleaterMode = M(true, 'Soul Eater Mode')

    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false
    -- any scythe that should use sets.engaged.Scythe 
    scytheList = S{ 'Xbalanque', 'Inanna', 'Anahera Scythe', 'Tajabit', 'Twilight Scythe', 'Liberator' }
    -- low delay great swords only. Leave the others out
    gsList = S{'Tunglmyrkvi', 'Ukudyoni', 'Kaquljaan' }
    -- list of weaponskills that make better use of otomi helm in attack capped situations
    wsList = S{'Spiral Hell'}
    adjust_engaged_sets()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false
    
    adjust_engaged_sets()
    get_combat_form()
    determine_custom_group()
    
    -- Additional local binds
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c toggle SouleaterMode')
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    
    select_default_macro_book()
end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^`')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind @f9')
end
 
       
-- Define sets and vars used by this job file.
function init_gear_sets()
    -- gear located in DRK_gear.lua 
end

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if is_sc_element_today(spell) then
            if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- use normal head piece
            else
                equip(sets.WSDayBonus)
            end
        end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.HybridMode.current == 'Reraise' or
    (state.HybridMode.current == 'Physical' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Souleater and state.SouleaterMode.value then
            send_command('cancel souleater')
        end
    end
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end
 
-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
end
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 50 then
        idleSet = set_combine(idleSet, sets.refresh)
    end
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    meleeSet = set_combine(meleeSet, sets.Ammo)
    if state.Buff['Last Resort'] then
    	meleeSet = set_combine(meleeSet, sets.buff['Last Resort'])
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

    if newStatus == "Engaged" then
        adjust_engaged_sets()
    end
    if newStatus == "Engaged" or newStatus == "Idle" then
        if player.equipment.ammo == 'Oxidant Bolt' then
            disable('ammo')
        else
            enable('ammo')
        end
    end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    if buff == 'Aftermath: Lv.3' and gain then
    	determine_custom_group()
   	    handle_equipping_gear(player.status)
    end

    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
    	--handle_equipping_gear(player.status)
    end
    if player.equipment.ammo == 'Oxidant Bolt' then
        disable('ammo')
    else
        enable('ammo')
    end

    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end


end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    
    war_sj = player.sub_job == 'WAR' or false
	adjust_engaged_sets()
    get_combat_form()
    determine_custom_group()

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end

function adjust_engaged_sets()
    if scytheList:contains(player.equipment.main) then
        state.CombatWeapon:set("Scythe")
    elseif gsList:contains(player.equipment.main) then
        state.CombatWeapon:set("LDGS")
    else -- use regular set
        state.CombatWeapon:reset()
    end
end

function select_static_ammo()
    if state.OffenseMode.current == 'Acc' or state.OffenseMode.current == 'Mid' then
	    if world.time >= (18*60) or world.time <= (6*60) then
            return sets.NightAccAmmo
        else
            return sets.DayAccAmmo
	    end
    else
        return sets.RegularAmmo
    end
end

--function adjust_melee_groups()
--	classes.CustomMeleeGroups:clear()
--	if state.Buff.Aftermath then
--		classes.CustomMeleeGroups:append('AM')
--	end
--end
function determine_custom_group()

	classes.CustomMeleeGroups:clear()
	
	--if buffactive.embrava and (buffactive['last resort'] or buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
	--	classes.CustomMeleeGroups:append('MaxHaste')
	--elseif buffactive.march == 2 and (buffactive.haste or buffactive['last resort']) then
	--	classes.CustomMeleeGroups:append('MaxHaste')
	--elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
	--	classes.CustomMeleeGroups:append('EmbravaHaste')
	--elseif buffactive.march == 1 and (buffactive['last resort'] or buffactive.haste or buffactive['haste samba']) then
	--	classes.CustomMeleeGroups:append('HighHaste')
	--elseif buffactive.march == 2 then
	--	classes.CustomMeleeGroups:append('HighHaste')

    if buffactive['Aftermath: Lv.3'] then
		classes.CustomMeleeGroups:append('AM3')
	end
end

function select_default_macro_book()
        -- Default macro set/book
	    if player.sub_job == 'DNC' then
	    	set_macro_page(6, 2)
	    elseif player.sub_job == 'SAM' then
	    	set_macro_page(6, 4)
	    else
	    	set_macro_page(6, 2)
	    end
end
