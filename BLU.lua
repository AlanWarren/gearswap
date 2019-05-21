-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
-- <slot01>cocoon</slot01> def - crawlers
-- <slot02>tail slap</slot02>  stp - merrows arrapago reef
-- <slot03>sickle slash</slot03> - STP - spiders aby mis coast
-- <slot04>diffusion ray</slot04> STP bonus - Chariots aby uleguerand #07
-- <slot05>anvil lightning</slot05> ACC bonus -  Escalent (ungeweder type = green/blue)
-- <slot06>empty thrash</slot06> Da/Ta - craver promy mea
-- <slot07>erratic flutter</slot07>
-- <slot08>fantod</slot08> - stp (also attack buff) - hippogryph in risenjima
-- <slot09>delta thrust</slot09> DW - peiste in aby mis coast #07
-- <slot10>white wind</slot10> regen trait - puk (Waugyl) in aby altepa
-- <slot11>barrier tusk</slot11> DT - olyphant aby uleguerant 
-- <slot12>nat. meditation</slot12> acc bonus (attk boost when used) - chapuli in risenjima
-- <slot13>sudden lunge</slot13> stp - ladybug aby altepa #01 or #03
-- <slot14>thrashing assault</slot14>
-- <slot15>vanity dive</slot15>
-- <slot16>barbed crescent</slot16>
-- <slot17>disseverment</slot17>
-- <slot18>molting plumage</slot18>
-- <slot19>occultation</slot19>
-- <slot20>heavy strike</slot20>
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
    
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')

    state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi', 'Trust'}

    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave'
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
        'Vanity Dive'
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite','Queasyshroom'
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb'
    }

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
    }
        
    -- Breath-based spells
    blue_magic_maps.Breath = S{
        'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Radiant Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Stun spells
    blue_magic_maps.Stun = S{
        'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
        'Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{
        'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Plasma Charge',
        'Pyric Bulwark','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
        'Memento Mori','Nat. Meditation','Occultation','Orcish Counterstance','Refueling',
        'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
        'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
        'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot'
    }
    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Mid', 'Learning')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')

    -- Additional local binds
    send_command('bind ^` input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind @` input /ja "Burst Affinity" <me>')
    send_command('bind @f9 gs c cycle HasteMode')

    update_combat_form()
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind @f9')
end


-- Set up gear sets.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = {feet="Mavi Basmak +2"}
    sets.buff['Chain Affinity'] = {head="Mavi Kavuk +2", feet="Assimilator's Charuqs"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah"}
    sets.buff.Efflux = {legs="Mavi Tayt +2"}
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        ammo="Sonia's Plectrum",
        head="Uk'uxkaj Cap",
        body="Vanir Cotehardie",
        hands="Buremte Gloves",
        ring1="Spiral Ring",
        back="Iximulew Cape",
        waist="Caudata Belt",
        legs="Hagondes Pants",
        feet="Iuitl Gaiters +1"
    }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        ammo="Impatiens",
        head="Haruspex Hat",
        ear2="Loquacious Earring",
        body="Luhlaza Jubbah",
        hands="Thaumas Gloves",
        ring1="Prolix Ring",
        back="Swith Cape +1",
        waist="Witful Belt",
        legs="Enif Cosciales",
        feet="Chelona Boots +1"
    }
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Mavi Mintan +2"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Whirlpool Mask",
        neck=gear.ElementalGorget,
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Assimilator's Bazubands +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist=gear.ElementalBelt,
        legs="Manibozho Brais",
        feet="Iuitl Gaiters +1"
    }
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, {hands="Buremte Gloves"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Aquasoul Ring",feet="Luhlaza Charuqs"})

    sets.precast.WS['Sanguine Blade'] = {
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hagondes Coat",hands="Mavi Bazubands +2",ring1="Acumen Ring",ring2="Strendu Ring",
        back="Toro Cape",legs="Hagondes Pants",feet="Iuitl Gaiters +1"}
    
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Haruspex Hat",ear2="Loquacious Earring",
        body="Luhlaza Jubbah",hands="Mavi Bazubands +2",ring1="Prolix Ring",
        back="Swith Cape +1",waist="Hurch'lan Sash",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}
        
    sets.midcast['Blue Magic'] = {}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {ammo="Mavi Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
        body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Spiral Ring",
        back="Cornflower Cape",waist="Caudata Belt",legs="Nahtirah Trousers",feet="Qaaxo Leggings"}

    sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Jukukik Feather",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
        body="Luhlaza Jubbah",hands="Buremte Gloves",ring1="Rajas Ring",ring2="Patricius Ring",
        back="Letalis Mantle",waist="Hurch'lan Sash",legs="Manibozho Brais",feet="Qaaxo Leggings"}

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Iuitl Vest",hands="Assimilator's Bazubands +1"})

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Jukukik Feather",body="Iuitl Vest",hands="Assimilator's Bazubands +1",
         waist="Chaac Belt",legs="Manibozho Brais"})

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Iximulew Cape"})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Vanir Cotehardie",hands="Iuitl Wristbands",ring2="Stormsoul Ring",
         waist="Chaac Belt",feet="Iuitl Gaiters +1"})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Psystorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         ring2="Icesoul Ring",back="Toro Cape",feet="Hagondes Sabots"})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Lifestorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         ring2="Aquasoul Ring",back="Refraction Cape"})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Refraction Cape",
         waist="Chaac Belt"})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {ammo="Dosis Tathlum",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hagondes Coat",hands="Mavi Bazubands +2",ring1="Icesoul Ring",ring2="Acumen Ring",
        back="Cornflower Cape",waist="Caudata Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {body="Vanir Cotehardie",ring1="Sangoma Ring",legs="Iuitl Tights",feet="Mavi Basmak +2"})
    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
        {ring1="Aquasoul Ring"})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,
        {ring1="Spiral Ring"})

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Ej Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vanir Cotehardie",ring2="Sangoma Ring",
        back="Cornflower Cape",legs="Iuitl Tights",feet="Iuitl Gaiters +1"}

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Ej Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="K'ayres Ring",ring2="Beeline Ring",
        back="Refraction Cape",legs="Enif Cosciales",feet="Iuitl Gaiters +1"}

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {waist="Chaac Belt"})
        
    sets.midcast['Blue Magic']['White Wind'] = {
        head="Whirlpool Mask",neck="Lavalier +1",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Buremte Gloves",ring1="K'ayres Ring",ring2="Meridian Ring",
        back="Fravashi Mantle",waist="Hurch'lan Sash",legs="Enif Cosciales",feet="Hagondes Sabots"}

    sets.midcast['Blue Magic'].Healing = {
        head="Uk'uxkaj Cap",ear1="Lifestorm Earring",ear2="Loquacious Earring",
        body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Aquasoul Ring",ring2="Sirona's Ring",
        back="Pahtli Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",
        body="Assimilator's Jubbah",
        back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}

    sets.midcast['Blue Magic'].Buff = {}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
    

    
    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",hands="Assimilator's Bazubands +1"}
        --head="Luhlaza Keffiyeh",  
        --body="Assimilator's Jubbah",hands="Assimilator's Bazubands +1",
        --back="Cornflower Cape",legs="Mavi Tayt +2",feet="Luhlaza Charuqs"}


    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Resting sets
    sets.resting = {
        head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",feet="Chelona Boots +1"}
    
    -- Idle sets
    sets.idle = {ammo="Impatiens",
        head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Serpentes Sabots"}

    sets.idle.PDT = {ammo="Impatiens",
        head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Hagondes Coat",hands="Iuitl Wristbands",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Iuitl Gaiters +1"}

    sets.idle.Town = {main="Buramenk'ah",ammo="Impatiens",
        head="Mavi Kavuk +2",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Luhlaza Jubbah",hands="Assimilator's Bazubands +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Atheling Mantle",waist="Flume Belt",legs="Crimson Cuisses",feet="Luhlaza Charuqs"}

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Whirlpool Mask",neck="Wiglen Gorget",ear1="Bloodgem Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Whirlpool Mask",neck="Twilight Torque",ear1="Bloodgem Earring",
        body="Hagondes Coat",hands="Iuitl Wristbands",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    sets.Kiting = {legs="Crimson Cuisses"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        ammo="Jukukik Feather",
        head="Whirlpool Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Luhlaza Jubbah",
        hands="Assimilator's Bazubands +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Manibozho Brais",
        feet="Iuitl Gaiters +1"
    }

    sets.engaged.Mid = set_combine(sets.engaged, {})

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {})

    sets.engaged.DW = {
        ammo="Jukukik Feather",
        head="Whirlpool Mask",
        neck="Asperity Necklace",
        ear1="Heartseeker Earring",
        ear2="Dudgeon Earring",
        body="Luhlaza Jubbah",
        hands="Assimilator's Bazubands +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Manibozho Brais",
        feet="Iuitl Gaiters +1"
    }

    sets.engaged.DW.Acc = {
        ammo="Jukukik Feather",
        head="Whirlpool Mask",
        neck="Ej Necklace",
        ear1="Heartseeker Earring",
        ear2="Dudgeon Earring",
        body="Luhlaza Jubbah",
        hands="Buremte Gloves",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Letalis Mantle",
        waist="Hurch'lan Sash",
        legs="Manibozho Brais",
        feet="Qaaxo Leggings"
    }

    sets.engaged.PDT = set_combine(sets.engaged, {})
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {})
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Mid.PDT, {})
    sets.engaged.Low = set_combine(sets.engaged, {})

    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)

    
    sets.engaged.MaxHaste = set_combine(sets.engaged, { })
    sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.MaxHaste, { })
    sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, { })
    sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, {})
    sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {})
    sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, {})

    sets.engaged.Haste_35 = set_combine(sets.engaged.MaxHaste, {
    })
    sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Mid.MaxHaste, {
    })
    sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Acc.MaxHaste, {
    })

    sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, {})
    sets.engaged.Mid.PDT.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, {})
    sets.engaged.Acc.PDT.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, {})

    -- 30% Haste 1626 / 798
    sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {
    })
    sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Low.Haste_30, {
    })
    sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
    })

    sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, {})
    sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {})
    sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, {})


    -- haste spell - 139 dex | 275 acc | 1150 total acc (with shigi R15)
    sets.engaged.Haste_15 = set_combine(sets.engaged.Haste_30, {
    })
    sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Low.Haste_15, { -- 676
    })
    sets.engaged.Acc.Haste_15 = sets.engaged.Acc.Haste_30
    
    sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, {})
    sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, {})
    sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Acc.Haste_15, {})

    sets.self_healing = {ring1="Kunaji Ring",ring2="Asklepian Ring"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
    if string.find(spell.english, 'Utsusemi') then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
            cancel_spell()
            eventArgs.cancel = true
            return
        end
    end

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
            equip(sets.self_healing)
        end
    end

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.OffenseMode.value == 'Learning' then
        equip(sets.Learning)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
    end
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
        determine_haste_group()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    if buff:startswith('Aftermath') then
        if player.equipment.main == 'Tizona' then
            classes.CustomMeleeGroups:clear()

            if (buff == "Aftermath: Lv.3" and gain) or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
                add_to_chat(8, '-------------AM3 UP-------------')
            end

            if not midaction() then
                handle_equipping_gear(player.status)
            end
        end
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    determine_haste_group()
    th_update(cmdParams, eventArgs)
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

function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- mythic AM	
    if player.equipment.main == 'Tizona' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    end
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.HasteMode.value == 'Hi' then
        if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
             ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
             ( buffactive.march == 2 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
                 ( buffactive.march == 1 and buffactive[604] ) ) then
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif ( buffactive.march == 1 or buffactive[604] ) then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    else
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
           ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
           ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
           ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
            add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
               ( buffactive.march == 2 and buffactive['haste samba'] ) or
               ( buffactive[580] and buffactive['haste samba'] ) then 
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
        elseif ( buffactive.march == 2 ) or -- two marches from ghorn
               ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
               ( buffactive[580] ) or  -- geo haste
               ( buffactive[33] and buffactive[604] ) then  -- haste with MG
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        end
    end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    -- Check for H2H or single-wielding
    --if player.equipment.sub == "Genbu's Shield" or player.equipment.sub == 'empty' then
    --    state.CombatForm:reset()
    --else
    --    state.CombatForm:set('DW')
    --end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 7)
    else
        set_macro_page(1, 7)
    end
end



