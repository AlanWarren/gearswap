--[[     
 === Notes ===
 this is incomplete. my war just hit 99
 Using warcry = Upheaval
 Using bloodrage = Ukko's
--]]
--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    --state.Buff.Souleater = buffactive.souleater or false
    state.Buff.Berserk = buffactive.berserk or false
    state.Buff.Retaliation = buffactive.retaliation or false
    
    wsList = S{ 'Savage Blade', 'Impulse Drive', 'Torcleaver'}
    gsList = S{'Macbain', 'Kaquljaan', 'Nativus Halberd'}
    war_sub_weapons = S{"Sangarius", "Usonmunku", "Perun", "Tanmogayi"}

    get_combat_form()
    get_combat_weapon()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false
    state.drain = M(false)
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    
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
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Augmented gear
    
    Odyssean = {}
    Odyssean.Legs = {}
    Odyssean.Legs.TP = { name="Odyssean Cuisses", augments={'"Triple Atk."+2','"Mag.Atk.Bns."+5','Quadruple Attack +1','Accuracy+17 Attack+17',}}
    Odyssean.Legs.WS = { name="Odyssean Cuisses", augments={'Accuracy+25','DEX+1','Weapon skill damage +7%','Accuracy+10 Attack+10',}}
    --Odyssean.Feet = {}
    --Odyssean.Feet.FC = { name="Odyssean Greaves", augments={'Attack+20','"Fast Cast"+4','Accuracy+15',}}


    Valorous = {}
    Valorous.Feet = {}
    Valorous.Feet.WS ={ name="Valorous Greaves", augments={'Weapon skill damage +5%','STR+9','Accuracy+15','Attack+11',}}
    Valorous.Feet.TH = { name="Valorous Greaves", augments={'CHR+13','INT+1','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
    
    sets.TreasureHunter = { 
        head="White rarab cap +1", 
        waist="Chaac Belt",
        feet=Valorous.Feet.TH
     }

     sets.Organizer = {
         main="Devivifier",
         sub="Sangarius",
         neck="Bloodrain Strap",
         legs="Odyssean Cuisses",
         feet="Odyssean Greaves"
     }

    sets.MadrigalBonus = {
        hands="Composer's Mitts"
    }
     -- Precast Sets
     -- Precast sets to enhance JAs
     --sets.precast.JA['Mighty Strikes'] = {hands="Fallen's Finger Gauntlets +1"}
     sets.precast.JA['Blood Rage'] = { body="Boii Lorica +1" }
     sets.precast.JA['Provoke'] = { hands="Pummeler's Mufflers +1"}
     sets.precast.JA['Berserk'] = { hands="Warrior's Calligae +2", back="Cichol's Mantle"}
     sets.precast.JA['Aggressor'] = { head="Pummeler's Mask +1"}

     sets.CapacityMantle  = { back="Mecistopins Mantle" }
     --sets.Berserker       = { neck="Berserker's Torque" }
     sets.WSDayBonus      = { head="Gavialis Helm" }
     -- TP ears for night and day, AM3 up and down. 
     sets.BrutalLugra     = { ear1="Brutal Earring", ear2="Lugra Earring +1" }
     sets.Lugra           = { ear1="Lugra Earring +1" }
     sets.Brutal          = { ear1="Brutal Earring" }
 
     sets.reive = {neck="Ygnas's Resolve +1"}
     -- Waltz set (chr and vit)
     sets.precast.Waltz = {
        -- head="Yaoyotl Helm",
     }
            
     -- Fast cast sets for spells
     sets.precast.FC = {
         ammo="Impatiens",
         head="Cizin Helm +1",
         body="Odyssean Chestplate",
         ear1="Loquacious Earring",
         hands="Leyline Gloves",
         ring1="Weatherspoon Ring", -- 10 macc
         ring2="Prolix Ring",
         legs="Eschite Cuisses",
         feet="Odyssean Greaves"
     }
     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

     -- Midcast Sets
     sets.midcast.FastRecast = {
         ammo="Impatiens",
         head="Otomi Helm",
         feet="Odyssean Greaves"
     }
            
     -- Specific spells
     sets.midcast.Utsusemi = {
         head="Otomi Helm",
         feet="Odyssean Greaves"
     }
 
     -- Ranged for xbow
     sets.precast.RA = {
         head="Otomi Helm",
         hands="Buremte Gloves",
         feet="Ejekamal Boots"
     }
     sets.midcast.RA = {
         head="White rarab cap +1",
        --  neck="Iqabi Necklace",
         ear2="Tripudio Earring",
         hands="Buremte Gloves",
         ring1="Beeline Ring",
         ring2="Garuda Ring",
         waist="Chaac Belt",
         legs="Aetosaur Trousers +1",
     }

     -- WEAPONSKILL SETS
     -- General sets
     sets.precast.WS = {
         ammo="Knobkierrie",
         head="Flamma Zucchetto +2",
         neck="Defiant Collar",
         ear1="Brutal Earring",
         ear2="Moonshade Earring",
         body="Flamma Korazin +2",
         hands="Odyssean Gauntlets",
         ring1="Niqmaddu Ring",
         ring2="Flamma Ring",
         back="Cichol's Mantle",
         waist="Windbuffet Belt +1",
         legs=Odyssean.Legs.WS,
         feet="Sulevia's Leggings +2"
     }

     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        --  ammo="Ginsen",
        --  head="Valorous Mask",
         --body="Ravenous Breastplate",
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
         ear1="Cessance Earring",
         waist="Olseni Belt",
     })
    
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
        neck="Flame Gorget",
        waist="Light Belt",
    })
 
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        neck="Breeze Gorget",
        waist="Metalsinger Belt",
        feet=Valorous.Feet.WS
    })
     -- RESOLUTION
     -- 86-100% STR
     sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
         neck="Breeze Gorget",
         waist="Soil Belt"
     })
     sets.precast.WS.Resolution.Mid = set_combine(sets.precast.WS.Resolution, {
         ammo="Ginsen",
         head="Valorous Mask",
     })
     sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution.Mid, sets.precast.WS.Acc) 

     -- TORCLEAVER 
     -- VIT 80%
     sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
         head="Odyssean Helm",
         ammo="Knobkierrie",
         neck="Aqua Gorget",
         legs=Odyssean.Legs.WS,
         waist="Caudata Belt"
     })
     sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Mid, {
        --  ammo="Ginsen",
         neck="Aqua Gorget",
     })
     sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, sets.precast.WS.Acc)

    sets.precast.WS.Stardiver = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        waist="Soil Belt",
        legs="Sulevia's Cuisses +2",
    })
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        head="Valorous Mask",
        neck="Shadow Gorget",
        ear1="Ishvara Earring",
        waist="Metalsinger Belt",
        feet=Valorous.Feet.WS
    })
    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS['Impulse Drive'], {
        neck="Breeze Gorget",
    })
     -- Sword WS's
     -- SANGUINE BLADE
     -- 50% MND / 50% STR Darkness Elemental
     sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
         neck="Stoicheion Medal",
         ear1="Friomisi Earring",
         hands="Odyssean Gauntlets",
         legs="Limbo Trousers",
         ring2="Acumen Ring",
         back="Toro Cape",
     })
     sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
     sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

     -- REQUISCAT
     -- 73% MND - breath damage
     sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
         neck="Shadow Gorget",
         back="Cichol's Mantle",
         waist="Soil Belt",
     })
     sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
     sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc)
     
     -- Resting sets
     sets.resting = {
         --head="Baghere Salade",
         ring1="Dark Ring",
         ring2="Paguroidea Ring",
     }
 
     -- Idle sets
     sets.idle.Town = {
         ammo="Ginsen",
         head="Hjarrandi Helm",
         neck="Sanctity Necklace",
         ear1="Etiolation Earring",
         ear2="Eabani Earring",
         body="Tartarus Platemail",
         hands="Sulevia's Gauntlets +2",
         ring1="Niqmaddu Ring",
         ring2="Defending Ring",
         waist="Flume Belt",
         legs=Odyssean.Legs.TP,
         feet="Hermes' Sandals"
     }
     
     sets.idle.Field = set_combine(sets.idle.Town, {
         ammo="Staunch Tathlum",
         head="Hjarrandi Helm",
         ear1="Etiolation Earring",
         ear2="Eabani Earring",
         neck="Sanctity Necklace",
         body="Tartarus Platemail",
         ring1="Paguroidea Ring",
         ring2="Defending Ring",
         hands="Sulevia's Gauntlets +2",
         back="Impassive Mantle",
         waist="Flume Belt",
         legs="Sulevia's Cuisses +2",
         feet="Hermes' Sandals"
     })
     sets.idle.Regen = set_combine(sets.idle.Field, {
     })
 
     sets.idle.Weak = {
         head="Hjarrandi Helm",
         body="Tartarus Platemail",
         ring2="Paguroidea Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
     }

     -- Defense sets
     sets.defense.PDT = {
         ammo="Staunch Tathlum",
         head="Hjarrandi Helm",
         neck="Agitator's Collar",
         body="Tartarus Platemail",
         hands="Sulevia's Gauntlets +2",
         ring1="Sulevia's Ring",
         ring2="Patricius Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
         legs="Sulevia's Cuisses +2",
         feet="Volte Sollerets"
     }
     sets.defense.Reraise = sets.idle.Weak
 
     sets.defense.MDT = set_combine(sets.defense.PDT, {
         neck="Twilight Torque",
         ear1="Telos Earring",
         ring2="K'ayres Ring",
         back="Impassive Mantle",
     })
 
     sets.Kiting = {feet="Hermes' Sandals"}
 
     sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

     -- Defensive sets to combine with various weapon-specific sets below
     -- These allow hybrid acc/pdt sets for difficult content
     sets.Defensive = {
         ammo="Staunch Tathlum",
         head="Hjarrandi Helm",
         neck="Agitator's Collar",
         body="Tartarus Platemail",
         ring1="Sulevia's Ring",
         ring2="Defending Ring",
         hands="Sulevia's Gauntlets +2",
         back="Impassive Mantle",
         waist="Sailfi Belt +1",
         legs="Sulevia's Cuisses +2",
         feet="Volte Sollerets"
     }
     sets.Defensive_Mid = {
         head="Hjarrandi Helm",
         neck="Agitator's Collar",
         body="Tartarus Platemail",
         hands="Sulevia's Gauntlets +2",
         back="Impassive Mantle",
         ring1="Sulevia's Ring",
         waist="Sailfi Belt +1",
         ring2="Defending Ring",
         feet="Sulevia's Leggings +2"
     }
     sets.Defensive_Acc = {
         head="Hjarrandi Helm",
         neck="Agitator's Collar",
         hands="Sulevia's Gauntlets +2",
         body="Tartarus Platemail",
         ring1="Sulevia's Ring",
         ring2="Patricius Ring",
         legs="Sulevia's Cuisses +2",
         feet="Sulevia's Leggings +2"
     }
 
     -- Engaged set, assumes Liberator
     sets.engaged = {
         ammo="Ginsen",
         head="Flamma Zucchetto +2",
         neck="Lissome Necklace",
         ear1="Brutal Earring",
         ear2="Cessance Earring",
    	 body="Valorous Mail",
         hands="Sulevia's Gauntlets +2",
         ring1="Niqmaddu Ring",
         ring2="Flamma Ring",
         back="Cichol's Mantle",
         waist="Ioskeha Belt",
         legs=Odyssean.Legs.TP,
         feet="Flamma Gambieras +2"
     }
     sets.engaged.Mid = set_combine(sets.engaged, {
         ammo="Ginsen",
         neck="Lissome Necklace",
         ear1="Telos Earring",
         body="Valorous Mail",
     })
     sets.engaged.Acc = set_combine(sets.engaged.Mid, {
         body="Flamma Korazin +2"
        --  back="Grounded Mantle +1",
     })

     sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
     sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
     sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)

     sets.engaged.DW = set_combine(sets.engaged, {
        ear1="Eabani Earring",
        ear2="Suppanomimi",
        waist="Shetal Stone"
     })
     sets.engaged.OneHand = set_combine(sets.engaged, {
     })

     sets.engaged.GreatSword = set_combine(sets.engaged, {
         ear1="Brutal Earring",
         ear2="Cessance Earring",
     })
     sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid, {
         ear1="Telos Earring",
         --back="Grounded Mantle +1"
         --ring2="K'ayres RIng"
     })
     sets.engaged.GreatSword.Acc = set_combine(sets.engaged.Acc, {
     })

     sets.engaged.Reraise = set_combine(sets.engaged, {
     	head="Twilight Helm",neck="Twilight Torque",
     	body="Twilight Mail"
     })
     sets.buff.Berserk = { 
         --feet="Warrior's Calligae +2" 
     }
     sets.buff.Retaliation = { 
         hands="Pummeler's Mufflers +1"
     }
    
end

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    --elseif spell.target.distance > 8 and player.status == 'Engaged' then
    --    eventArgs.cancel = true
    --    add_to_chat(122,"Outside WS Range! /Canceling")
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end
 
function job_post_precast(spell, action, spellMap, eventArgs)

    -- Make sure abilities using head gear don't swap 
	if spell.type:lower() == 'weaponskill' then
        -- handle Gavialis Helm
        if is_sc_element_today(spell) then
            if state.OffenseMode.current == 'Normal' and wsList:contains(spell.english) then
                -- do nothing
            else
                equip(sets.WSDayBonus)
            end
        end
        -- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        
        if player.tp > 2999 then
            equip(sets.BrutalLugra)
        else -- use Lugra + moonshade
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.Lugra)
            else
                equip(sets.Brutal)
            end
        end
        -- Use SOA neck piece for WS in rieves
        if buffactive['Reive Mark'] then
            equip(sets.reive)
        end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if (state.HybridMode.current == 'PDT' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
        equip(sets.buff.Berserk)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
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
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.Buff.Berserk and not state.Buff.Retaliation then
    	meleeSet = set_combine(meleeSet, sets.buff.Berserk)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        if buffactive.Berserk and not state.Buff.Retaliation then
            equip(sets.buff.Berserk)
        end
        get_combat_weapon()
    --elseif newStatus == 'Idle' then
    --    determine_idle_group()
    end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    
    if S{'madrigal'}:contains(buff:lower()) then
        if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
            equip(sets.MadrigalBonus)
        end
    end
    -- Warp ring rule, for any buff being lost
    if S{'Warp', 'Vocation', 'Capacity'}:contains(player.equipment.ring2) then
        if not buffactive['Dedication'] then
            disable('ring2')
        end
    else
        enable('ring2')
    end
    
    if buff == "Berserk" then
        if gain and not buffactive['Retaliation'] then
            equip(sets.buff.Berserk)
        else
            if not midaction() then
                handle_equipping_gear(player.status)
            end
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
    get_combat_form()
    get_combat_weapon()

end

function get_custom_wsmode(spell, spellMap, default_wsmode)
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    --if war_sj then
        --state.CombatForm:set("War")
    --else
        --state.CombatForm:reset()
    --end
    if S{'NIN', 'DNC'}:contains(player.sub_job) and war_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
    elseif S{'SAM', 'WAR'}:contains(player.sub_job) and player.equipment.sub == 'Rinda Shield' then
        state.CombatForm:set("OneHand")
    else
        state.CombatForm:reset()
    end

end

function get_combat_weapon()
    if gsList:contains(player.equipment.main) then
        state.CombatWeapon:set("GreatSword")
    else -- use regular set
        state.CombatWeapon:reset()
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    --if stateField == 'Look Cool' then
    --    if newValue == 'On' then
    --        send_command('gs equip sets.cool;wait 1.2;input /lockstyle on;wait 1.2;gs c update user')
    --        --send_command('wait 1.2;gs c update user')
    --    else
    --        send_command('@input /lockstyle off')
    --    end
    --end
end

function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 8)
	elseif player.sub_job == 'SAM' then
		set_macro_page(1, 8)
	else
		set_macro_page(1, 8)
	end
end

