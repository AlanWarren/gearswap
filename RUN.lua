-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--  RUN.lua 
--  author: Orestes
--  6/10/2014 

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
    state.Runes = {"Tellus","Unda","Flabra","Ignis","Gelus","Sulpor","Lux","Tenebrae"}
end


-- Setup vars that are user-independent.
function job_setup()
    state.Buff.Battuta = buffactive.battuta or false
    state.Buff.Vallation = buffactive.vallation or false
    state.Buff.Valiance = buffactive.valiance or false
    state.Buff.Swordplay = buffactive.swordplay or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    options.OffenseModes = {'Normal', 'Acc'}
    options.DefenseModes = {'Normal', 'PDT'}
    options.WeaponskillModes = {'Normal', 'Acc'}
    options.CastingModes = {'Normal'}
    options.IdleModes = {'Normal'}
    options.RestingModes = {'Normal'}
    options.PhysicalDefenseModes = {'PDT'}
    options.MagicalDefenseModes = {'MDT'}
    
    state.Defense.PhysicalMode = 'PDT'
    
    -- Additional local binds
    send_command('bind ^[ input /lockstyle on')
    
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
    if binds_on_unload then
    	binds_on_unload()
    end
    
    send_command('unbind ^[')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Swordplay = { hands="Futhark Mitons +1" }
    sets.precast.Effusion = {}

    -- Effusions
    sets.precast.Effusion.Lunge = { 
        ammo="Dosis Tathlum",
        head="A'as Circlet",
        neck="Eddy Necklace",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body="Vanir Cotehardie",
        hands="Spolia Cuffs",
        ring1="Acumen Ring",
        ring2="Sangoma Ring",
        back="Evasionist's Cape",
        legs="Shneddick Tights +1",
        feet="Weatherspoon Souliers +1"
    }
    sets.precast.Effusion.Swipe = sets.precast.Effusion.Lunge
    sets.precast.Effusion.Gambit = { hands="Runeist Mitons +1" }
    sets.precast.Effusion.Rayke = { feet="Futhark Boots +1" }

    -- Wards
    sets.precast.Ward = {}
    sets.precast.Ward.Battuta = { head="Futhark Bandeau +1" }
    sets.precast.Ward.Pflug = { feet="Runeist Bottes +1" }
    sets.precast.Ward.Vallation = { body="Runeist Coat +1", legs="Futhark Trousers +1" }
    sets.precast.Ward.Valiance = sets.precast.Ward.Vallation

    -- Fast Cast
    sets.precast.FC = {
        ammo="Impatiens",
        head="Runeist Bandeau +1",
        neck="Orunmila's Torque",
        ear1="Loquacious Earring",
        body="Vanir Cotehardie",
        hands="Thaumas Gloves",
        ring1="Prolix Ring",
        legs="Orvail Pants +1",
        feet="Chelona Boots +1"
    }
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        legs="Futhark Trousers +1"
    })

    -- Magic
    sets.midcast['Enhancing Magic'] = {
        neck="Colossus's Torque",
        ear1="Augmenting Earring",
        ear2="Andoaa Earring",
        body="Manasa Chasuble",
        hands="Runeist Mitons +1",
        back="Merciful Cape",
        waist="Olympus Sash",
        legs="Futhark Trousers +1"
    }
    
    -- Recast Timers for spells not otherwise specified
    sets.midcast.FastRecast = {
    	head="Felistris Mask",
        body="Runeist Coat +1",
    	hands="Qaaxo Mitaines",
        waist="Ninurta's Sash",
        legs="Runeist Trousers +1",
        feet="Iuitl Gaiters +1"
    }
    
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
    -- Sets to return to when not performing an action.
    
    sets.idle.Town = {
        head="Empress Hairpin",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Runeist Coat +1",
        hands="Runeist Mitons +1",
        ring1="Patricius Ring",
        ring2="Mars's Ring",
        back="Evasionist's Cape",
        waist="Windbuffet Belt",
        legs="Runeist Trousers +1",
        feet="Hermes' Sandals"
    }
    
    sets.idle.Field = set_combine(sets.idle.Town, {
        neck="Twilight Torque",
        ring1="Patricius Ring",
        ring2="Paguroidea Ring",
        head="Empress Hairpin",
        back="Shadow Mantle",
        feet="Hermes' Sandals"
    })
    
    
    -- Defense sets
    sets.defense.PDT = {
        ammo="Inlamvuyeso",
        head="Futhark Bandeau +1",
        neck="Twilight Torque",
        ear1="Trux Earring",
        ear2="Colossus's Earring",
        body="Futhark Coat +1",
        hands="Umuthi Gloves",
        ring1="Defending Ring",
        ring2="Patricius Ring",
        back="Repulse Mantle",
        waist="Flume Belt",
        legs="Qaaxo Tights", -- Path B
        feet="Qaaxo Leggings" -- Path B
    }
    
    sets.defense.MDT = set_combine(sets.defense.PDT, {
        ring2="Dark Ring",
        back="Mollusca Mantle"
    })
    
    sets.Kiting = {feet="Hermes' Sandals"}
    
    -- Engaged sets
    sets.engaged = {
        sub="Pole Grip",
        ammo="Ginsen",
        head="Empress hairpin",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Thaumas Coat",
        hands="Qaaxo Mitaines",
        ring1="Rajas Ring", 
        ring2="Epona's Ring", 
        back="Atheling Mantle", 
        waist="Windbuffet Belt",
        legs="Ighwa Trousers",
        feet="Qaaxo Leggings"
    }
    
    sets.engaged.Acc = set_combine(sets.engaged.Mid, { 
        head="Whirlpool Mask",
        neck="Iqabi Necklace",
        hands="Umuthi Gloves",
        ring1="Mars's Ring",
        back="Evasionist's Cape"
    })
    
    sets.engaged.PDT = sets.defense.PDT
    
    	
    -- Weaponskill sets
    sets.precast.WS = {
        head="Whirlpool Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Manibozho Jerkin",
        hands="Futhark Mitons +1",
        ring1="Rajas Ring",
        ring2="Strigoi Ring",
        back="Buquwik Cape",
        waist="Windbuffet Belt",
        legs="Ighwa Trousers",
        feet="Qaaxo Leggings"
    }
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        neck="Iqabi Necklace",
        ring1="Mars's Ring",
        back="Evasionist's Cape"
    })
    sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
        neck="Breeze Gorget",
        waist="Breeze Belt"
    })
    
    
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

function job_precast(spell, action, spellMap, eventArgs)
end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		--if state.Buff.Sengikori then
		--	equip(sets.buff.Sengikori)
		--end
	end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    --if state.Buff['Third Eye'] then
    --    if state.DefenseMode == 'PDT' then
    --        equip(sets.thirdeye)
    --    end
    --end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	--state.CombatForm = get_combat_form()
    --state.CombatWeapon = get_combat_weapon()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
    	set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
    	set_macro_page(1, 2)
    else
    	set_macro_page(1, 1)
    end
end

