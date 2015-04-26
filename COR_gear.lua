function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
	sets.precast.JA['Snake Eye'] = {legs="Commodore Culottes +1"}
	sets.precast.JA['Wild Card'] = {feet="Commodore Bottes +2"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
	sets.precast.JA['Fold'] = {body="Commodore Gants +2"}
    
    sets.CapacityMantle = {back="Mecistopins Mantle"}
	
	sets.precast.CorsairRoll = {
        head="Lanun Tricorne +1",
        hands="Navarch's Gants +2",
        body="Lanun Frac +1",
        ring1="Barataria Ring",
        back={name="Gunslinger's Cape", augments={'"Mag.Atk.Bns."+2','Enmity-3','"Phantom Roll" ability delay -2'}},
        feet="Lanun Bottes"
    }
	
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Navarch's Culottes +1"})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Navarch's Bottes +2"})
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +1"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Navarch's Gants +2"})
	
	sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    --sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
	
	sets.precast.CorsairShot = {}
	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Whirlpool Mask",
		body="Iuitl Vest",
        hands="Iuitl Wristbands +1",
		legs="Nahtirah Trousers",
    }
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {
        --ammo="Impatiens",
        head="Ejekamal Mask",
        ear1="Loquacious Earring",
        ring1="Prolix Ring",
        body="Dread Jupon",
        hands="Buremte Gloves",
        legs="Quiahuiz Trousers",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	sets.precast.RA = {
        ammo=gear.RAbullet,
		hands="Iuitl Wristbands +1",
		back="Navarch's Mantle",
        waist="Impulse Belt",
        legs="Nahtirah Trousers",
        feet="Wurrukatte Boots"
    }

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
        head="Lanun Tricorne +1",
        neck=gear.ElementalGorget,
        ear1="Flame Pearl",
        ear2="Flame Pearl",
		body="Lanun Frac +1",
        hands="Iuitl Wristbands +1",
        ring1="Karieyh Ring",
        ring2="Ifrit Ring +1",
		back="Buquwik Cape",
        waist=gear.ElementalBelt,
        legs="Nahtirah Trousers",
        feet="Lanun Bottes"
    }


	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, { ear2="Moonshade Earring"})

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {legs="Nahtirah Trousers"})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ear2="Moonshade Earring", legs="Nahtirah Trousers"})

	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
        ammo=gear.WSbullet,
        ear1="Flame Pearl",
        ear2="Moonshade Earring",
    })
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        ammo=gear.WSbullet,
        ear1="Enervating Earring",
        ear2="Moonshade Earring",
        back="Libeccio Mantle",
        ring1="Karieyh Ring",
        ring2="Longshot Ring"
    })

	sets.precast.WS['Wildfire'] = {
        ammo=gear.MAbullet,
        head="Lanun Tricorne +1",
        neck="Stoicheion Medal",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        body="Lanun Frac +1",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
        ring1="Karieyh Ring",
        ring2="Garuda Ring",
        back={name="Gunslinger's Cape", augments={'"Mag.Atk.Bns."+5','Enmity-4'}},
        waist="Aquiline Belt",
        legs="Shneddick Tights +1",
        feet="Lanun Bottes"
    }

	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], { ear2="Moonshade Earring"})
	
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Uk'uxkaj Cap",
        neck="Stoicheion Medal",
        hands="Iuitl Wristbands +1",
        ear1="Psystorm Earring",
        ear2="Lifestorm Earring",
        body="Mekosuchinae Harness",
        back={name="Gunslinger's Cape", augments={'"Mag.Atk.Bns."+5','Enmity-4'}},
        ring1="Globidonta Ring",
        ring2="Sangoma Ring",
		legs="Iuitl Tights +1",
        waist="Aquiline Belt",
    }
		
	-- Specific spells
	sets.midcast.Utsusemi = sets.midcast.FastRecast

	sets.midcast.CorsairShot = {
        ammo=gear.QDbullet,
        head="Umbani Cap",
        neck="Stoicheion Medal",
        ear1="Friomisi Earring",
        ear2="Crematio Earring",
        body="Lanun Frac +1",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
        ring1="Acumen Ring",
        ring2="Garuda Ring",
        back={name="Gunslinger's Cape", augments={'"Mag.Atk.Bns."+5','Enmity-4'}},
        waist="Aquiline Belt",
        legs="Shneddick Tights +1",
        feet="Lanun Bottes"
    }

	sets.midcast.CorsairShot.Acc = set_combine(sets.midcast.CorsairShot, {
        body="Mekosuchinae Harness",
        ear1="Lifestorm Earring",
        ear2="Psystorm Earring",
        ring1="Perception Ring",
        ring2="Sangoma Ring",
        feet="Navarch's Bottes +2"
    })

    sets.midcast.CorsairShot['Light Shot'] = sets.midcast.CorsairShot.Acc
	sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

	-- Ranged gear
	sets.midcast.RA = {
        ammo=gear.RAbullet,
        head="Umbani Cap",
        neck="Iqabi Necklace",
        ear1="Enervating Earring",
        ear2="Volley Earring",
        body="Lanun Frac +1",
        hands="Sigyn's Bazubands",
        ring1="Rajas Ring",
        ring2="Hajduk Ring",
        back={name="Gunslinger's Cape", augments={'"Mag.Atk.Bns."+5','Enmity-4'}},
        waist="Elanid Belt",
        legs="Aetosaur Trousers +1",
        feet="Scopuli Nails +1"
    }

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
    	body="Mekosuchinae Harness",
        ring1="Paqichikaji Ring",
        waist="Impulse Belt"
    })
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {ring2="Paguroidea Ring"}

	-- Idle sets
	sets.idle = {
        ammo=gear.RAbullet,
        head="Lanun Tricorne +1",
        neck="Twilight Torque",
        ear1="Zennaroi Earring",
        ear2="Crematio Earring",
        body="Lanun Frac +1",
        hands="Iuitl Wristbands +1",
        ring1="Karieyh Ring",
        ring2="Paguroidea Ring",
        back="Repulse Mantle",
        waist="Flume Belt",
        legs="Iuitl Tights +1",
        feet="Skadi's Jambeaux +1"
    }
    sets.idle.Regen = set_combine(sets.idle, {
        head="Ocelomeh Headpiece +1",
        body="Kheper jacket"
    })

	sets.idle.Town = {
        ammo=gear.RAbullet,
        head="Lanun Tricorne +1",
        neck="Iqabi Necklace",
        ear1="Enervating Earring",
        ear2="Crematio Earring",
        body="Councilor's Garb",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
        ring1="Ifrit Ring +1",
        ring2="Karieyh Ring",
        back={name="Gunslinger's Cape", augments={'"Mag.Atk.Bns."+5','Enmity-4'}},
        waist="Flume Belt",
        legs="Nahtirah trousers",
        feet="Skadi's Jambeaux +1"
    }
	
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle, {
        head="Lithelimb Cap",
        neck="Twilight Torque",
        hands="Iuitl Wristbands +1",
        body="Lanun Frac +1",
        ring1="Patricius Ring",
        ring2="Dark Ring",
        waist="Flume Belt",
        legs="Iuitl Tights +1",
        feet="Lanun Bottes"
    })

	sets.defense.MDT = sets.defense.PDT

	sets.Kiting = {legs="Crimson Cuisses"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
    sets.engaged = {
        ammo=gear.RAbullet,
        head="Umbani Cap",
        neck="Iqabi Necklace",
        ear1="Enervating Earring",
        ear2="Volley Earring",
        body="Lanun Frac +1",
        hands="Sigyn's Bazubands",
        ring1="Rajas Ring",
        ring2="Longshot Ring",
        back={name="Gunslinger's Cape", augments={'"Mag.Atk.Bns."+5','Enmity-4'}},
        waist="Elanid Belt",
        legs="Nahtirah Trousers",
        feet="Lanun Bottes"
    }
	-- Normal melee group
	sets.engaged.Melee = {
        ammo=gear.RAbullet,
        head="Whirlpool Mask",
        neck="Defiant Collar",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Iuitl Wristbands +1",
        ring1="Patricius Ring",
        ring2="Epona's Ring",
        back="Bleating Mantle",
        waist="Windbuffet Belt +1",
        legs="Taeon Tights",
        feet="Qaaxo Leggings"
    }

	sets.engaged.DW = set_combine(sets.engaged.Melee, {
        head="Taeon Chapeau",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        hands={name="Taeon Gloves", augments={'STR+3 VIT+3', 'Attack+22','"Dual Wield" +5'}},
        body="Taeon Tabard",
        ring1="Oneiros Ring",
        legs="Taeon Tights",
        waist="Shetal Stone",
        back="Bleating Mantle",
        feet="Taeon Boots"
    })
	
	sets.engaged.Acc = set_combine(sets.engaged.Melee, {
    	body="Mekosuchinae Harness",
        ring2="Mars's Ring",
        waist="Olseni Belt"
    })
	sets.engaged.Acc.DW = set_combine(sets.engaged.Melee.DW, {
        neck="Iqabi Necklace",
        ring2="Mars's Ring"
    })


end

