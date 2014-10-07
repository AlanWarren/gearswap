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

     sets.CapacityMantle = {back="Mecistopins Mantle"}
     sets.Berserker = {neck="Berserker's Torque"}
     sets.WSDayBonus     = { head="Gavialis Helm" }
 
     -- Waltz set (chr and vit)
     sets.precast.Waltz = {
        head="Yaoyotl Helm",
    	body="Mes'yohi Haubergeon",
        legs="Cizin Breeches +1",
        feet="Whirlpool Greaves"
     }
            
     -- Fast cast sets for spells
     sets.precast.FC = {
        head="Cizin Helm",
        ear1="Loquacious Earring",
        hands="Buremte Gloves",
        ring2="Prolix Ring"
     }

     sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })

     sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, { neck="Stoicheion Medal" })
     sets.precast.FC['Absorb-TP'] = set_combine(sets.precast.FC, { hands="Bale Gauntlets +2" })
     sets.precast.FC['Dark Magic'] = set_combine(sets.precast.FC, { head="Fallen's Burgeonet" })
              
     -- Midcast Sets
     sets.midcast.FastRecast = {
         head="Otomi Helm",
         hands="Cizin Mufflers +1",
         waist="Zoran's Belt",
         feet="Ejekamal Boots"
     }
            
     -- Specific spells
     sets.midcast.Utsusemi = {
         head="Otomi Helm",
         waist="Zoran's Belt",
         feet="Ejekamal Boots"
     }
 
     sets.midcast['Dark Magic'] = {
         head="Ignominy burgeonet +1",
         neck="Dark Torque",
         ear1="Lifestorm Earring",
         ear2="Psystorm Earring",
         body="Haruspex Coat",
         hands="Fallen's Finger Gauntlets",
         ring1="Perception Ring",
         ring2="Sangoma Ring",
         back="Niht Mantle",
         waist="Zoran's Belt",
         legs="Bale Flanchard +2",
         feet="Ignominy sollerets"
     }
     
	 sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
         head="Otomi Helm",
         waist="Chaac Belt",
         ring1="Globidonta Ring",
         back="Aput Mantle"
     })

     sets.midcast['Elemental Magic'] = {
         head="Ignominy burgeonet +1",
         neck="Stoicheion Medal",
         ear1="Friomisi Earring",
         ear2="Crematio Earring",
         body="Fallen's Cuirass +1",
         hands="Fallen's Finger Gauntlets",
         --legs="Haruspex Slops",
         legs="Ignominy Flanchard +1",
         ring1="Sangoma Ring",
         ring2="Acumen Ring",
         back="Aput Mantle",
         feet="Ignominy Sollerets"
     }
	 
     sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
         --head="Fallen's Burgeonet +1",
         body="Bale Cuirass +2",
         ring1="Beeline Ring",
         ring2="K'ayres Ring",
         back="Repulse Mantle",
         legs="Ignominy Flanchard +1",
         feet="Ejekamal Boots"
     })
     
     sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
         ring2="Excelsis Ring",
     })
     sets.midcast.Aspir = sets.midcast.Drain

     sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
         back="Chuparrosa Mantle",
         feet="Black Sollerets"
     })

     sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
         hands="Bale Gauntlets +2"
     })
     sets.midcast['Absorb-STR'] = sets.midcast.Absorb
     sets.midcast['Absorb-DEX'] = sets.midcast.Absorb
     sets.midcast['Absorb-Attri'] = sets.midcast.Absorb
     sets.midcast['Absorb-Acc'] = sets.midcast.Absorb

     -- Weaponskill sets
     sets.precast.WS = {
         ammo="Fracas Grenade",
         head="Otomi Helm",
         neck="Bale Choker",
         ear1="Brutal Earring",
         ear2="Moonshade Earring",
         body="Fallen's Cuirass +1",
         hands="Mikinaak Gauntlets",
         ring1="Ifrit Ring",
         ring2="Pyrosoul Ring",
         back="Niht Mantle",
         waist="Windbuffet Belt +1",
         legs="Ignominy Flanchard +1",
         feet="Fallen's Sollerets +1"
     }
     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
         head="Yaoyotl Helm",
         body="Fallen's Cuirass +1",
         feet="Ejekamal Boots"
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
         ring1="Mars's Ring"
     })
 
     -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
     sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {neck="Shadow Gorget"})
     sets.precast.WS['Catastrophe'].Mid = set_combine(sets.precast.WS['Catastrophe'], {waist="Soil Belt"})
     sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS.Acc, {neck="Shadow Gorget", waist="Soil Belt"})
     -- INT 
     sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {
         head="Otomi Helm",
         neck="Shadow Gorget",
         back="Atheling Mantle",
         legs="Scuffler's Cosciales",
         waist="Soil Belt",
         feet="Ejekamal Boots"
     })
     sets.precast.WS['Entropy'].Mid = set_combine(sets.precast.WS['Entropy'], { 
         body="Fallen's Cuirass +1",
         back="Niht Mantle"
     })
     sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'].Mid, { })

     sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
         head="Ignominy burgeonet +1",
         neck="Stoicheion Medal",
         ear1="Friomisi Earring",
         ear2="Crematio Earring",
         body="Fallen's Cuirass +1",
         hands="Fallen's Finger Gauntlets",
         --legs="Haruspex Slops",
         legs="Ignominy Flanchard +1",
         ring2="Acumen Ring",
         back="Toro Cape",
         feet="Ignominy Sollerets"
     })

     sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
         head="Ighwa Cap",
         neck="Shadow Gorget",
         hands="Umuthi Gloves",
         back="Atheling Mantle",
         waist="Soil Belt",
         feet="Whirlpool Greaves"
     })
 
     sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
         neck="Breeze Gorget",
         back="Niht Mantle",
         waist="Soil Belt"
     })
     sets.precast.WS['Resolution'].Mid = set_combine(sets.precast.WS['Resolution'], {
         head="Yaoyotl Helm",
         body="Fallen's Cuirass +1",
         hands="Ignominy Gauntlets +1",
         feet="Ejekamal Boots"
     })
     sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Mid, {
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
         ring1="Mars's Ring"
     })
     sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
         body="Phorcys Korazin",
         neck="Aqua Gorget",
         hands="Ignominy Gauntlets +1",
         legs="Scuffler's Cosciales",
         waist="Caudata Belt"
     })
     sets.precast.WS['Torcleaver'].Mid = set_combine(sets.precast.WS.Mid, {
         neck="Aqua Gorget",
         body="Fallen's Cuirass +1",
     })
     -- 60% STR / 60% MND
     sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
         hands="Ignominy Gauntlets +1",
         neck="Aqua Gorget",
         legs="Scuffler's Cosciales",
         waist="Metalsinger belt"
      })
     sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS.Mid, {
         hands="Ignominy Gauntlets +1",
         neck="Aqua Gorget",
         body="Fallen's Cuirass +1",
         waist="Metalsinger belt",
         back="Niht Mantle"
     })
     -- STR / MND 
     sets.precast.WS.Quietus = set_combine(sets.precast.WS, {
         head="Ighwa Cap",
         neck="Shadow Gorget",
         hands="Ignominy Gauntlets +1"
     })
     sets.precast.WS.Quietus.Mid = set_combine(sets.precast.WS.Quietus, {
         body="Fallen's Cuirass +1"
     })
     -- 50% STR / 50% INT 
     sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS['Entropy'], {
         head="Ighwa Cap",
         body="Phorcys Korazin",
         neck="Aqua Gorget",
         legs="Scuffler's Cosciales",
         waist="Metalsinger belt",
      })
     sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
         head="Ignominy burgeonet +1",
         neck="Aqua Gorget",
         ear1="Friomisi Earring",
         hands="Fallen's Finger Gauntlets",
         waist="Windbuffet Belt +1",
         back="Toro Cape",
         feet="Ignominy Sollerets"
      })
     -- Sets to return to when not performing an action.
     
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
         head="Ignominy burgeonet +1",
         neck="Agitator's Collar",
         ear1="Brutal Earring",
         ear2="Trux Earring",
    	 body="Mes'yohi Haubergeon",
         hands="Ignominy Gauntlets +1",
         ring1="Rajas Ring",
         ring2="K'ayres Ring",
         back="Niht Mantle",
         waist="Windbuffet Belt +1",
         legs="Crimson Cuisses",
         feet="Fallen's Sollerets +1"
     }
     
     sets.idle.Field = set_combine(sets.idle.Town, {
         head="Otomi Helm",
         neck="Bale Choker",
         body="Ares' Cuirass +1",
         hands="Cizin Mufflers +1",
         ring1="Dark Ring",
         ring2="Paguroidea Ring",
         back="Repulse Mantle",
         legs="Crimson Cuisses",
         feet="Fallen's Sollerets +1"
     })
     sets.idle.Regen = set_combine(sets.idle.Field, {
         head="Twilight Helm",
         body="Kumarbi's Akar"
     })
 
     sets.idle.Weak = {
         head="Twilight Helm",
         neck="Bale Choker",
         body="Twilight Mail",
         ring1="Dark Ring",
         ring2="Paguroidea Ring",
         back="Atheling Mantle",
         waist="Windbuffet Belt +1",
         legs="Crimson Cuisses",
         feet="Fallen's Sollerets +1"
     }

     sets.refresh = { 
         neck="Bale Choker",
         body="Ares' Cuirass +1"
     }
     
     -- Defense sets
     sets.defense.PDT = {
         head="Ighwa Cap",
         neck="Agitator's Collar",
         body="Cizin Mail +1",
         hands="Cizin Mufflers +1",
         back="Repulse Mantle",
         ring1="Dark Ring",
         ring2="Patricius Ring",
         legs="Cizin Breeches +1",
         feet="Cizin Greaves +1"
     }
     sets.defense.Reraise = sets.idle.Weak
 
     sets.defense.MDT = set_combine(sets.defense.PDT, {
         neck="Twilight Torque",
         ring2="K'ayres Ring"
     })
 
     sets.Kiting = {legs="Crimson Cuisses"}
 
     sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
     
     -- Defensive sets to combine with various weapon-specific sets below
     -- These allow hybrid acc/pdt sets for difficult content
     sets.Defensive = {
         head="Ighwa Cap",
         neck="Agitator's Collar",
         hands="Cizin Mufflers +1",
         ring2="Patricius Ring",
         legs="Cizin Breeches +1"
     }
     sets.Defensive_Mid = {
         head="Ighwa Cap",
         neck="Agitator's Collar",
         body="Cizin Mail +1",
         hands="Cizin Mufflers +1",
         ring2="Patricius Ring",
         legs="Cizin Breeches +1"
     }
     sets.Defensive_Acc = {
         head="Ighwa Cap",
         neck="Agitator's Collar",
         hands="Umuthi Gloves",
    	 body="Mes'yohi Haubergeon",
         ring1="Ramuh Ring +1",
         ring2="Patricius Ring",
         legs="Cizin Breeches +1",
         feet="Cizin Greaves +1"
     }
 
     -- Engaged set 
     -- Crobaci +2 = needs 35 STP TP &  24 STP in WS
     sets.engaged = {
         --sub="Bloodrain Strap",
         ammo="Ginsen",
     	 head="Otomi Helm",
         neck="Asperity Necklace", 
         ear1="Brutal Earring",
         ear2="Tripudio Earring",
     	 body="Xaddi Mail",
         hands="Cizin Mufflers +1",
         ring1="Rajas Ring",
         ring2="K'ayres Ring",
     	 back="Atheling Mantle",
         waist="Windbuffet Belt +1",
         legs="Xaddi Cuisses",
         feet="Ejekamal Boots"
     }
     sets.engaged.Mid = set_combine(sets.engaged, {
    	 body="Mes'yohi Haubergeon",
         hands="Xaddi Gauntlets",
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
     })

     sets.engaged.Acc = set_combine(sets.engaged.Mid, {
         neck="Iqabi Necklace",
         ear1="Zennaroi Earring",
         ear2="Steelflash Earring",
         ring1="Mars's Ring",
         ring2="Ramuh Ring +1",
         waist="Olseni Belt",
     })
     sets.engaged.PDT = set_combine(sets.engaged, sets.Defensive)
     sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.Defensive_Mid)
     sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.Defensive_Acc)
     
     -- lower delay greatswords
     sets.engaged.LDGS = set_combine(sets.engaged, {
         head="Yaoyotl Helm",
         feet="Mikinaak Greaves"
     })
     sets.engaged.LDGS.Mid = set_combine(sets.engaged.LDGS, {
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
         body="Mes'yohi Haubergeon"
     })
     sets.engaged.LDGS.Acc = sets.engaged.Acc
     sets.engaged.LDGS.PDT = set_combine(sets.engaged.LDGS, sets.Defensive)
     sets.engaged.LDGS.Mid.PDT = set_combine(sets.engaged.LDGS.Mid, sets.Defensive_Mid)
     sets.engaged.LDGS.Acc.PDT = sets.engaged.Acc.PDT

     -- GS war sub 
     sets.engaged.War = set_combine(sets.engaged, {
         ear1="Brutal Earring",
         ear2="Tripudio Earring",
         head="Otomi Helm",
         legs="Xaddi Cuisses"
     })
     sets.engaged.War.Mid = set_combine(sets.engaged.War, {
         ammo="Ginsen",
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
         ring2="Ramuh Ring +1",
         waist="Olseni Belt"
     })
     sets.engaged.War.PDT = set_combine(sets.engaged.War, sets.Defensive)
     sets.engaged.War.Mid.PDT = set_combine(sets.engaged.War.Mid, sets.Defensive_Mid)
     sets.engaged.War.Acc.PDT = set_combine(sets.engaged.War.Acc, sets.Defensive_Acc)

     -- Scythe 
     sets.engaged.Scythe = set_combine(sets.engaged, {
         --sub="Pole Grip",
         ammo="Ginsen",
    	 body="Xaddi Mail",
         hands="Cizin Mufflers +1",
         legs="Xaddi Cuisses",
         feet="Ejekamal Boots"
     })
     sets.engaged.Scythe.Mid = set_combine(sets.engaged.Scythe, {
    	 body="Mes'yohi Haubergeon",
         hands="Xaddi Gauntlets",
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
     })
     sets.engaged.Scythe.Acc = set_combine(sets.engaged.Scythe.Mid, { 
         neck="Iqabi Necklace",
         ring1="Mars's Ring",
         ring2="Patricius Ring",
         waist="Olseni Belt"
     })

     sets.engaged.Scythe.PDT = set_combine(sets.engaged.Scythe, sets.Defensive)
     sets.engaged.Scythe.Mid.PDT = set_combine(sets.engaged.Scythe.Mid, sets.Defensive_Mid)
     sets.engaged.Scythe.Acc.PDT = set_combine(sets.engaged.Scythe.Acc, sets.Defensive_Acc)
     
     -- Scythe war sub (aim for 40 stp)
     sets.engaged.War.Scythe = {
         --sub="Bloodrain Strap",
         ammo="Ginsen",
     	 head="Otomi Helm",
         neck="Asperity Necklace", 
         ear1="Brutal Earring",
         ear2="Tripudio Earring",
     	 body="Xaddi Mail",
         hands="Cizin Mufflers +1",
         ring1="Rajas Ring",
         ring2="K'ayres Ring",
     	 back="Atheling Mantle",
         waist="Windbuffet Belt +1",
         legs="Xaddi Cuisses",
         feet="Mikinaak Greaves"
     }
     sets.engaged.War.Scythe.Mid = set_combine(sets.engaged.War.Scythe, {
         head="Yaoyotl Helm",
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
    	 body="Mes'yohi Haubergeon",
         feet="Ejekamal Boots"
     })
     sets.engaged.War.Scythe.Acc = set_combine(sets.engaged.War.Scythe.Mid, {
         neck="Iqabi Necklace",
         hands="Buremte Gloves",
    	 body="Mes'yohi Haubergeon",
         ring1="Mars's Ring",
         ring2="Ramuh Ring +1",
         waist="Olseni Belt",
     })
     sets.engaged.War.Scythe.PDT = set_combine(sets.engaged.War.Scythe, sets.Defensive)
     sets.engaged.War.Scythe.Mid.PDT = set_combine(sets.engaged.War.Scythe.Mid, sets.Defensive_Mid)
     sets.engaged.War.Scythe.Acc.PDT = set_combine(sets.engaged.War.Scythe.Acc, sets.Defensive_Acc)


     sets.engaged.Reraise = set_combine(sets.engaged, {
     	head="Twilight Helm",neck="Twilight Torque",
     	body="Twilight Mail"
     })

     sets.engaged.HighHaste = set_combine(sets.engaged, {
         head="Otomi Helm",
         waist="Windbuffet Belt +1",
     })

     sets.engaged.MaxHaste = sets.engaged.HighHaste
     sets.engaged.EmbravaHaste = sets.engaged.HighHaste

     sets.buff['Last Resort'] = {
         feet="Fallen's Sollerets +1"
     }

     sets.buff.Souleater = { head="Ignominy burgeonet +1" }
end
