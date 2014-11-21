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
end

-- Setup vars that are user-independent.
function job_setup()
	-- Whether to use Luzaf's Ring
	state.LuzafRing = M(false, "Luzaf's Ring")
	state.warned = M(false)
    state.CapacityMode = M(false, 'Capacity Point Mantle')

	define_roll_values()
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Melee', 'Acc')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')

	gear.RAbullet = "Adlivun Bullet"
	gear.WSbullet = "Adlivun Bullet"
	gear.MAbullet = "Adlivun Bullet"
	gear.QDbullet = "Animikii Bullet"
	--gear.QDbullet = "Adlivun Bullet"
	options.ammo_warning_limit = 15

    state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }

    cor_sub_weapons = S{"Arendsi Fleuret", "Vanir Knife", "Sabebus", "Aphotic Kukri", "Atoyac", "Surcouf's Jambiya"}
    auto_gun_ws = "Wildfire"

    get_combat_form()
	-- Additional local binds
	-- Cor doesn't use hybrid defense mode; using that for ranged mode adjustments.
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
    -- gear located in COR_gear.lua
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
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

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

    msg = msg .. ', Roll Size: ' .. (state.LuzafRing.value and 'Large') or 'Small'
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
    else
        state.CombatForm:set('Stave')
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
