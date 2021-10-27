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
    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper",  "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}

    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Head'] = 'Magic',
        -- ['Soulsoother Head'] = 'Heal',
        -- ['Spiritreaver Head'] = 'Nuke'
        }

    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}
    
    -- Var to track the current pet mode.
    --state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic', 'Heal', 'Nuke'}
    state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic' }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.IdleMode:options('Normal', 'Refresh', 'Regen', 'Refresh')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    -- cs c maneuver 1
    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }

    update_pet_mode()
    select_default_macro_book()
end


-- Define sets used by this job file.
function init_gear_sets()
    -- Precast Sets

    -- Fast cast sets for spells
    HercFeet = {}
    HercHead = {}
    HercHands = {}
    HercBody = {}

    HercHands.R = { name="Herculean Gloves", augments={'AGI+9','Accuracy+3','"Refresh"+1',}}
    HercHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+4','Mag. Acc.+8','"Mag.Atk.Bns."+13',}}
    HercHands.WSD = { name="Herculean Gloves", augments={'Accuracy+23 Attack+23','Weapon skill damage +3%','STR+10','Accuracy+10','Attack+1',}}
    
    HercHead.TP = { name="Herculean Helm", augments={'Accuracy+25','"Triple Atk."+4','AGI+6','Attack+14',}}
    HercHead.DM = { name="Herculean Helm", augments={'Pet: STR+9','Mag. Acc.+10 "Mag.Atk.Bns."+10','Weapon skill damage +9%','Accuracy+12 Attack+12',}}

    HercFeet.TP = { name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','DEX+8',}}
    
    HercBody.WSD = { name="Herculean Vest", augments={'"Blood Pact" ability delay -4','AGI+3','Weapon skill damage +9%','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}

    sets.organizer = { 
        main="Midnights",
        sub="Puppetry Tobe",
        ammo="Sakpata's Fists",
        ear1="Neo Animator",
        hands="Tali'ah Gages +1",
        ammo="Puppetry Dastanas",
        legs="Puppetry Churidars",
        feet="Divinator II",
        body="Tali'ah Crackows +2"
    }
    
    sets.precast.FC = {
        head=HercHead.TP,
        ear1="Loquacious Earring",
        --hands="Leyline Gloves",
        --body="Dread Jupon",
        ring1="Weatherspoon Ring",
        ring2="Prolix Ring",
        legs="Quiahuiz Trousers",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- Precast sets to enhance JAs
      sets.precast.JA['Tactical Switch'] = {
          --feet="Cirque Scarpe +2"
        }
      sets.precast.JA['Overdrive'] = {
          --body="Pitre Tobe +3"
        }
      sets.precast.JA['Ventriloquy'] = {
          --legs="Pitre Churidars +1"
        }
      sets.precast.JA['Role Reversal'] = { 
          --feet="Pantin Babouches +2"
        }
      sets.precast.JA['Repair'] = { 
        --   main="Nibiru Sainti",
          ammo="Automat. Oil +3",
        --   ear1="Guignol Earring",
          feet="Puppetry Babouches",
          --feet="Foire Babouches +2"
        }
      sets.precast.JA.Maneuver = {
          main="Midnights",
        --   neck="Buffoon's Collar +1",
        --   body="Karagoz Farsetto",
        --   hands="Foire Dastanas +3",
          back="Visucius's Mantle"
        }
      sets.precast.JA['Maintenance'] = {
        --   main="Nibiru Sainti",
          ammo="Automat. Oil +3",
        --   ear1="Guignol Earring",
        --   feet="Foire Babouches +2"
        }
     
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Mpaca's Cap",
        neck="Lissome Necklace",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body=HercBody.WSD,
        hands=HercHands.WSD,
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
        waist="Moonbow Belt",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {
        -- neck="Rancor Collar",
        -- ear1="Brutal Earring",
        -- ear2="Moonshade Earring",
        -- ring1="Spiral Ring",
        -- waist="Soil Belt"
    })
    sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], {
        -- legs="Nahtirah Trousers"
    })

    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {
        -- neck="Rancor Collar",
        -- ear1="Brutal Earring",
        -- ear2="Moonshade Earring",
        -- waist="Thunder Belt"
    })

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
        head=HercHead.DM,
        neck="Flame Gorget",
        waist="Light Belt"
    })

    
    -- Midcast Sets

    sets.midcast.FastRecast = {
        -- head="Haruspex Hat",
        -- ear2="Loquacious Earring",
        -- body="Otronif Harness +1",
        -- hands="Regimen Mittens",
        -- legs="Manibozho Brais",
        -- feet="Otronif Boots +1"
    }
        

    -- Midcast sets for pet actions
    sets.midcast.Pet.Cure = {
        -- legs="Foire Churidars"
    }

    sets.midcast.Pet['Elemental Magic'] = {
        -- feet="Pitre Babouches"
    }

      sets.midcast.Pet.WeaponSkill = {
          --main="Xiucoatl",
          --range="Animator P +1",
          head="Mpaca's Cap",
          --neck="Shulmanu Collar",
          ear1="Crepuscular Earring",
          ear2="Telos Earring",
          body="Mpaca's Doublet",
          hands="Mpaca's Gloves",
          ring1="Varar Ring",
          --ring2="Cath Palug Ring",
          back="Visucius's Mantle",
         -- waist="Hurch'lan Sash",
          waist="Klouskap Sash",
          legs="Mpaca's Hose",
          feet="Mpaca's Boots",
      }

      sets.midcast.Pet.Enmity = {
        --   body="Heyoka Harness",
        --   feet="Durgai Leggings"
      }
    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        -- head="Pitre Taj",
        -- neck="Wiglen Gorget",
        -- ring1="Sheltered Ring",
        -- ring2="Paguroidea Ring"
    }
    

    -- Idle sets

    sets.idle = {
        main="Sakpata's Fists",
        range="Divinator II",
        --head="Pitre Taj",
        head="Rao Kabuto",
        neck="Sanctity Necklace",
        ear1="Infused Earring",
        ear2="Genmei Earring",
        --body="Foire Tobe",
        body="Hizamaru Haramaki +2",
        hands="Mpaca's Gloves",
        ring1="Defending Ring",
        ring2="Paguroidea Ring",
        back="Visucius's Mantle",
        waist="Moonbow Belt",
        legs="Mpaca's Hose",
        feet="Hermes' Sandals"
    }

    sets.idle.Town = set_combine(sets.idle, {
        --main="Tinhaspa"
    })

    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle

    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {
        main="Sakpata's Fists",
        head="Mpaca's Cap",
        neck="Sanctity Necklace",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        ring1="Varar Ring",
        ring2="Gere Ring",
        back="Visucius's Mantle",
        waist="Klouskap Sash",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
    }

    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {
        --hands="Cirque Guanti +2",
        --legs="Cirque Pantaloni +2"
    })

    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, {
        -- legs="Cirque Pantaloni +2",
        -- feet="Cirque Scarpe +2"
    })

    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {
        -- legs="Cirque Pantaloni +2",
        -- feet="Cirque Scarpe +2"
    })


    -- Defense sets

    sets.defense.Evasion = {
        main="Sakpata's Fists",
        head="Malignance Chapeau",
        neck="Twilight Torque",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        body="Malignance Tabard",
        hands="Malignance Gloves",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back="Visucius's Mantle",
        waist="Moonbow Belt",
        legs="Malignance Tights", 
        feet="Malignance Boots"
    }

    sets.defense.PDT = {
        main="Sakpata's Fists",
        head="Nyame Helm",
        neck="Twilight Torque",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        body="Mpaca's Doublet",
        hands="Nyame Gauntlets",
        ring1="Defending Ring",
        ring2="Gere Ring",
        back="Visucius's Mantle",
        waist="Moonbow Belt",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    }

    sets.defense.MDT = sets.defense.PDT

    sets.Kiting = {
        feet="Hermes' Sandals"
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        main="Sakpata's Fists",
        --head="Ryuo Somen",
        head=HercHead.TP,
        neck="Lissome Necklace",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
        back="Visucius's Mantle",
        waist="Moonbow Belt",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots",
    }
    sets.engaged.Acc = sets.engaged
    sets.engaged.PDT = {
        main="Sakpata's Fists",
        head="Rao Kabuto",
        --neck="Twilight Torque",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        ring1="Varar Ring",
        ring2="Gere Ring",
        back="Visucius's Mantle",
        waist="Klouskap Sash",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
    }
    sets.engaged.Acc.PDT = {
        head="Mpaca's Cap",
    }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Activate' then
        -- local abil_recasts = windower.ffxi.get_ability_recasts()
        -- if abil_recasts[spell.recast_id] > 0 then
        --     send_command('input /ja "Deus Ex Automata" <me>')
        --     add_to_chat(28, 'Activate timer is not ready - Using [Deus Ex Automata]!')
        --     eventArgs.cancel = true
        --     return
        -- end
        job_update()
    end

    if spell.type == "WeaponSkill" and spell.target.distance > target_distance then
        cancel_spell()
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        handle_equipping_gear(player.status)
        return
    end
end

  -- Called when pet is about to perform an action
  function job_pet_midcast(spell, action, spellMap, eventArgs)
      if petWeaponskills:contains(spell.english) then
          classes.CustomClass = "Weaponskill"
      end
  
      if spell.english == 'Provoke' then
          send_command('timers c "Strobe:Provoke" 30 up abilities/00002.png')
      elseif spell.english == 'Flash' then
          send_command('timers c "Flashbulb:Flash" 45 up abilities/00002.png')
      end
  
      handle_equipping_gear(player.status)
  end


  function job_pet_aftercast(spell, action, spellMap, eventArgs)
      handle_equipping_gear(player.status)
  end

  -------------------------------------------------------------------------------------------------------------------
  -- Customization hook for idle sets.
  -------------------------------------------------------------------------------------------------------------------
  
  function customize_idle_set(idleSet)
      return idleSet
  end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then
        handle_equipping_gear(player.status)
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end

 -- Called when the pet's status changes.
 function job_pet_status_change(newStatus, oldStatus)
     if newStatus == 'Engaged' or newStatus == 'Idle' then
         handle_equipping_gear(player.status)
     end
 end


  -- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
  function job_handle_equipping_gear(playerStatus, eventArgs)    	
      if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' or player.equipment.back == 'Nexus Cape' then
          disable('back')
      else
          enable('back')
      end
  end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
      local msg = 'Melee'
      
      if state.CombatForm.has_value then
          msg = msg .. ' (' .. state.CombatForm.value .. ')'
      end
      
      msg = msg .. ': '
      
      msg = msg .. state.OffenseMode.value
      if state.HybridMode.value ~= 'Normal' then
          msg = msg .. '/' .. state.HybridMode.value
      end
      msg = msg .. ', WS: ' .. state.WeaponskillMode.value
      
      if state.DefenseMode.value ~= 'None' then
          msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
      end
      
      if state.Kiting.value then
          msg = msg .. ', Kiting'
      end
  
      add_to_chat(122, msg)
  
      eventArgs.handled = true
    display_pet_status()
end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        -- if pet.isvalid then
        --     local man = defaultManeuvers[state.PetMode.value]
        --     if man and tonumber(cmdParams[2]) then
        --         man = man[tonumber(cmdParams[2])]
        --     end

        --     if man then
        --         send_command('input /pet "'..man..'" <me>')
        --     end
        -- else
        --     add_to_chat(123,'No valid pet.')
        -- end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
        return petModes[pet.head] or 'None'
    else
        return 'None'
    end
end

-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end

-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end

-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
        
        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end
        
        add_to_chat(122,petInfoString)
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
         set_macro_page(5, 11)
    -- if player.sub_job == 'DNC' then
    --     set_macro_page(2, 9)
    -- elseif player.sub_job == 'NIN' then
    --     set_macro_page(3, 9)
    -- elseif player.sub_job == 'THF' then
    --     set_macro_page(4, 9)
    -- else
    --     set_macro_page(1, 9)
    -- end
end


