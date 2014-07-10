-- Owner: AlanWarren, aka ~ Orestes 
-- current file resides @ https://github.com/AlanWarren/gearswap
--[[ 

 === Notes ===
 -- Set format is as follows:
    sets[phase][type][CustomClass][CombatForm][CombatWeapon][RangedMode][CustomRangedGroup]
    ex: sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mid.SamRoll = {}
    you can also append CustomRangedGroups to each other
    ex: sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mid.Decoy.SamRoll = {}
 
 -- These are the available sets per category
 -- CustomClass = SAM
 -- CombatForm = Stave, DW
 -- CombatWeapon = weapon name, ex: Yoichinoyumi  (you can make new sets for any ranged weapon)
 -- RangedMode = Normal, Mid, Acc
 -- CustomRangedGroup = Decoy, SamRoll

 -- Gear.Stave should be set to your 2-handed weapon of choice if you wish to take advantage of sets.midcast.RA.Stave
 -- SamRoll is applied automatically whenever you have the roll on you. 
 -- SAM is used when you're RNG/SAM 
 -- Decoy mode helps with enmity control. I only use this with Yoichi, but if desired you can also use it with gun
    by toggling use_decoy_with_gun = true
    ** If you do this, you'll need to create either a weapon specific set, or general set with Decoy appended.
    i.e. sets.midcast.RA.Lionsquall.Decoy = {}
    i.e. sets.midcast.RA.Decoy = {}
    ** The idea is to put -enmity gear in your regular set, and take it off in the Decoy set. So, you will be shooting
    from sets.midcast.RA.Decoy when decoy is up, and sets.midcast.RA when Decoy is down. 

 * Auto RA
 - You can use the built in hotkey (CTRL -) or create a macro. (like below) Note "AutoRA" is case sensitive
   /console gs c toggle AutoRA
 - You have to shoot once after toggling autora for it to begin.
 - AutoRA will use weaponskills @ 1000TP, depending on which weapon you're using. However, this will only
   work if you set gear.Gun or gear.Bow to the weapon you're using. You also have to specify the desired
   ws it should use, with the settings auto_gun_ws and auto_bow_ws. 
 
 === Helpful Commands ===
    //gs validate
    //gs showswaps
    //gs debugmode

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
        options.RangedModes = {'Normal', 'Mid', 'Acc'}
        options.DefenseModes = {'Normal', 'PDT'}
        options.WeaponskillModes = {'Normal', 'Mid', 'Acc'}
        options.PhysicalDefenseModes = {'PDT'}
        options.MagicalDefenseModes = {'MDT'}
        state.Defense.PhysicalMode = 'PDT'
 
        state.Buff.Barrage = buffactive.Barrage or false
        state.Buff.Camouflage = buffactive.Camouflage or false
        state.Buff.Overkill = buffactive.Overkill or false

        -- settings
        state.AutoRA = false
        auto_gun_ws = "Coronach"
        auto_bow_ws = "Namas Arrow"

        use_decoy_with_gun = false
        use_night_earring = true

        gear.Gun = "Annihilator"
        gear.Bow = "Yoichinoyumi"
        gear.Stave = "Mekki Shakki"
        
        gear.Earring = { name="Volley Earring" }
        gear.NightEarring = "Fenrir's earring"
        gear.DayEarring = "Volley Earring"
       
        rng_sub_weapons = S{'Hurlbat', 'Vanir Knife', 'Sabebus', 
            'Eminent Axe', 'Trailer\'s Kukri', 'Aphotic Kukri', 'Atoyac'}
        
        sam_sj = player.sub_job == 'SAM' or false

      	DefaultAmmo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Achiyalabopa bullet"}
	    U_Shot_Ammo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Achiyalabopa bullet"} 

        select_earring()
        get_combat_form()
        get_custom_ranged_groups()
        select_default_macro_book()

        send_command('bind f9 gs c cycle RangedMode')
        send_command('bind !f9 gs c cycle OffenseMode')
        send_command('bind ^f9 gs c cycle DefenseMode')
        send_command('bind ^] gs c cycle WeaponskillMode')
        send_command('bind ^- gs c toggle AutoRA')
        send_command('bind ^[ input /lockstyle on')
        send_command('bind ![ input /lockstyle off')
        
        -- Testing 
        --windower.register_event('incoming text', detect_cor_rolls)
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind ^-')
end
 
function init_gear_sets()
    -- gear placed in RNG_gear.lua
end

function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' then
        if player.tp >= 1000 and state.AutoRA and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
function job_precast(spell, action, spellMap, eventArgs)
        
        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
        --add_to_chat(8, state.CombatForm)
        if sam_sj then
            classes.CustomClass = 'SAM'
        end

        if spell.action_type == 'Ranged Attack' then
            state.CombatWeapon = player.equipment.range
        end
        -- add support for RangedMode toggles to EES
        if spell.english == 'Eagle Eye Shot' then
            classes.JAMode = state.RangedMode
        end
        -- Safety checks for weaponskills 
        if spell.type:lower() == 'weaponskill' then
            if player.tp < 1000 then
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
    if buff == 'Velocity Shot' and gain then
        windower.send_command('wait 290;input /echo **VELOCITY SHOT** Wearing off in 10 Sec.')
    elseif buff == 'Double Shot' and gain then
        windower.send_command('wait 90;input /echo **DOUBLE SHOT OFF**;wait 90;input /echo **DOUBLE SHOT READY**')
    elseif buff == 'Decoy Shot' and gain then
        windower.send_command('wait 170;input /echo **DECOY SHOT** Wearing off in 10 Sec.];wait 120;input /echo **DECOY SHOT READY**')
    end

    if  buff == "Decoy Shot" or buff == "Samurai Roll" or buff == "Courser's Roll" or string.find(buff:lower(), 'flurry') then
        classes.CustomRangedGroups:clear()

        if (buff == "Decoy Shot" and gain) or buffactive['Decoy Shot'] then
            -- Only append Decoy if we're using bow, or changed the setting to force it
            if player.equipment.range == gear.Bow or use_decoy_with_gun then
                classes.CustomRangedGroups:append('Decoy')
            end
        end
        
        if (buff == "Samurai Roll" and gain) or buffactive['Samurai Roll'] then
            classes.CustomRangedGroups:append('SamRoll')
        end
       
        if (buff == "Flurry II" and gain) or buffactive['Flurry II'] then
            classes.CustomRangedGroups:append('Snapshot')
        end
    end

    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end

    if buff == "Decoy Shot" or buff == "Camouflage" or buff == "Overkill" or buff == "Samurai Roll" or buff == "Courser's Roll" then
        handle_equipping_gear(player.status)
    end
end
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    --select_earring()
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
    if newStatus == "Engaged" then
         state.CombatWeapon = player.equipment.range
         select_earring()
    end

    if camo_active() then
        disable('body')
    else
        enable('body')
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
    get_combat_form()
    get_custom_ranged_groups()
    sam_sj = player.sub_job == 'SAM' or false
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false
    state.Buff.Overkill = buffactive.overkill or false

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
-- Special WS mode for Sam subjob
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
function get_combat_form()
    if player.equipment.main == gear.Stave then
        state.CombatForm = "Stave"
    else
        if S{'NIN', 'DNC'}:contains(player.sub_job) and rng_sub_weapons:contains(player.equipment.sub) then
            state.CombatForm = "DW"
        else
            state.CombatForm = nil
        end
    end
end

function select_earring()
    -- world.time is given in minutes into each day
    -- 7:00 AM would be 420 minutes
    -- 17:00 PM would be 1020 minutes
    if world.time >= (18*60) or world.time <= (8*60) and use_night_earring then
        gear.Earring.name = gear.NightEarring
    else
        gear.Earring.name = gear.DayEarring
    end
end

function get_custom_ranged_groups()
	classes.CustomRangedGroups:clear()
    
    if player.equipment.range == gear.Bow or use_decoy_with_gun then
        if buffactive['Decoy Shot'] then
		    classes.CustomRangedGroups:append('Decoy')
        end
    end

    if buffactive['Samurai Roll'] then
        classes.CustomRangedGroups:append('SamRoll')
    end

    if buffactive['Flurry II'] then
        classes.CustomRangedGroups:append('Snapshot')
    end
    
end

function use_weaponskill()
    if player.equipment.range == gear.Bow then
        send_command('input /ws "'..auto_bow_ws..'" <t>')
    elseif player.equipment.range == gear.Gun then
        send_command('input /ws "'..auto_gun_ws..'" <t>')
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- BOW
    if player.equipment.range == gear.Bow then
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25'
         else
             if buffactive["Courser's Roll"] then
                 delay = '0.7' -- MAKE ADJUSTMENT HERE
             elseif buffactive["Flurry II"] or buffactive.Overkill then
                 delay = '0.5'
             else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    else
    -- GUN 
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25' 
        else
            if buffactive["Courser's Roll"] then
                delay = '0.7' -- MAKE ADJUSTMENT HERE
            elseif buffactive.Overkill or buffactive['Flurry II'] then
                delay = '0.5'
            else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
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
-- Orestes uses Samurai Roll. The total comes to 5!
--function detect_cor_rolls(old,new,color,newcolor)
--    if string.find(old,'uses Samurai Roll. The total comes to') then
--        add_to_chat(122,"SAM Roll")
--    end
--end
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

