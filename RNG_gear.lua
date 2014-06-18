function init_gear_sets()

        -- Misc. Job Ability precasts
        sets.precast.JA['Bounty Shot'] = {hands="Sylvan Glovelettes +2"}
        sets.precast.JA['Double Shot'] = {head="Sylvan Gapette +2"}
        sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
        sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
        sets.precast.JA['Velocity Shot'] = {body="Sylvan Caban +2"}
        sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}

        sets.precast.JA['Eagle Eye Shot'] = {
            head="Uk'uxkaj Cap", 
            neck="Rancor Collar",
            back="Buquwik Cape",
            ring2="Pyrosoul Ring",
            legs="Arcadian Braccae +1", 
            feet="Arcadian Socks +1"
        }
        sets.precast.JA['Eagle Eye Shot'].Mod = set_combine(sets.precast.JA['Eagle Eye Shot'], {
            back="Lutian Cape",
            ring2="Longshot Ring",
            feet="Orion Socks +1"
        })
        sets.precast.JA['Eagle Eye Shot'].Acc = set_combine(sets.precast.JA['Eagle Eye Shot'].Mod, {
            neck="Iqabi Necklace",
            waist="Elanid Belt"
        })

        sets.precast.FC = {
            ring1="Prolix Ring"
        }

        sets.idle = {
            head="Umbani Cap",
            neck="Twilight torque",
            ear1="Volley Earring",
            ear2="Dawn Earring",
            body="Kheper Jacket",
            hands="Iuitl Wristbands +1",
            ring1="Dark Ring",
            ring2="Paguroidea Ring",
            back="Shadow Mantle",
            waist="Elanid Belt",
            legs="Arcadian Braccae +1",
            feet="Orion Socks +1"
        }

        sets.idle.Town = set_combine(sets.idle, {
            neck="Ocachi Gorget",
            ear1="Fenrir's Earring",
            ear2="Dawn Earring",
            ring1="Rajas Ring",
            ring2="Pyrosoul Ring",
            back="Lutian Cape"
        })
 
        -- Engaged sets
        sets.engaged =  {
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Volley Earring",
            ear2="Tripudio Earring",
            body="Kyujutsugi",
            hands="Sigyn's Bazubands",
            ring1="Rajas Ring",
            ring2="Paguroidea Ring",
            back="Shadow Mantle",
            waist="Elanid Belt",
            legs="Nahtirah Trousers",
            feet="Orion Socks +1"
        }

        sets.engaged.Bow = set_combine(sets.engaged, {
            hands="Arcadian Bracers +1",
            feet="Arcadian Socks +1"
        })

        sets.engaged.Melee = {
            head="Whirlpool Mask",
            neck="Rancor Collar",
            ear1="Bladeborn Earring",
            ear2="Steelflash Earring",
            body="Thaumas Coat",
            hands="Iuitl Wristbands +1",
            ring1="Rajas Ring",
            ring2="Epona's Ring",
            back="Atheling Mantle",
            waist="Cetl Belt",
            legs="Manibozho Brais",
            feet="Manibozho Boots"
        }

        -- Snapshot 
        sets.precast.RA = {
            head="Sylvan Gapette +2",
            body="Sylvan Caban +2",
            hands="Iuitl Wristbands +1",
            legs="Nahtirah Trousers",
            waist="Impulse Belt",
            feet="Wurrukatte Boots"
        }

        -- Gun Default : (822 total delay)
        -- STP: 42 ~ (2/4 recycle proc required)
        -- Racc: 251.75
        -- Ratk: 209
        -- AGI: 141
        -- STR: 100
        sets.midcast.RA = { 
            -- main="Hurlbat",
            -- sub="Legion Scutum", 
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Volley Earring", 
            ear2="Tripudio Earring", 
            body="Kyujutsugi",
            hands="Sigyn's Bazubands",
            ring1="Rajas Ring",
            ring2="Pyrosoul Ring",
            back="Sylvan Chlamys",
            waist="Elanid Belt",
            legs="Nahtirah Trousers",
            feet="Orion Socks +1"
        }

        -- Gun Mod 
        -- STP: 31 ~ 86.8 TP after 4 hits (3/4 recycle required)
        -- Racc: 287.25
        -- Ratk: 206.25
        -- AGI: 151
        -- STR: 91
        sets.midcast.RA.Mod = set_combine(sets.midcast.RA, {
            hands="Seiryu's Kote",
            ring2="Longshot Ring",
            back="Lutian Cape",
            waist="Elanid Belt",
        })

        -- Gun Acc 
        -- STP: 21 ~ 80 TP after 4 hits (4/4 recycle required)
        -- Racc: 316.25
        -- Ratk: 177.75
        -- AGI: 151
        -- STR: 86
        sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Mod, {
            neck="Iqabi Necklace",
            ring1="Hajduk Ring",
            legs="Arcadian Braccae +1"
        })

        -- Stave + Strap set for Gun (stats are approx since we swap stuff)
        -- STP: 41 ~ (2/4 recycle in adoulin 3/4 out)
        -- Racc: 225.75
        -- Ratk: 255.75 day / 262 at night
        -- AGI: 129
        -- STR: 107 day / 104 night
        sets.midcast.RA.Gun2H = set_combine(sets.midcast.RA, {
            --main="Mekki Shakki",
            --sub="Bloodrain Strap",
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Volley Earring",
            ear2="Tripudio Earring", 
            body="Sylvan Caban +2",
            hands="Sigyn's Bazubands",
            ring1="Rajas Ring",
            ring2="Pyrosoul Ring",
            back="Lutian Cape",
            waist="Elanid Belt",
            legs="Nahtirah Trousers",
            feet="Orion Socks +1"
        })

        -- STP: 38 ~ 91.6 TP after 4 hits (2/4 recycle required)
        -- Racc: 269
        -- Ratk: 229
        -- AGI: 134
        -- STR: 104
        sets.midcast.RA.Mod.Gun2H = set_combine(sets.midcast.RA.Gun2H, {
            body="Kyujutsugi",
            legs="Aetosaur Trousers +1",
            ring2="Longshot Ring",
            back="Lutian Cape"
        })

        -- STP: 32 ~ 87.6 TP after 4 hits (3/4 recycle required)
        -- Racc: 295.25
        -- Ratk: 176.5
        -- AGI: 141
        -- STR: 91
        sets.midcast.RA.Acc.Gun2H = set_combine(sets.midcast.RA.Mod.Gun2H, {
            hands="Seiryu's Kote",
            neck="Iqabi Necklace",
            ring1="Hajduk Ring"
        })

        -- XXX:SAM SJ - Experimental (gun only)
        sets.midcast.RA.SAM = {
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Volley Earring", 
            ear2="Tripudio Earring", 
            body="Kyujutsugi",
            ring1="Rajas Ring", 
            ring2="K'ayres Ring",
            back="Sylvan Chlamys",
            waist="Patentia Sash",
            legs="Sylvan Bragues +2"
        }
        sets.midcast.RA.Mod.SAM = set_combine(sets.midcast.RA.Mod, sets.midcast.RA.SAM)
        sets.midcast.RA.Acc.SAM = set_combine(sets.midcast.RA.Acc, sets.midcast.RA.SAM)

        -- This is a 3-hit build with 3 out of 3 recycle procs and /sam sub. 
        -- It's used automatically by having /sam and gear.Stave equipped.
        -- STP: 57 for TP and 55 for WS 
        -- Racc: 200.5
        -- Ratk: 201.5 
        -- AGI: 110
        -- STR: 81 
        sets.midcast.RA.SAM2H = {
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Volley Earring", 
            ear2="Tripudio Earring", 
            body="Kyujutsugi",
            hands="Sigyn's Bazubands",
            ring1="Rajas Ring", 
            ring2="K'ayres Ring",
            back="Sylvan Chlamys",
            waist="Patentia Sash",
            legs="Sylvan Bragues +2",
            feet="Orion Socks +1"
        }
        sets.midcast.RA.Mod.SAM2H = set_combine(sets.midcast.RA.SAM2H, {
            waist="Elanid Belt",
            legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.Acc.SAM2H = set_combine(sets.midcast.RA.Mod.SAM2H, {
            ring1="Longshot Ring",
            ring2="Paqichikaji Ring",
            back="Lutian Cape"
        })

        sets.midcast.RA.Bow = {
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Novia Earring", 
            ear2="Tripudio Earring",
            body="Kyujutsugi",
            hands="Iuitl Wristbands +1",
            ring1="Rajas Ring",
            ring2="K'ayres Ring",
            back="Sylvan Chlamys",
            waist="Elanid Belt", 
            legs="Arcadian Braccae +1",
            feet="Arcadian Socks +1"
        }
        sets.midcast.RA.Mod.Bow = set_combine(sets.midcast.RA.Bow, {
            ear1="Volley Earring",
            hands="Sylvan Glovelettes +2",
            legs="Nahtirah Trousers",
            back="Lutian Cape",
            feet="Orion Socks +1"
        })

        -- High accuracy set
        sets.midcast.RA.Acc.Bow = set_combine(sets.midcast.RA.Bow, {
            hands="Seiryu's Kote", 
            ring1="Hajduk Ring",
            legs="Arcadian Braccae +1",
            back="Lutian Cape", 
            feet="Orion Socks +1"
        })

        -- 1 handed weapon set for Bow. (Hurlbat, etc.)
        sets.midcast.RA.Bow1H = set_combine(sets.midcast.RA.Bow, {
            hands="Sylvan Glovelettes +2"
        })
        -- Mod toggle for 1-handed wpn. with Bow.
        sets.midcast.RA.Mod.Bow1H = set_combine(sets.midcast.RA.Bow1H, {
            ear1="Volley Earring",
            feet="Orion Socks +1"
        })
        sets.midcast.RA.Acc.Bow1H = sets.midcast.RA.Acc.Bow

        -- This set will activate when using Bow, and Decoy Shot is ON
        -- STP: 45 
        -- Racc: 225
        -- Ratk: 253.25 
        -- AGI: 128 
        -- STR: 111 
        sets.midcast.RA.Decoy = set_combine(sets.midcast.RA.Bow, {
            ear1="Volley Earring",
            hands="Sylvan Glovelettes +2",
            legs="Aetosaur Trousers +1",
            waist="Elanid Belt",
            feet="Orion Socks +1"
        })
        sets.midcast.RA.Mod.Decoy = set_combine(sets.midcast.RA.Decoy, {
            legs=gear.samrolllegs
        })
        -- 1-handed weapon set used when decoy shot is ON
        sets.midcast.RA.Decoy1H = set_combine(sets.midcast.RA.Decoy, {
            back="Sylvan Chlamys",
            legs=gear.samrolllegs
        })
        sets.midcast.RA.Mod.Decoy1H = sets.midcast.RA.Mod.Bow1H
        -- High Accuracy set
        sets.midcast.RA.Acc.Decoy = set_combine(sets.midcast.RA.Decoy, {
            neck="Iqabi Necklace",
            ring1="Hajduk Ring",
            legs="Aetosaur Trousers +1",
            feet="Orion Socks +1"
        })
        sets.midcast.RA.Acc.Decoy1H = sets.midcast.RA.Acc.Decoy

        -- Weaponskill sets  
        sets.precast.WS = {
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Flame Pearl",
            ear2="Flame Pearl",
            body="Kyujutsugi",
            hands="Arcadian Bracers +1",
            ring1="Rajas Ring",
            ring2="Pyrosoul Ring",
            back="Buquwik Cape",
            waist="Elanid Belt",
            legs="Nahtirah Trousers",
            feet="Arcadian Socks +1"
        }
        sets.precast.WS.Mod = set_combine(sets.precast.WS, {
            legs="Aetosaur Trousers +1",
            feet="Orion Socks +1"
        })
        sets.precast.WS.Acc = set_combine(sets.precast.WS.Mod, {
            hands="Sigyn's Bazubands",
            back="Lutian Cape"
        })

        -- WILDFIRE
        sets.Wildfire = {
            head="Umbani Cap",
            body="Orion Jerkin +1",
            ear1="Crematio Earring",
            ear2="Friomisi Earring",
            neck="Stoicheion Medal",
            ring1="Acumen Ring",
            ring2="Stormsoul Ring",
            waist="Aquiline Belt",
            legs="Shneddick Tights +1",
            back="Toro Cape",
            feet="Arcadian Socks +1"
        }
        sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, sets.Wildfire)
        sets.precast.WS['Wildfire'].Mod = set_combine(sets.precast.WS.Mod, sets.Wildfire)
        sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Acc, sets.Wildfire)

        -- CORONACH
        sets.Coronach = {
           neck="Breeze Gorget",
           waist="Thunder Belt",
           ear1="Dawn Earring"
        }
        sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, sets.Coronach)
        sets.precast.WS['Coronach'].Mod = set_combine(sets.precast.WS.Mod, sets.Coronach)
        sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS.Acc, sets.Coronach)

        sets.precast.WS['Coronach'].SAM = set_combine(sets.precast.WS, {
            neck="Ocachi Gorget",
            ear1="Volley Earring",
            ear2="Tripudio Earring",
            hands="Sylvan Glovelettes +2",
            ring2="K'ayres Ring",
            legs="Aetosaur Trousers +1"
        })
        sets.precast.WS['Coronach'].SAM2H = sets.precast.WS['Coronach'].SAM

        -- LAST STAND
        sets.LastStand = {
           neck="Aqua Gorget",
           ring2="Stormsoul Ring",
           waist="Light Belt",
           legs="Arcadian Braccae +1",
           feet="Orion Socks +1"
        }
        sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, sets.LastStand)
        sets.precast.WS['Last Stand'].Mod = set_combine(sets.precast.WS.Mod, sets.LastStand)
        sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS.Acc, sets.LastStand)
        
        -- DETONATOR
        sets.Detonator = {
           neck="Flame Gorget",
           waist="Light Belt",
           feet="Arcadian Socks +1"
        }
        sets.precast.WS['Detonator'] = set_combine(sets.precast.WS, sets.Detonator)
        sets.precast.WS['Detonator'].Mod = set_combine(sets.precast.WS.Mod, sets.Detonator)
        sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS.Acc, sets.Detonator)
        
        -- SLUG SHOT
        sets.SlugShot = {
           neck="Breeze Gorget",
           waist="Light Belt",
           feet="Arcadian Socks +1"
        }
        sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS, sets.SlugShot)
        sets.precast.WS['Slug Shot'].Mod = set_combine(sets.precast.WS.Mod, sets.SlugShot)
        sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS.Acc, sets.SlugShot)
        
        sets.precast.WS['Heavy Shot'] = set_combine(sets.precast.WS, sets.SlugShot)
        sets.precast.WS['Heavy Shot'].Mod = set_combine(sets.precast.WS.Mod, sets.SlugShot)
        sets.precast.WS['Heavy Shot'].Acc = set_combine(sets.precast.WS.Acc, sets.SlugShot)

        -- NAMAS
        sets.Namas = {
            neck="Aqua Gorget",
            waist="Light Belt",
            hands="Arcadian Bracers +1", -- override since we don't want sigyns in Mod or Acc
            back="Sylvan Chlamys",
            feet="Arcadian Socks +1"
        }
        sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, sets.Namas)
        sets.precast.WS['Namas Arrow'].Mod = set_combine(sets.precast.WS.Mod, sets.Namas)
        sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS.Acc, sets.Namas)

        -- JISHNUS
        sets.Jishnus = {
            neck="Flame Gorget",
            ear2="Dawn Earring",
            waist="Light Belt",
            hands="Arcadian Bracers +1", -- override 
            legs="Arcadian Braccae +1",
            ring2="Thundersoul Ring",
            back="Rancorous Mantle"
        }
        sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, sets.Jishnus)
        sets.precast.WS['Jishnu\'s Radiance'].Mod = set_combine(sets.precast.WS.Mod, sets.Jishnus)
        sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS.Acc, sets.Jishnus)

        -- SIDEWINDER
        sets.Sidewinder = {
            neck="Aqua Gorget",
            waist="Light Belt",
            hands="Arcadian Bracers +1",
            back="Buquwik Cape",
            feet="Arcadian Socks +1"
        }
        sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS, sets.Sidewinder)
        sets.precast.WS['Sidewinder'].Mod = set_combine(sets.precast.WS.Mod, sets.Sidewinder)
        sets.precast.WS['Sidewinder'].Acc = set_combine(sets.precast.WS.Acc, sets.Sidewinder)

        sets.precast.WS['Refulgent Arrow'] = sets.precast.WS['Sidewinder']
        sets.precast.WS['Refulgent Arrow'].Mod = sets.precast.WS['Sidewinder'].Mod
        sets.precast.WS['Refulgent Arrow'].Acc = sets.precast.WS['Sidewinder'].Acc
       
        -- Resting sets
        sets.resting = {}
       
        -- Defense sets
        sets.defense.PDT = set_combine(sets.idle, {})
        sets.defense.MDT = set_combine(sets.idle, {})
        --sets.Kiting = {feet="Fajin Boots"}
       
        sets.buff.Barrage = {
            head="Ux'uxkaj Cap",
            neck="Rancor Collar",
            ear1="Volley Earring",
            ear2="Clearview Earring",
            body="Orion Jerkin +1",
            hands="Orion Bracers +1",
            ring1="Paqichikaji Ring",
            ring2="Longshot Ring",
            back="Lutian Cape",
            waist="Elanid Belt",
            legs="Sylvan Bragues +2",
            feet="Orion Socks +1"
        }

        sets.buff.Camouflage =  {body="Orion Jerkin +1"}

        sets.Overkill =  {
            body="Arcadian Jerkin"
        }

        sets.Overkill.Preshot = set_combine(sets.precast.RA, {
            head="Orion Beret +1",
            feet="Arcadian Socks +1"
        })
end

