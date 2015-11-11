-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    indi_timer = ''
    indi_duration = 180
    state.CapacityMode = M(false, 'Capacity Point Mantle')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.Buff.Poison = buffactive['Poison'] or false

    state.OffenseMode:options('None', 'Normal', 'Melee')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Melee')

    gear.default.weaponskill_waist = "Windbuffet Belt +1"

    geo_sub_weapons = S{"Nehushtan", "Bolelabunga"}

    select_default_macro_book()
    send_command('bind != gs c toggle CapacityMode')
end

function file_unload()
    send_command('unbind !=')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga', 
        'Stonera', 'Watera', 'Aerora', 'Fira', 'Blizzara', 'Thundara',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = {body="Bagua Tunic"}
    sets.precast.JA['Life Cycle'] = {head="Azimuth Hood +1", body="Geomancy Tunic +1"}
    sets.precast.JA['Full Circle'] = {hands="Bagua Mitaines"}
    sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}

    sets.CapacityMantle  = { back="Mecistopins Mantle" }

    sets.Organizer = {
        main="Nehushtan", 
    }

    -- Fast cast sets for spells

    sets.precast.FC = {
        main="Marin Staff",
        head="Welkin Crown",
        ear2="Loquacious Earring",
        hands="Magavan Mitts",
        --body="Vanir Cotehardie",
        ring1="Prolix Ring",
        back="Lifestream Cape",
        waist="Witful Belt",
        legs="Geomancy Pants +1",
        feet="Chelona Boots"
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        --main="Tamaxchi",
        --sub="Genbu's Shield",
        --back="Pahtli Cape"
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        neck="Stoicheion Medal",
        hands="Bagua Mitaines",
    })

    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        --head="Nahtirah Hat",
        neck=gear.ElementalGorget,
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        --body="Vanir Cotehardie",
        --hands="Yaoyotl Gloves",
        ring1="Karieyh Ring",
        ring2="Ifrit Ring +1",
        back="Buquwik Cape",
        waist=gear.ElementalBelt,
        --legs="Hagondes Pants",
        feet="Hagondes Sabots"
    }

    sets.precast.WS['Flash Nova'] = {
        --ammo="Dosis Tathlum",
        head="Hagondes Hat",
        neck="Eddy Necklace",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        --body="Hagondes Coat",
        --hands="Yaoyotl Gloves",
        ring1="Acumen Ring",
        --ring2="Strendu Ring",
        back="Toro Cape",
        --waist="Snow Belt",
        --legs="Hagondes Pants",
        feet="Hagondes Sabots"
    }

    sets.precast.WS['Starlight'] = {ear2="Moonshade Earring"}

    sets.precast.WS['Moonlight'] = {ear2="Moonshade Earring"}


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = {
        ear2="Loquacious Earring",
        neck="Incanter's Torque",
        body="Azimuth Coat +1", -- 3%
        hands="Geomancy Mitaines +1", -- 3%
        ring1="Prolix Ring",
        back="Lifestream Cape",
        waist="Witful Belt", -- 4%
        legs="Geomancy Pants +1", -- 5%
    }

    sets.midcast.Geomancy = {
        main="Marin Staff",
        sub="Giuoco Grip",
        range="Dunna", 
        head="Azimuth Hood +1", -- 10
        neck="Incanter's Torque", -- 10
        ear1="Gwati Earring",
        hands="Geomancy Mitaines +1", -- 15
        body="Bagua Tunic", -- 10
        back="Lifestream Cape", -- 9
        legs="Geomancy Pants +1",
        feet="Umbani Boots"
    }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
        legs="Bagua Pants",
        feet="Azimuth Gaiters"
    })

    sets.midcast.Cure = set_combine(sets.midcast.FastRecast, {
        neck="Incanter's Torque",
        hands="Telchine Gloves",
        legs="Telchine Braconi"
    })
        --main="Tamaxchi",
        --sub="Genbu's Shield",
        --body="Heka's Kalasiris",
        --ring1="Haoma Ring",
        --ring2="Sirona's Ring",
        --back="Swith Cape +1",
        --legs="Nares Trews",
        --feet="Hagondes Sabots"
    
    sets.midcast.Curaga = sets.midcast.Cure

    --sets.midcast.Protectra = {ring1="Sheltered Ring"}

    --sets.midcast.Shellra = {ring1="Sheltered Ring"}

    sets.midcast.HighTierNuke = {
        main="Marin Staff",
        sub="Mephitis Grip",
        --sub="Wizzan Grip",
        --ammo="Witchstone",
        head="Welkin Crown",
        neck="Eddy Necklace",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        body="Azimuth Coat +1",
        hands="Helios Gloves",
        ring1="Shiva Ring",
        ring2="Shiva Ring",
        back="Toro Cape",
        waist="Refoccilation Stone", 
        legs="Azimuth Tights +1",
        feet="Helios Boots"
    }
    
    sets.midcast.HighTierNuke.Resistant = set_combine(sets.midcast.HighTierNuke, {
        head="Hagondes Hat",
        ear1="Friomisi Earring",
        ear2="Gwati Earring", 
        hands="Azimuth Gloves",
        back="Refraction Cape",
        legs="Azimuth Tights +1",
        feet="Helios Boots"
        --feet="Bokwus Boots"
    })
    --sets.midcast['Elemental Magic'].Mindmelter = set_combine(sets.midcast.HighTierNuke, {
    --    main="Mindmelter"
    --})

    sets.precast.JA['Concentric Pulse'] = sets.midcast.HightTierNuke

    sets.midcast.LowTierNuke = set_combine(sets.midcast.HighTierNuke, {
        sub="Giuoco Grip",
        ear2="Crematio Earring",
        body="Witching Robe",
        feet="Umbani Boots"
    })
    
    sets.midcast.LowTierNuke.Resistant = set_combine(sets.midcast.LowTierNuke, {
        head="Hagondes Hat",
        ear1="Friomisi Earring",
        ear2="Gwati Earring", 
        legs="Azimuth Tights +1",
        ring2="Sangoma Ring",
        back="Refraction Cape",
        feet="Helios Boots"
    })

    sets.midcast.Macc = { 
        main="Marin Staff",
        sub="Mephitis Grip", 
        ammo="Plumose Sachet",
        head="Bagua Galero",
        neck="Eddy Necklace", 
        ear1="Lifestorm Earring", 
        ear2="Psystorm Earring",
        body="Azimuth Coat +1",
        hands="Helios Gloves",
        ring1="Perception Ring", 
        ring2="Sangoma Ring",
        back="Refraction Cape",
        legs="Azimuth Tights +1",
        waist="Yamabuki-no-obi", 
        feet="Helios Boots"
    }
    
    sets.midcast.Aspir = set_combine(sets.midcast.Macc, { 
        head="Bagua Galero",
        neck="Incanter's Torque", 
        ear1="Gwati Earring",
        ear2="Hirudinea Earring",
        ring1="Excelsis Ring",
        body="Geomancy tunic +1",
        waist="Fucho-no-obi",
        legs="Azimuth Tights +1",
    })
    sets.midcast.Drain = sets.midcast.Aspir
    sets.midcast.Stun = sets.midcast.Macc
    
    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.Macc, {
        neck="Incanter's Torque",
        waist="Casso Sash",
        back="Lifestream Cape",
        hands="Azimuth Gloves",
        ring2="Globidonta Ring",
        feet="Bagua Sandals"
    })
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast.Macc, {
        waist="Casso Sash",
        back="Lifestream Cape",
        ring1="Shiva Ring",
        ring2="Globidonta Ring",
        feet="Bagua Sandals"
    })

	sets.midcast['Enhancing Magic'] = sets.midcast.FastRecast
        --sub="Fulcio Grip", 
        --neck="Colossus's Torque", 
        --body="Anhur Robe",
        --hands="Ayao's Gloves"
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
    sets.resting = {
        neck="Twilight Torque",
        body="Azimuth Coat +1",
        hands="Geomancy Mitaines +1",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
        --waist="Austerity Belt",
        --legs="Nares Trews",
    }


    -- Idle sets
    sets.idle = {
        main="Bolelabunga",
        sub="Genbu's Shield",
        range="Dunna",
        head="Azimuth Hood +1",
        neck="Lissome Necklace",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body="Azimuth Coat +1",
        hands="Bagua Mitaines",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
        back="Repulse Mantle",
        waist="Fucho-no-obi",
        legs="Azimuth Tights +1",
        feet="Geomancy Sandals"
    }
    sets.idle.PDT = set_combine(sets.idle, {
        head="Hagondes Hat",
        hands="Geomancy Mitaines +1",
        ring2="Patricius Ring",
        back="Repulse Mantle",
        feet="Azimuth Gaiters"
    })

    -- .Pet sets are for when Luopan is present.
    sets.idle.Pet = set_combine(sets.idle, {
        head="Azimuth Hood +1",
        hands="Geomancy Mitaines +1",
        back="Lifestream Cape",
        feet="Bagua Sandals"
    })

    sets.idle.PDT.Pet = set_combine(sets.idle.Pet, {
        ring2="Patricius Ring",
    })

    sets.idle.Melee = set_combine(sets.idle, {
        main="Malevolence",
        --sub="Bolelabunga"
    })

    -- .Indi sets are for when an Indi-spell is active.
    sets.idle.Indi = set_combine(sets.idle, {
        legs="Bagua Pants", 
        feet="Geomancy Sandals",
        back="Lifestream Cape",
        --feet="Azimuth Gaiters"
    })
    sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {
        legs="Bagua Pants", 
    })
    sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {
        legs="Bagua Pants", 
        feet="Azimuth Gaiters"
    })
    sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {
        legs="Bagua Pants", 
    })

    sets.idle.Town = set_combine(sets.idle, {
        body="Councilor's Garb",
        head="Welkin Crown",
        neck="Incanter's Torque",
        waist="Refoccilation Stone",
        legs="Geomancy Pants +1"
    })

    sets.idle.Weak = sets.idle

    -- Defense sets

    sets.defense.PDT = {
        range="Dunna",
        head="Hagondes Hat",
        neck="Twilight Torque",
        ear1="Zennaroi Earring",
        body="Azimuth Coat +1",
        hands="Geomancy Mitaines +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
        --back="Umbra Cape",
        --legs="Hagondes Pants",
        feet="Azimuth Gaiters"
    }

    sets.defense.MDT = {
        range="Dunna",
        --head="Nahtirah Hat",
        --neck="Wiglen Gorget",
        ear1="Zennaroi Earring",
        ear2="Loquacious Earring",
        body="Azimuth Coat +1",
        hands="Geomancy Mitaines +1",
        --ring1="Defending Ring",
        --ring2="Shadow Ring",
        --back="Umbra Cape",
        waist="Yamabuki-no-Obi",
        --legs="Bokwus Slops",
        --feet="Hagondes Sabots"
    }

    sets.Kiting = {}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group
    sets.engaged = {
        range="Dunna",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Azimuth Coat +1",
        --body="Vanir Cotehardie",
        hands="Geomancy Mitaines +1",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
        back="Kayapa Cape",
        waist="Windbuffet Belt +1",
        legs="Geomancy Pants +1",
        feet="Umbani Boots"
    }
    sets.engaged.Melee = set_combine(sets.engaged, {
        main="Malevolence",
    })
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    --if state.Buff.Poison then
    --    classes.CustomClass = 'Mindmelter'
    --end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    -- Make sure abilities using head gear don't swap 
	if spell.type:lower() == 'weaponskill' then
        -- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
--function job_status_change(newStatus, oldStatus, eventArgs)
--    if newStatus == 'Engaged' then
--        -- nothing yet
--        elseif newStatus == 'Idle' then
--            determine_idle_group()
--    end
--end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
            if lowTierNukes:contains(spell.english) then
                return 'LowTierNuke'
            else
                return 'HighTierNuke'
            end
        end

    end
end

function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CapacityMode.value then
        idleSet = set_combine(idleSet, sets.CapacityMantle)
    end
    if state.OffenseMode.value == 'Melee' then
        idleSet = set_combine(sets.idle, sets.idle.Melee)
    end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 6)
end

