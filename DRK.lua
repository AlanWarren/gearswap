--[[     
=== Features ===
If you want auto Reive detection for Ygnas Resolve+1, and Gavialis Helm for some of your WS, then you will need my User-Globals.lua
Otherwise, you might be able to get away without it.  (not tested)

If you don't use organizer, then remove the include('organizer-lib') in get_sets() and remove sets.Organizer

This lua has a few MODES you can toggle with hotkeys or macros, and there's a few situational RULES that activate without hotkeys

::MODES::

SouleaterMode 
Status: OFF by default. 
Hotkey: Toggle this with @F9 (window key + F9). 
Macro: /console gs c togggle SouleaterMode

Notes: This mode makes it possible to use Souleater in situations where you would normally avoid using it. When SouleaterMode 
is ON, Souleater will be canceled automatically after the first Weaponskill used. CAVEAT -. If Bloodweapon 
is active, or if Drain's HP Boost buff is active, then Souleater will remain active until the next WS used after 
either buff wears off. 

CapacityMode
Status: OFF by default. 
Hotkey: with ALT + = 
Macro: /console cs c toggle CapacityMode

Notes: It will full-time whichever piece of gear you specify in sets.CapacityMantle 

Extra Info: You can change the default (true|false) status of any MODE by changing their values in job_setup()

::RULES::

Gavialis helm
Status: enabled
Setting: set use_gavialis = true below in job_setup. 

Notes: Gavialis Helm will automatically be used for all weaponskills on their respective days of the week. If you would like to 
exclude a weapon skill, you must add it to wsList below. (found in job_setup) You also need my User-Globals.lua for this
to even work. 

Ygna's Resolve +1 
Status: enabled in Reive
Setting: n/a

Notes: Will automatically be used when you're in a reive. If you have my User-Globals.lua this will work
with all your jobs that use mote's includes. Not just this one! 

Moonshade earring
Status: Not used for WS's at 3000 TP. 
Setting: n/a

You can hit F12 to display custom MODE status as well as the default stuff. 

Single handed weapons are handled in the sets.engaged.SW set. (sword + shield, etc.)

::NOTES::

My sets have a specific order, or they will not function correctly. 
sets.engaged.[CombatForm][CombatWeapon][Offense or HybridMode][CustomMeleeGroups or CustomClass]

CombatForm = Haste, DW, SW
CombatWeapon = GreatSword, Scythe, Apocalypse, Ragnarok, Caladbolg, Liberator, Anguta
OffenseMode = Mid, Acc
HybridMode = PDT
CustomMeleeGroups = AM3, AM, Haste
CustomClass = OhShit 

CombatForm Haste is used when Last Resort + Hasso AND either Haste, March, Indi-Haste Geo-Haste is on you.

CombatForm DW will activate with /dnc or /nin AND a weapon listed in drk_sub_weapons equipped offhand. 
SW is active with an empty sub-slot, or a shield listed in the shields = S{} list.  

CombatWeapon GreatSword will activate when you equip a GS listed in gsList in job_setup(). 
CombatWeapon Scythe will activate when you equip a Scythe listed in scytheList in job_setup(). 
Weapons that do not fall into these groups, or have sets by weapon name, will use default sets.engaged

most gear sets derrive themselves from sets.engaged, so try to keep it updated. It's much smarter to derrive sets than to 
completely re-invent each gear set for every weapon. Let your gear inherit. Less code written means less errors. 

CustomMeleeGroups AM3 will activate when Aftermath lvl 3 is up, and CustomMeleeGroups AM will activate when relic Aftermath is up.
There are no empy AM sets for now.

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

    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')

    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false
    -- Set the default to false if you'd rather SE always stay acitve
    state.SouleaterMode = M(false, 'Soul Eater Mode')
    -- state.LastResortMode = M(false, 'Last Resort Mode')
    -- Use Gavialis helm?
    use_gavialis = true
    -- Weaponskills you do NOT want Gavialis helm used with (only considered if use_gavialis = true)
    wsList = S{'Spiral Hell', 'Torcleaver', 'Insurgency', 'Quietus', 'Cross Reaper'}
    -- Greatswords you use. 
    gsList = S{'Malfeasance', 'Macbain', 'Kaquljaan', 'Mekosuchus Blade', 'Ragnarok', 'Raetic Algol', 'Raetic Algol +1', 'Caladbolg', 'Montante +1', 'Albion' }
    scytheList = S{'Raetic Scythe', 'Deathbane', 'Twilight Scythe' }
    shields = S{'Rinda Shield'}
    -- Mote has capitalization errors in the default Absorb mappings, so we use our own
    absorbs = S{'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT', 'Absorb-MND', 'Absorb-CHR', 'Absorb-Attri', 'Absorb-ACC', 'Absorb-TP'}
    -- Offhand weapons used to activate DW mode
    swordList = S{"Sangarius", "Sangarius +1", "Usonmunku", "Perun +1", "Tanmogayi"}

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
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind != gs c toggle CapacityMode')
    send_command('bind @f9 gs c toggle SouleaterMode')
    send_command('bind !- gs equip sets.crafting')
    --send_command('bind ^` gs c toggle LastResortMode')

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
    Niht = {}
    Niht.DarkMagic = {name="Niht Mantle", augments={'Attack+7','Dark magic skill +10','"Drain" and "Aspir" potency +25'}}
    Niht.WSD = {name="Niht Mantle", augments={'Attack+14','Dark magic skill +4', '"Drain" and "Aspir" potency +17', 'Weapon skill damage +5%'}}

    Ankou = {}
    Ankou.FC  = { name="Ankou's Mantle", augments={'"Fast Cast"+10',}}
    Ankou.STP = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}}
    Ankou.WSD = { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    Ankou.VIT = { name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}

    sets.TreasureHunter = { waist="Chaac Belt" }

    Odyssean = {}
    Odyssean.Legs = {}
    Odyssean.Legs.TP = { name="Odyssean Cuisses", augments={'"Triple Atk."+2','"Mag.Atk.Bns."+5','Quadruple Attack +1','Accuracy+17 Attack+17',}}
    Odyssean.Legs.WS = { name="Odyssean Cuisses", augments={'Accuracy+25','DEX+1','Weapon skill damage +7%','Accuracy+10 Attack+10',}}
    Odyssean.Feet = {}
    Odyssean.Feet.FC = { name="Odyssean Greaves", augments={'Attack+20','"Fast Cast"+4','Accuracy+15',}}
    Odyssean.Feet.TP = { name="Odyssean Greaves", augments={'Accuracy+16 Attack+16','"Store TP"+4','DEX+1','Accuracy+13','Attack+15',}}

 
    sets.Organizer = {
        main="Liberator",
        sub="Sangarius",
        ammo="Caladbolg",
        ring1="Apocalypse",
        ring2="Loyalist Sabatons",
        ear2="Reraise Earring",
        neck="Bloodrain Strap",
        grip="Pole Grip",
        waist="Mes. Haubergeon",
        back=Niht.DarkMagic,
    }

    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +1"}
    sets.precast.JA['Nether Void']  = {legs="Heathen's Flanchard +1"}
    sets.precast.JA['Dark Seal']    = {head="Fallen's burgeonet +1"}
    sets.precast.JA['Souleater']    = {head="Ignominy burgeonet +1"}
    sets.precast.JA['Weapn Bash']   = {hands="Ignominy Gauntlets +1"}
    sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +3"}
    sets.precast.JA['Last Resort']  = {back=Ankou.WSD}

    sets.CapacityMantle  = { back="Mecistopins Mantle" }
    sets.WSDayBonus      = { head="Gavialis Helm" }
    sets.WSBack          = { back="Trepidity Mantle" }
    
    -- Earring considerations, given Lugra's day/night stats 
    sets.BrutalLugra     = { ear1="Brutal Earring", ear2="Lugra Earring +1" }
    sets.IshvaraLugra     = { ear1="Ishvara Earring", ear2="Lugra Earring +1" }
    sets.Lugra           = { ear1="Lugra Earring +1" }
    sets.Brutal          = { ear1="Brutal Earring" }
    sets.Ishvara          = { ear1="Ishvara Earring" }

    -- Waltz set (chr and vit) 
    -- sets.precast.Waltz = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Impatiens",
        head="Fallen's Burgeonet +1",
        body="Fallen's Cuirass +3",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        hands="Leyline Gloves",
        ring1="Prolix Ring",
        ring2="Kishar Ring",
        legs="Eschite Cuisses",
        back=Ankou.FC,
        feet=Odyssean.Feet.FC
    }

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { 
        head="Cizin Helm +1",
        neck="Stoicheion Medal" 
    })
    sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
        head="Cizin Helm +1",
    })
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        -- body="Jumalik Mail",
    })

    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Impatiens",
        head="Fallen's Burgeonet +1",
        back="Grounded Mantle +1",
        waist="Sailfi Belt +1",
        legs="Carmine Cuisses +1",
        feet=Odyssean.Feet.FC
    }
    sets.midcast.Trust =  {
        head="Fallen's Burgeonet +1",
        hands="Odyssean Gauntlets",
        body="Fallen's Cuirass +3",
        legs="Carmine Cuisses +1",
        feet=Odyssean.Feet.FC
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
        feet=Odyssean.Feet.FC
    }

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum", 
        -- head="Flamma Zucchetto +2", -- 44 macc
        head="Ignominy Burgeonet +1", -- 17
        neck="Erra Pendant", -- 10 dark + 17 macc
        ear1="Gwati Earring",
        ear2="Dark Earring", -- 3
        body="Fallen's Cuirass +3",
        hands="Flamma Manopolas +2",
        waist="Casso Sash", -- 5
        ring1="Evanescence Ring", -- 10
        ring2="Sangoma Ring", -- 8 macc
        back=Niht.DarkMagic, -- 10
        legs="Fallen's Flanchard +3",  -- 18 + 39macc
        feet="Ratri Sollerets" -- macc 33
    }
    sets.midcast.Endark = set_combine(sets.midcast['Dark Magic'], {
        head="Ignominy Burgeonet +1",
        hands="Fallen's Finger Gauntlets +1"
    })

    sets.midcast['Dark Magic'].Acc = set_combine(sets.midcast['Dark Magic'], {
        head="Flamma Zucchetto +2", -- 44 macc
        hands="Leyline Gloves",
        waist="Eschan Stone"
    })

    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
        head="Valorous Mask",
        neck="Erra Pendant", -- 10 + 17 macc
        hands="Leyline Gloves",
        ring2="Kishar Ring",
        back="Aput Mantle"
    })

    sets.midcast['Elemental Magic'] = {
        ammo="Pemphredo Tathlum", 
        head="Flamma Zucchetto +2", -- mab+15 mdmg+15
        neck="Eddy Necklace", -- 11 matk
        ear1="Friomisi Earring", -- 10 matk
        ear2="Crematio Earring", -- 6 matk 6 mdmg
        body="Fallen's Cuirass +3",
        hands="Carmine Finger Gauntlets +1",
        ring1="Resonance Ring", -- int 8
        ring2="Shiva Ring", -- matk 4
        waist="Eschan Stone", -- macc/matk 7
        legs="Eschite Cuisses", -- matk 25 
        back="Aput Mantle", -- mdmg 10
        feet="Founder's Greaves" -- matk 29
    }

    -- Mix of HP boost, -Spell interruption%, and Dark Skill
    sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
        ammo="Impatiens",
        head="Ignominy Burgeonet +1", -- 17
        ear1="Etiolation Earring",
        ear2="Eabani Earring", -- 3
        body="Heathen's Cuirass +1",
        hands="Fallen's Finger Gauntlets +1",
        back="Trepidity Mantle",
    })
    sets.midcast['Dread Spikes'].Acc = set_combine(sets.midcast['Dark Magic'], {
        body="Heathen's Cuirass +1",
        hands="Fallen's Finger Gauntlets +1"
    })

    -- Drain spells 
    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Fallen's Burgeonet +1",
        ear1="Gwati Earring",
        ear2="Hirudinea Earring",
        ring2="Excelsis Ring",
        feet="Ratri Sollerets"
    })
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Drain.Acc = set_combine(sets.midcast.Drain, {
        hands="Leyline Gloves",
        waist="Eschan Stone", -- macc/matk 7
    })
    sets.midcast.Aspir.Acc = sets.midcast.Drain.Acc

    sets.midcast.Drain.OhShit = set_combine(sets.midcast.Drain, {
        legs="Carmine Cuisses +1",
        feet="Ratri Sollerets"
    })

    -- Absorbs
    sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
        head="Flamma Zucchetto +2", -- 44 macc
        back="Chuparrosa Mantle",
        hands="Pavor Gauntlets",
        ring2="Kishar Ring",
    })

    sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
        hands="Heathen's Gauntlets +1",
        ring2="Kishar Ring",
    })

    sets.midcast['Absorb-TP'].Acc = set_combine(sets.midcast.Absorb.Acc, {
        hands="Heathen's Gauntlets +1",
        ring2="Kishar Ring",
    })
    sets.midcast.Absorb.Acc = set_combine(sets.midcast['Dark Magic'].Acc, {
        back="Chuparrosa Mantle",
        hands="Pavor Gauntlets",
        ring2="Kishar Ring",
    })

    -- Ranged for xbow
    sets.precast.RA = {
        head="Otomi Helm",
        feet="Ejekamal Boots",
        hands="Carmine Finger Gauntlets +1"
    }
    sets.midcast.RA = {
        ear2="Tripudio Earring",
        ring1="Cacoethic Ring +1",
        waist="Chaac Belt",
    }

    -- WEAPONSKILL SETS
    -- General sets
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
        neck="Ganesha's Mala",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body="Ignominy Cuirass +3",
        hands="Odyssean Gauntlets",
        ring1="Niqmaddu Ring",
        ring2="Karieyh Ring",
        back=Ankou.WSD,
        waist="Windbuffet Belt +1",
        legs="Fallen's Flanchard +3",
        feet="Sulevia's Leggings +2"
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        legs="Fallen's Flanchard +3",
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        body="Fallen's Cuirass +3",
        waist="Olseni Belt",
    })

    -- RESOLUTION
    -- 86-100% STR
    sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
        ear1="Brutal Earring",
        neck="Breeze Gorget",
        --body="Valorous Mail",
        hands="Sulevia's Gauntlets +2",
        waist="Soil Belt",
        legs="Fallen's Flanchard +3",
        feet="Sulevia's Leggings +2"
    })
    sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution.Mid, {
        ammo="Seething Bomblet +1",
        legs="Fallen's Flanchard +3",
        feet="Sulevia's Leggings +2"
    }) 

    -- TORCLEAVER 
    -- VIT 80%
    sets.precast.WS.Torcleaver = set_combine(sets.precast.WS, {
        head="Odyssean Helm",
        body="Ignominy Cuirass +3",
        neck="Aqua Gorget",
        waist="Light Belt",
        back=Ankou.VIT,
        legs="Fallen's Flanchard +3",
    })
    sets.precast.WS.Torcleaver.Mid = set_combine(sets.precast.WS.Mid, {
        neck="Aqua Gorget",
    })
    sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver.Mid, {
        neck="Aqua Gorget",
        body="Fallen's Cuirass +3",
        legs=Odyssean.Legs.WS
    })

    -- INSURGENCY
    -- 20% STR / 20% INT 
    -- Base set only used at 3000TP to put AM3 up
    sets.precast.WS.Insurgency = set_combine(sets.precast.WS, {
        head="Flamma Zucchetto +2",
        neck="Shadow Gorget",
        body="Ignominy Cuirass +3",
        legs="Fallen's Flanchard +3",
        ring2="Flamma Ring",
        waist="Light Belt",
    })
    sets.precast.WS.Insurgency.Mid = set_combine(sets.precast.WS.Insurgency, {})
    sets.precast.WS.Insurgency.Acc = set_combine(sets.precast.WS.Insurgency.Mid, {
        ammo="Seething Bomblet +1",
        body="Fallen's Cuirass +3",
        legs=Odyssean.Legs.WS
    })

    sets.precast.WS.Catastrophe = set_combine(sets.precast.WS, {
        head="Odyssean Helm",
        neck="Shadow Gorget",
        body="Ignominy Cuirass +3",
        legs="Fallen's Flanchard +3",  
        waist="Soil Belt",
    })
    sets.precast.WS.Catastrophe.Mid = set_combine(sets.precast.WS.Catastrophe, {})
    sets.precast.WS.Catastrophe.Acc = set_combine(sets.precast.WS.Catastrophe.Mid, {
        body="Fallen's Cuirass +3",
        waist="Olseni Belt",
    })

    -- CROSS REAPER
    -- 60% STR / 60% MND
    sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
        body="Ignominy Cuirass +3",
        waist="Metalsinger Belt",
        legs="Fallen's Flanchard +3",
    })
    sets.precast.WS['Cross Reaper'].Mid = set_combine(sets.precast.WS['Cross Reaper'], {})
    sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'].Mid, {
        ammo="Seething Bomblet +1",
        body="Fallen's Cuirass +3",
        legs=Odyssean.Legs.WS
    })
    -- ENTROPY
    -- 86-100% INT 
    sets.precast.WS.Entropy = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        body="Ignominy Cuirass +3",
        waist="Soil Belt",
        ring1="Niqmaddu Ring",
        ring2="Karieyh Ring",
        legs="Fallen's Flanchard +3",  
        feet="Sulevia's Leggings +1"
    })
    sets.precast.WS.Entropy.Mid = set_combine(sets.precast.WS.Entropy, {
    })
    sets.precast.WS.Entropy.Acc = set_combine(sets.precast.WS.Entropy.Mid, {
        body="Fallen's Cuirass +3",
        ammo="Seething Bomblet +1",
    })

    -- Quietus
    -- 60% STR / MND 
    sets.precast.WS.Quietus = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        body="Ignominy Cuirass +3",
        hands="Odyssean Gauntlets",
        waist="Caudata Belt",
        legs="Fallen's Flanchard +3",  
        feet="Sulevia's Leggings +1",
    })
    sets.precast.WS.Quietus.Mid = set_combine(sets.precast.WS.Quietus, {
    })
    sets.precast.WS.Quietus.Acc = set_combine(sets.precast.WS.Quietus.Mid, {
        body="Fallen's Cuirass +3",
        ammo="Seething Bomblet +1",
        legs=Odyssean.Legs.WS
    })

    -- SPIRAL HELL
    -- 50% STR / 50% INT 
    sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS['Entropy'], {
        neck="Aqua Gorget",
        body="Ignominy Cuirass +3",
        waist="Metalsinger belt",
    })
    sets.precast.WS['Spiral Hell'].Mid = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Mid, { })
    sets.precast.WS['Spiral Hell'].Acc = set_combine(sets.precast.WS['Spiral Hell'], sets.precast.WS.Acc, { })

    -- SHADOW OF DEATH
    -- 40% STR 40% INT - Darkness Elemental
    sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
        head="Odyssean Helm",
        neck="Eddy Necklace",
        body="Fallen's Cuirass +3",
        ear1="Friomisi Earring",
        hands="Carmine Finger Gauntlets +1",
        back=Ankou.WSD,
        legs="Fallen's Flanchard +3",  
        waist="Eschan Stone", -- macc/matk 7
        feet="Sulevia's Leggings +2"
    })

    sets.precast.WS['Shadow of Death'].Mid = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Mid, {
    })
    sets.precast.WS['Shadow of Death'].Acc = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Acc, {
    })

    -- DARK HARVEST 
    -- 40% STR 40% INT - Darkness Elemental
    sets.precast.WS['Dark Harvest'] = sets.precast.WS['Shadow of Death']
    sets.precast.WS['Dark Harvest'].Mid = set_combine(sets.precast.WS['Shadow of Death'], {head="Terminal Helm", feet="Heathen's Sollerets +1"})
    sets.precast.WS['Dark Harvest'].Acc = set_combine(sets.precast.WS['Shadow of Death'], {head="Terminal Helm", feet="Heathen's Sollerets +1"})

    -- Sword WS's
    -- SANGUINE BLADE
    -- 50% MND / 50% STR Darkness Elemental
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
        head="Terminal Helm",
        neck="Eddy Necklace",
        ear1="Friomisi Earring",
        body="Fallen's Cuirass +3",
        hands="Founder's Gauntlets",
        back=Ankou.WSD,
        feet="Heathen's Sollerets +1"
    })
    sets.precast.WS['Sanguine Blade'].Mid = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Mid)
    sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], sets.precast.WS.Acc)

    -- REQUISCAT
    -- 73% MND - breath damage
    sets.precast.WS.Requiescat = set_combine(sets.precast.WS, {
        head="Flamma Zucchetto +2",
        neck="Shadow Gorget",
        body="Ignominy Cuirass +3",
        hands="Odyssean Gauntlets",
        waist="Soil Belt",
    })
    sets.precast.WS.Requiescat.Mid = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Mid)
    sets.precast.WS.Requiescat.Acc = set_combine(sets.precast.WS.Requiscat, sets.precast.WS.Acc)

    -- Idle sets
    sets.idle.Town = {
        ammo="Ginsen",
        head="Sulevia's Mask +2",
        neck="Sanctity Necklace",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        body="Sulevia's Platemail +2",
        hands="Sulevia's Gauntlets +2",
        ring1="Karieyh Ring",
        ring2="Defending Ring",
        back=Ankou.STP,
        waist="Flume Belt",
        legs="Carmine Cuisses +1",
        feet="Volte Sollerets"
    }

    sets.idle.Field = set_combine(sets.idle.Town, {
        head="Valorous Mask",
        body="Sulevia's Platemail +2",
    })
    sets.idle.Regen = set_combine(sets.idle.Field, {
        head="",
        neck="Sanctity Necklace",
        body="Lugra Cloak +1",
        ring1="Paguroidea Ring",
    })
    sets.idle.Refresh = set_combine(sets.idle.Regen, {
        head="Befouled Crown",
        body="Jumalik mail",
        neck="Coatl Gorget +1"
    })

    sets.idle.Weak = set_combine(sets.defense.PDT, {
        head="Baghere Salade",
        neck="Sanctity Necklace",
        body="Sulevia's Platemail +2",
        hands="Sulevia's Gauntlets +2",
        ring1="Paguroidea Ring",
        ring2="Defending Ring",
        back=Ankou.STP,
        waist="Flume Belt",
        legs="Sulevia's Cuisses +2",
        feet="Volte Sollerets"
    })

    -- Defense sets
    sets.defense.PDT = {
        ammo="Hasty Pinion +1", -- 2% haste
        head="Sulevia's Mask +2", -- 3% haste
        neck="Agitator's Collar",
        body="Jumalik Mail", -- 3% haste
        --body="Sulevia's Platemail +1", -- 1% haste
        hands="Sulevia's Gauntlets +2", -- 3% haste
        ear1="Etiolation Earring",
        ring1="Patricius Ring",
        ring2="Defending Ring",
        back="Grounded Mantle +1", -- 2% haste
        waist="Ioskeha Belt", -- 7% haste
        legs="Sulevia's Cuisses +2", -- 2% haste
        feet="Volte Sollerets" -- 3% haste
    }
    sets.defense.Reraise = sets.idle.Weak

    sets.defense.MDT = set_combine(sets.defense.PDT, {
        neck="Twilight Torque",
        body="Lugra Cloak +1",
        ear1="Etiolation Earring",
        back="Impassive Mantle",
    })

    sets.Kiting = {
        legs="Carmine Cuisses +1",
    }

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- sets.HighHaste = {
    --     ammo="Ginsen",
    --     head="Argosy Celata",
    -- }

    -- Defensive sets to combine with various weapon-specific sets below
    -- These allow hybrid acc/pdt sets for difficult content
    sets.Defensive = {
        --sub="Gracile grip",
        ammo="Hasty Pinion +1",
        head="Sulevia's Mask +2", -- 6% 
        neck="Agitator's Collar", -- 4% pdt
        body="Valorous Mail",
        hands="Sulevia's Gauntlets +2", -- 5% pdt
        ring1="Niqmaddu Ring", 
        ring2="Defending Ring", -- 10% dt
        back=Ankou.STP, -- 5% dt
        waist="Ioskeha Belt",
        legs="Sulevia's Cuisses +2", -- 7% dt
        feet="Volte Sollerets"  -- 4% pdt | 6% mdt
    }
    sets.Defensive_Mid = {
        ammo="Hasty Pinion +1",
        head="Sulevia's Mask +2",
        neck="Twilight Torque",
        body="Valorous Mail",
        hands="Sulevia's Gauntlets +2",
        ring1="Patricius Ring",
        ring2="Defending Ring",
        back=Ankou.STP,
        waist="Ioskeha Belt",
        legs="Sulevia's Cuisses +2",
        feet="Volte Sollerets" 
    }
    -- Higher DT, less haste
    sets.DefensiveHigh = set_combine(sets.Defensive, {
        ammo="Ginsen",
        head="Sulevia's Mask +2",
        neck="Agitator's Collar",
        body="Sulevia's Platemail +2",
        hands="Sulevia's Gauntlets +2",
        ring1="Niqmaddu Ring", 
        ring2="Defending Ring",
        legs="Sulevia's Cuisses +2",
        feet="Volte Sollerets",
        back=Ankou.STP,
    })
    sets.Defensive_Acc = set_combine(sets.Defensive_Mid, sets.DefensiveHigh)

    -- Base set (global catch-all set)
    sets.engaged = {
        -- sub="Bloodrain Strap",
        ammo="Ginsen",
        head="Flamma Zucchetto +2",
        neck="Ganesha's Mala",
        ear1="Cessance Earring",
        ear2="Brutal Earring",
        body="Valorous Mail",
        hands="Flamma Manopolas +2",
        ring1="Niqmaddu Ring",
        ring2="Flamma Ring",
        back=Ankou.STP,
        waist="Ioskeha Belt",
        legs="Ignominy Flanchard +3",
        feet="Flamma Gambieras +2"
    }
    sets.engaged.Mid = set_combine(sets.engaged, {
        neck="Lissome Necklace",
        body="Valorous Mail",
    })
    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        -- ammo="Hasty Pinion +1",
        ear1="Cessance Earring",
        ear2="Zennaroi Earring",
        body="Fallen's Cuirass +3",
        back=Ankou.STP,
    })

    -- These only apply when delay is capped.
    sets.engaged.Haste = set_combine(sets.engaged, {
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.Haste.Acc = set_combine(sets.engaged.Acc, {})

    -- Hybrid
    sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)

    -- Hybrid with capped delay
    sets.engaged.Haste.PDT = set_combine(sets.engaged.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Mid.PDT = set_combine(sets.engaged.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Acc.PDT = set_combine(sets.engaged.Acc.PDT, sets.DefensiveHigh)

    -- Liberator
    sets.engaged.Liberator = sets.engaged
    sets.engaged.Liberator.Mid = sets.engaged.Mid
    sets.engaged.Liberator.Acc = set_combine(sets.engaged.Acc, {
        body="Fallen's Cuirass +3",
    })

    -- Liberator AM3
    sets.engaged.Liberator.AM3 = set_combine(sets.engaged.Liberator, {
        ammo="Ginsen",
        head="Flamma Zucchetto +2",
        body="Valorous Mail",
        neck="Ganesha's Mala",
        hands="Flamma Manopolas +2",
        ear1="Cessance Earring",
        ear2="Tripudio Earring",
        ring1="Niqmaddu Ring",
        ring2="Flamma Ring",
        back=Ankou.STP,
        waist="Sailfi Belt +1",
        legs=Odyssean.Legs.TP,
        feet="Flamma Gambieras +2"
    })
    sets.engaged.Liberator.Mid.AM3 = set_combine(sets.engaged.Liberator.AM3, {
        neck="Lissome Necklace",
        legs=Odyssean.Legs.TP,
    })
    sets.engaged.Liberator.Acc.AM3 = set_combine(sets.engaged.Liberator.Mid.AM3, {
        ear2="Zennaroi Earring",
        body="Fallen's Cuirass +3",
        waist="Ioskeha Belt",
        legs="Ignominy Flanchard +3",
    })
    sets.engaged.Haste.Liberator = set_combine(sets.engaged.Liberator, {
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Liberator.Mid = sets.engaged.Liberator.Mid
    sets.engaged.Haste.Liberator.Acc = sets.engaged.Liberator.Acc
    
    sets.engaged.Haste.Liberator.AM3 = set_combine(sets.engaged.Liberator.AM3, {
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Liberator.Mid.AM3 = sets.engaged.Liberator.Mid.AM3
    sets.engaged.Haste.Liberator.Acc.AM3 = sets.engaged.Liberator.Acc.AM3
    
    -- Hybrid
    sets.engaged.Liberator.PDT = set_combine(sets.engaged.Liberator, {
        head="Sulevia's Mask +2",
        neck="Agitator's Collar",
        hands="Sulevia's Gauntlets +2",
        ring2="Defending Ring",
        back=Ankou.STP,
        waist="Sailfi Belt +1",
        feet="Volte Sollerets" 
    })
    sets.engaged.Liberator.Mid.PDT = set_combine(sets.engaged.Liberator.PDT, {
        ammo="Hasty Pinion +1",
        body="Sulevia's Platemail +2"
    })
    sets.engaged.Liberator.Acc.PDT = set_combine(sets.engaged.Liberator.Acc, sets.Defensive_Acc)
    -- Hybrid with AM3 up
    sets.engaged.Liberator.PDT.AM3 = set_combine(sets.engaged.Liberator.AM3, sets.Defensive)
    sets.engaged.Liberator.Mid.PDT.AM3 = set_combine(sets.engaged.Liberator.Mid.AM3, sets.Defensive_Mid)
    sets.engaged.Liberator.Acc.PDT.AM3 = set_combine(sets.engaged.Liberator.Acc.AM3, sets.Defensive_Acc)
    -- Hybrid with capped delay
    sets.engaged.Haste.Liberator.PDT = set_combine(sets.engaged.Liberator.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Liberator.Mid.PDT = set_combine(sets.engaged.Liberator.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Liberator.Acc.PDT = set_combine(sets.engaged.Liberator.Acc.PDT, sets.DefensiveHigh)
    -- Hybrid with capped delay + AM3 up
    sets.engaged.Haste.Liberator.PDT.AM3 = set_combine(sets.engaged.Liberator.PDT.AM3, sets.DefensiveHigh)
    sets.engaged.Haste.Liberator.Mid.PDT.AM3 = set_combine(sets.engaged.Liberator.Mid.PDT.AM3, sets.DefensiveHigh)
    sets.engaged.Haste.Liberator.Acc.PDT.AM3 = set_combine(sets.engaged.Liberator.Acc.PDT.AM3, sets.DefensiveHigh)

    -- Apocalypse
    sets.engaged.Apocalypse = set_combine(sets.engaged, {
        ear1="Cessance Earring",
        ear2="Brutal Earring",
    })
    sets.engaged.Apocalypse.Mid = set_combine(sets.engaged.Mid, {
        neck="Lissome Necklace",
    })
    sets.engaged.Apocalypse.Acc = set_combine(sets.engaged.Acc, {
        ear2="Zennaroi Earring",
        legs="Ignominy Flanchard +3",
    })
    
    sets.engaged.Apocalypse.AM = set_combine(sets.engaged.Apocalypse, {
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Apocalypse.Mid.AM = set_combine(sets.engaged.Apocalypse.AM, {
    })
    sets.engaged.Apocalypse.Acc.AM = set_combine(sets.engaged.Apocalypse.Mid.AM, {
        ear1="Cessance Earring",
        ear2="Zennaroi Earring",
        ring2="Cacoethic Ring +1",
        waist="Ioskeha Belt"
    })
    sets.engaged.Haste.Apocalypse = set_combine(sets.engaged.Apocalypse, {
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Apocalypse.Mid = sets.engaged.Apocalypse.Mid
    sets.engaged.Haste.Apocalypse.Acc = sets.engaged.Apocalypse.Acc

    -- Hybrid
    sets.engaged.Apocalypse.PDT = set_combine(sets.engaged.Apocalypse, sets.Defensive)
    sets.engaged.Apocalypse.Mid.PDT = set_combine(sets.engaged.Apocalypse.Mid, sets.Defensive_Mid)
    sets.engaged.Apocalypse.Acc.PDT = set_combine(sets.engaged.Apocalypse.Acc, sets.Defensive_Acc)
    -- Hybrid with relic AM 
    sets.engaged.Apocalypse.PDT.AM = set_combine(sets.engaged.Apocalypse, sets.Defensive)
    sets.engaged.Apocalypse.Mid.PDT.AM = set_combine(sets.engaged.Apocalypse.Mid, sets.Defensive_Mid)
    sets.engaged.Apocalypse.Acc.PDT.AM = set_combine(sets.engaged.Apocalypse.Acc, sets.Defensive_Acc)
    -- Hybrid with capped delay
    sets.engaged.Haste.Apocalypse.PDT = set_combine(sets.engaged.Apocalypse.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Apocalypse.Mid.PDT = set_combine(sets.engaged.Apocalypse.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Apocalypse.Acc.PDT = set_combine(sets.engaged.Apocalypse.Acc.PDT, sets.DefensiveHigh)
    -- Hybrid with capped delay + AM3 up
    sets.engaged.Haste.Apocalypse.PDT.AM3 = set_combine(sets.engaged.Apocalypse.PDT.AM3, sets.DefensiveHigh)
    sets.engaged.Haste.Apocalypse.Mid.PDT.AM3 = set_combine(sets.engaged.Apocalypse.Mid.PDT.AM3, sets.DefensiveHigh)
    sets.engaged.Haste.Apocalypse.Acc.PDT.AM3 = set_combine(sets.engaged.Apocalypse.Acc.PDT.AM3, sets.DefensiveHigh)

    -- generic scythe
    sets.engaged.Scythe = set_combine(sets.engaged, {})
    sets.engaged.Scythe.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.Scythe.Acc = set_combine(sets.engaged.Acc, {})

    sets.engaged.Scythe.PDT = set_combine(sets.engaged.Scythe, sets.Defensive)
    sets.engaged.Scythe.Mid.PDT = set_combine(sets.engaged.Scythe.Mid, sets.Defensive_Mid)
    sets.engaged.Scythe.Acc.PDT = set_combine(sets.engaged.Scythe.Acc, sets.Defensive_Acc)

    sets.engaged.Haste.Scythe = set_combine(sets.engaged.Haste, {})
    sets.engaged.Haste.Scythe.Mid = set_combine(sets.engaged.Haste.Mid, {})
    sets.engaged.Haste.Scythe.Acc = set_combine(sets.engaged.Haste.Acc, {})

    sets.engaged.Haste.Scythe.PDT = set_combine(sets.engaged.Scythe.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Scythe.Mid.PDT = set_combine(sets.engaged.Scythe.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Scythe.Acc.PDT = set_combine(sets.engaged.Scythe.Acc.PDT, sets.DefensiveHigh)

    -- generic great sword
    sets.engaged.GreatSword = set_combine(sets.engaged, {
        hands="Flamma Manopolas +2"
    })
    sets.engaged.GreatSword.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.GreatSword.Acc = set_combine(sets.engaged.Acc, {
        body="Fallen's Cuirass +3",
        legs="Ignominy Flanchard +3",
    })

    sets.engaged.GreatSword.PDT = set_combine(sets.engaged.GreatSword, sets.Defensive)
    sets.engaged.GreatSword.Mid.PDT = set_combine(sets.engaged.GreatSword.Mid, sets.Defensive_Mid)
    sets.engaged.GreatSword.Acc.PDT = set_combine(sets.engaged.GreatSword.Acc, sets.Defensive_Acc)

    sets.engaged.Haste.GreatSword = set_combine(sets.engaged.Haste, {})
    sets.engaged.Haste.GreatSword.Mid = set_combine(sets.engaged.Haste.Mid, {})
    sets.engaged.Haste.GreatSword.Acc = set_combine(sets.engaged.Haste.Acc, {})

    sets.engaged.Haste.GreatSword.PDT = set_combine(sets.engaged.GreatSword.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.GreatSword.Mid.PDT = set_combine(sets.engaged.GreatSword.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.GreatSword.Acc.PDT = set_combine(sets.engaged.GreatSword.Acc.PDT, sets.DefensiveHigh)

    -- Ragnarok
    sets.engaged.Ragnarok = set_combine(sets.engaged.GreatSword, {})
    sets.engaged.Ragnarok.Mid = set_combine(sets.engaged.GreatSword.Mid, {})
    sets.engaged.Ragnarok.Acc = set_combine(sets.engaged.GreatSword.Acc, {})
    
    sets.engaged.Ragnarok.PDT = set_combine(sets.engaged.Ragnarok, sets.Defensive)
    sets.engaged.Ragnarok.Mid.PDT = set_combine(sets.engaged.Ragnarok.Mid, sets.Defensive_Mid)
    sets.engaged.Ragnarok.Acc.PDT = set_combine(sets.engaged.Ragnarok.Acc, sets.Defensive_Acc)
    
    -- Caladbolg
    sets.engaged.Caladbolg = set_combine(sets.engaged.GreatSword, {
        hands="Flamma Manopolas +2"
    })
    sets.engaged.Caladbolg.Mid = set_combine(sets.engaged.GreatSword.Mid, {
        hands="Flamma Manopolas +2"
    })
    sets.engaged.Caladbolg.Acc = set_combine(sets.engaged.GreatSword.Acc, {
        hands="Flamma Manopolas +2",
        body="Fallen's Cuirass +3",
        legs="Ignominy Flanchard +3",
    })
    
    sets.engaged.Caladbolg.PDT = set_combine(sets.engaged.Caladbolg, sets.Defensive)
    sets.engaged.Caladbolg.Mid.PDT = set_combine(sets.engaged.Caladbolg.Mid, sets.Defensive_Mid)
    sets.engaged.Caladbolg.Acc.PDT = set_combine(sets.engaged.Caladbolg.Acc, sets.Defensive_Acc)
    
    sets.engaged.Haste.Caladbolg = set_combine(sets.engaged.Caladbolg, { 
        hands="Sulevia's Gauntlets +2",
        waist="Windbuffet Belt +1"
    })
    sets.engaged.Haste.Caladbolg.Mid = set_combine(sets.engaged.Caladbolg.Mid, {
        hands="Sulevia's Gauntlets +2",
    })
    sets.engaged.Haste.Caladbolg.Acc = set_combine(sets.engaged.Caladbolg.Acc, {
        hands="Sulevia's Gauntlets +2",
    })

    sets.engaged.Haste.Caladbolg.PDT = set_combine(sets.engaged.Caladbolg.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Caladbolg.Mid.PDT = set_combine(sets.engaged.Caladbolg.Mid.PDT, sets.DefensiveHigh)
    sets.engaged.Haste.Caladbolg.Acc.PDT = set_combine(sets.engaged.Caladbolg.Acc.PDT, sets.DefensiveHigh)
    
    -- dual wield
    sets.engaged.DW = set_combine(sets.engaged, {
        ear1="Eabani Earring",
        ear2="Suppanomimi",
        waist="Patentia Sash",
        legs="Carmine Cuisses +1",
    })
    sets.engaged.DW.Mid = set_combine(sets.engaged.DW, {
        neck="Lissome Necklace"
    })
    sets.engaged.DW.Acc = set_combine(sets.engaged.DW.Mid, {
        ear2="Zennaroi Earring",
    })

    -- single wield (sword + shield possibly)
    sets.engaged.SW = set_combine(sets.engaged, {
        ammo="Yetshila",
    })
    sets.engaged.SW.Mid = set_combine(sets.engaged.Mid, {})
    sets.engaged.SW.Acc = set_combine(sets.engaged.Acc, {})

    sets.engaged.Reraise = set_combine(sets.engaged, {
        head="Twilight Helm",
        neck="Twilight Torque",
        body="Twilight Mail"
    })

    sets.buff.Souleater = { 
        head="Ignominy Burgeonet +1",
        --body="Ratri Breastplate",
    }

    -- sets.buff['Last Resort'] = { 
    --     feet="Fallen's Sollerets +1" 
    -- }
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
    local recast = windower.ffxi.get_ability_recasts()
    -- Make sure abilities using head gear don't swap 
    if spell.type:lower() == 'weaponskill' then
        -- handle Gavialis Helm
        if use_gavialis then
            if is_sc_element_today(spell) then
                if wsList:contains(spell.english) then
                    -- do nothing
                else
                    equip(sets.WSDayBonus)
                end
            end
        end
        -- CP mantle must be worn when a mob dies, so make sure it's equipped for WS.
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end

        -- if spell.english == 'Entropy' and recast[95] == 0 then
        --     eventArgs.cancel = true
        --     send_command('@wait 4.0;input /ja "Consume Mana" <me>')
        --     --windower.chat.input:schedule(1, '/ws "Entropy" <t>')
        --     return
        -- end

        if player.tp > 2999 then
            if wsList:contains(spell.english) then
                equip(sets.IshvaraLugra)
            else
                equip(sets.BrutalLugra)
            end
        else -- use Lugra + moonshade
            if world.time >= (17*60) or world.time <= (7*60) then
                equip(sets.Lugra)
            else
                if wsList:contains(spell.english) then
                    equip(sets.Ishvara)
                else
                    equip(sets.Brutal)
                end
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
    if spell.english:startswith('Drain') then
        if player.status == 'Engaged' and state.CastingMode.current == 'Normal' and player.hpp < 70 then
            classes.CustomClass = 'OhShit'
        end
    end

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
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if state.Buff['Souleater'] then
        meleeSet = set_combine(meleeSet, sets.buff.Souleater)
    end
    --meleeSet = set_combine(meleeSet, select_earring())
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == "Engaged" then
        --if state.Buff['Last Resort'] then
        --    send_command('@wait 1.0;cancel hasso')
        --end
        -- handle weapon sets
        if gsList:contains(player.equipment.main) then
            state.CombatWeapon:set("GreatSword")
        elseif scytheList:contains(player.equipment.main) then
            state.CombatWeapon:set("Scythe")
        elseif player.equipment.main == 'Apocalypse' then
            state.CombatWeapon:set('Apocalypse')
        elseif player.equipment.main == 'Anguta' then
            state.CombatWeapon:set('Anguta')
        elseif player.equipment.main == 'Ragnarok' then
            state.CombatWeapon:set('Ragnarok')
        elseif player.equipment.main == 'Caladbolg' then
            state.CombatWeapon:set('Caladbolg')
        elseif player.equipment.main == 'Liberator' then
            state.CombatWeapon:set('Liberator')
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

    if S{'haste', 'march', 'embrava', 'geo-haste', 'indi-haste', 'last resort'}:contains(buff:lower()) then
        if (buffactive['Last Resort']) then
            if (buffactive.embrava or buffactive.haste) and buffactive.march then
                state.CombatForm:set("Haste")
                if not midaction() then
                    handle_equipping_gear(player.status)
                end
            end
        else
            if state.CombatForm.current ~= 'DW' and state.CombatForm.current ~= 'SW' then
                state.CombatForm:reset()
            end
            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end
    -- Drain II/III HP Boost. Set SE to stay on.
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
                add_to_chat(8, '-------------Mythic AM3 UP-------------')
            -- elseif (buff == "Aftermath: Lv.3" and not gain) then
            --     add_to_chat(8, '-------------Mythic AM3 DOWN-------------')
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
    
    -- if  buff == "Samurai Roll" then
    --     classes.CustomRangedGroups:clear()
    --     if (buff == "Samurai Roll" and gain) or buffactive['Samurai Roll'] then
    --         classes.CustomRangedGroups:append('SamRoll')
    --     end
       
    -- end

    --if buff == "Last Resort" then
    --    if gain then
    --        send_command('@wait 1.0;cancel hasso')
    --    else
    --        if not midaction() then
    --            send_command('@wait 1.0;input /ja "Hasso" <me>')
    --        end
    --    end
    --end
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
    select_default_macro_book()
end

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
        then 
            return true
    end
end
-- function get_custom_wsmode(spell, spellMap, default_wsmode)
--     if state.OffenseMode.current == 'Mid' then
--         if buffactive['Aftermath: Lv.3'] then
--             return 'AM3Mid'
--         end
--     elseif state.OffenseMode.current == 'Acc' then
--         if buffactive['Aftermath: Lv.3'] then
--             return 'AM3Acc'
--         end
--     else
--         if buffactive['Aftermath: Lv.3'] then
--             return 'AM3'
--         end
--     end
-- end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()

    if S{'NIN', 'DNC'}:contains(player.sub_job) and swordList:contains(player.equipment.main) then
        state.CombatForm:set("DW")
    --elseif player.equipment.sub == '' or shields:contains(player.equipment.sub) then
    elseif swordList:contains(player.equipment.main) then
        state.CombatForm:set("SW")
    elseif buffactive['Last Resort'] then
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
    if player.equipment.main == 'Apocalypse' then
        state.CombatWeapon:set('Apocalypse')
    elseif player.equipment.main == 'Anguta' then
        state.CombatWeapon:set('Anguta')
    elseif player.equipment.main == 'Ragnarok' then
        state.CombatWeapon:set('Ragnarok')
    elseif player.equipment.main == 'Caladbolg' then
        state.CombatWeapon:set('Caladbolg')
    elseif player.equipment.main == 'Liberator' then
        state.CombatWeapon:set('Liberator')
    elseif gsList:contains(player.equipment.main) then
        state.CombatWeapon:set("GreatSword")
    elseif scytheList:contains(player.equipment.main) then
        state.CombatWeapon:set("Scythe")
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
    if state.CombatForm.current ~= '' then 
        msg = msg .. ', Form: ' .. state.CombatForm.current 
    end
    if state.CombatWeapon.current ~= '' then 
        msg = msg .. ', Weapon: ' .. state.CombatWeapon.current 
    end
    if state.CapacityMode.value then
        msg = msg .. ', Capacity: ON, '
    end
    if state.SouleaterMode.value then
        msg = msg .. ', SE Cancel, '
    end
    -- if state.LastResortMode.value then
    --     msg = msg .. ', LR Defense, '
    -- end
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

function select_earring()
    if world.time >= (17*60) or world.time <= (7*60) then
        return sets.Lugra
    else
        return sets.Brutal
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
        -- if buffactive['Samurai Roll'] then
        --     classes.CustomRangedGroups:append('SamRoll')
        -- end
    end
end

function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 4)
    elseif player.equipment.main == 'Apocalypse' then
        set_macro_page(9, 4)
    elseif gsList:contains(player.equipment.main) then
        set_macro_page(5, 4)
    elseif player.sub_job == 'SAM' then
        set_macro_page(8, 4)
    else
        set_macro_page(8, 4)
    end
end
