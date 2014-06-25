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
        sets.precast.JA['Eagle Eye Shot'].Mid = set_combine(sets.precast.JA['Eagle Eye Shot'], {
            back="Lutian Cape",
            ring2="Longshot Ring",
            feet="Orion Socks +1"
        })
        sets.precast.JA['Eagle Eye Shot'].Acc = set_combine(sets.precast.JA['Eagle Eye Shot'].Mid, {
            neck="Iqabi Necklace",
            waist="Elanid Belt"
        })

        sets.precast.FC = {
            head="Uk'uxkaj Cap",
            ear1="Loquacious Earring",
            ring1="Prolix Ring"
        }
        
        sets.NightEarring = {ear2="Fenrir's earring"}
        sets.DayEarring = {ear2="Volley Earring"}

        sets.earring = select_earring()

        sets.idle = {
            head="Crimson Mask",
            neck="Twilight Torque",
            ear1="Volley Earring",
            ear2="Dawn Earring",
            body="Kheper Jacket",
            hands="Iuitl Wristbands +1",
            ring1="Dark Ring",
            ring2="Paguroidea Ring",
            back="Repulse Mantle",
            waist="Elanid Belt",
            legs="Arcadian Braccae +1",
            feet="Orion Socks +1"
        }

        sets.idle.Town = set_combine(sets.idle, {
            neck="Ocachi Gorget",
            ear1="Fenrir's Earring",
            ear2="Dawn Earring",
            body="Arcadian Jerkin +1",
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
            body="Arcadian Jerkin +1",
            hands="Iuitl Wristbands +1",
            ring1="Rajas Ring",
            ring2="Paguroidea Ring",
            back="Repulse Mantle",
            waist="Impulse Belt",
            legs="Nahtirah Trousers",
            feet="Orion Socks +1"
        }
        sets.engaged.PDT = set_combine(sets.engaged, {
            neck="Twilight Torque",
            ring1="Dark Ring",
            ring2="Patricius Ring"
        })
        sets.engaged.Yoichinoyumi = set_combine(sets.engaged, {})

        sets.engaged.Melee = {
            head="Whirlpool Mask",
            neck="Asperity Necklace",
            ear1="Bladeborn Earring",
            ear2="Steelflash Earring",
            body="Qaaxo Harness",
            hands="Iuitl Wristbands +1",
            ring1="Oneiros Ring",
            ring2="Epona's Ring",
            back="Atheling Mantle",
            waist="Cetl Belt",
            legs="Manibozho Brais",
            feet="Qaaxo Leggings"
        }
        sets.engaged.Melee.PDT = set_combine(sets.engaged.Melee, {
            neck="Twilight Torque",
            ring1="Dark Ring",
            ring2="Patricius Ring"
        })

        sets.engaged.DualWield = set_combine(sets.engaged, {})
        sets.engaged.DualWield.Melee = set_combine(sets.engaged.Melee, {
            ear1="Dudgeon Earring",
            ear2="Heartseeker Earring",
            waist="Patentia Sash"
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
        sets.midcast.RA.Mid = set_combine(sets.midcast.RA, {
            back="Lutian Cape", legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Mid, {
            neck="Iqabi Necklace", hands="Seiryu's Kote",
            ring1="Hajduk Ring", ring2="Longshot Ring",
            legs="Arcadian Braccae +1"
        })
    
        ------------------------------------------------------------------
        -- Specialized Gear Sets
        ------------------------------------------------------------------

        -- Stave sets 
        
        -- Placeholder for custom earring
        sets.StavePH = set_combine(sets.midcast.RA, {
            body="Arcadian Jerkin +1",
            back="Lutian Cape"
        })
        sets.midcast.RA.Stave = set_combine(sets.StavePH, sets.earring)

        sets.midcast.RA.Stave.Mid = set_combine(sets.midcast.RA.Stave, {
            body="Kyujutsugi",
            ring2="Longshot Ring",
            legs="Aetosaur Trousers +1",
        })
        sets.midcast.RA.Stave.Acc = set_combine(sets.midcast.RA.Stave.Mid, {
            hands="Seiryu's Kote",
            neck="Iqabi Necklace",
            ring1="Paqichikaji Ring"
        })
        
        -- Samurai Roll sets 
        -- Placeholder for custom earring
        sets.SamPH = set_combine(sets.midcast.RA, {
            body="Arcadian Jerkin +1",
            ring2="Pyrosoul Ring",
        })

        sets.midcast.RA.SamRoll = set_combine(sets.midcast.RA, sets.SamPH)

        sets.midcast.RA.Mid.SamRoll = set_combine(sets.midcast.RA.SamRoll, {
            ring2="Longshot Ring",
            back="Lutian Cape",
            legs="Nahtirah Trousers"
        })
        sets.midcast.RA.Acc.SamRoll = set_combine(sets.midcast.RA.Mid.SamRoll, {
            neck="Iqabi Necklace", hands="Sigyn's Bazubands",
            ring1="Hajduk Ring", ring2="Longshot Ring",
            legs="Arcadian Braccae +1"
        })

        sets.midcast.RA.Stave.SamRoll = set_combine(sets.midcast.RA.Stave, {
            body="Arcadian Jerkin +1",
            ring2="Pyrosoul Ring",
            waist="Elanid Belt"
        })
        sets.midcast.RA.Stave.Mid.SamRoll = set_combine(sets.midcast.RA.Stave.Mid, {
            body="Kyujutsugi",
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
            waist="Elanid Belt",
            legs="Aetosaur Trousers +1",
            feet="Orion Socks +1"
        }
        sets.midcast.RA.SAM.Mid = set_combine(sets.midcast.RA.SAM, { 
            hands="Seiryu's Kote",
        })
        sets.midcast.RA.SAM.Acc = set_combine(sets.midcast.RA.SAM.Mid, {
            back="Lutian Cape", 
            neck="Iqabi Necklace", 
            ring2="Longshot Ring"
        })

        -- Stave set for SAM
        sets.midcast.RA.SAM.Stave = set_combine(sets.midcast.RA.SAM, {
            hands="Sigyn's Bazubands"
        })
        sets.midcast.RA.SAM.Stave.Mid = set_combine(sets.midcast.RA.SAM.Mid, {
            hands="Sigyn's Bazubands",
            legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.SAM.Stave.Acc = set_combine(sets.midcast.RA.SAM.Acc, {})
        
        -- Samurai Roll for /sam, assume we're using a staff
        sets.midcast.RA.SAM.Stave.SamRoll = set_combine(sets.midcast.RA.SAM.Stave, {
            hands="Sigyn's Bazubands"
        })
        sets.midcast.RA.SAM.Stave.Mid.SamRoll = set_combine(sets.midcast.RA.SAM.Stave.Mid, {
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
        -- place holder
        sets.YoichiPH = set_combine(sets.midcast.RA.Yoichinoyumi, {
            ear1="Volley Earring",
            back="Lutian Cape",
            feet="Orion Socks +1",
            legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.Yoichinoyumi.Mid = set_combine(sets.YoichiPH, sets.earring)
        sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Yoichinoyumi.Mid, {
            hands="Seiryu's Kote",
            ring1="Longshot Ring",
            ring2="Paqichikaji Ring",
            legs="Arcadian Braccae +1"
        })

        -- Decoy up 
        -- place holder
        sets.YoichiDecoyPH = set_combine(sets.midcast.RA.Yoichinoyumi, {
            ear1="Volley Earring",
            legs="Nahtirah Trousers"
        })
        sets.midcast.RA.Yoichinoyumi.Decoy = set_combine(sets.YoichiDecoyPH, sets.earring)

        sets.midcast.RA.Yoichinoyumi.Mid.Decoy = set_combine(sets.midcast.RA.Yoichinoyumi.Mid, {
            hands="Seiryu's Kote"
        })
        sets.midcast.RA.Yoichinoyumi.Acc.Decoy = set_combine(sets.midcast.RA.Yoichinoyumi.Acc, {})
       
        -- Stave
        sets.midcast.RA.Stave.Yoichinoyumi = set_combine(sets.midcast.RA.Yoichinoyumi, { hands="Iuitl Wristbands +1" })
        sets.midcast.RA.Stave.Yoichinoyumi.Mid = set_combine(sets.midcast.RA.Yoichinoyumi.Mid, { legs="Nahtirah Trousers" })
        sets.midcast.RA.Stave.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Yoichinoyumi.Acc, {})

        -- Stave / Decoy up
        sets.YoichiStavePH = set_combine(sets.midcast.RA.Stave.Yoichinoyumi, {
            hands="Sylvan Glovelettes +2",
            ear1="Volley Earring",
            legs="Nahtirah Trousers",
            feet="Orion Socks +1"
        })
        sets.midcast.RA.Stave.Yoichinoyumi.Decoy = set_combine(sets.YoichiStavePH, sets.earring)
        sets.midcast.RA.Stave.Yoichinoyumi.Mid.Decoy = set_combine(sets.midcast.RA.Stave.Yoichinoyumi.Mid, {
            legs="Aetosaur Trousers +1"
        })
        sets.midcast.RA.Stave.Yoichinoyumi.Acc.Decoy = set_combine(sets.midcast.RA.Stave.Yoichinoyumi.Acc, {})

        
        -- Sam SJ / Bow - assuming you'll use a Stave here..
        sets.midcast.RA.SAM.Stave.Yoichinoyumi = set_combine(sets.midcast.RA.SAM, {
            feet="Arcadian Socks +1"
        })
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mid = set_combine(sets.midcast.RA.SAM.Mid, {
            feet="Orion Socks +1"
        })
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.SAM.Acc, {})

        -- SAM SJ / Bow / Decoy doesn't matter here
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mid.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mid
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc

        -- Sam SJ / Bow / Sam's Roll
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.SamRoll = set_combine(sets.midcast.RA.SAM.Stave.Yoichinoyumi, {
            waist="Elanid Belt",
            feet="Orion Socks +1"
        })

        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mid.SamRoll = set_combine(sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mid, {
            waist="Elanid Belt",
        })
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc.SamRoll = set_combine(sets.midcast.RA.SAM.Stave.Yoichinoyumi.Acc, {})

        -- Don't care about decoy here
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.SamRoll.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi.SamRoll
        sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mid.SamRoll.Decoy = sets.midcast.RA.SAM.Stave.Yoichinoyumi.Mid.SamRoll
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
        sets.precast.WS.Mid = set_combine(sets.precast.WS, {
            legs="Aetosaur Trousers +1",
            feet="Orion Socks +1"
        })
        sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
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
        sets.precast.WS['Wildfire'].Mid = set_combine(sets.precast.WS.Mid, sets.Wildfire)
        sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Acc, sets.Wildfire)

        -- CORONACH
        sets.Coronach = {
           ear1="Dawn Earring",
           neck="Breeze Gorget",
           waist="Thunder Belt"
        }
        sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, sets.Coronach)
        sets.precast.WS['Coronach'].Mid = set_combine(sets.precast.WS.Mid, sets.Coronach)
        sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS.Acc, sets.Coronach)

        sets.precast.WS['Coronach'].SAM = set_combine(sets.precast.WS, {
            neck="Ocachi Gorget",
            ear1="Volley Earring",
            ear2="Tripudio Earring",
            hands="Sylvan Glovelettes +2",
            legs="Aetosaur Trousers +1"
        })

        -- LAST STAND
        sets.LastStand = {
           neck="Aqua Gorget",
           ring2="Stormsoul Ring",
           waist="Light Belt",
           legs="Arcadian Braccae +1",
           feet="Orion Socks +1"
        }
        sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, sets.LastStand)
        sets.precast.WS['Last Stand'].Mid = set_combine(sets.precast.WS.Mid, sets.LastStand)
        sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS.Acc, sets.LastStand)

        sets.precast.WS['Last Stand'].SAM = set_combine(sets.precast.WS, {
            neck="Aqua Gorget",
            ear1="Volley Earring",
            ear2="Tripudio Earring",
            hands="Seiryu's Kote",
            ring2="Stormsoul Ring",
            waist="Light Belt",
            legs="Aetosaur Trousers +1",
        })
        
        -- DETONATOR
        sets.Detonator = {
           neck="Flame Gorget",
           waist="Light Belt",
           feet="Arcadian Socks +1"
        }
        sets.precast.WS['Detonator'] = set_combine(sets.precast.WS, sets.Detonator)
        sets.precast.WS['Detonator'].Mid = set_combine(sets.precast.WS.Mid, sets.Detonator)
        sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS.Acc, sets.Detonator)
        
        -- SLUG SHOT
        sets.SlugShot = {
           neck="Breeze Gorget",
           waist="Light Belt",
           feet="Arcadian Socks +1"
        }
        sets.precast.WS['Slug Shot'] = set_combine(sets.precast.WS, sets.SlugShot)
        sets.precast.WS['Slug Shot'].Mid = set_combine(sets.precast.WS.Mid, sets.SlugShot)
        sets.precast.WS['Slug Shot'].Acc = set_combine(sets.precast.WS.Acc, sets.SlugShot)
        
        sets.precast.WS['Heavy Shot'] = set_combine(sets.precast.WS, sets.SlugShot)
        sets.precast.WS['Heavy Shot'].Mid = set_combine(sets.precast.WS.Mid, sets.SlugShot)
        sets.precast.WS['Heavy Shot'].Acc = set_combine(sets.precast.WS.Acc, sets.SlugShot)

        -- NAMAS
        sets.Namas = {
            neck="Aqua Gorget",
            waist="Light Belt",
            hands="Arcadian Bracers +1", -- override since we don't want sigyns in Mid or Acc
            back="Sylvan Chlamys",
            feet="Arcadian Socks +1"
        }
        sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, sets.Namas)
        sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS.Mid, sets.Namas)
        sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS.Acc, sets.Namas)
        
        sets.precast.WS['Namas Arrow'].SAM = set_combine(sets.precast.WS, {
            neck="Aqua Gorget",
            ear1="Volley Earring",
            ear2="Tripudio Earring",
            ring2="Pyrosoul Ring",
            waist="Light Belt",
            back="Sylvan Chlamys",
            legs="Aetosaur Trousers +1"
        })

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
        sets.precast.WS['Jishnu\'s Radiance'].Mid = set_combine(sets.precast.WS.Mid, sets.Jishnus)
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
        sets.precast.WS['Sidewinder'].Mid = set_combine(sets.precast.WS.Mid, sets.Sidewinder)
        sets.precast.WS['Sidewinder'].Acc = set_combine(sets.precast.WS.Acc, sets.Sidewinder)

        sets.precast.WS['Refulgent Arrow'] = sets.precast.WS['Sidewinder']
        sets.precast.WS['Refulgent Arrow'].Mid = sets.precast.WS['Sidewinder'].Mid
        sets.precast.WS['Refulgent Arrow'].Acc = sets.precast.WS['Sidewinder'].Acc
       
        -- Resting sets
        sets.resting = {}
       
        -- Defense sets
        sets.defense.PDT = set_combine(sets.idle, {})
        sets.defense.MDT = set_combine(sets.idle, {})
        --sets.Kiting = {feet="Fajin Boots"}
       
        sets.buff.Barrage = {
            head="Uk'uxkaj Cap",
            neck="Rancor Collar",
            ear1="Volley Earring",
            ear2="Clearview Earring",
            body="Orion Jerkin +1",
            hands="Orion Bracers +1",
            ring1="Hajduk Ring",
            ring2="Longshot Ring",
            back="Lutian Cape",
            waist="Elanid Belt",
            legs="Arcadian Braccae +1",
            feet="Orion Socks +1"
        }

        sets.buff.Camouflage =  {body="Orion Jerkin +1"}

        sets.Overkill =  {
            body="Arcadian Jerkin +1"
        }

        sets.Overkill.Preshot = set_combine(sets.precast.RA, {
            body="Arcadian Jerkin +1"
        })
end

