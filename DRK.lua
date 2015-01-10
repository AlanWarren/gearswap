--[[     
 === Notes ===
    Souleater: By default, souleater will cancel after any weaponskill is used.  
               However, if Blood Weapon is used, Souleater will remain active for it's duration.
               It will be canceled after your next weaponskill, following Blood Weapon wearing off. 
               This behavior can be toggled off/on with @f9 (window key + f9) 
    Last Resort: There is an LR Hybrid Mode toggle present. This is useful when Last Resort may be risky.
    
    I simplified this lua since I got Liberator. There are no longer sets for greatswords. - Sorry
    
    Set format is as follows: 
    sets.engaged.[CombatForm][CombatWeapon][Offense or DefenseMode][CustomGroup]
    CombatForm = War
    CustomGroups = AM3
--]]
--
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
 
-- Setup vars that are user-independent.
function job_setup()
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false
    state.LookCool = M{['description']='Look Cool', 'Normal', 'On' }
    state.SouleaterMode = M(true, 'Soul Eater Mode')
    
    --wsList = S{'Spiral Hell'}
    
    get_combat_form()
    update_melee_groups()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'LR', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false
    
    -- Additional local binds
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c toggle SouleaterMode')
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind ^[ gs c cycle LookCool')
    
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
     -- Precast Sets
     -- Precast sets to enhance JAs
     sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets"}
     sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets"}
     sets.precast.JA['Nether Void'] = {legs="Bale Flanchard +2"}
     sets.precast.JA['Dark Seal'] = {head="Fallen's burgeonet"}
     sets.precast.JA['Souleater'] = {head="Ignominy burgeonet +1"}
     --sets.precast.JA['Last Resort'] = {feet="Fallen's Sollerets +1"}
     sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}
     sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +1"}

     sets.CapacityMantle = { back="Mecistopins Mantle" }
     sets.Berserker      = { neck="Berserker's Torque" }
     sets.WSDayBonus     = { head="Gavialis Helm" }
     sets.WSBack         = { back="Trepidity Mantle" }
 
     -- Waltz set (chr and vit)
     sets.precast.Waltz = {
        head="Yaoyotl Helm",
    	body="Mes'yohi Haubergeon",
        legs="Cizin Breeches +1",
        feet="Whirlpool Greaves"
     }
            
     -- Fast cast sets for spells
     sets.precast.FC = {
        ammo="Impatiens",
        head="Fallen's Burgeonet",
        ear1="Loquacious Earring",
        hands="Buremte Gloves",
        ring2="Prolix Ring"
     }

     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

     sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { 
         head="Cizin Helm +1",
         neck="Stoicheion Medal" 
     })
     sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
         head="Cizin Helm +1",
         neck="Stoicheion Medal" 
     })
     
     -- Midcast Sets
     sets.midcast.FastRecast = {
         ammo="Impatiens",
         head="Otomi Helm",
         hands="Cizin Mufflers +1",
         feet="Ejekamal Boots"
     }
            
     -- Specific spells
     sets.midcast.Utsusemi = {
         head="Otomi Helm",
         feet="Ejekamal Boots"
     }
 
     sets.midcast['Dark Magic'] = {
         ammo="Impatiens",
         head="Ignominy burgeonet +1",
         neck="Dark Torque",
         ear1="Lifestorm Earring",
         ear2="Psystorm Earring",
         body="Haruspex Coat",
         hands="Fallen's Finger Gauntlets",
         waist="Casso Sash",
         ring1="Perception Ring",
         ring2="Sangoma Ring",
         back={name="Niht Mantle", augments={'Attack +7','Dark magic skill +10','"Drain" and "Aspir" potency +25'}},
         legs="Fallen's Flanchard",
         feet="Ignominy sollerets"
     }
     
	 sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
         neck="Eddy Necklace",
         head="Otomi Helm",
         body="Ignominy Cuirass +1",
         ring1="Globidonta Ring",
         back="Aput Mantle"
     })

     sets.midcast['Elemental Magic'] = {
         ammo="Impatiens",
         head="Ignominy burgeonet +1",
         neck="Eddy Necklace",
         ear1="Friomisi Earring",
         ear2="Crematio Earring",
         body="Fallen's Cuirass +1",
         hands="Fallen's Finger Gauntlets",
         ring1="Shiva Ring",
         ring2="Acumen Ring",
         waist="Caudata Belt",
         --legs="Haruspex Slops",
         legs="Ignominy Flanchard +1",
         back="Aput Mantle",
         feet="Bale Sollerets +2"
     }
	 
     sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
         ammo="Impatiens",
         head="Gavialis Helm",
         body="Bale Cuirass +2",
         hands="Boor Bracelets",
         ring1="Beeline Ring",
         ring2="K'ayres Ring",
         back="Trepidity Mantle",
         legs="Ignominy Flanchard +1",
         feet="Ejekamal Boots"
     })
     
     sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
         ring2="Excelsis Ring",
     })
     sets.midcast.Aspir = sets.midcast.Drain

     sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
         back="Chuparrosa Mantle",
         hands="Pavor Gauntlets",
         feet="Black Sollerets"
     })

     sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
         hands="Bale Gauntlets +2"
     })
     sets.midcast['Absorb-STR'] = sets.midcast.Absorb
     sets.midcast['Absorb-DEX'] = sets.midcast.Absorb
     sets.midcast['Absorb-AGI'] = sets.midcast.Absorb
     sets.midcast['Absorb-MND'] = sets.midcast.Absorb
     sets.midcast['Absorb-VIT'] = sets.midcast.Absorb
     sets.midcast['Absorb-Attri'] = sets.midcast.Absorb
     sets.midcast['Absorb-Acc'] = sets.midcast.Absorb

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
         feet="Whirlpool Greaves"
     }

     -- WEAPONSKILL SETS
     -- General sets
     sets.precast.WS = {
         ammo="Fracas Grenade",
         head="Otomi Helm",
         neck="Bale Choker",
         ear1="Brutal Earring",
         ear2="Moonshade Earring",
         body="Ignominy Cuirass +1",
         hands="Mikinaak Gauntlets",
         ring1="Ifrit Ring",
         ring2="Ifrit Ring +1",
         back={name="Niht Mantle", augments={'Attack +10','Dark magic skill +4','"Drain" and "Aspir" potency +23', 'Weapon skill damage +1%'}},
         waist="Windbuffet Belt +1",
         legs="Ignominy Flanchard +1",
         feet="Fallen's Sollerets +1"
     }
     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
         ammo="Ginsen",
         head="Yaoyotl Helm",
         body="Fallen's Cuirass +1",
         hands="Ignominy Gauntlets +1",
         feet="Whirlpool Greaves"
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
         ear1="Zennaroi Earring",
         hands="Buremte Gloves",
         waist="Olseni Belt"
     })
 
     -- RESOLUTION
     -- 86-100% STR
     sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
         neck="Breeze Gorget",
         back={name="Niht Mantle", augments={'Attack +10','Dark magic skill +4','"Drain" and "Aspir" potency +23', 'Weapon skill damage +1%'}},
         waist="Soil Belt"
     })
     sets.precast.WS.Resolution.Mid = set_combine(sets.precast.WS.Resolution, {
         ammo="Ginsen",
         head="Yaoyotl Helm",
    	 body="Mes'yohi Haubergeon",
         hands="Ignominy Gauntlets +1",
         feet="Whirlpool Greaves"
     })
     sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution.Mid, sets.precast.WS.Acc) 

     -- TORCLEAVER 
     -- VIT 80%
     sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
         body="Phorcys Korazin",
         neck="Aqua Gorget",
         hands="Ignominy Gauntlets +1",
         legs="Scuffler's Cosciales",
         waist="Caudata Belt"
     })
     sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Mid, {
         ammo="Ginsen",
         neck="Aqua Gorget",
    	 body="Mes'yohi Haubergeon"
     })
     sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, sets.precast.WS.Acc)

     -- INSURGENCY
     -- 20% STR / 20% INT
     sets.precast.WS.Insurgency = set_combine(sets.precast.WS, {
         neck="Shadow Gorget",
         ear1="Bale Earring",
         legs="Scuffler's Cosciales",
         feet="Ejekamal Boots",
     })
     sets.precast.WS.Insurgency.AM3 = set_combine(sets.precast.WS.Insurgency, {
         back="Bleating Mantle",
         legs="Ignominy Flanchard +1"
     })
     sets.precast.WS.Insurgency.Mid = set_combine(sets.precast.WS.Insurgency, {
         ammo="Ginsen",
         head="Yaoyotl Helm",
         body="Fallen's Cuirass +1",
         hands="Ignominy Gauntlets +1",
         waist="Metalsinger Belt",
     })
     sets.precast.WS.Insurgency.Mid.AM3 = set_combine(sets.precast.WS.Insurgency.Mid, {})
     sets.precast.WS.Insurgency.Acc = set_combine(sets.precast.WS.Insurgency.Mid, {
         ring1="Mars's Ring",
         body="Mes'yohi Haubergeon",
         hands="Buremte Gloves",
         legs="Xaddi Cuisses",
         waist="Olseni Belt"
     })
     sets.precast.WS.Insurgency.Acc.AM3 = set_combine(sets.precast.WS.Insurgency.Acc, {
         body="Fallen's Cuirass +1"
     })

     -- CROSS REAPER
     -- 60% STR / 60% MND
     sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
         neck="Aqua Gorget",
         hands="Ignominy Gauntlets +1",
         body="Phorcys Korazin",
         waist="Windbuffet belt +1",
         legs="Scuffler's Cosciales",
         feet="Ejekamal Boots"
     })
     sets.precast.WS['Cross Reaper'].Mid = set_combine(sets.precast.WS.Mid, {
         neck="Aqua Gorget",
         body="Fallen's Cuirass +1",
         waist="Metalsinger Belt",
     })
     sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'].Mid, sets.precast.WS.Acc)
     
     -- ENTROPY
     -- 86-100% INT 
     sets.precast.WS.Entropy = set_combine(sets.precast.WS, {
         ammo="Ginsen",
         head="Ignominy burgeonet +1",
         neck="Shadow Gorget",
         body="Fallen's Cuirass +1",
         ring1="Shiva Ring",
         back="Bleating Mantle",
         waist="Soil Belt",
         feet="Mikinaak Greaves"
     })
     sets.precast.WS.Entropy.Mid = set_combine(sets.precast.WS.Entropy, { 
         head="Ighwa Cap",
         feet="Whirlpool Greaves"
     })
     sets.precast.WS.Entropy.Acc = set_combine(sets.precast.WS.Entropy.Mid, sets.precast.WS.Acc)

     -- Quietus
     -- 60% STR / MND 
     sets.precast.WS.Quietus = set_combine(sets.precast.WS, {
         neck="Shadow Gorget",
         ear2="Bale Earring",
         body="Fallen's Cuirass +1",
         hands="Ignominy Gauntlets +1",
         waist="Windbuffet Belt +1",
         feet="Ejekamal Boots"
     })
     sets.precast.WS.Quietus.Mid = set_combine(sets.precast.WS.Quietus, {
         head="Yaoyotl Helm",
         waist="Caudata Belt",
     })
     sets.precast.WS.Quietus.Acc = set_combine(sets.precast.WS.Quietus.Mid, sets.precast.WS.Acc)

     -- SPIRAL HELL
     -- 50% STR / 50% INT 
     sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS['Entropy'], {
         head="Ighwa Cap",
         body="Phorcys Korazin",
         neck="Aqua Gorget",
         legs="Scuffler's Cosciales",
         waist="Metalsinger belt",
     })
     sets.precast.WS['Spiral Hell'].Mid = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Mid)
     sets.precast.WS['Spiral Hell'].Acc = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Acc)

     -- SHADOW OF DEATH
     -- 40% STR 40% INT - Darkness Elemental
     sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
         head="Ignominy burgeonet +1",
         neck="Aqua Gorget",
         body="Fallen's Cuirass +1",
         ear1="Friomisi Earring",
         hands="Fallen's Finger Gauntlets",
         back="Argochampsa Mantle",
         waist="Caudata Belt",
         feet="Ignominy Sollerets"
      })
     sets.precast.WS['Shadow of Death'].Mid = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Mid)
     sets.precast.WS['Shadow of Death'].Acc = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Acc)

     -- Sword WS's
     -- SANGUINE BLADE
     -- 50% MND / 50% STR Darkness Elemental
     sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
         head="Ignominy burgeonet +1",
         neck="Stoicheion Medal",
         ear1="Friomisi Earring",
         ear2="Crematio Earring",
         body="Fallen's Cuirass +1",
         hands="Fallen's Finger Gauntlets",
         legs="Ignominy Flanchard +1",
         ring2="Acumen Ring",
         back="Argochampsa Mantle",
         feet="Ignominy Sollerets"
     })
     sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
     sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

     -- REQUISCAT
     -- 73% MND - breath damage
     sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
         head="Ighwa Cap",
         neck="Shadow Gorget",
         hands="Umuthi Gloves",
         body="Fallen's Cuirass +1",
         back="Bleating Mantle",
         waist="Soil Belt",
         feet="Whirlpool Greaves"
     })
     sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
     sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc)
     
     -- Resting sets
     sets.resting = {
         head="Twilight Helm",
         body="Ares' Cuirass +1",
         hands="Cizin Mufflers +1",
         ring1="Dark Ring",
         ring2="Paguroidea Ring",
         legs="Crimson Cuisses"
     }
 
     -- Idle sets
     sets.idle.Town = {
         ammo="Ginsen",
         head="Baghere Salade",
         neck="Coatl Gorget +1",
         ear1="Brutal Earring",
         ear2="Trux Earring",
         body="Mes'yohi Haubergeon",
         hands="Ignominy Gauntlets +1",
         ring1="Rajas Ring",
         ring2="Ifrit Ring +1",
         back={name="Niht Mantle", augments={'Attack +10','Dark magic skill +4','"Drain" and "Aspir" potency +23', 'Weapon skill damage +1%'}},
         waist="Windbuffet Belt +1",
         legs="Crimson Cuisses",
         feet="Fallen's Sollerets +1"
     }
     
    sets.cool = set_combine(sets.idle.Town, {
         head="Ignominy Burgeonet +1",
         legs="Ignominy Flanchard +1",
         feet="Ignominy Sollerets"
     })

     sets.idle.Field = set_combine(sets.idle.Town, {
         ammo="Ginsen",
         head="Baghere Salade",
         neck="Coatl Gorget +1",
         body="Emet Harness +1",
         hands="Cizin Mufflers +1",
         ring1="Dark Ring",
         ring2="Paguroidea Ring",
         back="Engulfer Cape +1",
         waist="Flume Belt",
         legs="Crimson Cuisses",
         feet="Cizin Greaves +1"
     })
     sets.idle.Regen = set_combine(sets.idle.Field, {
         body="Kumarbi's Akar"
     })
 
     sets.idle.Weak = {
         head="Twilight Helm",
         neck="Coatl Gorget +1",
         body="Twilight Mail",
         ring1="Dark Ring",
         ring2="Paguroidea Ring",
         back="Repulse Mantle",
         waist="Windbuffet Belt +1",
         legs="Crimson Cuisses",
         feet="Cizin Greaves +1"
     }

     sets.refresh = { 
         neck="Coatl Gorget +1",
         body="Ares' Cuirass +1"
     }
     
     -- Defense sets
     sets.defense.PDT = {
         head="Ighwa Cap",
         neck="Agitator's Collar",
         body="Emet Harness +1",
         hands="Cizin Mufflers +1",
         ear1="Zennaroi Earring",
         ring1="Dark Ring",
         ring2="Patricius Ring",
         back="Repulse Mantle",
         waist="Flume Belt",
         legs="Cizin Breeches +1",
         feet="Cizin Greaves +1"
     }
     sets.defense.Reraise = sets.idle.Weak
 
     sets.defense.MDT = set_combine(sets.defense.PDT, {
         neck="Twilight Torque",
         ear1="Zennaroi Earring",
         ring2="K'ayres Ring",
         back="Engulfer Cape +1"
     })
 
     sets.Kiting = {legs="Crimson Cuisses"}
 
     sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
     
     -- Defensive sets to combine with various weapon-specific sets below
     -- These allow hybrid acc/pdt sets for difficult content
     sets.Defensive = {
         head="Ighwa Cap",
         neck="Agitator's Collar",
         body="Emet Harness +1",
         hands="Cizin Mufflers +1",
         ring2="Patricius Ring",
         legs="Cizin Breeches +1"
     }
     sets.Defensive_Mid = {
         head="Ighwa Cap",
         neck="Agitator's Collar",
         body="Emet Harness +1",
         hands="Umuthi Gloves",
         ring2="Patricius Ring",
     }
     sets.Defensive_Acc = {
         head="Ighwa Cap",
         neck="Agitator's Collar",
         hands="Umuthi Gloves",
         body="Emet Harness +1",
         ring1="Mars's Ring",
         ring2="Patricius Ring",
         legs="Cizin Breeches +1",
         feet="Cizin Greaves +1"
     }
 
     -- Engaged set, assumes Liberator
     sets.engaged = {
         ammo="Ginsen",
         head="Otomi Helm",
         neck="Asperity Necklace",
         ear1="Brutal Earring",
         ear2="Trux Earring",
    	 body="Xaddi Mail",
         hands="Cizin Mufflers +1",
         ring1="Rajas Ring",
         ring2="K'ayres Ring",
         back="Bleating Mantle",
         waist="Windbuffet Belt +1",
         legs="Xaddi Cuisses",
         feet="Ejekamal Boots"
     }
     sets.engaged.Mid = set_combine(sets.engaged, {
         head="Yaoyotl Helm",
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
         hands="Xaddi Gauntlets",
    	 body="Mes'yohi Haubergeon",
         feet="Xaddi Boots",
     })
     sets.engaged.Acc = set_combine(sets.engaged.Mid, {
         ear1="Steelflash Earring",
         ear2="Zennaroi Earring",
         neck="Iqabi Necklace",
         ring1="Mars's Ring",
         ring2="Patricius Ring",
         waist="Olseni Belt"
     })
     sets.engaged.LR = set_combine(sets.engaged, {
         neck="Agitator's Collar",
         ring2="Patricius Ring",
         legs="Cizin Breeches +1"
     })
     sets.engaged.Mid.LR = set_combine(sets.engaged.Mid, {
         neck="Agitator's Collar",
         hands="Umuthi Gloves",
         ring2="Patricius Ring"
     })
     sets.engaged.Acc.LR = set_combine(sets.engaged.Acc, {
         neck="Agitator's Collar",
         hands="Umuthi Gloves",
         ring1="Patricius Ring"
     })
     sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
     sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
     sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)
     
     sets.engaged.War = set_combine(sets.engaged, {
         ear1="Brutal Earring",
         ear2="Tripudio Earring",
         head="Yaoyotl Helm",
         legs="Xaddi Cuisses",
         feet="Mikinaak Greaves"
     })
     sets.engaged.War.Mid = set_combine(sets.engaged.War, {
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
         legs="Xaddi Cuisses",
         feet="Ejekamal Boots"
     })
     sets.engaged.War.Acc = set_combine(sets.engaged.War.Mid, {
         neck="Iqabi Necklace",
         hands="Xaddi Gauntlets",
    	 body="Mes'yohi Haubergeon",
         ring1="Mars's Ring",
         ring2="Patricius Ring",
         waist="Olseni Belt"
     })
     sets.engaged.War.PDT = set_combine(sets.engaged.War, sets.Defensive)
     sets.engaged.War.Mid.PDT = set_combine(sets.engaged.War.Mid, sets.Defensive_Mid)
     sets.engaged.War.Acc.PDT = set_combine(sets.engaged.War.Acc, sets.Defensive_Acc)

     sets.engaged.AM3 = set_combine(sets.engaged, {
         ammo="Yetshila",
         head="Yaoyotl Helm",
         ear2="Tripudio Earring",
         hands="Cizin Mufflers +1",
         back="Bleating Mantle",
         legs="Xaddi Cuisses",
         feet="Ejekamal Boots"
     })
     sets.engaged.Mid.AM3 = set_combine(sets.engaged.AM3, {
         ammo="Ginsen",
         body="Mes'yohi Haubergeon",
         hands="Xaddi Gauntlets",
         legs="Xaddi Cuisses",
         feet="Xaddi Boots"
     })
     sets.engaged.Acc.AM3 = set_combine(sets.engaged.Mid.AM3, {
         neck="Iqabi Necklace",
         ear1="Zennaroi Earring",
         ear2="Steelflash Earring",
         ring1="Rajas Ring",
         ring2="Mars's Ring",
         waist="Olseni Belt"
     })

     sets.engaged.Reraise = set_combine(sets.engaged, {
     	head="Twilight Helm",neck="Twilight Torque",
     	body="Twilight Mail"
     })

     sets.buff.Souleater = { head="Ignominy burgeonet +1" }
     sets.buff['Last Resort'] = { feet="Fallen's Sollerets +1" }
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_precast(spell)
    --if spell.action_type == 'Magic' then
    --    equip(sets.precast.FC)
    --end
end
 
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
        if is_sc_element_today(spell) then
            equip(sets.WSDayBonus)
        end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        --if world.day_element == 'Dark' then
        --    equip(sets.WSBack)
        --end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
end
 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.HybridMode.current == 'Reraise' or
    (state.HybridMode.current == 'Physical' and state.PhysicalDefenseMode.current == 'Reraise') then
        equip(sets.Reraise)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_aftercast(spell)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
    end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if state.Buff.Souleater and state.SouleaterMode.value then
            send_command('@wait 1.0;cancel souleater')
        end
    end
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
    if player.mpp < 50 then
        idleSet = set_combine(idleSet, sets.refresh)
    end
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
    if state.Buff['Last Resort'] and state.HybridMode.current == 'LR' then
    	meleeSet = set_combine(meleeSet, sets.buff['Last Resort'])
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
    --if newStatus == "Engaged" then
    --    get_combat_weapon()
    --end
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    
    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end

    if buff == "Max HP Boost" then
        if gain then
            state.SouleaterMode:set(false)
        else
            state.SouleaterMode:set(true)
        end
    end

    if buff == 'Blood Weapon' then
        if gain or buffactive['Blood Weapon'] then
            state.SouleaterMode:set(false)
        else
            state.SouleaterMode:set(true)
        end
    end

    if buff == 'Aftermath: Lv.3' then
        classes.CustomMeleeGroups:clear()
	
        if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end

        handle_equipping_gear(player.status)
    end

    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
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
    update_melee_groups()

end

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if buffactive['Aftermath: Lv.3'] then
        return 'AM3'
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end

function aw_custom_aftermath_timers_precast(spell)
    if spell.type == 'WeaponSkill' then
        info.aftermath = {}
        
        local mythic_ws = "Insurgency"
        
        info.aftermath.weaponskill = mythic_ws
        info.aftermath.duration = 0
        
        info.aftermath.level = math.floor(player.tp / 1000)
        if info.aftermath.level == 0 then
            info.aftermath.level = 1
        end
        
        if spell.english == mythic_ws and player.equipment.main == 'Liberator' then
            -- nothing can overwrite lvl 3
            if buffactive['Aftermath: Lv.3'] then
                return
            end
            -- only lvl 3 can overwrite lvl 2
            if info.aftermath.level ~= 3 and buffactive['Aftermath: Lv.2'] then
                return
            end
            
            if info.aftermath.level == 1 then
                info.aftermath.duration = 90
            elseif info.aftermath.level == 2 then
                info.aftermath.duration = 120
            else
                info.aftermath.duration = 180
            end
        end
    end
end

-- Call from job_aftercast() to create the custom aftermath timer.
function aw_custom_aftermath_timers_aftercast(spell)
    if not spell.interrupted and spell.type == 'WeaponSkill' and
       info.aftermath and info.aftermath.weaponskill == spell.english and info.aftermath.duration > 0 then

        local aftermath_name = 'Aftermath: Lv.'..tostring(info.aftermath.level)
        send_command('timers d "Aftermath: Lv.1"')
        send_command('timers d "Aftermath: Lv.2"')
        send_command('timers d "Aftermath: Lv.3"')
        send_command('timers c "'..aftermath_name..'" '..tostring(info.aftermath.duration)..' down abilities/aftermath'..tostring(info.aftermath.level)..'.png')

        info.aftermath = {}
    end
end
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Look Cool' then
        if newValue == 'On' then
            send_command('gs equip sets.cool;wait 1.2;input /lockstyle on;wait 1.2;gs c update user')
            --send_command('wait 1.2;gs c update user')
        else
            send_command('@input /lockstyle off')
        end
    end
end

windower.register_event('Zone change', function(new,old)
    if state.LookCool.value == 'On' then
        send_command('wait 3; gs equip sets.cool;wait 1.2;input /lockstyle on;wait 1.2;gs c update user')
    end
end)

--function adjust_melee_groups()
--	classes.CustomMeleeGroups:clear()
--	if state.Buff.Aftermath then
--		classes.CustomMeleeGroups:append('AM')
--	end
--end
function update_melee_groups()

	classes.CustomMeleeGroups:clear()
	
    if buffactive['Aftermath: Lv.3'] then
		classes.CustomMeleeGroups:append('AM3')
	end
end

function select_default_macro_book()
        -- Default macro set/book
	    if player.sub_job == 'DNC' then
	    	set_macro_page(6, 2)
	    elseif player.sub_job == 'SAM' then
	    	set_macro_page(7, 4)
	    else
	    	set_macro_page(6, 2)
	    end
end
