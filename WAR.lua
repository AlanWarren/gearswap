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
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    --state.Buff.Souleater = buffactive.souleater or false
    state.Buff.Berserk = buffactive.berserk or false
    state.Buff.Retaliation = buffactive.retaliation or false
    
    wsList = S{}
    gsList = S{'Macbain', 'Kaquljaan'}
    war_sub_weapons = S{"Sangarius", "Usonmunku"}

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
     Acro = {}
     Acro.Hands = {}
     Acro.Feet = {}
    
     Acro.Hands.Haste = {name="Acro gauntlets", augments={'STR+3 AGI+3','Accuracy+18 Attack+18','Haste+2'}} 
     Acro.Hands.STP = {name="Acro gauntlets", augments={'Accuracy+19 Attack+19','"Store TP"+5','Weapon skill damage +3%'}}

     Acro.Feet.STP = {name="Acro Leggings", augments={'STR+7 AGI+7','Accuracy+17 Attack+17','"Store TP"+6'}} 
     Acro.Feet.WSD = {name="Acro Leggings", augments={'Accuracy+18 Attack+18','"Dbl. Atk."+3','Weapon skill damage +2%'}} 

     Niht = {}
     Niht.DarkMagic = {name="Niht Mantle", augments={'Attack+7','Dark magic skill +10','"Drain" and "Aspir" potency +25'}}
     Niht.WSD = {name="Niht Mantle", augments={'Attack+9','Dark magic skill +4', '"Drain" and "Aspir" potency +11','Weapon skill damage +4%'}}

     sets.Organizer = {
         main="Devivifier",
         sub="Sangarius",
         neck="Bloodrain Strap",
         head="Acro Helm",
         hands="Acro Gauntlets",
         body="Acro Surcoat",
         legs="Acro Breeches",
         feet="Acro Leggings"
     }

     -- Precast Sets
     -- Precast sets to enhance JAs
     --sets.precast.JA['Mighty Strikes'] = {hands="Fallen's Finger Gauntlets +1"}
     sets.precast.JA['Blood Rage'] = { body="Boii Lorica +1" }

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
        head="Yaoyotl Helm",
        legs="Cizin Breeches +1",
     }
            
     -- Fast cast sets for spells
     sets.precast.FC = {
         ammo="Impatiens",
         head="Cizin Helm +1",
         body="Yorium Cuirass",
         ear1="Loquacious Earring",
         hands="Leyline Gloves",
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
         neck="Iqabi Necklace",
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
         --ammo="Fracas Grenade",
         head="Valorous Mask",
         neck="Defiant Collar",
         ear1="Brutal Earring",
         ear2="Moonshade Earring",
         body="Acro Surcoat",
         hands="Odyssean Gauntlets",
         ring1="Karieyh Ring",
         ring2="Ifrit Ring",
         waist="Windbuffet Belt +1",
         back="Mauler's Mantle",
         legs="Argosy Breeches",
         feet=Acro.Feet.WSD
     }
     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
         ammo="Ginsen",
         head="Valorous Mask",
         --body="Ravenous Breastplate",
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
         ear1="Zennaroi Earring",
         hands="Crusher's Gauntlets",
         waist="Olseni Belt",
     })
    
    sets.precast.WS['Upheaval'] = set_combine(sets.precast.WS, {
        neck="Flame Gorget",
        body="Mes'yohi Haubergeon",
        hands="Crusher's Gauntlets",
        waist="Light Belt",
    })
 
    sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
        ammo="Yetshila",
        neck="Breeze Gorget",
        hands=Acro.Hands.STP,
        waist="Metalsinger Belt",
        back="Mauler's Mantle",
        feet="Thereoid Greaves"
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
         neck="Aqua Gorget",
         hands="Crusher's Gauntlets",
         legs="Yorium Cuisses",
         waist="Caudata Belt"
     })
     sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Mid, {
         ammo="Ginsen",
         neck="Aqua Gorget",
     })
     sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, sets.precast.WS.Acc)

     -- Sword WS's
     -- SANGUINE BLADE
     -- 50% MND / 50% STR Darkness Elemental
     sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
         neck="Stoicheion Medal",
         ear1="Friomisi Earring",
         hands=Acro.Hands.STP,
         legs="Limbo Trousers",
         ring2="Acumen Ring",
         back="Toro Cape",
     })
     sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
     sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

     -- REQUISCAT
     -- 73% MND - breath damage
     sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
         head="Otomi Helm",
         neck="Shadow Gorget",
         back="Bleating Mantle",
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
         head="Valorous Mask",
         neck="Sanctity Necklace",
         ear1="Cessance Earring",
         ear2="Tripudio Earring",
         hands="Redan Gloves",
         body="Boii Lorica +1",
         ring1="Karieyh Ring",
         ring2="Defending Ring",
         back="Mauler's Mantle",
         legs="Boii Cuisses +1",
         waist="Windbuffet Belt +1",
         feet="Hermes' Sandals"
     }
     
     sets.idle.Field = set_combine(sets.idle.Town, {
         ammo="Ginsen",
         head="Valorous Mask",
         neck="Sanctity Necklace",
         body="Kumarbi's Akar",
         ring1="Karieyh Ring",
         ring2="Paguroidea Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
         feet="Hermes' Sandals"
     })
     sets.idle.Regen = set_combine(sets.idle.Field, {
     })
 
     sets.idle.Weak = {
         head="Valorous Mask",
         body="Twilight Mail",
         ring2="Paguroidea Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
     }

     -- Defense sets
     sets.defense.PDT = {
         head="Yorium Barbuta",
         neck="Agitator's Collar",
         body="Jumalik Mail",
         hands="Redan Gloves",
         ear1="Zennaroi Earring",
         ring1="Dark Ring",
         ring2="Patricius Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
         legs="Odyssean Cuisses",
         feet="Odyssean Greaves"
     }
     sets.defense.Reraise = sets.idle.Weak
 
     sets.defense.MDT = set_combine(sets.defense.PDT, {
         neck="Twilight Torque",
         ear1="Zennaroi Earring",
         ring2="K'ayres Ring",
         back="Impassive Mantle",
     })
 
     sets.Kiting = {feet="Hermes' Sandals"}
 
     sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

     -- Defensive sets to combine with various weapon-specific sets below
     -- These allow hybrid acc/pdt sets for difficult content
     sets.Defensive = {
         head="Yorium Barbuta",
         neck="Agitator's Collar",
         body="Jumalik Mail",
         hands="Redan Gloves",
         ring2="Defending Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
         legs="Cizin Breeches +1",
         feet="Amm Greaves"
     }
     sets.Defensive_Mid = {
         head="Yorium Barbuta",
         neck="Agitator's Collar",
         body="Jumalik Mail",
         hands="Redan Gloves",
         back="Impassive Mantle",
         ring2="Defending Ring",
         feet="Loyalist Sabatons"
     }
     sets.Defensive_Acc = {
         head="Yorium Barbuta",
         neck="Agitator's Collar",
         hands="Redan Gloves",
         body="Founder's Breastplate",
         ring2="Defending Ring",
         legs="Cizin Breeches +1",
         feet="Loyalist Sabatons"
     }
 
     -- Engaged set, assumes Liberator
     sets.engaged = {
         ammo="Yetshila",
         head="Valorous Mask",
         neck="Asperity Necklace",
         ear1="Brutal Earring",
         ear2="Cessance Earring",
    	 body="Boii Lorica +1",
         hands=Acro.Hands.STP,
         ring1="Rajas Ring",
         ring2="Oneiros Ring",
         back="Mauler's Mantle",
         waist="Windbuffet Belt +1",
         legs="Odyssean Cuisses",
         feet=Acro.Feet.WSD
     }
     sets.engaged.Mid = set_combine(sets.engaged, {
         ammo="Ginsen",
         neck="Lissome Necklace",
         hands="Odyssean Gauntlets",
         feet=Acro.Feet.WSD
     })
     sets.engaged.Acc = set_combine(sets.engaged.Mid, {
         head="Argosy Celata",
         ring2="Mars's Ring",
         waist="Olseni Belt",
         back="Grounded Mantle +1",
         feet="Loyalist Sabatons"
     })

     sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
     sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
     sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)

     sets.engaged.DW = set_combine(sets.engaged, {
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        waist="Shetal Stone"
     })
     sets.engaged.OneHand = set_combine(sets.engaged, {
     })

     sets.engaged.GreatSword = set_combine(sets.engaged, {
         ear1="Cessance Earring",
         ear2="Tripudio Earring"
     })
     sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid, {
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
         --feet="Ravager's Calligae +2" 
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
    if state.Buff.Berserk and not state.Buff.Retaliation then
    	meleeSet = set_combine(meleeSet, sets.buff.Berserk)
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

