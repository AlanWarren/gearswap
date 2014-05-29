-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
-- NOTE: This is Mote's GEO.lua with added support for nuking like a boss

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
	include('Mote-Include.lua')
end

-- Setup vars that are user-independent.
function job_setup()

end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    options.CastingModes = {'Normal', 'Resistant', 'Proc'}
	options.OffenseModes = {'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.Defense.PhysicalMode = 'PDT'
    state.OffenseMode = 'None'
	
	-- Default macro set/book
	set_macro_page(1, 6)
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
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Vanir Cotehardie",ring1="Prolix Ring",
		back="Swith Cape",waist="Witful Belt",legs="Orvail Pants +1",feet="Chelona Boots +1"}

	sets.precast.FC.Cure = {
		head="Nahtirah Hat",ear2="Loquacious Earring",
		body="Heka's Kalasiris",ring1="Prolix Ring",
		back="Pahtli Cape",waist="Witful Belt",legs="Orvail Pants +1",feet="Chelona Boots +1"}

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {neck="Stoicheion Medal"}) 

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Flash Nova'] = {
		head="Hagondes Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring2="Strendu Ring",
		back="Toro Cape",waist="Snow Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

	sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}
	
	
	-- Midcast Sets
	
	sets.midcast.FastRecast = {
		head="Zelus Tiara",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Bokwus Gloves",ring1="Prolix Ring",
		back="Swith Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
		
	sets.midcast.Geomancy = {range="Filiae Bell", body="Bagua Tunic", hands="Geomancy Mitaines",
        back="Lifestream Cape", legs="Bagua Pants"}

	sets.midcast.Cure = {
		body="Heka's Kalasiris",hands="Bokwus Gloves",
		back="Swith Cape",legs="Nares Trews",feet="Hagondes Sabots"}

	sets.midcast.Protectra = {ring1="Sheltered Ring"}

	sets.midcast.Shellra = {ring1="Sheltered Ring"}

	sets.midcast['Enhancing Magic'] = { sub="Fulcio Grip", neck="Colossus's Torque", body="Anhur Robe",
        hands="Ayao's Gloves"
    }
    sets.midcast.Stoneskin = sets.midcast['Enhancing Magic']

    sets.midcast.Macc = { main="Antinian Staff", sub="Mephitis Grip", ammo="Aureole",
        head="Nahtirah Hat", neck="Eddy Necklace", lear="Lifestorm Earring", rear="Psystorm Earring",
        body="Bokwus Robe", hands="Hagondes Cuffs", lring="Balrahn's Ring", rring="Sangoma Ring",
        back="Lifestream Cape", waist="Demonry Sash", legs="Bokwus Slops", feet="Bokwus Boots"}
    
    sets.midcast['Enfeebling Magic'] = sets.midcast.Macc
    sets.midcast.ElementalEnfeeble = sets.midcast.Macc

    sets.midcast['Dark Magic']  = set_combine(sets.midcast.Macc, {
        head="Bagua Galero", neck="Aesir Torque",
        body="Geomancy Tunic", back="Merciful Cape",
        waist="Fucho-no-Obi"
    })
    sets.midcast.Aspir = set_combine(sets.midcast['Dark Magic'], { lring="Excelsis Ring" })
    sets.midcast.Drain = sets.midcast.Aspir
    sets.midcast.Stun = sets.midcast.Macc

	-- Elemental Magic sets are default for handling low-tier nukes.
    sets.midcast.LowTierNuke = {main="Lehbrailg +2",sub="Wizzan Grip",ammo="Witchstone",
        head="Hagondes Hat",neck="Stoicheion Medal",ear1="Hecate's Earring",ear2="Friomisi Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
        back="Toro Cape",waist=gear.ElementalObi,legs="Hagondes Pants",feet="Hagondes Sabots"}
    
    sets.midcast.LowTierNuke.Resistant = set_combine(sets.midcast.LowTierNuke, {
        ear1="Psystorm Earring", ear2="Lifestorm Earring",
        feet="Bokwus Boots"
    })
    
    -- Idle set when doing procs. Fast cast gear, minimal nuke gear. Won't change out of this for nukes.
    sets.midcast.LowTierNuke.Proc = {main="Earth Staff", sub="Wizzan Grip",ammo="Impatiens",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Manasa Chasuble",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Swith Cape",waist="Witful Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    
    -- Custom classes for high-tier nukes.
    sets.midcast.HighTierNuke = {main="Lehbrailg +2",sub="Wizzan Grip",ammo="Witchstone",
        head="Hagondes Hat",neck="Stoicheion Medal",ear1="Hecate's Earring",ear2="Friomisi Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Strendu Ring",
        back="Toro Cape",waist=gear.ElementalObi,legs="Hagondes Pants",feet="Hagondes Sabots"}
    
    sets.midcast.HighTierNuke.Resistant = set_combine(sets.midcast.HighTierNuke, {
        ear1="Psystorm Earring", ear2="Lifestorm Earring",
        feet="Bokwus Boots"
    })

	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {head="Nefer Khat +1",neck="Wiglen Gorget",
		body="Heka's Kalasiris",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		legs="Nares Trews",feet="Chelona Boots +1"}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle.Town = {main="Bolelabunga",sub="Genbu's Shield",range="Matre Bell",
		head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Nares Trews",feet="Herald's Gaiters"}
	
	sets.idle.Field = {main="Bolelabunga",sub="Genbu's Shield",range="Matre Bell",
		head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.Field.PDT = {main="Bolelabunga",sub="Genbu's Shield",range="Matre Bell",
		head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Nares Trews",feet="Herald's Gaiters"}

	sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",range="Matre Bell",
		head="Nefer Khat +1",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Heka's Kalasiris",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Nares Trews",feet="Herald's Gaiters"}
	
	-- Defense sets

	sets.defense.PDT = {range="Matre Bell",
		head="Hagondes Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

	sets.defense.MDT = {range="Matre Bell",
		head="Nahtirah Hat",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
		body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Bokwus Slops",feet="Hagondes Sabots"}

	sets.Kiting = {feet="Herald's Gaiters"}
	
    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {range="Matre Bell",
		head="Zelus Tiara",neck="Peacock Charm",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="Paguroidea Ring",
		back="Umbra Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Goading Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Sekhmet Corset"
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
		-- Default base equipment layer of fast recast.
		equip(sets.midcast.FastRecast)

        if spell.skill == 'Elemental Magic' and state.CastingMode == 'Proc' then
            add_to_chat(15, 'Proc mode, no damage gear for midcast.')
            eventArgs.handled = true
        end
	end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------
-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
    end
end

function customize_idle_set(idleSet)
	return idleSet
end

function customize_melee_set(meleeSet)
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus,oldStatus)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	--handle_equipping_gear(player.status)
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'OffenseMode' then
        if newValue == 'Normal' then
            disable('main','sub')
        else
            enable('main','sub')
        end
    elseif stateField == 'Reset' then
        if state.OffenseMode == 'None' then
            enable('main','sub')
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)

end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local meleeString = ''
    if state.OffenseMode == 'Normal' then
        meleeString = 'Melee: Weapons locked, '
    end
    
    local defenseString = ''
    if state.Defense.Active then
        local defMode = state.Defense.PhysicalMode
        if state.Defense.Type == 'Magical' then
            defMode = state.Defense.MagicalMode
        end
    
        defenseString = 'Defense: '..state.Defense.Type..' '..defMode..', '
    end
    
    add_to_chat(122,meleeString..'Casting ['..state.CastingMode..'], Idle ['..state.IdleMode..'], '..defenseString..
    'Kiting: '..on_off_names[state.Kiting])
    
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


