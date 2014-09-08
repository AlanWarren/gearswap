-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands="Wyrm Finger Gauntlets +2"}

	sets.precast.JA.Jump = {
        ammo="Hagneia Stone",
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
		body="Lancer's Plackart +2",
        hands="Lancer's Vambraces +2",
        ring1="Rajas Ring",
        ring2="Oneiros Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Ares' Flanchard +1",
        feet="Cizin Greaves +1"
    }

	sets.precast.JA['Ancient Circle'] = {}
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

	sets.precast.JA['Spirit Link'] = {hands="Lancer's Vambraces +2"}
	sets.precast.JA['Call Wyvern'] = {body="Wyrm Mail"}
	sets.precast.JA['Deep Breathing'] = {--head="Wyrm Armet +1"
    }
	sets.precast.JA['Spirit Surge'] = { --body="Wyrm Mail +2"
    }
	
	-- Healing Breath sets
	sets.HB = {
        ammo="Hagneia Stone",
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
		back="Atheling Mantle",legs="Xaddi Cuisses",feet="Whirlpool Greaves"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
        head="Cizin Helm", 
        ear1="Loquacious Earring", 
        hands="Buremte Gloves",
        ring1="Prolix Ring"
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Otomi Helm",
        hands="Cizin Mufflers +1",
		legs="Xaddi Cuisses",
        feet="Ejekamal Boots",
        waist="Zoran's Belt"
    }	
		
	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { head="Wyrm Armet", waist="Glassblower's Belt" })
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
        waist="Windbuffet Belt",
        legs="Scuffler's Cosciales",
        feet="Ejekamal Boots"
    }
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        head="Yaoyotl Helm",
        legs="Xaddi Cuisses"
    })
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        neck="Shadow Gorget",
        back="Buquwik Cape",
        waist="Soil Belt"
    })
	sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {
        head="Yaoyotl Helm",
        feet="Mikinaak Greaves"
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
        hands="Cizin Mufflers +1",
        waist="Light Belt",
        ring2="Pyrosoul Ring",
        legs="Lancer's Cuissots +2"
    })
	sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {head="Yaoyotl Helm"})
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
		back="Shadow Mantle",
        waist="Zoran's Belt",
        legs="Crimson Cuisses",
        feet="Whirlpool Greaves"
    }
	

	-- Idle sets
	sets.idle = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {
        ammo="Hagneia Stone",
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
		body="Ares' Cuirass +1",
        hands="Ares' Gauntlets +1",
        ring1="Patricius Ring",
        ring2="Oneiros Ring",
		back="Atheling Mantle",
        waist="Metalsinger Belt",
        legs="Crimson Cuisses",
        feet="Ejekamal Boots"
    }
	
	sets.idle.Field = set_combine(sets.idle.Town, {
        head="Twilight Helm",
        neck="Twilight Torque",
		body="Ares' Cuirass +1",
        ring2="Paguroidea Ring",
        back="Repulse Mantle"
    })

	sets.idle.Weak = set_combine(sets.idle.Field, {
		head="Twilight Helm",
		body="Twilight Mail",
    })
	
	-- Defense sets
	sets.defense.PDT = {
        ammo="Hagneia Stone",
		head="Ighwa Cap",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Cizin Mail +1",
        hands="Cizin Mufflers +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
		back="Repulse Mantle",
        waist="Cetl Belt",
        legs="Cizin Breeches +1",
        feet="Cizin Greaves +1"
    }

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.defense.MDT = sets.defense.PDT

	sets.Kiting = {legs="Crimson Cuisses"}

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged = {
        ammo="Hagneia Stone",
		head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Brutal Earring",
        ear2="Tripudio Earring",
		body="Xaddi Mail",
        hands="Cizin Mufflers +1",
        ring1="Rajas Ring",
        ring2="Oneiros Ring",
		back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Xaddi Cuisses",
        feet="Ejekamal Boots"
    }

	sets.engaged.Mid = set_combine(sets.engaged, {
        head="Yaoyotl Helm",
        back="Updraft Mantle",
        hands="Xaddi Gauntlets",
        ring2="K'ayres Ring",
        feet="Ejekamal Boots"
    })

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        neck="Iqabi Necklace",
        hands="Mikinaak Gauntlets",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        ring1="Patricius Ring"
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
        head="Ighwa Cap",
        neck="Twilight Torque",
        body="Cizin Mail +1",
        ring1="Rajas Ring",
        ring2="Patricius Ring",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
        feet="Cizin Greaves +1"
    })
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        head="Ighwa Cap",
        ring2="Patricius Ring",
        body="Cizin Mail +1",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
    })
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        head="Ighwa Cap",
        ring2="Patricius Ring",
        body="Cizin Mail +1",
        hands="Cizin Mufflers +1",
        back="Repulse Mantle",
        legs="Cizin Breeches +1",
    })

	sets.engaged.Reraise = set_combine(sets.engaged, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.engaged.Acc.Reraise = sets.engaged.Reraise

end

