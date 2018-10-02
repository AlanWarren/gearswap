-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('organizer-lib')
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
	state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
    buffactive['Aftermath: Lv.2'] or
    buffactive['Aftermath: Lv.3'] or false
    
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false


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
        'Uppercut','Vertical Cleave','Saurian Slide'
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
        'Retinal Glare','Subduction','Tem. Upheaval','Water Bomb','Searing Tempest','Blinding Fulgor',
		'Spectral Floe','Scouring Spate','Anvil Lightning','Silent Storm','Entomb','Tenebral Crush','Palling Salvo'
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
        'Wild Carrot','Battery Charge'
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
        'Droning Whirlwind','Gates of Hades','Harden Shell','Pyric Bulwark','Thunderbolt',
        'Tourbillion'
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Refresh', 'Learning')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Learning')


    -- Additional local binds
    send_command('bind Delete input /ja "Chain Affinity" <me>')
    send_command('bind !` input /ja "Efflux" <me>')
    send_command('bind End input /ja "Burst Affinity" <me>')

	update_combat_weapon()
	update_melee_groups()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
 --------------------------------------
    -- Start defining the sets
    --------------------------------------

    sets.buff['Burst Affinity'] = {feet="Hashishin Basmak +1"}
    sets.buff['Chain Affinity'] = {head="Hashishin Kavuk", feet="Assimilator's Charuqs +1"}
    sets.buff.Convergence = {head="Luhlaza Keffiyeh +1"}
    sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
    sets.buff.Enchainment = {body="Luhlaza Jubbah +1"}
    sets.buff.Efflux = {legs="Hashishin Tayt"}

    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Uk'uxkaj Cap",
        body="Vanir Cotehardie",hands="Buremte Gloves",ring1="Spiral Ring",
        legs="Hagondes Pants +1",feet="Hashishin Basmak +1"}
        
    -- Don't need any special gear for Healing Waltz.

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Sapience Orb",
        head="Carmine Mask",neck="Orunmila's Torque",ear2="Loquacious Earring",
        body="Luhlaza Jubbah +1",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Swith Cape",waist="Witful Belt",legs="Psycloth lappas",feet="Amalric Nails"}
        
    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Adhemar Bonnet",neck="Sanctity necklace",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Rawhide Vest",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Fotia Belt",legs={ name="Herculean Trousers", augments={'Accuracy+25','"Triple Atk."+2','STR+2',}},feet="Herculean Boots"}
    
    sets.precast.WS.acc = set_combine(sets.precast.WS, {hands="Herculean Gloves"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {
        head="Uk'uxkaj Cap",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Vanir Cotehardie",hands="Leyline Gloves",ring1="Globidonta Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Fotia Belt",legs="Quiahuiz Trousers",feet="Assimilator's Charuqs +1"}

    sets.precast.WS['Sanguine Blade'] = {
        head="Herculean Helm",neck="Sanctity Necklace",ear1="Hecate's Earring",ear2="Friomisi Earring",
        body="Amalric Doublet",hands="Amalric gages",ring1="Archon Ring",ring2="Acumen Ring",
        back="Cornflower Cape",waist="Eschan stone",legs="Hagondes Pants +1",feet="Hashishin Basmak +1"}
		
	sets.precast.WS['Flash Nova'] = {
        head="Hagondes Hat +1",neck="Eddy Necklace",ear1="Hecate's Earring",ear2="Novio Earring",
        body="Hagondes Coat +1",hands="Helios Gloves",ring1="Weatherspoon Ring",ring2="Acumen Ring",
        back="Cornflower Cape",waist="Aswang Sash",legs="Hagondes Pants +1",feet="Hashishin Basmak +1"}
    
	sets.precast.WS['Chant du Cygne'] = {
        head="Adhemar Bonnet",neck="Sanctity necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Abnoba Kaftan",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Fotia Belt",legs={ name="Herculean Trousers", augments={'Accuracy+25','"Triple Atk."+2','STR+2',}},feet="Thereoid Greaves"}
    
	sets.precast.WS['Savage Blade'] = {
        head="Uk'uxkaj Cap",neck="Sanctity necklace",ear1="Moonshade Earring",ear2="Brutal Earring",
        body="Rawhide vest",hands="Rawhide Gloves",ring1="Ifrit Ring +1",ring2="Epona's Ring",
        back="Rosmerta's cape",waist="Fotia Belt",legs="Samnuha Tights",feet="Rawhide boots"}
    
	-- Midcast Sets
    sets.midcast.FastRecast = {
        head="Carmine Mask",neck="Orunmila's Torque",ear2="Loquacious Earring",
        body="Dread jupon",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Weatherspoon Ring",
        back="Swith Cape",waist="Witful belt",legs="Psycloth lappas",feet="Chelona Boots"}
        
    sets.midcast['Blue Magic'] = {hands="Rawhide Gloves"}
    
    -- Physical Spells --
    
    sets.midcast['Blue Magic'].Physical = {ammo="Ginsen",
        head="Adhemar Bonnet",neck="Sanctity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mekosuchinae Harness",hands="Herculean Gloves",ring1="Rajas Ring",ring2="Apate Ring",
        back="Cornflower Cape",waist="Prosilio Belt",legs="Hashishin Tayt +1",feet="Herculean Boots"}

    sets.midcast['Blue Magic'].PhysicalAcc = {ammo="Amar Cluster",
        head="Whirlpool Mask",neck="Sanctity Necklace",ear1="Heartseeker Earring",ear2="Steelflash Earring",
        body="Mekosuchinae Harness",hands="Herculean Gloves",ring1="Rajas Ring",ring2="Beeline Ring",
        back="Aurist's Cape",waist="Hurch'lan Sash",legs={ name="Herculean Trousers", augments={'Accuracy+25','"Triple Atk."+2','STR+2',}},feet="Herculean Boots"}

    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical,
        {head="Uk'uxkaj Cap",body="Assimilator's Jubbah +1",hands="Assimilator's Bazubands +1",waist="Metalsinger Belt"})

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical,
        {ammo="Mavi Tathlum",body="Rawhide Vest",hands="Rawhide Gloves",
         waist="Wanion Belt",legs="Manibozho Brais"})

    sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Assimilator's Jubbah +1",hands="Assimilator's Bazubands +1",back="Cornflower Cape"})

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Assimilator's Jubbah +1",hands="Nilas Gloves",ring2="Stormsoul Ring",
         waist="Chaac Belt",feet="Assimilator's Charuqs +1"})

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Psystorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         ring2="Icesoul Ring",back="Cornflower Cape",feet="Amalric Nails"})

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,
        {ear1="Lifestorm Earring",body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",
         ring2="Aquasoul Ring",back="Cornflower Cape"})

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical,
        {body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",back="Swith Cape +1",
         waist="Chaac Belt"})

    sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical)


    -- Magical Spells --
    
    sets.midcast['Blue Magic'].Magical = {ammo="Pemphredo tathlum",
        head="Herculean helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Amalric Doublet",hands="Amalric Gages",ring1="Acumen Ring",ring2="Shiva Ring",
        back="Cornflower Cape",waist="Yamabuki-no-Obi",legs="Hagondes Pants",feet="Amalric Nails"}

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
        {body="Assimilator's Jubbah +1",ring1="Etana Ring",legs="Psycloth Lappas",feet="Hashishin Basmak +1"})
    
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical,
        {ring1="Weatherspoon Ring"})

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical,
        {ring1="Weatherspoon Ring"})

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical)

    sets.midcast['Blue Magic'].MagicAccuracy = {ammo="Pemphredo Tathlum",
        head="Amalric Coif",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Dignitary's Earring",
        body="Hashishin Mintan +1",hands="Rawhide Gloves",ring1="Sangoma Ring",ring2="Etana Ring",
        back="Cornflower Cape",waist="Yamabuki-no-Obi",legs="Psycloth lappas",feet="Hashishin Basmak +1"}

    -- Breath Spells --
    
    sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh",neck="Ej Necklace",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Vanir Cotehardie",hands="Assimilator's Bazubands +1",ring1="K'ayres Ring",ring2="Beeline Ring",
        legs="Enif Cosciales",feet="Assimilator's Charuqs +1"}

    -- Other Types --
    
    sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy,
        {ammo="Honed Tathlum",
		neck="Ej Necklace",
		body="Mekosuchinae Harness",
		waist="Olseni Belt"})
        
    sets.midcast['Blue Magic']['White Wind'] = {
        head="Telchine Cap",neck="Lavalier +1",ear1="Bloodgem Earring",ear2="Mendicant's Earring",
        body="Chelona Blazer",hands="Weatherspoon Cuffs",ring1="K'ayres Ring",ring2="Meridian Ring",
        back="Solemnity Cape",waist="Gishdubar Sash",legs="Magavan Slops",feet="Assimilator's Charuqs +1"}

    sets.midcast['Blue Magic'].Healing = {
        head="Telchine Cap",neck="Phalaina Locket",ear1="Mendicant's Earring",ear2="Loquacious Earring",
        body="Chelona Blazer",hands="Weatherspoon Cuffs",ring1="Aquasoul Ring",ring2="Lebeche Ring",
        back="Solemnity Cape",waist="Gishdubar Sash",legs="Magavan Slops",feet="Hashishin Basmak +1"}

    sets.midcast['Blue Magic'].SkillBasedBuff = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",neck="Incantor's torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Assimilator's Jubbah +1",hand="Rawhide Gloves",
        back="Cornflower Cape",legs="Hashishin Tayt",feet="Luhlaza Charuqs +1"}

    sets.midcast['Blue Magic'].Buff = {}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Protectra = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    sets.midcast.Shellra = {ring1="Sheltered Ring"}
    

    
    
    -- Sets to return to when not performing an action.

    -- Gear for learning spells: +skill and AF hands.
    sets.Learning = {ammo="Mavi Tathlum",
        head="Luhlaza Keffiyeh +1",  
        body="Assimilator's Jubbah +1",hands="Magus Bazubands",
        back="Cornflower Cape",legs="Hashishin Tayt",feet="Luhlaza Charuqs +1"}


    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Resting sets
    sets.resting = {
        head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",ear1="Moonshade Earring",ear2="Relaxing Earring",
        body="Mekosuchinae Harness",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt",feet="Chelona Boots +1"}
    
    -- Idle sets
    sets.idle = {ammo="Impatiens",
        head="Rawhide mask",neck="Bathy choker",ear1="Moonshade Earring",ear2="Loquacious Earring",
        body="Amalric Doublet",hands="Rawhide gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Fucho-no-obi",legs="Carmine cuisses +1",feet="Herculean boots"}

    sets.idle.PDT = {ammo="Impatiens",
        head="Hagondes Hat",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Sanare Earring",
        body="Mekosuchinae Harness",hands="Iuitl wristbands +1",ring1="Defending Ring",ring2="Vocane Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine cuisses +1",feet="Herculean boots"}

    sets.idle.Town = {main="Claidheamh Soluis",sub="Buramenk'ah",ammo="Impatiens",
        head="Taeon Chapeau",neck="Wiglen Gorget",ear1="Moonshade Earring",ear2="Ethereal Earring",
        body="Luhlaza Jubbah +1",hands="Taeon Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Assimilator's Charuqs +1"}

    sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    
    -- Defense sets
    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Sanare Earring",
        body="Hagondes Coat +1",hands="Umuthi Gloves",ring1="Defending Ring",ring2="Vocane Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Carmine cuisses +1",feet="Herculean Boots"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Hagondes Hat +1",neck="Twilight Torque",ear1="Ethereal Earring",ear2="Sanare Earring",
        body="Hagondes Coat +1",hands="Umuthi Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Hagondes Pants +1",feet="Hashishin Basmak +1"}

    sets.Kiting = {legs="Blood Cuisses"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Ginsen", 
        head="Adhemar bonnet",neck="Asperity Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        body="Herculean Vest",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Taeon Tights",feet="Taeon Boots"}

    sets.engaged.Acc = {ammo="Amar Cluster",
        head="Carmine Mask",neck="Subtlety Spectacles",ear1="Bladeborn Earring",ear2="Dignitary's Earring",
        body="Herculean Vest",hands="Herculean Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Hurch'lan Sash",legs="Carmine Cuisses +1",feet="Herculean Boots"}

    sets.engaged.Refresh = {ammo="Honed Tathlum",
        head="Taeon Chapeau",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        body="Luhlaza Jubbah +1",hands="Taeon Gloves",ring1="Patricus Ring",ring2="Mars's Ring",
        back="Letalis Mantle",waist="Olseni Belt",legs="Taeon Tights",feet="Taeon Boots"}
		
	sets.engaged.Tizona = {ammo="Ginsen", 
        head="Adhemar bonnet",neck="Asperity Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        body="Herculean Vest",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Taeon Tights",feet="Herculean Boots"}

    sets.engaged.Tizona.Acc = {ammo="Amar Cluster",
        head="Skormoth Mask",neck="Subtlety Spectacles",ear1="Bladeborn Earring",ear2="Dignitary's Earring",
        body="Herculean Vest",hands="Herculean Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Rosmerta's Cape",waist="Hurch'lan Sash",legs="Carmine Cuisses +1",feet="Herculean Boots"}

    sets.engaged.Tizona.Refresh = {ammo="Honed Tathlum",
        head="Taeon Chapeau",neck="Ej Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        body="Luhlaza Jubbah +1",hands="Taeon Gloves",ring1="Patricus Ring",ring2="Mars's Ring",
        back="Letalis Mantle",waist="Olseni Belt",legs="Taeon Tights",feet="Taeon Boots"}

	sets.engaged.Tizona.AM3 = {ammo="Ginsen", 
        head="Adhemar bonnet",neck="Asperity Necklace",ear1="Suppanomimi",ear2="Dignitary's Earring",
        body="Herculean Vest",hands="Herculean Gloves",ring1="Petrov Ring",ring2="Rajas Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs={ name="Herculean Trousers", augments={'"Triple Atk."+3','STR+10','Accuracy+10','Attack+3',}},feet="Herculean Boots"}
		
	sets.engaged.Tizona.AM3.Acc = {ammo="Ginsen", 
        head="Skormoth Mask",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Dignitary's Earring",
        body="Herculean Vest",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Rajas Ring",
        back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Carmine Cuisses +1",feet="Herculean Boots"}
		
    sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)


    sets.self_healing = {ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
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
-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	update_combat_weapon()
	update_melee_groups()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
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
	update_combat_weapon()
	update_melee_groups()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
local msg = 'Melee'
if state.CombatForm.has_value then
msg = msg .. ' (' .. state.CombatForm.value .. ')'
end
if state.CombatWeapon.has_value then
msg = msg .. ' (' .. state.CombatWeapon.value .. ')'
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
if state.Kiting.value == true then
msg = msg .. ', Kiting'
end
if state.PCTargetMode.value ~= 'default' then
msg = msg .. ', Target PC: '..state.PCTargetMode.value
end
if state.SelectNPCTargets.value == true then
msg = msg .. ', Target NPCs'
end
add_to_chat(122, msg)
eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_weapon()
	state.CombatWeapon:set(player.equipment.main)
end

function update_melee_groups()

    classes.CustomMeleeGroups:clear()
    -- mythic AM	
    if player.equipment.main == 'Tizona' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    end

end

