-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
	get_combat_form()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	
    -- list of weaponskills that make better use of Gavialis helm
    wsList = S{'Stardiver'}

	state.Buff = {}
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Mid', 'Acc')
	state.IdleMode:options('Normal', 'Sphere')
	state.HybridMode:options('Normal', 'PDT')
	state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false

	select_default_macro_book(1, 16)
    send_command('bind != gs c toggle CapacityMode')
	send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind ^[')
	send_command('unbind ![')
	send_command('unbind ^=')
	send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
    Brigantia = {}
    Brigantia.TP = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Pet: Damage taken -5%',}}
    Brigantia.WS = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    Brigantia.DAWS = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}

    Valorous = {}
    Valorous.Hands = {}
    Valorous.Hands.TP = { name="Valorous Mitts", augments={'Accuracy+26','"Store TP"+6','AGI+10',}}
    Valorous.Hands.WS = { name="Valorous Mitts", augments={'Accuracy+27','Weapon skill damage +4%','Accuracy+5 Attack+5','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
    
    Valorous.Feet = {}
    Valorous.Feet.WS ={ name="Valorous Greaves", augments={'Weapon skill damage +5%','STR+9','Accuracy+15','Attack+11',}}
    Valorous.Feet.TH = { name="Valorous Greaves", augments={'CHR+13','INT+1','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
    Valorous.Feet.TP = { name="Valorous Greaves", augments={'CHR+13','INT+1','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
    
    Valorous.Body = {}
    Valorous.Body.STP = { name="Valorous Mail", augments={'Accuracy+30','"Store TP"+6','DEX+3','Attack+14',}}
    Valorous.Body.DA = { name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Dbl.Atk."+4','VIT+4','Attack+6',}}
    -- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver Finger Gauntlets +2"}
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    --sets.Berserker = {neck="Berserker's Torque"}
    sets.WSDayBonus     = { head="Gavialis Helm" }

    sets.Organizer = {
        hands="Pearlsack",
        waist="Linkpearl",
    }

	sets.precast.JA.Jump = {
        ammo="Coiste Bodhar",
		head="Flamma Zucchetto +2",
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        hands="Flamma Manopolas +2",
        --hands="Vishap Finger Gauntlets +1",
        body="Pteroslaver Mail +3",
        ring1="Niqmaddu Ring",
        ring2="Petrov Ring",
		back=Brigantia.TP,
        waist="Ioskeha Belt",
        legs="Pteroslaver Brais +3",
        feet="Ostro Greaves"
    }

	sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +3" }
    sets.TreasureHunter = { 
        head="White rarab cap +1", 
        waist="Chaac Belt",
        feet=Valorous.Feet.TH
     }

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Vishap Brais +3",
    }) 
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {
		body="Vishap Mail +2",
        --legs="Peltast's Cuissots +1"
    })
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
        --legs="Peltast's Cuissots +1",
        --feet="Lancer's Schynbalds +2"
    })
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {
        hands="Lancer's Vambraces +2", 
        head="Vishap Armet +1"
    }
	sets.precast.JA['Call Wyvern'] = {body="Pteroslaver Mail +3"}
	sets.precast.JA['Deep Breathing'] = {--head="Wyrm Armet +1" or Petroslaver Armet +1
    }
    sets.precast.JA['Spirit Surge'] = { --body="Wyrm Mail +2"
        body="Pteroslaver Mail +3"
    }
	
	-- Healing Breath sets
	sets.HB = {
        ammo="Coiste Bodhar",
		head="Pteroslaver Armet +3",
        neck="Adad Amulet",
        ear1="Sherida Earring",
        ear2="Cessance Earring",
		body=Valorous.Body.STP,
        hands="Flamma Manopolas +2",
        back="Updraft Mantle",
        ring1="Dreki Ring",
        waist="Glassblower's Belt",
        legs="Vishap Brais +3",
        feet="Pteroslaver Greaves"
    }

    sets.MadrigalBonus = {
        hands="Composer's Mitts"
    }
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
        ammo="Impatiens",
        head="Cizin Helm +1", 
        ear1="Loquacious Earring", 
        hands="Leyline Gloves",
        legs="Limbo Trousers",
        ring1="Prolix Ring",
        ring2="Weatherspoon Ring"
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
    }	
		
	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { head="Vishap Armet +1", ring1="Dreki Ring" })
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
        ammo="Knobkierrie",
        head="Valorous Mask", 
        neck="Dragoon's Collar +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
		body=Valorous.Body.DA,
        hands="Pteroslaver Finger Gauntlets +2",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
		back=Brigantia.WS,
        waist="Sailfi Belt +1",
        legs="Vishap Brais +3",
        feet="Sulevia's Leggings +2"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        head="Valorous Mask",
    })

	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		--head="Flamma Zucchetto +2",
	    head="Stinger Helm +1",
        ear1="Sherida Earring",
        neck="Shadow Gorget",
        waist="Soil Belt",
		back=Brigantia.DAWS,
        hands="Sulevia's Gauntlets +2",
        legs="Sulevia's Cuisses +2",
        feet="Flamma Gambieras +2"
    })
	sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {
		--head="Flamma Zucchetto +2",
		head="Pteroslaver Armet +3",
        ear1="Sherida Earring",
        neck="Dragoon's Collar +2",
        waist="Soil Belt",
        hands="Sulevia's Gauntlets +2",
        feet="Flamma Gambieras +2"
    })
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {
		head="Pteroslaver Armet +3",
        neck="Dragoon's Collar +2",
        body="Pteroslaver Mail +3",
        waist="Soil Belt",
        legs="Vishap Brais +3",
    })

    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
	    head="Stinger Helm +1",
        neck="Breeze Gorget",
        ear1="Thrud Earring",
        ear2="Ishvara Earring",
        body=Valorous.Body.DA,
        hands="Pteroslaver Finger Gauntlets +2",
		back=Brigantia.WS,
        waist="Breeze Belt",
        legs="Vishap Brais +3",
        feet="Sulevia's Leggings +2"
    })
	sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {
        head="Valorous Mask", 
		back=Brigantia.WS,
    })
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
	    head="Stinger Helm +1",
		body="Hjarrandi Breastplate",
        waist="Sailfi Belt +1",
        hands="Flamma Manopolas +2",
        legs="Peltast's Cuissots +1",
        feet=Valorous.Feet.WS
    })
	sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {
        head="Valorous Mask",
		back=Brigantia.WS,
    })
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {})
    
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        ear1="Thrud Earring",
        hands="Flamma Manopolas +2",
        waist="Sailfi Belt +1",
        legs="Vishap Brais +3",
        feet=Valorous.Feet.WS
    })
	sets.precast.WS['Impulse Drive'].Mid = set_combine(sets.precast.WS['Impulse Drive'], {
		back=Brigantia.WS,
        feet="Sulevia's Leggings +2",
        hands=Valorous.Hands.WS,
    })
	sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'].Mid, {
    })
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
        --neck="Twilight Torque",
        ear1="Sherida Earring",
        ear2="Cessance Earring",
        ring1="Defending Ring",
        ring2="Paguroidea Ring",
		back=Brigantia.TP,
        legs="Carmine Cuisses +1",
        feet="Flamma Gambieras +2"
    }

	-- Idle sets
	sets.idle = {
        ammo="Coiste Bodhar",
        head="Hjarrandi Helm",
        neck="Dragoon's Collar +2",
        ear1="Sherida Earring",
        ear2="Telos Earring",
   	    body="Tartarus Platemail",
        hands="Sulevia's Gauntlets +2",
        ring1="Defending Ring",
        ring2="Dreki Ring",
		back=Brigantia.TP,
        --waist="Asklepian Belt",
        legs="Carmine Cuisses +1",
        feet="Sulevia's Leggings +2"
    }

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = set_combine(sets.idle, {
        head="Stinger Helm +1",
        ring1="Niqmaddu Ring",
        neck="Dragoon's Collar +2",
        waist="Sailfi Belt +1",
        --body="Pteroslaver Mail +3",
        ring2="Regal Ring",
    })
	
	sets.idle.Field = set_combine(sets.idle, {
        ammo="Staunch Tathlum",
        head="Hjarrandi Helm",
        neck="Sanctity Necklace",
   	    body="Tartarus Platemail",
        ear1="Etiolation Earring",
        ear2="Genmei Earring",
        hands="Sulevia's Gauntlets +2",
        ring1="Defending Ring",
        ring2="Dreki Ring",
        waist="Flume Belt",
		back=Brigantia.TP,
        legs="Carmine Cuisses +1",
        feet="Sulevia's Leggings +2"
    })
    sets.idle.Sphere = set_combine(sets.idle, { body="Makora Meikogai"  })

    sets.idle.Regen = set_combine(sets.idle.Field, {
        ear2="Infused Earring",
        neck="Sanctity Necklace",
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
		head="Nyame Helm",
		body="Nyame Mail",
    })
	
	-- Defense sets
	sets.defense.PDT = {
        -- ammo="Hasty Pinion +1",
        ammo="Crepuscular Pebble",
        head="Hjarrandi Helm",
        neck="Twilight Torque",
        ear1="Cessance Earring",
        ear2="Telos Earring",
   	    body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Patricius Ring",
        ring2="Dark Ring",
        waist="Sailfi Belt +1",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    }

	sets.defense.MDT = set_combine(sets.defense.PDT, {
    })

	sets.Kiting = {
        legs="Carmine Cuisses +1",
    }

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
        ammo="Coiste Bodhar",
		head="Flamma Zucchetto +2",
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Dedition Earring",
		body="Hjarrandi Breastplate",
        hands="Flamma Manopolas +2",
        ring1="Niqmaddu Ring",
        ring2="Petrov Ring",
		back=Brigantia.TP,
        waist="Sailfi Belt +1",
        legs="Pteroslaver Brais +3",
        feet="Flamma Gambieras +2"
    }

	sets.engaged.Mid = set_combine(sets.engaged, {
  --      head="Hjarrandi Helm",
		head="Flamma Zucchetto +2",
        ear2="Brutal Earring",
        neck="Shulmanu Collar",
        hands="Sulevia's Gauntlets +2",
		body="Hjarrandi Breastplate",
        ring2="Flamma Ring",
        legs="Pteroslaver Brais +3",
        waist="Ioskeha Belt",
		back=Brigantia.TP,
    })

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        ammo="Ginsen",
        ear1="Cessance Earring",
        neck="Shulmanu Collar",
        hands="Flamma Manopolas +2",
        ring2="Regal Ring",
		body="Hjarrandi Breastplate",
        legs="Sulevia's Cuisses +2"
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
        ammo="Crepuscular Pebble",
        head="Hjarrandi Helm",
        neck="Dragoon's Collar +2",
		body="Hjarrandi Breastplate",
        ring1="Niqmaddu Ring",
        ring2="Dreki Ring",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        waist="Sailfi Belt +1",
        feet="Nyame Sollerets"
    })
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        head="Hjarrandi Helm",
   	    body="Nyame Mail",
        ring2="Patricius Ring",
		back=Brigantia.TP,
        hands="Nyame Gauntlets",
   	    body="Nyame Mail",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        ring2="Patricius Ring",
		back=Brigantia.TP,
        hands="Nyame Gauntlets",
   	    body="Nyame Mail",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    })

    sets.engaged.War = set_combine(sets.engaged, {
        hands="Flamma Manopolas +2",
        neck="Anu Torque",
        ring2="Petrov Ring"
    })
    sets.engaged.War.Mid = set_combine(sets.engaged.Mid, {
        -- neck="Defiant Collar",
    })

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.english == "Spirit Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command('Jump')
        end
    elseif spell.english == "Soul Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command("High Jump")
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if player.hpp < 51 then
		classes.CustomClass = "Breath" 
	end
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        if is_sc_element_today(spell) then
            if wsList:contains(spell.english) then
                equip(sets.WSDayBonus)
            end
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	    equip(sets.midcast.FastRecast)
	    if player.hpp < 51 then
		    classes.CustomClass = "Breath" 
	    end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_precast(spell, action, spellMap, eventArgs)
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' or spell.english == 'Steady Wing' or spell.english == 'Smiting Breath' then
		equip(sets.HB)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
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
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus)
        end
    end
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function job_update(cmdParams, eventArgs)
    war_sj = player.sub_job == 'WAR' or false
	classes.CustomMeleeGroups:clear()
	th_update(cmdParams, eventArgs)
	get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
	--if areas.Adoulin:contains(world.area) and buffactive.ionis then
	--	state.CombatForm:set('Adoulin')
	--end

    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

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
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(8, 1)
    elseif player.sub_job == 'WHM' then
    	set_macro_page(8, 2)
    else
    	set_macro_page(8, 1)
    end
end
