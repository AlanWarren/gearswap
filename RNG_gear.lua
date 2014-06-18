function init_gear_sets()
        -- NOTE: Set format is as follows:
        -- sets[phase][type][CustomClass][CombatForm][CombatWeapon][RangedMode][CustomRangedGroup]
        -- ex: sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mod.SamRoll = {}
        -- you can also append CustomRangedGroups to each other
        -- ex: sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mod.Decoy.SamRoll = {}
        
        -- These are the available sets per category
        -- CustomClass = SAM
        -- CombatForm = Stave, DualWield
        -- CombatWeapon = weapon name
        -- RangedMode = Normal, Mod, Acc
        -- CustomRangedGroup = Decoy, SamRoll

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
        
        sets.NightEarring = {ear2="Fenrir's earring"}
        sets.WSEarring = {ear2="Flame Pearl"}
        sets.DayEarring = {ear2="Volley Earring"}

        sets.wsearring = select_wsearring()
        sets.earring = select_earring()

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
            neck="Asperity Necklace",
            ear1="Bladeborn Earring",
            ear2="Steelflash Earring",
            body="Qaaxo Harness",
            hands="Iuitl Wristbands +1",
            ring1="Patricius Ring",
            ring2="Epona's Ring",
            back="Atheling Mantle",
            waist="Cetl Belt",
            legs="Manibozho Brais",
            feet="Qaaxo Leggings"
        }

        sets.engaged.DualWield = set_combine(sets.engaged, {})
        sets.engaged.DualWield.Melee = set_combine(sets.engaged.Melee, {
            head="Whirlpool Mask",
            neck="Asperity Necklace",
            body="Qaaxo Harness",
            ear1="Dudgeon Earring",
            ear2="Heartseeker Earring",
            hands="Iuitl Wristbands +1",
            ring1="Oneiros Ring",
            ring2="Epona's Ring",
            back="Atheling Mantle",
            waist="Patentia Sash",
            legs="Manibozho Brais",
            feet="Qaaxo Leggings"
        })

        ------------------------------------------------------------------
        -- Preshot / Snapshot sets
        ------------------------------------------------------------------
        sets.precast.RA = {
            head="Sylvan Gapette +2",
            body="Sylvan Caban +2",
            hands="Iuitl Wristbands +1",
            legs="Nahtirah Trousers",
            waist="Impulse Belt",
            feet="Wurrukatte Boots"
        }
        
        ------------------------------------------------------------------
        -- Default Base Gear Sets for Ranged Attacks. Geared for Gun
        ------------------------------------------------------------------

        sets.midcast.RA = { 
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Volley Earring", 
            ear2="Tripudio Earring", 
            body="Kyujutsugi",
            hands="Sigyn's Bazubands",
            ring1="Rajas Ring",
            ring2="K'ayres Ring",
            back="Sylvan Chlamys",
            waist="Elanid Belt", 
            legs="Nahtirah Trousers",
            feet="Orion Socks +1"
        }
        sets.midcast.RA.Mod = set_combine(sets.midcast.RA, {
            back="Lutian Cape", legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Mod, {
            neck="Iqabi Necklace", hands="Seiryu's Kote"
            ring1="Hajduk Ring", ring2="Longshot Ring",
            legs="Arcadian Braccae +1"
        })
    
        ------------------------------------------------------------------
        -- Specialized Gear Sets
        ------------------------------------------------------------------

        -- Stave sets 
        sets.midcsat.RA.Stave = set_combine(sets.midcast.RA, {
            body="Sylvan Caban +2",
            back="Lutian Cape",
        })
        sets.midcast.RA.Stave.Mod = set_combine(sets.midcast.RA.Stave, {
            body="Kyujutsugi",
            ring2="Longshot Ring",
            legs="Aetosaur Trousers +1",
        })
        sets.midcast.RA.Stave.Acc = set_combine(sets.midcast.RA.Stave.Mod, {
            hands="Seiryu's Kote",
            neck="Iqabi Necklace",
            ring1="Paqichikaji Ring"
        })
        
        -- Samurai Roll sets 
        sets.midcast.RA.SamRoll = set_combine(sets.midcast.RA, {
            --ear1=fenrir
            body="Sylvan Caban +2",
            ring2="Pyrosoul Ring",
        })
        sets.midcast.RA.Mod.SamRoll = set_combine(sets.midcast.RA.Mod, {
            body="Sylvan Caban +2",
            legs="Nahtirah Trousers"
        })
        sets.midcast.RA.Acc.SamRoll = set_combine(sets.midcast.RA.Acc, {
            hands="Sigyn's Bazubands"
        })

        sets.midcast.RA.Stave.SamRoll = set_combine(sets.midcast.RA.Stave, {
            body="Sylvan Caban +2",
            ring2="Pyrosoul Ring",
            waist="Elanid Belt"
        })
        sets.midcast.RA.Stave.Mod.SamRoll = set_combine(sets.midcast.RA.Stave.Mod, {
            body="Sylvan Caban +2",
            legs="Arcadian Braccae +1"
        })
        sets.midcast.RA.Stave.Acc.SamRoll = set_combine(sets.midcast.RA.Stave.Acc, {})

        -- SAM Subjob
        sets.midcast.RA.SAM = {
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Volley Earring", 
            ear2="Tripudio Earring", 
            body="Kyujutsugi",
            hands="Sylvan Glovelettes +2",
            ring1="Rajas Ring", 
            ring2="K'ayres Ring",
            back="Sylvan Chlamys",
            waist="Patentia Sash",
            legs="Sylvan Bragues +2",
            feet="Orion Socks +1"
        }
        sets.midcast.RA.SAM.Mod = set_combine(sets.midcast.RA.SAM, { 
            hands="Seiryu's Kote",
            legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.SAM.Acc = set_combine(sets.midcast.RA.SAM.Mod, {
            back="Lutian Cape", waist="Elanid Belt", 
            neck="Iqabi Necklace", ring2="Longshot Ring"
        })

        -- Stave set for SAM
        sets.midcast.RA.SAM.Stave = set_combine(sets.midcast.RA.SAM, {
            hands="Sigyn's Bazubands"
        })
        sets.midcast.RA.SAM.Stave.Mod = set_combine(sets.micast.RA.SAM.Mod, {
            hands="Sigyn's Bazubands",
            legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.SAM.Stave.Acc = set_combine(sets.midcast.RA.SAM.Acc, {})
        
        -- Samurai Roll for /sam, assume we're using a staff
        sets.midcast.RA.SAM.Stave.SamRoll = set_combine(sets.midcast.RA.SAM.Stave, {
            hands="Sigyn's Bazubands"
        })
        sets.midcast.RA.SAM.Stave.Mod.SamRoll = set_combine(sets.midcast.RA.SAM.Stave.Mod, {
            ear1="Clearview Earring",
            hands="Sigyn's Bazubands",
            legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.SAM.Stave.Acc.SamRoll = set_combine(sets.midcast.RA.SAM.Stave.Acc, {
            hands="Sigyn's Bazubands",
        })

        -- Bow base set.
        sets.midcast.RA.Yoichinoyumi = {
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Novia Earring",
            ear2="Tripudio Earring",
            body="Kyujutsugi",
            hands="Sylvan Glovelettes +2",
            ring1="Rajas Ring",
            ring2="K'ayres Ring",
            back="Sylvan Chlamys",
            waist="Elanid Belt",
            legs="Arcadian Braccae +1",
            feet="Arcadian Socks +1"
        }
        sets.midcast.RA.Yoichinoyumi.Mod = set_combine(sets.midcast.RA.Yoichinoyumi, {
            ear1="Volley Earring",
            back="Lutian Cape",
            feet="Orion Socks +1",
            legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Yoichinoyumi.Mod, {
            hands="Seiryu's Kote",
            ring1="Longshot Ring",
            ring2="Paqichikaji Ring",
            legs="Arcadian Braccae +1"
        })

        -- Decoy up 
        sets.midcast.RA.Yoichinoyumi.Decoy = set_combine(sets.midcast.RA.Yoichinoyumi, {
            ear1="Volley Earring",
            legs="Nahtirah Trousers"
        })
        sets.midcast.RA.Yoichinoyumi.Mod.Decoy = set_combine(sets.midcast.RA.Yoichinoyumi.Mod, {
            hands="Seiryu's Kote"
        })
        sets.midcast.RA.Yoichinoyumi.Acc.Decoy = set_combine(sets.midcast.RA.Yoichinoyumi.Acc, {})
       
        -- Stave
        sets.midcast.RA.Stave.Yoichinoyumi = set_combine(sets.midcast.RA.Yoichinoyumi, { hands="Iuitl Wristbands +1" })
        sets.midcast.RA.Stave.Yoichinoyumi.Mod = set_combine(sets.midcast.RA.Yoichinoyumi.Mod, { legs="Nahtirah Trousers" })
        sets.midcast.RA.Stave.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Yoichinoyumi.Acc, {})

        -- Stave / Decoy up
        sets.midcast.RA.Stave.Yoichinoyumi.Decoy = set_combine(sets.midcast.RA.Stave.Yoichinoyumi, {
            hands="Sylvan Glovelettes +2",
            ear1="Volley Earring",
            legs="Nahtirah Trousers",
            feet="Orion Socks +1"
        })
        sets.midcast.RA.Stave.Yoichinoyumi.Mod.Decoy = set_combine(sets.midcast.RA.Stave.Yoichinoyumi.Mod, {
            legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.Stave.Yoichinoyumi.Acc.Decoy = set_combine(sets.midcast.RA.Stave.Yoichinoyumi.Acc, {})

        
        -- Sam SJ / Bow - assuming you'll use a Stave here..
        sets.midcast.RA.SAM.Stave.Yoichinoyumi = set_combine(sets.midcast.RA.SAM, {
            feet="Qaaxo Leggings"
        })
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mod = set_combine(sets.midcast.RA.SAM.Mod, {
            feet="Orion Socks +1"
        })
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.SAM.Acc, {})

        -- SAM SJ / Bow / Decoy doesn't matter here
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mod.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mod
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc

        -- Sam SJ / Bow / Sam's Roll
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.SamRoll = set_combine(sets.midcast.RA.SAM.Stave.Yoichinoyumi, {
            waist="Elanid Belt",
            feet="Orion Socks +1"
        })

        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mod.SamRoll = set_combine(sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mod, {
            waist="Elanid Belt",
        })
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc.SamRoll = set_combine(sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc, {})

        -- Don't care about decoy here
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.SamRoll.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi.SamRoll
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mod.SamRoll.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mod.SamRoll
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc.SamRoll.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc.SamRoll


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

