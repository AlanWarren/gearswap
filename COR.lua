-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file to go with this.

--[[
	gs c toggle luzaf -- Toggles use of Luzaf Ring on and off
	
	Offense mode is melee or ranged.  Used ranged offense mode if you are engaged
	for ranged weaponskills, but not actually meleeing.
	Acc on offense mode (which is intended for melee) will currently use .Acc weaponskill
	mode for both melee and ranged weaponskills.  Need to fix that in core.
--]]


-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
	include('organizer-lib')
end

-- Setup vars that are user-independent.
function job_setup()
	-- Whether to use Luzaf's Ring
	state.LuzafRing = M(false, "Luzaf's Ring")
	state.warned = M(false)
    state.CapacityMode = M(false, 'Capacity Point Mantle')
    state.Buff['Triple Shot'] = buffactive['Triple Shot'] or false

	define_roll_values()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Melee', 'Acc')
	state.HybridMode:options('Normal', 'PDT' )
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')

	gear.RAbullet = "Decimating Bullet"
	gear.WSbullet = "Decimating Bullet"
	gear.MAbullet = "Decimating Bullet"
	gear.QDbullet = "Animikii Bullet"
	--gear.QDbullet = "Adlivun Bullet"
	options.ammo_warning_limit = 15

    state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }

    cor_sub_weapons = S{"Arendsi Fleuret", "Vanir Knife", "Sabebus", "Aphotic Kukri", "Atoyac", "Surcouf's Jambiya"}
    auto_gun_ws = "Wildfire"

    get_combat_form()
	-- Additional local binds
	-- Cor doesn't use hybrid defense mode; using that for ranged mode adjustments.
    send_command('bind f9 gs c cycle RangedMode')
    send_command('bind !f9 gs c cycle OffenseMode')
	send_command('bind ^` input /ja "Double-up" <me>')
	send_command('bind !` input /ja "Bolter\'s Roll" <me>')
    send_command('bind != gs c toggle CapacityMode')
    
    send_command('bind ^- gs c cycle AutoRA')
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
	send_command('unbind ^`')
	send_command('unbind !=')
	send_command('unbind !`')
	send_command('unbind ^-')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
	--sets.precast.JA['Snake Eye'] = {legs="Commodore Culottes +1"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
	--sets.precast.JA['Fold'] = {hands="Commodore Gants +2"}} 
    sets.CapacityMantle = {back="Mecistopins Mantle"}
	
    TaeonHead = {}
    TaeonHead.Snap = { name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Snapshot"+5','"Snapshot"+4',}}

    Camulus = {}
    Camulus.STP = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    Camulus.WSD = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}

    HercFeet = {}
    HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+4%','Mag. Acc.+14','"Mag.Atk.Bns."+13',}}
    HercFeet.TP = { name="Herculean Boots", augments={'Accuracy+22 Attack+22','"Triple Atk."+3','STR+5','Attack+11',}}

	sets.precast.CorsairRoll = {
        head="Lanun Tricorne +1",
        hands="Chasseur's Gants +1",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        neck="Regal Necklace",
        body="Meghanada Cuirie +2",
        ring1="Dark Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        legs="Mummu Kecks +2",
        feet="Lanun Bottes"
    }
    
	--sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +1"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
	--sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +1"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
	
	sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    --sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
	
	sets.precast.CorsairShot = {}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
        hands="Meghanada Gloves +2",
        legs="Adhemar Kecks",
    }

    sets.Organizer = {
        main="Fettering Blade",
        sub="Odium",
        ear2="Reraise Earring",
        range="Doomsday",
        hands="Compensator",
        ammo="Nusku Shield"
    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
        --ammo="Impatiens",
        head="Herculean Helm",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        ring1="Prolix Ring",
        ring2="Kishar Ring",
        body="Dread Jupon",
        hands="Leyline Gloves",
        legs="Quiahuiz Trousers",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	sets.precast.RA = {
        ammo=gear.RAbullet,
        head=TaeonHead.Snap,
        hands="Carmine Finger Gauntlets +1",
		back="Navarch's Mantle",
        body="Pursuer's Doublet",
        waist="Impulse Belt",
        legs="Adhemar Kecks",
        feet="Meghanada Jambeaux +2"
    }

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
        head="Meghanada Visor +2",
        neck="Iskur Gorget",
        ear1="Ishvara Earring",
        ear2="Enervating Earring",
        body="Mummu Jacket +2",
        hands="Meghanada Gloves +2",
        ring1="Dingir Ring",
        ring2="Karieyh Ring",
        back=Camulus.WSD,
        waist="Kwahu Kachina Belt",
        legs="Herculean Trousers",
        feet="Meghanada Jambeaux +2"
    }


	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, { ear2="Moonshade Earring"})

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {legs="Samnuha Tights"})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring", legs="Samnuha Tights"})

	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
        ammo=gear.WSbullet,
        neck="Aqua Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body="Meghanada Cuirie +2",
        ring1="Dingir Ring",
        ring2="Karieyh Ring",
        waist="Light Belt",
    })
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        ammo=gear.WSbullet,
        ear1="Enervating Earring",
        ear2="Moonshade Earring",
        ring1="Dingir Ring",
        ring2="Karieyh Ring",
        back=Camulus.WSD,
        feet="Mummu Gamashes +2"
    })

	sets.precast.WS['Wildfire'] = {
        ammo=gear.MAbullet,
        head="Mummu Bonnet +1",
        neck="Sanctity Necklace",
        ear1="Ishvara Earring",
        ear2="Friomisi Earring",
        body="Samnuha Coat",
        hands="Carmine Finger Gauntlets +1",
        ring1="Dingir Ring",
        ring2="Garuda Ring",
        back=Camulus.WSD,
        waist="Eschan Stone",
        legs="Herculean Trousers",
        feet=HercFeet.MAB
    }
    sets.precast.WS['Wildfire'].Acc = {
        body="Mummu Jacket +2",
        legs="Mummu Kecks +2"
    }

	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], { ear2="Moonshade Earring"})
	sets.precast.WS['Leaden Salute'].Acc = set_combine(sets.precast.WS['Leaden Salute'], { 
        body="Mummu Jacket +2",
        legs="Mummu Kecks +2"
    })
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Uk'uxkaj Cap",
        neck="Sanctity Necklace",
        hands="Meghanada Gloves +2",
        ear1="Lempo Earring",
        ear2="Gwati Earring",
        body="Pursuer's Doublet",
        back=Camulus.STP,
        ring1="Globidonta Ring",
        ring2="Sangoma Ring",
		legs="Adhemar Kecks",
        waist="Aquiline Belt",
    }
		
	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	sets.midcast.CorsairShot = {
        ammo=gear.QDbullet,
        head="Mummu Bonnet +1",
        neck="Sanctity Necklace",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body="Samnuha Coat",
        hands="Carmine Finger Gauntlets +1",
        ring1="Dingir Ring",
        ring2="Garuda Ring",
        back="Gunslinger's Cape",
        waist="Eschan Stone",
        legs="Mummu Kecks +2",
        feet=HercFeet.MAB
    }

	sets.midcast.CorsairShot.Acc = set_combine(sets.midcast.CorsairShot, {
        body="Mummu Jacket +2",
        head="Mummu Bonnet +1",
        ear1="Lempo Earring",
        ear2="Gwati Earring",
        ring1="Dingir Ring",
        ring2="Sangoma Ring",
        feet="Navarch's Bottes +2"
    })

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Acc
	sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

	-- Ranged gear
	sets.midcast.RA = {
        ammo=gear.RAbullet,
        head="Meghanada Visor +2",
        neck="Iskur Gorget",
        ear1="Enervating Earring",
        ear2="Tripudio Earring",
        body="Mummu Jacket +2",
        hands="Adhemar Wristbands",
        ring1="Dingir Ring",
        ring2="Apate Ring",
        back=Camulus.STP,
        waist="Kwahu Kachina Belt",
        legs="Adhemar Kecks",
        feet="Mummu Gamashes +2"
    }


	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        ring1="Dingir Ring",
        ring2="Cacoethic Ring +1",
        body="Meghanada Cuirie +2",
        feet="Meghanada Jambeaux +2"
    })

    sets.midcast.RA.Triple = set_combine(sets.midcast.RA, {
        body="Chasseur's Frac +1"
    })
	sets.midcast.RA.Triple.Acc = set_combine(sets.midcast.RA.Triple, {
        body="Meghanada Cuirie +2",
        ring2="Cacoethic Ring +1",
        feet="Meghanada Jambeaux +2"
    })
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}

	-- Idle sets
	sets.idle = {
        ammo=gear.RAbullet,
        head="Meghanada Visor +2",
        neck="Sanctity Necklace",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        --body="Mekosuchinae Harness",
        body="Meghanada Cuirie +2",
        hands="Meghanada Gloves +2",
        ring1="Meghanada Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Meghanada Jambeaux +2"
    }
    sets.idle.Regen = set_combine(sets.idle, {
        --head="Ocelomeh Headpiece +1",
        neck="Sanctity Necklace",
        body="Meghanada Cuirie +2",
        ring1="Meghanada Ring",
    })

	sets.idle.Town = {
        ammo=gear.RAbullet,
        head="Meghanada Visor +2",
        neck="Regal Necklace",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        body="Meghanada Cuirie +2",
        hands="Carmine Finger Gauntlets +1",
        ring1="Dingir Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        waist="Eschan Stone",
        legs="Carmine Cuisses +1",
        feet="Meghanada Jambeaux +2"
    }
	
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle, {
        head="Meghanada Visor +2",
        neck="Twilight Torque",
        hands="Meghanada Gloves +2",
        body="Meghanada Cuirie +2",
        ring1="Patricius Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        waist="Flume Belt",
        legs="Meghanada Chausses +1",
        feet="Meghanada Jambeaux +2"
    })

	sets.defense.MDT = sets.defense.PDT

	sets.Kiting = {legs="Carmine Cuisses +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
    sets.engaged = {
        ammo=gear.RAbullet,
        head="Meghanada Visor +2",
        neck="Twilight Torque",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        body="Meghanada Cuirie +2",
        hands="Meghanada Gloves +2",
        ring1="Karieyh Ring",
        ring2="Defending Ring",
        back=Camulus.STP,
        waist="Flume Belt",
        legs="Mummu Kecks +2",
        feet="Meghanada Jambeaux +2"
    }
	-- Normal melee group
	sets.engaged.Melee = {
        head="Herculean Helm",
        neck="Lissome Necklace",
        ear1="Brutal Earring",
        ear2="Cessance Earring",
        body="Herculean Vest",
        hands="Herculean Gloves",
        ring1="Petrov Ring",
        ring2="Epona's Ring",
        back=Camulus.STP,
        waist="Windbuffet Belt +1",
        legs="Meghanada Chausses +1",
        feet=HercFeet.TP
    }

	sets.engaged.DW = set_combine(sets.engaged.Melee, {
        ear1="Eabani Earring",
        ear2="Suppanomimi",
        hands="Floral Gauntlets",
        body="Samnuha Coat",
        legs="Carmine Cuisses +1",
        waist="Patentia Sash",
        back=Camulus.STP,
        feet="Taeon Boots"
    })
	
	sets.engaged.Acc = set_combine(sets.engaged.Melee, {
        waist="Olseni Belt",
    })
	sets.engaged.Acc.DW = set_combine(sets.engaged.Melee.DW, {
        neck="Lissome Necklace",
        ring2="Mummu Ring",
        back=Camulus.STP,
        feet="Mummu Gamashes +2"
    })
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------
function job_pretarget(spell, action, spellMap, eventArgs)
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' then
        if player.tp >= 1000 and state.AutoRA.value == 'WS' and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Check that proper ammo is available if we're using ranged attacks or similar.
	if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
		do_bullet_checks(spell, spellMap, eventArgs)
	end

    if spell.type:lower() == 'weaponskill' then
        if player.tp < 1000 then
            eventArgs.cancel = true
            return
        end
        if ((spell.target.distance >8 and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
            -- Cancel Action if distance is too great, saving TP
            add_to_chat(122,"Outside WS Range! /Canceling")
            eventArgs.cancel = true
            return
        
        elseif state.DefenseMode.value ~= 'None' then
            -- Don't gearswap for weaponskills when Defense is on.
            eventArgs.handled = true
        end
    end
	-- gear sets
	if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and state.LuzafRing.value then
		equip(sets.precast.LuzafRing)
	elseif spell.type == 'CorsairShot' and state.CastingMode.value == 'Resistant' then
		classes.CustomClass = 'Acc'
    elseif spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
        end
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' or spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if spell.type == 'CorsairRoll' and not spell.interrupted then
		display_roll_info(spell)
	end
    if state.AutoRA.value ~= 'Normal' then
        use_ra(spell)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, default_wsmode)
	--if buffactive['Transcendancy'] then
	--	return 'Brew'
	--end
end
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    return idleSet
end
function customize_melee_set(meleeSet)
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
    if newStatus == 'Engaged' then
        get_combat_form()
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    if buff == 'Triple Shot' and gain then
        if (buffactive['Triple Shot']) then
            state.CombatForm:set('Triple')
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            if state.CombatForm.current ~= 'DW' then
                state.CombatForm:reset()
            end
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
end

function update_combat_form()
    if state.Buff['Triple Shot'] then
        state.CombatForm:set('Triple')
    else
        state.CombatForm:reset()
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
end

-- Job-specific toggles.
function job_toggle_state(field)
	if field:lower() == 'luzaf' then
		state.LuzafRing:toggle()
		return "Use of Luzaf Ring", state.LuzafRing.value
	end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Off.: '..state.OffenseMode.current
    msg = msg .. ', Rng.: '..state.RangedMode.current
    msg = msg .. ', WS.: '..state.WeaponskillMode.current
    msg = msg .. ', QD.: '..state.CastingMode.current

    if state.AutoRA.value ~= 'Normal' then
        msg = '[Auto RA: ON]['..state.AutoRA.value..']'
    else
        msg = msg .. '[Auto RA: OFF]'
    end
    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    msg = msg .. ', Roll Size: ' .. ((state.LuzafRing.value and 'Large') or 'Small')
    add_to_chat(122, msg)
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    if cor_sub_weapons:contains(player.equipment.main) then
    --if player.equipment.main == gear.Stave then
        if S{'NIN', 'DNC'}:contains(player.sub_job) and cor_sub_weapons:contains(player.equipment.sub) then
            state.CombatForm:set("DW")
        else
            state.CombatForm:reset()
        end
    end
    if state.Buff['Triple Shot'] then
        state.CombatForm:set('Triple')
    else
        state.CombatForm:reset()
    end
end

function define_roll_values()
	rolls = {
		["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
		["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
		["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
		["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
		["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
		["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
		["Puppet Roll"]      = {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
		["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
		["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
		["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
		["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
		["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
		["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
		["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
		["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
		["Drachen Roll"]     = {lucky=3, unlucky=7, bonus="Pet Accuracy"},
		["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
		["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
		["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
		["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
		["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
		["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
		["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
		["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
		["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
		["Allies's Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
		["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
		["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
		["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
	}
end

function display_roll_info(spell)
	rollinfo = rolls[spell.english]
	local rollsize = 'Small'
	if state.LuzafRing then
		rollsize = 'Large'
	end
	if rollinfo then
		add_to_chat(104, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
		add_to_chat(104, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.')
	end
end

-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
	local bullet_name
	local bullet_min_count = 1
	
	if spell.type == 'WeaponSkill' then
		if spell.skill == "Marksmanship" then
			if spell.element == 'None' then
				-- physical weaponskills
				bullet_name = gear.WSbullet
			else
				-- magical weaponskills
				bullet_name = gear.MAbullet
			end
		else
			-- Ignore non-ranged weaponskills
			return
		end
	elseif spell.type == 'CorsairShot' then
		bullet_name = gear.QDbullet
	elseif spell.action_type == 'Ranged Attack' then
		bullet_name = gear.RAbullet
		if buffactive['Triple Shot'] then
			bullet_min_count = 3
		end
	end
	
	local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]
	
	-- If no ammo is available, give appropriate warning and end.
	if not available_bullets then
		if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
			add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
			return
		elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
			add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
			return
		else
			add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
			eventArgs.cancel = true
			return
		end
	end
	
	-- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
	if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
		add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
		eventArgs.cancel = true
		return
	end
	
	-- Low ammo warning.
	if spell.type ~= 'CorsairShot' and not state.warned
	    and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '**** LOW AMMO WARNING: '..bullet_name..' ****'
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)
		state.warned = true
	elseif available_bullets.count > options.ammo_warning_limit and state.warned then
		state.warned = false
	end
end

function use_weaponskill()
    send_command('input /ws "'..auto_gun_ws..'" <t>')
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- GUN 
    if spell.type:lower() == 'weaponskill' then
        delay = '2.25' 
    else
        if buffactive["Courser's Roll"] then
            delay = '0.7' -- MAKE ADJUSTMENT HERE
        elseif buffactive['Flurry II'] then
            delay = '0.5'
        else
            delay = '1.05' -- MAKE ADJUSTMENT HERE
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function select_default_macro_book()
	set_macro_page(6, 1)
end
