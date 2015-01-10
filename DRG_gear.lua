-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Pteroslaver Finger Gauntlets"}
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    sets.Berserker = {neck="Berserker's Torque"}
    sets.WSDayBonus     = { head="Gavialis Helm" }

	sets.precast.JA.Jump = {
        ammo="Ginsen",
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
		body="Lancer's Plackart +2",
        hands="Xaddi Gauntlets",
        ring1="Rajas Ring",
        ring2="Oneiros Ring",
		back="Bleating Mantle",
        waist="Windbuffet Belt +1",
        legs="Scuffler's Cosciales",
        feet="Cizin Greaves +1"
    }

	sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais" }
	sets.TreasureHunter = {waist="Chaac Belt"}

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {
    }) 
	sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Lancer's Cuissots +2"
    })
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
        legs="Lancer's Cuissots +2"
        --feet="Lancer's Schynbalds +2"
    })
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {hands="Lancer's Vambraces +2", head="Vishap Armet +1"}
	sets.precast.JA['Call Wyvern'] = {body="Wyrm Mail"}
	sets.precast.JA['Deep Breathing'] = {--head="Wyrm Armet +1" or Petroslaver Armet +1
    }
	sets.precast.JA['Spirit Surge'] = { --body="Wyrm Mail +2"
    }
	
	-- Healing Breath sets
	sets.HB = {
        ammo="Ginsen",
		head="Wyrm Armet",
        neck="Lancer's Torque",
        ear1="Steelflash Earring",
        ear2="Bladeborn Earring",
		body="Xaddi Mail",
        hands="Cizin Mufflers +1",
        ring1="Dark Ring",
        ring2="K'ayres Ring",
		back="Updraft Mantle",
        waist="Glassblower's Belt",
        legs="Vishap Brais",
        feet="Wym. Greaves +2"
    }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Yaoyotl Helm",
		body="Mikinaak Breastplate",hands="Cizin Mufflers +1",ring1="Rajas Ring",
		back="Bleating Mantle",legs="Xaddi Cuisses",feet="Whirlpool Greaves"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
        ammo="Impatiens",
        head="Cizin Helm +1", 
        ear1="Loquacious Earring", 
        hands="Buremte Gloves",
        ring1="Prolix Ring"
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Vishap Armet +1",
        neck="Lancer's Torque",
        hands="Cizin Mufflers +1",
        body="Xaddi Mail",
        ring1="Beeline Ring",
        ring2="K'ayres Ring",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
		legs="Cizin Breeches +1",
        feet="Ejekamal Boots",
    }	
		
	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { head="Vishap Armet +1" })
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}

	sets.precast.WS = {
        ammo="Thew Bomblet",
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
		body="Gorney Haubert +1",
        hands="Mikinaak Gauntlets",
        ring1="Ifrit Ring",
        ring2="Pyrosoul Ring",
		back="Buquwik Cape",
        waist="Windbuffet Belt +1",
        legs="Scuffler's Cosciales",
        feet="Ejekamal Boots"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		back="Updraft Mantle",
        head="Yaoyotl Helm",
        legs="Xaddi Cuisses"
    })
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        hands="Lancer's Vambraces +2",
        ring2="Rajas Ring",
        back="Buquwik Cape",
        waist="Soil Belt"
    })
	sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {
        head="Yaoyotl Helm",
        hands="Mikinaak Gauntlets",
		back="Updraft Mantle",
    })
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {neck="Shadow Gorget",waist="Soil Belt"})

    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
        neck="Breeze Gorget",
        body="Phorcys Korazin",
        back="Buquwik Cape",
        waist="Metalsinger Belt",
        feet="Whirlpool Greaves"
    })
	sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {
        head="Yaoyotl Helm", 
        ear1="Bladeborn Earring", 
        ear2="Steelflash Earring", 
        back="Updraft Mantle"
    })
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
        neck="Flame Gorget", 
        hands="Mikinaak Gauntlets",
        back="Rancorous Mantle",
        waist="Windbuffet Belt +1"
    })
	sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {
		    back="Updraft Mantle",
            head="Yaoyotl Helm"
    })
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {hands="Mikinaak Gauntlets"})

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
        head="Twilight Helm",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Twilight Mail",
        hands="Cizin Mufflers +1",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
		back="Repulse Mantle",
        legs="Crimson Cuisses",
        feet="Whirlpool Greaves"
    }
	

	-- Idle sets
	sets.idle = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {
        ammo="Ginsen",
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
		body="Ares' Cuirass +1",
        hands="Ares' Gauntlets +1",
        ring1="Patricius Ring",
        ring2="Oneiros Ring",
		back="Bleating Mantle",
        waist="Metalsinger Belt",
        legs="Crimson Cuisses",
        feet="Cizin Greaves +1"
    }
	
	sets.idle.Field = set_combine(sets.idle.Town, {
        head="Otomi Helm",
        neck="Twilight Torque",
		body="Ares' Cuirass +1",
        ring2="Paguroidea Ring",
        back="Repulse Mantle"
    })

    sets.idle.Regen = set_combine(sets.idle.Field, {
        head="Twilight Helm",
		body="Ares' Cuirass +1",
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
		head="Twilight Helm",
		body="Twilight Mail",
    })
	
	-- Defense sets
	sets.defense.PDT = {
        ammo="Ginsen",
		head="Ighwa Cap",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Emet Harness +1",
        hands="Cizin Mufflers +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
		back="Repulse Mantle",
        waist="Flume Belt",
        legs="Cizin Breeches +1",
        feet="Cizin Greaves +1"
    }

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.defense.MDT = set_combine(sets.defense.PDT, {
         back="Engulfer Cape +1"
    })

	sets.Kiting = {legs="Crimson Cuisses"}

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
        ammo="Ginsen",
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Xaddi Mail",
        hands="Xaddi Gauntlets",
        ring1="Rajas Ring",
        ring2="Oneiros Ring",
        back="Bleating Mantle",
        waist="Windbuffet Belt +1",
        legs="Xaddi Cuisses",
        feet="Ejekamal Boots"
    }

	sets.engaged.Mid = set_combine(sets.engaged, {
        head="Yaoyotl Helm",
        ear1="Zennaroi Earring",
        ring2="Ramuh Ring +1"
    })

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        neck="Iqabi Necklace",
        hands="Buremte Gloves",
        waist="Olseni Belt",
        ring1="Mars's Ring",
        back="Updraft Mantle"
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
        head="Ighwa Cap",
        neck="Twilight Torque",
        body="Emet Harness +1",
        ring2="Patricius Ring",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
        feet="Cizin Greaves +1"
    })
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        head="Ighwa Cap",
        ring2="Patricius Ring",
        body="Emet Harness +1",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        head="Ighwa Cap",
        ring2="Patricius Ring",
        body="Emet Harness +1",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
    })

    sets.engaged.War = set_combine(sets.engaged, {
        --head="Yaoyotl Helm",
        feet="Mikinaak Greaves",
        ring2="K'ayres Ring"
    })
    sets.engaged.War.Mid = sets.engaged.Mid

	sets.engaged.Reraise = set_combine(sets.engaged, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.engaged.Acc.Reraise = sets.engaged.Reraise

end

