-- Current Owner: AlanWarren, aka ~ Orestes 
-- Orinal file credit KBEEZIE
-- current file resides @ https://github.com/AlanWarren/gearswap

--[[ 
 === General Notes ===
 I've added options so anyone can use this script with any weapon they want. Look towards the top of this script for
 gear.Bow, gear.Gun, and gear.Stave. There's also a toggle for use_night_earring that you can set to false if you
 don't have or want to use Fenrir's Earring.

 Debug: //gs debugmode
       //gs showswaps

 Auto RA: 
 gs c toggle autora

 === Some Notes On Sets ===
 1) Annihilator + Hurlbat - This is used whenever ranged accuracy is a concern, or when I want war SJ's fencer bonus
 2) Annihilator + Mekki Shakki - These sets have higher ranged attack, and generally do more damage at the cost of some racc.
 3) Yoichi + Mekki Shakki + Decoy Down - This set is a bit light on racc/ratk, with focus on 4-hit and -enmity
 4) Yoichi + Mekki Shakki + Decoy Up - This set is high ratk, with less focus on racc since Yoichi's aftermath provides a bit
 5) Yoichi + Hurlbat - This set is pretty much a wash since bow needs so much STP to x-hit. Normally this would be a higher
    racc set for Bow, but it doesn't really accomplish this well right now. Stick to staves for bow.. 
 6) Annihilator + SAM Subjob - This is "messing around" set that will 3-hit with all 3 shots proc'ing recycle! 

 === Toggles ===
 1) Normal aims to be a 4-hit with as few recycle procs as I can possibly gear for without sacrificing too much.
    I will usually start out with this set, and occasionaly stick with it if my food allows decent racc.
 2) Mod adds a bit more acc, while maintaining 4 hit (may require more recycle procs) 
    I generally use this set on anything Difficult+, or delve2. Sometimes it allows me to eat meat. 
 3) Acc is full blown racc with minimal concern for anything else. Some sets will 4-hit with with all 4 shots proc'ing recycle
    This mode is only used when fighting difficult content, and all buffs drop. 

 === Modes ===
 1) Non-specific default sets are for Gun. They assume a 1 handed weapon since Hurlbat is my default for Annihilator.
    * Gun2H set is used whenever your main weapon is equal to gear.Stave. This set was designed for Mekki + Bloodrain
 1) Bow sets will activate by equipping whichever bow you defined in gear.Bow
    * Bow sets assume a stave + strap combination
    * Decoy1H and Bow1H will be used whenever you're NOT using gear.Stave i.e. Hurlbat
 2) Decoy set only applies while decoy is active AND you're using Bow
    * Standard Bow set uses -enmity gear, while maintaining 4-hit (with 4/4 recycle proc)
    * Decoy set removes -enmity gear for a normal 4-hit setup (3/4 or 2/4 recycle proc)
 3) Fenrir's earring is equipped at night for WS. You can disable this by setting use_night_earring = false
 4) During Overkill, I use a special set for precast/midcast containing rapidshot / doubleshot dmg gear. 

 === In Precast ===
 1) Checks to make sure you're in an engaged state and have 100+ TP before firing a weaponskill
 2) Checks the distance to target to prevent WS from being fired when target is too far (prevents TP loss)
 3) Does not allow gear-swapping on weaponskills when Defense mode is enabled
 4) Checks to see of "Unlimited Shot" buff is on, if there's any special ammo defined in sets equipped
 5) Checks for empty ammo (or special without buff) and fills in the default ammunition for that weapon
    ^ keeps empty if that ammo cannot be found, or there is no match to the weapon equipped
 6) Provides a low ammunition warning if current ammo in slot (counts all in inventory) is less than 15
    ^ If you have 5 Tulfaire arrows in slot, but 20 also in inventory it see's it as 25 total

 === In Midcast ===
 If Sneak is active, sends the cancel command before Spectral Jig finish casting

 === In Post-Midcast ===
 If Barrage Buff is active, equips sets.BarrageMid

 === In Buff Change ===
 If Camouflage is active, disable body swaping
 This is done to preserve the +100 Camouflage Duration given by Orion Jerkin
--]]
 
function get_sets()
        -- Load and initialize the include file.
        include('Mote-Include.lua')
end

-- setup vars that are user-independent.
function job_setup()

end
 
-- setup vars that are user-dependent. 
function user_setup()
        -- Options: Override default values
        options.OffenseModes = {'Normal', 'Melee'}
        options.RangedModes = {'Normal', 'Mod', 'Acc'}
        options.DefenseModes = {'Normal', 'PDT'}
        options.WeaponskillModes = {'Normal', 'Mod', 'Acc'}
        options.PhysicalDefenseModes = {'PDT'}
        options.MagicalDefenseModes = {'MDT'}
        state.Defense.PhysicalMode = 'PDT'
 
        state.Buff.Barrage = buffactive.Barrage or false
        state.Buff.Camouflage = buffactive.Camouflage or false
        state.Buff.Overkill = buffactive.Overkill or false
        
        -- settings
        state.AutoRA = false
        use_night_earring = true

        gear.Gun = "Annihilator"
        gear.Bow = "Yoichinoyumi"
        gear.Stave = "Mekki Shakki"

        -- Overriding Global Defaults for this job
        gear.default.weaponskill_neck = "Ocachi Gorget"
        gear.default.weaponskill_waist = "Elanid Belt"
 
      	DefaultAmmo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Achiyalabopa bullet"}
	    U_Shot_Ammo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Achiyalabopa bullet"} 
        
        determine_ranged()
        select_default_macro_book()

        send_command('bind f9 gs c cycle RangedMode')
        send_command('bind ^] gs c cycle OffenseMode')
        send_command('bind ^f9 gs c cycle DefenseMode')
        send_command('bind !f9 gs c cycle WeaponskillMode')
        send_command('bind ^- gs c toggle AutoRA')
        send_command('bind ^[ input /lockstyle on')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^[')
    send_command('unbind ^-')
end
 
function init_gear_sets()
    -- gear placed in RNG_gear.lua
end

function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' then
        if player.tp >= 100 and state.AutoRA and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
function job_precast(spell, action, spellMap, eventArgs)
        
        cancel_conflicting_buffs(spell, action, spellMap, eventArgs)
        refine_waltz(spell, action, spellMap, eventArgs)

        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
        -- add support for RangedMode toggles to EES
        if spell.english == 'Eagle Eye Shot' then
            classes.JAMode = state.RangedMode
        end
        -- Safety checks for weaponskills 
        if spell.type:lower() == 'weaponskill' then
            if player.tp < 100 then
                    eventArgs.cancel = true
                    return
            end
            if ((spell.target.distance >8 and spell.skill ~= 'Archery' and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
                -- Cancel Action if distance is too great, saving TP
                add_to_chat(122,"Outside WS Range! /Canceling")
                eventArgs.cancel = true
                return

            elseif state.Defense.Active then
                -- Don't gearswap for weaponskills when Defense is on.
                eventArgs.handled = true
            end
        end
        -- Ammo checks
	    if spell.action_type == 'Ranged Attack' or
          (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
            check_ammo(spell, action, spellMap, eventArgs)
        end
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
-- This is where you place gear swaps you want in precast but applied on top of the precast sets
function job_post_precast(spell, action, spellMap, eventArgs)
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    elseif state.Buff.Overkill then
        equip(sets.Overkill.Preshot)
    end
    sets.earring = select_earring()
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    -- Barrage
    if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
        equip(sets.buff.Barrage)
        eventArgs.handled = true
    end
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
        equip(sets.Overkill)
    end
end

 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- autora
    if (spell.action_type == 'Ranged Attack' or spell.type:lower() == 'weaponskill') and state.AutoRA then
        use_ra(spell)
    end

    if state.Buff[spell.name] ~= nil then
        state.Buff[spell.name] = not spell.interrupted or buffactive[spell.english]
    end

end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --if S{"courser's roll"}:contains(buff:lower()) then
    --if string.find(buff:lower(), 'samba') then

    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end
	determine_ranged()
end
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    sets.earring = select_earring()
end
 
function customize_idle_set(idleSet)
	if state.Buff.Camouflage then
		idleSet = set_combine(idleSet, sets.buff.Camouflage)
	end
    return idleSet
end
 
function customize_melee_set(meleeSet)
    if state.Buff.Camouflage then
    	meleeSet = set_combine(meleeSet, sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
    	meleeSet = set_combine(meleeSet, sets.Overkill)
    end
    return meleeSet
end
 
function job_status_change(newStatus, oldStatus, eventArgs)
    if camo_active() then
        disable('body')
    else
        enable('body')
    end
	determine_ranged()
end
 
function select_earring()
    -- world.time is given in minutes into each day
    -- 7:00 AM would be 420 minutes
    -- 17:00 PM would be 1020 minutes
    if world.time >= (18*60) or world.time <= (8*60) and use_night_earring then
        return sets.NightEarring
    else
        return sets.DayEarring
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    determine_ranged()
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false
    state.Buff.Overkill = buffactive.overkill or false
    state.Buff['Decoy Shot'] = buffactive['Decoy Shot'] or false

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 
-- Job-specific toggles.
function job_toggle_state(field)
    if field:lower() == 'autora' then
        state.AutoRA = not state.AutoRA
        return state.AutoRA
    end
end
 
-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_option_modes(field)
    if field:lower() == 'autora' then
        return state.AutoRA
    end
end
 
-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_option_mode(field, val)
    if field:lower() == 'autora' then
        state.AutoRA = val
        return true
    end
end
 
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
 
end
 
-- Handle notifications of user state values being changed.
function job_state_change(stateField, newValue, oldValue)
 
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    if state.AutoRA then
        msg = '[Auto RA: ON]'
    else
        msg = '[Auto RA: OFF]'
    end

    add_to_chat(122, 'Ranged: '..state.RangedMode..'/'..state.DefenseMode..', WS: '..state.WeaponskillMode..', '..msg)
    
    eventArgs.handled = true
 
end

function get_custom_wsmode(spell, spellMap, ws_mode)
    if spell.skill == 'Archery' or spell.skill == 'Marksmanship' then
        if player.sub_job == 'SAM' then
            return 'SAM'
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_ranged()
    -- cleanup everything each time function is called
	classes.CustomRangedGroups:clear()
	classes.CustomMeleeGroups:clear()

    if player.equipment.range == gear.Bow then
        -- if decoy is up 
        if buffactive['Decoy Shot'] then
            -- default decoy set assumes staff is used. 
            if player.equipment.main == gear.Stave then
                classes.CustomMeleeGroups:append('Decoy')
		        classes.CustomRangedGroups:append('Decoy')
            else -- append the 1 handed weapon class
                classes.CustomMeleeGroups:append('Decoy1H')
		        classes.CustomRangedGroups:append('Decoy1H')
            end
        else
            if player.equipment.main == gear.Stave then
                classes.CustomMeleeGroups:append('Bow')
		        classes.CustomRangedGroups:append('Bow')
            else -- one handed weapon setup
                classes.CustomMeleeGroups:append('Bow1H')
		        classes.CustomRangedGroups:append('Bow1H')
            end
        end

    elseif player.equipment.range == gear.Gun then

        if player.equipment.main == gear.Stave then

	        if player.sub_job == 'SAM' then
	            classes.CustomRangedGroups:append('SAM2H')
            else
	            classes.CustomRangedGroups:append('Gun2H')
                classes.CustomMeleeGroups:append('Gun2H')
            end
        else 
	        if player.sub_job == 'SAM' then
	            classes.CustomRangedGroups:append('SAM')
            else
                -- The default sets.midcast.RA applies
	            classes.CustomRangedGroups:clear()
	            classes.CustomMeleeGroups:clear()
            end
        end

    end
end

function use_weaponskill()
    if player.equipment.range == gear.Bow then
        send_command('input /ws "Namas Arrow" <t>')
    elseif player.equipment.range == gear.Gun then
        send_command('input /ws "Coronach" <t>')
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- BOW
    if player.equipment.range == gear.Bow then
        if spell.type:lower() == 'weaponskill' then
            delay = '2.6'
         else
            if buffactive["Courser's Roll"] then
                delay = '1.6'
            else
                delay = '1.8'
            end
        end
    else
    -- GUN 
        if spell.type:lower() == 'weaponskill' then
            delay = '3.0'
        else
            if buffactive["Courser's Roll"] then
                delay = '2.0'
            else
                delay = '2.2'
            end
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function camo_active()
    return state.Buff['Camouflage']
end
-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
	-- Filter ammo checks depending on Unlimited Shot
	if state.Buff['Unlimited Shot'] then
		if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
			if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
				equip({ammo=U_Shot_Ammo[player.equipment.range]})
			elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
				add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
				equip({ammo=DefaultAmmo[player.equipment.range]})
			else
				add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
			end
		end
	else
		if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
					equip({ammo=empty})
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
				equip({ammo=empty})
			end
		elseif player.equipment.ammo == 'empty' then
			if DefaultAmmo[player.equipment.range] then
				if player.inventory[DefaultAmmo[player.equipment.range]] then
					add_to_chat(122,"Using Default Ammo")
					equip({ammo=DefaultAmmo[player.equipment.range]})
				else
					add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
				end
			else
				add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
			end
		elseif player.inventory[player.equipment.ammo].count < 15 then
			add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
		end
	end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR'then
		    set_macro_page(3, 5)
	elseif player.sub_job == 'SAM' then
		    set_macro_page(4, 5)
	else
		set_macro_page(3, 5)
	end
end

