--[[     
 === Features ===
    !!!!Make sure you have my User-Globals.lua!!! Do not rename it. It goes in the data folder along side this file.

    If you don't use organizer, then remove the include('organizer-lib') in get_sets() and remove sets.Organizer

    This lua has a few MODES you can toggle with hotkeys, and there's a few situational RULES that activate without hotkeys
    I'd recommend reading and understanding the following information if you plan on using this file.

    ::MODES::

    SouleaterMode: OFF by default. Toggle this with @F9 (window key + F9). 
    This mode makes it possible to use Souleater in situations where you would normally avoid using it. When SouleaterMode 
    is ON, Souleater will be canceled automatically after the first Weaponskill used, WITH THESE EXCEPTIONS. If Bloodweapon 
    is active, or if Drain's HP Boost buff is active, then Souleater will remain active until the next WS used after 
    either buff wears off. If you use DRK at events, I'd recommend making this default to ON, as it's damn useful.

    LastResortMode OFF by default. Toggle with CTRL + `  (back tic is left of the 1 key). 
    This mode will equip Fallen's sollerets while LR is active to negate 10% of the defense penalty. 
    (this is probably less useful now days, with current gear)
    
    CapacityMode OFF by default. Toggle with ALT + = 
    It will full-time whichever piece of gear you specify in sets.CapacityMantle 

    NOTE: You can change the default (true|false) status of any MODE by changing their values in job_setup()

    ::RULES::

    Gavialis Helm will automatically be used for all weaponskills on their respective days of the week. If you don't want
    it used for a ws, then you have to add the WS to wsList = {} in job_setup. You also need my User-Globals.lua for this
    to even work. 

    Ygna's Resolve +1 will automatically be used when you're in a reive. If you have my User-Globals.lua this will work
    with all your jobs that use mote's includes. Not just this one! 

    Moonshade earring is not used for WS's at 3000 TP. 

    You can hit F12 to display custom MODE status as well as the default stuff. 

    ::NOTES::

    All of the default sets are geared around scythe. There is support for great sword by using 
    sets.engaged.GreatSword but you will have to edit gsList in job_setup so that your GS is present. IF you would rather
    all the default sets (like sets.engaged, etc.) cater to great sword instead of scyth, then simply remove the great swords 
    listed in gsList and ignore sets.engaged.GreatSword. (but dont delete it)  
    
    Set format is as follows: 
    sets.engaged.[CombatForm][CombatWeapon][Offense or HybridMode][CustomMeleeGroups]
    
    CombatForm = Haste, DW 
    CombatWeapon = GreatSword
    OffenseMode = Normal, Mid, Acc
    HybridMode = Normal, PDT
    CustomMeleeGroups = AM3

    CombatForm Haste is used when Last Resort AND either Haste, March, Indi-Haste Geo-Haste is on you.
    This allows you to equip full acro, even though it doesn't have 25% gear haste. You still cap. 

    CombatForm DW will activate with /dnc or /nin AND a weapon listed in drk_sub_weapons equipped offhand.
   
    CombatWeapon GreatSword will activate when you equip a GS listed in gsList in job_setup() 

    CustomMeleeGroups AM3 will activate when Aftermath lvl 3 is up. 
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

    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false
    -- Set the default to false if you'd rather SE always stay acitve
    state.SouleaterMode = M(false, 'Soul Eater Mode')
    state.LastResortMode = M(false, 'Last Resort Mode')
    -- If you have a fully upgraded Apoc, set this to true 
    state.ApocHaste = M(false, 'Apoc Haste Mode')   
    -- Weaponskills you do NOT want Gavialis helm used with
    wsList = S{'Spiral Hell', 'Torcleaver'}
    -- Greatswords you use. 
    gsList = S{'Malfeasance', 'Macbain', 'Kaquljaan', 'Mekosuchus Blade' }
    -- Mote has capitalization errors in the default Absorb mappings, so we correct them
    absorbs = S{'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT', 'Absorb-MND', 'Absorb-CHR', 'Absorb-Attri', 'Absorb-ACC', 'Absorb-TP'}
    -- Offhand weapons used to activate DW mode
    drk_sub_weapons = S{"Sangarius", "Usonmunku", "Perun"}

    get_combat_form()
    get_combat_weapon()
    update_melee_groups()
end
 
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.CastingMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false
    
    -- Additional local binds
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c toggle SouleaterMode')
    send_command('bind ^` gs c toggle LastResortMode')
    
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
    
     Acro.Hands.Haste = {name="Acro gauntlets", augments={'STR+4 DEX+4','Accuracy+18 Attack+18','Haste+2'}} 
     Acro.Hands.STP = {name="Acro gauntlets", augments={'Accuracy+19 Attack+19','"Store TP"+5','Weapon skill damage +3%'}}

     Acro.Feet.STP = {name="Acro Leggings", augments={'STR+7 AGI+7','Accuracy+17 Attack+17','"Store TP"+6'}} 
     Acro.Feet.WSD = {name="Acro Leggings", augments={'Accuracy+18 Attack+18','"Dbl. Atk."+3','Weapon skill damage +2%'}} 

     Niht = {}
     Niht.DarkMagic = {name="Niht Mantle", augments={'Attack+7','Dark magic skill +10','"Drain" and "Aspir" potency +25'}}
     Niht.WSD = {name="Niht Mantle", augments={'Attack+14','Dark magic skill +4', '"Drain" and "Aspir" potency +17', 'Weapon skill damage +5%'}}

     sets.Organizer = {
         main="Liberator",
         sub="Sangarius",
         ring1="Apocalypse",
         ring2="Loyalist Sabatons",
         neck="Bloodrain Strap",
         grip="Pole Grip",
         head="Acro Helm",
         hands="Acro Gauntlets",
         waist="Mes. Haubergeon",
         back=Niht.DarkMagic,
         body="Acro Surcoat",
         legs="Acro Breeches",
         feet="Acro Leggings"
     }

     -- Precast Sets
     -- Precast sets to enhance JAs
     sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +1"}
     sets.precast.JA['Nether Void'] = {legs="Heathen's Flanchard +1"}
     sets.precast.JA['Dark Seal'] = {head="Fallen's burgeonet +1"}
     sets.precast.JA['Souleater'] = {head="Ignominy burgeonet +1"}
     sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}

     sets.CapacityMantle  = { back="Mecistopins Mantle" }
     --sets.Berserker       = { neck="Berserker's Torque" }
     sets.WSDayBonus      = { head="Gavialis Helm" }
     sets.WSBack          = { back="Trepidity Mantle" }
     -- TP ears for night and day, AM3 up and down. 
     sets.BrutalLugra     = { ear1="Cessance Earring", ear2="Lugra Earring +1" }
     sets.Lugra           = { ear1="Lugra Earring +1" }
     sets.Brutal          = { ear1="Brutal Earring" }
 
     -- Waltz set (chr and vit)
     sets.precast.Waltz = {
        head="Fallen's Burgeonet +1",
        neck="Ganesha's Mala",
        body="Founder's Breastplate",
        hands="Redan Gloves",
        legs="Scuffler's Cosciales",
        feet="Amm Greaves"
     }
            
     -- Fast cast sets for spells
     sets.precast.FC = {
        ammo="Impatiens",
        head="Fallen's Burgeonet +1",
        body="Yorium Cuirass",
        ear1="Loquacious Earring",
        hands="Leyline Gloves",
        ring2="Prolix Ring",
        legs="Eschite Cuisses",
        feet="Odyssean Greaves"
     }

     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

     sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { 
         head="Cizin Helm +1",
         neck="Stoicheion Medal" 
     })
     sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
         head="Cizin Helm +1",
     })
     
     -- Midcast Sets
     sets.midcast.FastRecast = {
         ammo="Impatiens",
         head="Otomi Helm",
         neck="Incanter's Torque", -- 10
         back="Grounded Mantle +1",
         hands="Leyline gloves",
         feet="Odyssean Greaves"
     }
    sets.midcast.Trust =  {
         head="Valorous Mask",
         hands="Odyssean Gauntlets",
         body="Founder's Breastplate",
         legs="Eschite Cuisses",
         feet="Amm Greaves"
    }
     sets.midcast["Apururu (UC)"] = set_combine(sets.midcast.Trust, {
         body="Apururu Unity shirt",
     })
            
     -- Specific spells
     sets.midcast.Utsusemi = {
         ammo="Impatiens",
         head="Otomi Helm",
         neck="Incanter's Torque",
         body="Founder's Breastplate",
         hands="Leyline Gloves",
         back="Grounded Mantle +1",
         feet="Odyssean Greaves"
     }
 
     sets.midcast['Dark Magic'] = {
         ammo="Plumose Sachet", 
         head="Ignominy burgeonet +1", -- 17
         neck="Incanter's Torque", -- 10
         ear1="Gwati Earring",
         ear2="Dark Earring", -- 3
         body="Demon's Harness", --5
         hands="Fallen's Finger Gauntlets +1", -- 14
         waist="Casso Sash", -- 5
         ring1="Evanescence Ring", -- 10
         ring2="Sangoma Ring",
         back=Niht.DarkMagic, -- 10
         legs="Eschite Cuisses",  -- 20
         feet="Odyssean Greaves"
     }
    sets.midcast.Endark = set_combine(sets.midcast['Dark Magic'], {
         ammo="Impatiens",
    })
     
     sets.midcast['Dark Magic'].Acc = set_combine(sets.midcast['Dark Magic'], {
         body="Founder's Breastplate",
         hands="Leyline Gloves"
     })
     
	 sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
         head="Valorous Mask",
         body="Founder's breastplate",
         hands="Leyline Gloves",
         ring1="Globidonta Ring",
         back="Aput Mantle"
     })

     sets.midcast['Elemental Magic'] = {
         ammo="Plumose Sachet",
         head="Terminal Helm", -- mab+15 mdmg+15
         neck="Eddy Necklace", -- 11 matk
         ear1="Friomisi Earring", -- 10 matk
         ear2="Crematio Earring", -- 6 matk 6 mdmg
         body="Founder's breastplate", -- 15 matk
         hands="Leyline Gloves",
         ring1="Resonance Ring", -- int 8
         ring2="Shiva Ring", -- matk 4
         waist="Caudata Belt", -- int 6
         legs="Eschite Cuisses", -- matk 25 
         back="Aput Mantle", -- mdmg 10
         feet="Founder's Greaves" -- matk 29
     }
	 
     -- Gear that boosts HP is preferred over anything else.  
     sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
         ammo="Impatiens",
         head="Gavialis Helm",
         body="Heathen's Cuirass +1",
         hands=Acro.Hands.Haste,
         ring2="K'ayres Ring",
         back="Trepidity Mantle",
         legs="Eschite Cuisses", 
         feet="Odyssean Greaves"
     })
     
     -- Drain spells 
     sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
         ear1="Gwati Earring",
         ear2="Hirudinea Earring",
         body="Lugra Cloak +1",
         ring2="Excelsis Ring",
     })
     sets.midcast.Aspir = sets.midcast.Drain

     sets.midcast.Drain.Acc = set_combine(sets.midcast.Drain, {
        head="Ignominy Burgeonet +1",
        body="Founder's Breastplate",
        hands="Leyline Gloves"
     })
     sets.midcast.Aspir.Acc = sets.midcast.Drain.Acc

     -- Absorbs
     sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
         back="Chuparrosa Mantle",
         body="Founder's Breastplate",
         hands="Pavor Gauntlets",
     })

     sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
         hands="Heathen's Gauntlets +1"
     })

     sets.midcast.Absorb.Acc = set_combine(sets.midcast['Dark Magic'].Acc, {
         back="Chuparrosa Mantle",
     })
     sets.midcast['Absorb-TP'].Acc = set_combine(sets.midcast.Absorb.Acc, {
         hands="Heathen's Gauntlets +1"
     })
     
     -- Ranged for xbow
     sets.precast.RA = {
         head="Otomi Helm",
     }
     sets.midcast.RA = {
         ear2="Tripudio Earring",
         ring1="Beeline Ring",
         ring2="Garuda Ring",
         waist="Chaac Belt",
         legs="Aetosaur Trousers +1",
     }

     -- WEAPONSKILL SETS
     -- General sets
     sets.precast.WS = {
         ammo="Aqreqaq Bomblet",
         head="Argosy Celata",
         neck="Ganesha's Mala",
         ear1="Brutal Earring",
         ear2="Moonshade Earring",
         body="Acro Surcoat",
         hands="Odyssean Gauntlets",
         ring1="Karieyh Ring",
         ring2="Ifrit Ring +1",
         back=Niht.WSD,
         waist="Windbuffet Belt +1",
         legs="Argosy Breeches",
         feet=Acro.Feet.WSD
     }
     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
         ammo="Ginsen",
         body="Mes'yohi Haubergeon",
         legs="Odyssean Cuisses"
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
         head="Valorous Mask",
         ear1="Zennaroi Earring",
         body="Fallen's Cuirass +1",
         waist="Olseni Belt",
     })
 
     -- RESOLUTION
     -- 86-100% STR
     sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
         neck="Breeze Gorget",
         waist="Soil Belt"
     })
     sets.precast.WS.Resolution.Mid = set_combine(sets.precast.WS.Resolution, {
         ammo="Ginsen",
     })
     sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution.Mid, sets.precast.WS.Acc) 

     -- TORCLEAVER 
     -- VIT 80%
     sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
         neck="Aqua Gorget",
         hands="Odyssean Gauntlets",
         legs="Argosy Breeches",
         waist="Caudata Belt"
     })
     sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Mid, {
         ammo="Ginsen",
         neck="Aqua Gorget",
     })
     sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, sets.precast.WS.Acc)

     -- INSURGENCY
     -- 20% STR / 20% INT 
     -- Base set only used at 3000TP to put AM3 up
     sets.precast.WS.Insurgency = set_combine(sets.precast.WS, {
         head="Valorous Mask",
         neck="Shadow Gorget",
         body="Acro Surcoat",
         waist="Windbuffet Belt +1",
     })
     sets.precast.WS.Insurgency.AM3 = set_combine(sets.precast.WS.Insurgency, {
         ear1="Lugra Earring +1",
         body="Acro Surcoat",
         feet=Acro.Feet.STP
     })
     -- Mid assumes higher defense target
     sets.precast.WS.Insurgency.Mid = set_combine(sets.precast.WS.Insurgency, {
         neck="Shadow Gorget",
         body="Acro Surcoat",
         legs="Argosy Breeches",
         waist="Caudata Belt"
     })
     sets.precast.WS.Insurgency.AM3Mid = set_combine(sets.precast.WS.Insurgency.Mid, {
         body="Fallen's Cuirass +1",
         waist="Light Belt",
         feet=Acro.Feet.STP
     })
     sets.precast.WS.Insurgency.Acc = set_combine(sets.precast.WS.Insurgency.Mid, {
         head="Argosy Celata",
         body="Mes'yohi Haubergeon",
         ear1="Zennaroi Earring",
     })
     sets.precast.WS.Insurgency.AM3Acc = set_combine(sets.precast.WS.Insurgency.Acc, {
         head="Argosy Celata",
         neck="Shadow Gorget",
         waist="Light Belt",
         feet=Acro.Feet.STP
     })

     sets.precast.WS.Catastrophe = set_combine(sets.precast.WS, {
         ear2="Trux Earring",
         neck="Shadow Gorget",
         waist="Soil Belt"
     })
     sets.precast.WS.Catastrophe.Mid = set_combine(sets.precast.WS.Catastrophe, {})
     sets.precast.WS.Catastrophe.Acc = set_combine(sets.precast.WS.Catastrophe.Mid, {
         body="Mes'yohi Haubergeon",
         ear1="Zennaroi Earring",
     })
     
     -- CROSS REAPER
     -- 60% STR / 60% MND
     sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
         body="Acro Surcoat",
         neck="Aqua Gorget",
         waist="Windbuffet Belt +1"
     })
     sets.precast.WS['Cross Reaper'].AM3 = set_combine(sets.precast.WS['Cross Reaper'], {
         body="Acro Surcoat",
     })

     sets.precast.WS['Cross Reaper'].Mid = set_combine(sets.precast.WS['Cross Reaper'], {
         neck="Ganesha's Mala",
         waist="Metalsinger Belt",
         legs="Argosy Breeches",
     })
     sets.precast.WS['Cross Reaper'].AM3Mid = set_combine(sets.precast.WS['Cross Reaper'].Mid, {
         neck="Aqua Gorget",
     })
     sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'].Mid, {
         ammo="Ginsen",
         head="Valorous Mask",
         neck="Aqua Gorget",
         body="Fallen's Cuirass +1"
     })
     
     -- ENTROPY
     -- 86-100% INT 
     sets.precast.WS.Entropy = set_combine(sets.precast.WS, {
         ammo="Ginsen",
         neck="Shadow Gorget",
         head="Valorous Mask",
         body="Founder's Breastplate",
         ring2="Shiva Ring",
         back=Niht.WSD,
         waist="Soil Belt",
         legs="Heathen's Flanchard +1",
         feet=Acro.Feet.WSD
     })
     sets.precast.WS.Entropy.AM3 = set_combine(sets.precast.WS.Entropy, {
         legs="Acro Breeches",
         back=Niht.WSD,
     })
     sets.precast.WS.Entropy.Mid = set_combine(sets.precast.WS.Entropy, { 
         legs="Acro Breeches",
         back=Niht.WSD,
     })
     sets.precast.WS.Entropy.AM3Mid = set_combine(sets.precast.WS.Entropy.Mid, {})
     sets.precast.WS.Entropy.Acc = set_combine(sets.precast.WS.Entropy.Mid, {})

     -- Quietus
     -- 60% STR / MND 
     sets.precast.WS.Quietus = set_combine(sets.precast.WS, {
         neck="Shadow Gorget",
         ear2="Lugra Earring +1",
         waist="Windbuffet Belt +1",
         legs="Argosy Breeches",
     })
     sets.precast.WS.Quietus.AM3 = set_combine(sets.precast.WS.Quietus, {})
     sets.precast.WS.Quietus.Mid = set_combine(sets.precast.WS.Quietus, {
         waist="Caudata Belt",
     })
     sets.precast.WS.Quietus.AM3Mid = set_combine(sets.precast.WS.Quietus.Mid, {
         ear1="Lugra Earring +1",
         ear2="Brutal Earring",
     })
     sets.precast.WS.Quietus.Acc = set_combine(sets.precast.WS.Quietus.Mid, sets.precast.WS.Acc)

     -- SPIRAL HELL
     -- 50% STR / 50% INT 
     sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS['Entropy'], {
         neck="Aqua Gorget",
         body="Phorcys Korazin",
         legs="Argosy Breeches",
         waist="Metalsinger belt",
     })
     sets.precast.WS['Spiral Hell'].Mid = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Mid, {
     })
     sets.precast.WS['Spiral Hell'].Acc = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Acc, {
     })

     -- SHADOW OF DEATH
     -- 40% STR 40% INT - Darkness Elemental
     sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
         head="Terminal Helm",
         neck="Eddy Necklace",
         body="Founder's Breastplate",
         ear1="Friomisi Earring",
         hands="Leyline Gloves",
         back="Toro Cape",
         legs="Eschite Cuisses",
         waist="Caudata Belt",
         feet="Heathen's Sollerets +1"
      })

     sets.precast.WS['Shadow of Death'].Mid = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Mid, {
     })
     sets.precast.WS['Shadow of Death'].Acc = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Acc, {
     })

     -- DARK HARVEST 
     -- 40% STR 40% INT - Darkness Elemental
     sets.precast.WS['Dark Harvest'] = sets.precast.WS['Shadow of Death']
     sets.precast.WS['Dark Harvest'].Mid = set_combine(sets.precast.WS['Shadow of Death'], {head="Terminal Helm", feet="Heathen's Sollerets +1"})
     sets.precast.WS['Dark Harvest'].Acc = set_combine(sets.precast.WS['Shadow of Death'], {head="Terminal Helm", feet="Heathen's Sollerets +1", ring1="Sangoma Ring"})

     -- Sword WS's
     -- SANGUINE BLADE
     -- 50% MND / 50% STR Darkness Elemental
     sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
         head="Terminal Helm",
         neck="Eddy Necklace",
         ear1="Friomisi Earring",
         body="Founder's Breastplate",
         hands="Founder's Gauntlets",
         legs="Eschite Cuisses",
         back="Toro Cape",
         feet="Heathen's Sollerets +1"
     })
     sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
     sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

     -- REQUISCAT
     -- 73% MND - breath damage
     sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
         head="Acro Helm",
         neck="Shadow Gorget",
         body="Acro Surcoat",
         hands="Odyssean Gauntlets",
         legs="Scuffler's Cosciales",
         waist="Soil Belt",
     })
     sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
     sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc)
     
     -- Idle sets
     sets.idle.Town = {
         ammo="Ginsen",
         head="Valorous Mask",
         neck="Ganesha's Mala",
         ear1="Cessance Earring",
         ear2="Tripudio Earring",
         body="Councilor's Garb",
         hands="Odyssean Gauntlets",
         ring1="Karieyh Ring",
         ring2="Defending Ring",
         back=Niht.WSD,
         waist="Windbuffet Belt +1",
         legs="Crimson Cuisses",
         feet="Amm Greaves"
     }
     
     sets.idle.Field = set_combine(sets.idle.Town, {
         ammo="Ginsen",
         head="Valorous Mask",
         ear1="Zennaroi Earring",
         neck="Sanctity Necklace",
         body="Jumalik Mail",
         hands="Redan Gloves",
         ring1="Karieyh Ring",
         ring2="Defending Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
         legs="Crimson Cuisses",
         feet="Amm Greaves"
     })
     sets.idle.Regen = set_combine(sets.idle.Field, {
         neck="Sanctity Necklace",
         body="Lugra Cloak +1",
         ring2="Paguroidea Ring",
         head="",
     })
     sets.idle.Refresh = set_combine(sets.idle.Regen, {
         neck="Coatl Gorget +1"
     })
 
     sets.idle.Weak = set_combine(sets.defense.PDT, {
         ammo="Hasty Pinion +1",
         head="Valorous Mask",
         neck="Agitator's Collar",
         hands="Redan Gloves",
         ear1="Zennaroi Earring",
         ring1="Patricius Ring",
         ring2="Defending Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
         legs="Valorous Hose",
         feet="Amm Greaves"

     })

     
     -- Defense sets
     sets.defense.PDT = {
         ammo="Hasty Pinion +1",
         head="Yorium Barbuta",
         neck="Agitator's Collar",
         body="Jumalik Mail",
         hands="Redan Gloves",
         ear1="Zennaroi Earring",
         ring1="Patricius Ring",
         ring2="Defending Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
         legs="Valorous Hose",
         feet="Amm Greaves"
     }
     sets.defense.Reraise = sets.idle.Weak
 
     sets.defense.MDT = set_combine(sets.defense.PDT, {
         neck="Twilight Torque",
         body="Lugra Cloak +1",
         ear1="Zennaroi Earring",
         ring1="Dark Ring",
         back="Impassive Mantle",
     })
 
     sets.Kiting = {legs="Crimson Cuisses"}
 
     sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- sets.HighHaste = {
    --     ammo="Ginsen",
    --     head="Argosy Celata",
    --     --hands=Acro.Hands.STP,
    --     feet=Acro.Feet.STP
    -- }
     
     -- Defensive sets to combine with various weapon-specific sets below
     -- These allow hybrid acc/pdt sets for difficult content
     sets.Defensive = {
         ammo="Hasty Pinion +1",
         head="Yorium Barbuta", -- 7% haste
         neck="Agitator's Collar", -- 3%
         body="Jumalik Mail",
         hands="Redan Gloves",
         ring1="Patricius Ring",
         ring2="Defending Ring",
         back="Impassive Mantle",
         waist="Flume Belt",
         legs="Valorous Hose",
         feet="Amm Greaves"
     }
     sets.Defensive_Mid = {
         ammo="Hasty Pinion +1",
         head="Yorium Barbuta",
         neck="Agitator's Collar",
         body="Founder's Breastplate",
         hands="Redan Gloves",
         back="Impassive Mantle",
         ring1="Patricius Ring",
         ring2="Defending Ring",
         legs="Valorous Hose",
         feet="Loyalist Sabatons"
     }
     sets.Defensive_Acc = {
         ammo="Hasty Pinion +1",
         head="Yorium Barbuta",
         neck="Agitator's Collar",
         hands="Redan Gloves",
         body="Founder's Breastplate",
         back="Grounded Mantle +1",
         ring1="Supershear Ring",
         ring2="Patricius Ring",
         legs="Valorous Hose",
         feet="Founder's Greaves" -- matk 29
     }
 
     -- Engaged set, assumes Liberator
     sets.engaged = {
         --sub="Bloodrain Strap",
         ammo="Ginsen",
         head="Valorous Mask",
         neck="Ganesha's Mala",
         ear1="Cessance Earring",
         ear2="Brutal Earring",
         body="Vatic Byrnie",
         hands=Acro.Hands.Haste,
         ring1="Rajas Ring",
         ring2="K'ayres Ring",
         back="Bleating Mantle",
         waist="Windbuffet Belt +1",
         legs="Acro Breeches",
         feet=Acro.Feet.STP
     }
     sets.engaged.Mid = set_combine(sets.engaged, {
         head="Valorous Mask",
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
         hands=Acro.Hands.Haste,
         body="Mes'yohi Haubergeon",
         back="Grounded Mantle +1",
         legs="Odyssean Cuisses",
     })
     sets.engaged.Acc = set_combine(sets.engaged.Mid, {
         ammo="Hasty Pinion +1",
         head="Argosy Celata",
         neck="Lissome Necklace",
         ear1="Cessance Earring",
         ear2="Zennaroi Earring",
         hands="Odyssean Gauntlets",
         ring2="Mars's Ring",
         waist="Olseni Belt",
         feet="Founder's Greaves"
     })
     -- Liberator AM3
     sets.engaged.AM3 = set_combine(sets.engaged, {
         ammo="Ginsen",
         head="Valorous Mask",
         body="Acro Surcoat",
         hands=Acro.Hands.Haste,
         ear1="Cessance Earring",
         ear2="Tripudio Earring",
         legs="Acro Breeches",
         feet=Acro.Feet.STP
     })
     sets.engaged.Mid.AM3 = set_combine(sets.engaged.AM3, {
         body="Mes'yohi Haubergeon",
         back="Grounded Mantle +1",
         legs="Odyssean Cuisses",
     })
     sets.engaged.Acc.AM3 = set_combine(sets.engaged.Mid.AM3, {
         ammo="Hasty Pinion +1",
         head="Argosy Celata",
         neck="Lissome Necklace",
         ear1="Cessance Earring",
         ear2="Zennaroi Earring",
         body="Mes'yohi Haubergeon",
         hands="Odyssean Gauntlets",
         ring1="Rajas Ring",
         ring2="Mars's Ring",
         waist="Olseni Belt",
         feet="Founder's Greaves"
     })
     
     -- Apocalypse
     sets.engaged.Apocalypse = set_combine(sets.engaged, {
         --sub="Pole Grip",
         ammo="Yetshila",
         hands=Acro.Hands.Haste,
         --body="Acro Surcoat",
         ear1="Cessance Earring",
         ear2="Brutal Earring"
     })
     sets.engaged.Apocalypse.Mid = set_combine(sets.engaged.Mid, {
         feet=Acro.Feet.WSD
     })
     sets.engaged.Apocalypse.Acc = set_combine(sets.engaged.Acc, {
         feet=Acro.Feet.WSD
     })

     sets.engaged.Apocalypse.AM = set_combine(sets.engaged.Apocalypse, {
         head="Argosy Celata",
         feet=Acro.Feet.WSD
     })
     sets.engaged.Apocalypse.Mid.AM = set_combine(sets.engaged.Apocalypse.AM, {
         ammo="Ginsen",
         hands=Acro.Hands.STP,
         feet="Loyalist Sabatons"
     })
     sets.engaged.Apocalypse.Acc.AM = set_combine(sets.engaged.Apocalypse.Mid.AM, {
         head="Valorous Mask",
         ammo="Hasty Pinion +1",
         ear1="Cessance Earring",
         ear2="Zennaroi Earring",
         neck="Defiant Collar",
         ring2="Mars's Ring",
         waist="Olseni Belt"
     })

     sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
     sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
     sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)
     
     sets.engaged.PDT.AM3 = set_combine(sets.engaged.AM3, sets.Defensive)
     sets.engaged.Mid.PDT.AM3 = set_combine(sets.engaged.Mid.AM3, sets.Defensive_Mid)
     sets.engaged.Acc.PDT.AM3 = set_combine(sets.engaged.Acc.AM3, sets.Defensive_Acc)

     sets.engaged.Apocalypse.PDT = set_combine(sets.engaged.Apocalypse, sets.Defensive)
     sets.engaged.Apocalypse.Mid.PDT = set_combine(sets.engaged.Apocalypse.Mid, sets.Defensive_Mid)
     sets.engaged.Apocalypse.Acc.PDT = set_combine(sets.engaged.Apocalypse.Acc, sets.Defensive_Acc)
    
     -- dual wield
     sets.engaged.DW = set_combine(sets.engaged, {
        ammo="Yetshila",
        head="Valorous Mask",
        body="Vatic Byrnie",
        hands=Acro.Hands.STP,
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        legs="Argosy Breeches",
        waist="Shetal Stone",
        feet=Acro.Feet.WSD
     })
     sets.engaged.DW.Mid = set_combine(sets.engaged.DW, {
         ammo="Ginsen",
         body="Acro Surcoat",
         back="Grounded Mantle +1",
         hands=Acro.Hands.Haste
     })
     sets.engaged.DW.Acc = set_combine(sets.engaged.DW.Mid, {
         ammo="Hasty Pinion +1",
         hands="Odyssean Gauntlets",
         back="Grounded Mantle +1",
     })

     -- great sword
     sets.engaged.GreatSword = set_combine(sets.engaged, {
         head="Otomi Helm",
         ear1="Brutal Earring",
         ear2="Tripudio Earring"
     })
     sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid, {
         head="Valorous Mask",
         feet="Loyalist Sabatons"
         --back="Grounded Mantle +1"
         --ring2="K'ayres RIng"
     })
     sets.engaged.GreatSword.Acc = set_combine(sets.engaged.Acc, {
         hands="Heathen's Gauntlets +1"
     })

     sets.engaged.GreatSword.PDT = set_combine(sets.engaged.GreatSword, sets.Defensive)
     sets.engaged.GreatSword.Mid.PDT = set_combine(sets.engaged.GreatSword.Mid, sets.Defensive_Mid)
     sets.engaged.GreatSword.Acc.PDT = set_combine(sets.engaged.GreatSword.Acc, sets.Defensive_Acc)
     
     -- sword is more multi-hit, less stp
     sets.engaged.Sangarius = set_combine(sets.engaged, {
         ammo="Yetshila",
         head="Valorous Mask",
         legs="Argosy Breeches",
         hands=Acro.Hands.Haste,
         feet=Acro.Feet.WSD
     })
     sets.engaged.Sangarius.Mid = set_combine(sets.engaged.Mid, {
         ammo="Ginsen",
         hands="Odyssean Gauntlets",
         feet=Acro.Feet.WSD
     })
     sets.engaged.Sangarius.Acc = set_combine(sets.engaged.Acc, {
         ammo="Hasty Pinion +1"
     })

     sets.engaged.Reraise = set_combine(sets.engaged, {
     	head="Twilight Helm",neck="Twilight Torque",
     	body="Twilight Mail"
     })
    
     sets.buff.Souleater = { 
         head="Ignominy Burgeonet +1",
         body="Acro Surcoat"
     }

     sets.buff['Last Resort'] = { 
         feet="Fallen's Sollerets +1" 
     }
end

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type:endswith('Magic') and buffactive.silence then
        eventArgs.cancel = true
        send_command('input /item "Echo Drops" <me>')
    end
end
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    aw_custom_aftermath_timers_precast(spell)
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
            --enable("head")
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
    if player.mpp < 70 then
        idleSet = set_combine(idleSet, sets.idle.Refresh)
    end
    if player.hpp < 70 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
    if state.HybridMode.current == 'PDT' then
        idleSet = set_combine(idleSet, sets.defense.PDT)
    end
    return idleSet
end
 
-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.Buff['Last Resort'] and state.LastResortMode.value then
    	meleeSet = set_combine(meleeSet, sets.buff['Last Resort'])
    end
    return meleeSet
end
 
-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        if state.Buff['Last Resort'] and state.LastResortMode.value then
            equip(sets.buff['Last Resort'])
        end
        -- handle weapon sets
        if gsList:contains(player.equipment.main) then
            state.CombatWeapon:set("GreatSword")
        elseif player.equipment.main == 'Apocalypse' then
            state.CombatWeapon:set('Apocalypse')
        else -- use regular set, which caters to Liberator
            state.CombatWeapon:reset()
        end
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
    
    if S{'haste', 'march', 'embrava', 'geo-haste', 'indi-haste'}:contains(buff:lower()) and gain then
        if (buffactive['Last Resort'] or (buffactive.hasso and (state.ApocHaste.value and buffactive['Aftermath']))) then
            if (buffactive.embrava or buffactive.haste) and buffactive.march then
                state.CombatForm:set("Haste")
                if not midaction() then
                    handle_equipping_gear(player.status)
                end
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
    -- Drain II HP Boost. Set SE to stay on.
    if buff == "Max HP Boost" and state.SouleaterMode.value then
        if gain or buffactive['Max HP Boost'] then
            state.SouleaterMode:set(false)
        else
            state.SouleaterMode:set(true)
        end
    end
    -- Make sure SE stays on for BW
    if buff == 'Blood Weapon' and state.SouleaterMode.value then
        if gain or buffactive['Blood Weapon'] then
            state.SouleaterMode:set(false)
        else
            state.SouleaterMode:set(true)
        end
    end
    -- AM custom groups
    if buff:startswith('Aftermath') then
        if player.equipment.main == 'Liberator' then
            classes.CustomMeleeGroups:clear()
	        
            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
                add_to_chat(8, '-------------AM3 UP-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        else
            classes.CustomMeleeGroups:clear()

            if buff == "Aftermath" and gain or buffactive.Aftermath then
                classes.CustomMeleeGroups:append('AM')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end

    if buff == "Last Resort" and state.LastResortMode.value then
        if gain then
            equip(sets.buff["Last Resort"])
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
    update_melee_groups()

end

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if state.OffenseMode.current == 'Mid' then
        if buffactive['Aftermath: Lv.3'] then
            return 'AM3Mid'
        end
    elseif state.OffenseMode.current == 'Acc' then
        if buffactive['Aftermath: Lv.3'] then
            return 'AM3Acc'
        end
    else
        if buffactive['Aftermath: Lv.3'] then
            return 'AM3'
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    
    if S{'NIN', 'DNC'}:contains(player.sub_job) and drk_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
    elseif (buffactive['Last Resort'] or (buffactive.hasso and (state.ApocHaste.value and buffactive['Aftermath']))) then
        if (buffactive.embrava or buffactive.haste) and buffactive.march then
            add_to_chat(8, '-------------Delay Capped-------------')
            state.CombatForm:set("Haste")
        else
            state.CombatForm:reset()
        end
    else
        state.CombatForm:reset()
    end
end

function get_combat_weapon()
    if gsList:contains(player.equipment.main) then
        state.CombatWeapon:set("GreatSword")
    elseif player.equipment.main == 'Apocalypse' then
        state.CombatWeapon:set('Apocalypse')
    else -- use regular set, which caters to Liberator
        state.CombatWeapon:reset()
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

function display_current_job_state(eventArgs)
    local msg = ''
    msg = msg .. 'Offense: '..state.OffenseMode.current
    msg = msg .. ', Hybrid: '..state.HybridMode.current

    if state.DefenseMode.value ~= 'None' then
        local defMode = state[state.DefenseMode.value ..'DefenseMode'].current
        msg = msg .. ', Defense: '..state.DefenseMode.value..' '..defMode
    end
    if state.CombatForm.current == 'Haste' then
        msg = msg .. ', High Haste, '
    end
    if state.CapacityMode.value then
        msg = msg .. ', Capacity, '
    end
    if state.SouleaterMode.value then
        msg = msg .. ', SE Cancel, '
    end
    if state.LastResortMode.value then
        msg = msg .. ', LR Defense, '
    end
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
    if state.SelectNPCTargets.value then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(123, msg)
    eventArgs.handled = true
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-- Creating a custom spellMap, since Mote capitalized absorbs incorrectly
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Dark Magic' and absorbs:contains(spell.english) then
        return 'Absorb'
    end
    if spell.type == 'Trust' then
        return 'Trust'
    end
end

function update_melee_groups()

	classes.CustomMeleeGroups:clear()
    -- mythic AM	
    if player.equipment.main == 'Liberator' then
        if buffactive['Aftermath: Lv.3'] then
	    	classes.CustomMeleeGroups:append('AM3')
	    end
    else
        -- relic AM
        if buffactive['Aftermath'] then
	    	classes.CustomMeleeGroups:append('AM')
        end
    end
end

function select_default_macro_book()
    -- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(6, 2)
	elseif player.sub_job == 'SAM' then
		set_macro_page(7, 4)
	else
		set_macro_page(8, 4)
	end
end
