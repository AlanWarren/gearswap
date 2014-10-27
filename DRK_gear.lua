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
         waist="Caudata Belt"
         ring1="Perception Ring",
         ring2="Sangoma Ring",
         back="Niht Mantle",
         legs="Bale Flanchard +2",
         feet="Ignominy sollerets"
     }
     
	 sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
         head="Otomi Helm",
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
         ring1="Sangoma Ring",
         ring2="Acumen Ring",
         --legs="Haruspex Slops",
         legs="Ignominy Flanchard +1",
         back="Aput Mantle",
         feet="Ignominy Sollerets"
     }
	 
     sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
         ammo="Impatiens",
         head="Gavialis Helm",
         body="Bale Cuirass +2",
         ring1="Beeline Ring",
         ring2="K'ayres Ring",
         back="Trepidity Mantle",
         legs="Ignominy Flanchard +1",
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
     sets.midcast['Absorb-AGI'] = sets.midcast.Absorb
     sets.midcast['Absorb-MND'] = sets.midcast.Absorb
     sets.midcast['Absorb-VIT'] = sets.midcast.Absorb
     sets.midcast['Absorb-Attri'] = sets.midcast.Absorb
     sets.midcast['Absorb-Acc'] = sets.midcast.Absorb

     -- WEAPONSKILL SETS
     -- General sets
     sets.precast.WS = {
         ammo="Fracas Grenade",
         head="Otomi Helm",
         neck="Bale Choker",
         ear1="Brutal Earring",
         ear2="Moonshade Earring",
         body="Fallen's Cuirass +1",
         hands="Mikinaak Gauntlets",
         ring1="Pyrosoul Ring",
         ring2="Ifrit Ring",
         back="Niht Mantle",
         waist="Windbuffet Belt +1",
         legs="Ignominy Flanchard +1",
         feet="Fallen's Sollerets +1"
     }
     sets.precast.WS.Mid = set_combine(sets.precast.WS, {
         ammo="Ginsen",
         head="Yaoyotl Helm",
         hands="Ignominy Gauntlets +1",
         ring1="Rajas Ring",
         feet="Whirlpool Greaves"
     })
     sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
         ear1="Zennaroi Earring",
         ring1="Mars's Ring",
         waist="Olseni Belt"
     })
 
     -- RESOLUTION
     -- 86-100% STR
     sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
         neck="Breeze Gorget",
         back="Niht Mantle",
         waist="Soil Belt"
     })
     sets.precast.WS.Resolution.Mid = set_combine(sets.precast.WS.Resolution, {
         ammo="Ginsen",
         head="Yaoyotl Helm",
    	 body="Mes'yohi Haubergeon",
         hands="Ignominy Gauntlets +1",
         ring1="Rajas Ring",
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
         ring1="Rajas Ring",
         waist="Windbuffet Belt +1",
         legs="Scuffler's Cosciales",
         legs="Ejekamal Boots",
     })
     sets.precast.WS.Insurgency.Mid = set_combine(sets.precast.WS.Insurgency, {
         head="Yaoyotl Helm",
         hands="Ignominy Gauntlets +1",
         waist="Caudata Belt",
         feet="Whirlpool Greaves"
     })
     sets.precast.WS.Insurgency.Acc = set_combine(sets.precast.WS.Insurgency.Mid, sets.precast.WS.Acc, {waist="Light Belt"})

     -- CROSS REAPER
     -- 60% STR / 60% MND
     sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {
         hands="Ignominy Gauntlets +1",
         neck="Aqua Gorget",
         waist="Windbuffet belt +1",
         legs="Scuffler's Cosciales",
         feet="Ejekamal Boots"
     })
     sets.precast.WS['Cross Reaper'].Mid = set_combine(sets.precast.WS.Mid, {
         neck="Aqua Gorget",
         waist="Metalsinger Belt",
     })
     sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'].Mid, sets.precast.WS.Acc)
     
     -- ENTROPY
     -- 86-100% INT 
     sets.precast.WS.Entropy = set_combine(sets.precast.WS, {
         head="Otomi Helm",
         neck="Shadow Gorget",
         back="Niht Mantle",
         legs="Scuffler's Cosciales",
         waist="Soil Belt",
         feet="Ejekamal Boots"
     })
     sets.precast.WS.Entropy.Mid = set_combine(sets.precast.WS.Entropy, { 
         head="Yaoyotl Helm",
         legs="Ignominy Flanchard +1",
         feet="Whirlpool Greaves"
     })
     sets.precast.WS.Entropy.Acc = set_combine(sets.precast.WS.Entropy.Mid, sets.precast.WS.Acc)

     -- Quietus
     -- 60% STR / MND 
     sets.precast.WS.Quietus = set_combine(sets.precast.WS, {
         neck="Shadow Gorget",
         ear2="Trux Earring",
         hands="Ignominy Gauntlets +1",
         ring1="Rajas Ring",
         waist="Windbuffet Belt +1",
         feet="Ejekamal Boots"
     })
     sets.precast.WS.Quietus.Mid = set_combine(sets.precast.WS.Quietus, {
         waist="Caudata Belt",
         feet="Whirlpool Greaves"
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
         ear1="Friomisi Earring",
         hands="Fallen's Finger Gauntlets",
         waist="Caudata Belt",
         back="Argochampsa Mantle",
         feet="Ignominy Sollerets"
      })
     sets.precast.WS['Shadow of Death'].Mid = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Mid)
     sets.precast.WS['Shadow of Death'].Acc = set_combine(sets.precast.WS['Shadow of Death'], sets.precast.WS.Acc)

     -- CATASTROPHY
     sets.precast.WS.Catastrophe = set_combine(sets.precast.WS, {neck="Shadow Gorget"})
     sets.precast.WS.Catastrophe.Mid = set_combine(sets.precast.WS.Catastrophe, {waist="Soil Belt"})
     sets.precast.WS.Catastrophe.Acc = set_combine(sets.precast.WS.Acc, {neck="Shadow Gorget", waist="Soil Belt"})

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
         back="Atheling Mantle",
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
         head="Ignominy burgeonet +1",
         neck="Agitator's Collar",
         ear1="Brutal Earring",
         ear2="Trux Earring",
    	 body="Mes'yohi Haubergeon",
         hands="Ignominy Gauntlets +1",
         ring1="Ramuh Ring +1",
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
         ear2="Trux Earring",
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
         head="Yaoyotl Helm",
         ear1="Zennaroi Earring",
         ear2="Steelflash Earring",
    	 body="Mes'yohi Haubergeon",
         back="Niht Mantle",
         hands="Xaddi Gauntlets",
         ring2="Ramuh Ring +1"
     })
     sets.engaged.Acc = set_combine(sets.engaged.Mid, {
         neck="Iqabi Necklace",
         ring1="Mars's Ring",
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
         ammo="Ginsen",
         head="Otomi Helm",
         neck="Asperity Necklace",
         ear1="Brutal Earring",
         ear2="Trux Earring",
    	 body="Xaddi Mail",
         hands="Xaddi Gauntlets",
         ring1="Rajas Ring",
         ring2="K'ayres Ring",
         back="Atheling Mantle",
         waist="Windbuffet Belt +1",
         legs="Cizin Breeches +1",
         feet="Ejekamal Boots"
     })
     sets.engaged.Scythe.Mid = set_combine(sets.engaged.Scythe, {
         head="Yaoyotl Helm",
         ear2="Zennaroi Earring",
    	 body="Mes'yohi Haubergeon",
         ring2="Ramuh Ring +1",
         legs="Xaddi Cuisses"
     })
     sets.engaged.Scythe.Acc = set_combine(sets.engaged.Scythe.Mid, { 
         ear1="Steelflash Earring",
         neck="Iqabi Necklace",
         ring1="Mars's Ring",
         waist="Olseni Belt"
     })

     sets.engaged.Scythe.AM3 = set_combine(sets.engaged.Scythe, {
         head="Yaoyotl Helm",
         ear2="Tripudio Earring",
         hands="Cizin Mufflers +1",
         back="Niht Mantle",
         legs="Ares' Flanchard +1",
         feet="Mikinaak Greaves"
     })
     sets.engaged.Scythe.Mid.AM3 = set_combine(sets.engaged.Scythe.AM3, {
         neck="Iqabi Necklace",
         ear1="Zennaroi Earring",
         body="Mes'yohi Haubergeon",
         hands="Xaddi Gauntlets",
         legs="Ares' Flanchard +1",
         feet="Ejekamal Boots"
     })
     sets.engaged.Scythe.Acc.AM3 = set_combine(sets.engaged.Scythe.Mid.AM3, {
         ear2="Steelflash Earring",
         ring2="Ramuh Ring +1",
         waist="Olseni Belt"
     })

     sets.engaged.Scythe.PDT = set_combine(sets.engaged.Scythe, sets.Defensive)
     sets.engaged.Scythe.Mid.PDT = set_combine(sets.engaged.Scythe.Mid, sets.Defensive_Mid)
     sets.engaged.Scythe.Acc.PDT = set_combine(sets.engaged.Scythe.Acc, sets.Defensive_Acc)
     
     -- Scythe war sub (aim for 40 stp)
     sets.engaged.War.Scythe = set_combine(sets.engaged.Scythe, {
         legs="Xaddi Cuisses",
     })
     sets.engaged.War.Scythe.Mid = set_combine(sets.engaged.War.Scythe, {
         head="Yaoyotl Helm",
         ear1="Bladeborn Earring",
         ear2="Steelflash Earring",
    	 body="Mes'yohi Haubergeon"
     })
     sets.engaged.War.Scythe.Acc = set_combine(sets.engaged.War.Scythe.Mid, {
         neck="Iqabi Necklace",
         ear1="Steelflash Earring",
         ear2="Zennaroi Earring",
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

     sets.buff['Last Resort'] = {
         feet="Fallen's Sollerets +1"
     }

     sets.buff.Souleater = { head="Ignominy burgeonet +1" }
end
