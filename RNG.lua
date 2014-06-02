-- Current Owner: AlanWarren, aka ~ Orestes 
-- Orinal file credit KBEEZIE
-- current file resides @ https://github.com/AlanWarren/gearswap

--[[ 
 === General Notes ===
 I've added options so anyone can use this script with any weapon they want. Look towards the top of this script for
 gear.Bow, gear.Gun, and gear.Stave. There's also a toggle for use_night_earring that you can set to false if you
 don't have or want to use Fenrir's Earring.

 Debug: //gs debugmode
       //gs showswaps

 Auto RA: 
 gs c toggle autora

 === Some Notes On Sets ===
 1) Annihilator + Hurlbat - This is used whenever ranged accuracy is a concern, or when I want war SJ's fencer bonus
 2) Annihilator + Mekki Shakki - These sets have higher ranged attack, and generally do more damage at the cost of some racc.
 3) Yoichi + Mekki Shakki + Decoy Down - This set is a bit light on racc/ratk, with focus on 4-hit and -enmity
 4) Yoichi + Mekki Shakki + Decoy Up - This set is high ratk, with less focus on racc since Yoichi's aftermath provides a bit
 5) Yoichi + Hurlbat - This set is pretty much a wash since bow needs so much STP to x-hit. Normally this would be a higher
    racc set for Bow, but it doesn't really accomplish this well right now. Stick to staves for bow.. 
 6) Annihilator + SAM Subjob - This is "messing around" set that will 3-hit with all 3 shots proc'ing recycle! 

 === Toggles ===
 1) Normal aims to be a 4-hit with as few recycle procs as I can possibly gear for without sacrificing too much.
    I will usually start out with this set, and occasionaly stick with it if my food allows decent racc.
 2) Mod adds a bit more acc, while maintaining 4 hit (may require more recycle procs) 
    I generally use this set on anything Difficult+, or delve2. Sometimes it allows me to eat meat. 
 3) Acc is full blown racc with minimal concern for anything else. Some sets will 4-hit with with all 4 shots proc'ing recycle
    This mode is only used when fighting difficult content, and all buffs drop. 

 === Modes ===
 1) Non-specific default sets are for Gun. They assume a 1 handed weapon since Hurlbat is my default for Annihilator.
    * Gun2H set is used whenever your main weapon is equal to gear.Stave. This set was designed for Mekki + Bloodrain
 1) Bow sets will activate by equipping whichever bow you defined in gear.Bow
    * Bow sets assume a stave + strap combination
    * Decoy1H and Bow1H will be used whenever you're NOT using gear.Stave i.e. Hurlbat
 2) Decoy set only applies while decoy is active AND you're using Bow
    * Standard Bow set uses -enmity gear, while maintaining 4-hit (with 4/4 recycle proc)
    * Decoy set removes -enmity gear for a normal 4-hit setup (3/4 or 2/4 recycle proc)
 3) Fenrir's earring is equipped at night for WS. You can disable this by setting use_night_earring = false
 4) During Overkill, I use a special set for precast/midcast containing rapidshot / doubleshot dmg gear. 

 === In Precast ===
 1) Checks to make sure you're in an engaged state and have 100+ TP before firing a weaponskill
 2) Checks the distance to target to prevent WS from being fired when target is too far (prevents TP loss)
 3) Does not allow gear-swapping on weaponskills when Defense mode is enabled
 4) Checks to see of "Unlimited Shot" buff is on, if there's any special ammo defined in sets equipped
 5) Checks for empty ammo (or special without buff) and fills in the default ammunition for that weapon
    ^ keeps empty if that ammo cannot be found, or there is no match to the weapon equipped
 6) Provides a low ammunition warning if current ammo in slot (counts all in inventory) is less than 15
    ^ If you have 5 Tulfaire arrows in slot, but 20 also in inventory it see's it as 25 total

 === In Midcast ===
 If Sneak is active, sends the cancel command before Spectral Jig finish casting

 === In Post-Midcast ===
 If Barrage Buff is active, equips sets.BarrageMid

 === In Buff Change ===
 If Camouflage is active, disable body swaping
 This is done to preserve the +100 Camouflage Duration given by Orion Jerkin
--]]
 
function get_sets()
        -- Load and initialize the include file.
        include('Mote-Include.lua')
end

function user_setup()
        send_command('bind f9 gs c cycle RangedMode')
        send_command('bind ^] gs c cycle OffenseMode')
        send_command('bind ^f9 gs c cycle DefenseMode')
        send_command('bind !f9 gs c cycle WeaponskillMode')
        send_command('bind ^- gs c toggle AutoRA')
        send_command('bind ^[ input /lockstyle on')
end

function job_setup()
    determine_ranged()
    state.Buff.Camouflage = buffactive.camouflage or false
    state.Buff.Overkill = buffactive.overkill or false

    use_night_earring = true
end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    binds_on_unload()
end
 
function init_gear_sets()
        gear.Gun = "Annihilator"
        gear.Bow = "Yoichinoyumi"
        gear.Stave = "Mekki Shakki"
        
        -- Auto RA + WS
        state.AutoRA = false
        -- Overriding Global Defaults for this job
        gear.default.weaponskill_neck = "Ocachi Gorget"
        gear.default.weaponskill_waist = "Elanid Belt"
 
        -- List of ammunition that should only be used under unlimited shot
        U_Shot_Ammo = S{'Animikii Bullet'}
       
        -- Simply add a line of DefaultAmmo["Weapon"] = "Ammo Name"
        DefaultAmmo = {}
        DefaultAmmo[gear.Gun] = "Achiyalabopa Bullet"
        DefaultAmmo[gear.Bow] = "Achiyalabopa Arrow"
       
        -- Options: Override default values
        options.OffenseModes = {'Normal', 'Melee'}
        options.RangedModes = {'Normal', 'Mod', 'Acc'}
        options.DefenseModes = {'Normal', 'PDT'}
        options.WeaponskillModes = {'Normal', 'Mod', 'Acc'}
        options.PhysicalDefenseModes = {'PDT'}
        options.MagicalDefenseModes = {'MDT'}
        state.Defense.PhysicalMode = 'PDT'
 
        -- Misc. Job Ability precasts
        sets.precast.JA['Bounty Shot'] = {hands="Sylvan Glovelettes +2"}
        sets.precast.JA['Double Shot'] = {head="Sylvan Gapette +2"}
        sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
        sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
        sets.precast.JA['Velocity Shot'] = {body="Sylvan Caban +2"}
        sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}

        sets.precast.JA['Eagle Eye Shot'] = {
            head="Ux'uxkaj Cap", 
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

        sets.NightEarring = {ear2="Fenrir's earring"}
        sets.DayEarring = {ear2="Flame Pearl"}

        sets.earring = select_earring()

        select_default_macro_book()

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

        -- Ranged Attack Sets

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
        -- STP: 37 ~ 90.8 TP after 4 hits (2/4 recycle required)
        -- Racc: 264
        -- Ratk: 219.75
        -- AGI: 148
        -- STR: 105
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
            ring2="K'ayres Ring",
            back="Sylvan Chlamys",
            waist="Elanid Belt", 
            legs="Aetosaur Trousers +1",
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
            back="Lutian Cape"
        })

        -- Gun Acc 
        -- STP: 21 ~ 80 TP after 4 hits (4/4 recycle required)
        -- Racc: 316.25
        -- Ratk: 177.75
        -- AGI: 151
        -- STR: 86
        sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Mod, {
            neck="Iqabi Necklace",
            ring1="Hajduk Ring"
        })

        -- sam subjob 
        --sets.midcast.RA.SAM = sets.midcast.RA
        --sets.midcast.RA.SAM.Mod = sets.midcast.RA.Mod
        --sets.midcast.RA.SAM.Acc = sets.midcast.RA.Acc


        -- Stave + Strap set for Gun
        -- STP: 38 ~ 91.6 TP after 4 hits (2/4 recycle required)
        -- Racc: 242
        -- Ratk: 262.75
        -- AGI: 136
        -- STR: 109
        sets.midcast.RA.Gun2H = set_combine(sets.midcast.RA, {
            --main="Mekki Shakki",
            --sub="Bloodrain Strap",
            legs="Nahtirah Trousers",
            back="Lutian Cape",
        })

        -- STP: 38 ~ 91.6 TP after 4 hits (2/4 recycle required)
        -- Racc: 269
        -- Ratk: 229
        -- AGI: 134
        -- STR: 104
        sets.midcast.RA.Mod.Gun2H = set_combine(sets.midcast.RA.Gun2H, {
            legs="Aetosaur Trousers +1",
            ring2="Longshot Ring"
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
        
        -- This is a 3-hit build with 3 out of 3 recycle procs and /sam sub. 
        -- It's used automatically by having /sam and gear.Stave equipped. (sacrifices should be obvious)
        -- STP: 57
        -- Racc: 200.5
        -- Ratk: 201.5 
        -- AGI: 110
        -- STR: 81 
        --sets.midcast.RA.SAM.Gun2H = {
        --    head="Arcadian Beret +1",
        --    neck="Ocachi Gorget",
        --    ear1="Volley Earring", 
        --    ear2="Tripudio Earring", 
        --    body="Kyujutsugi",
        --    hands="Sigyn's Bazubands",
        --    ring1="Rajas Ring", 
        --    ring2="K'ayres Ring",
        --    back="Sylvan Chlamys",
        --    waist="Patentia Sash",
        --    legs="Sylvan Bragues +2",
        --    feet="Orion Socks +1"
        --}
        --sets.midcast.RA.SAM.Mod.Gun2H = set_combine(sets.midcast.RA.SAM.Gun2H, {
        --    waist="Elanid Belt",
        --    legs="Aetosaur Trousers +1"
        --})
        --sets.midcast.RA.SAM.Acc.Gun2H = set_combine(sets.midcast.RA.SAM.Mod.Gun2H, {
        --    ring1="Longshot Ring",
        --    ring2="Paqichikaji Ring",
        --    back="Lutian Cape"
        --})

        
        -- Bow Default (614 total delay) 4-hit with 3/4 recycle
        -- This set is only used while Decoy Shot is OFF
        -- Enmity: -40
        -- STP: 46
        -- Racc: 219.75
        -- Ratk: 206.75 
        -- AGI: 149
        -- STR: 113 
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
            legs="Aetosaur Trousers +1", 
            feet="Arcadian Socks +1"
        }
        -- Mod toggle for Bow.
        -- All around good set for events, but not when you care a lot about -enmity
        -- Enmity: -29
        -- STP: 45 
        -- Racc: 240.5 
        -- Ratk: 240.25 
        -- AGI: 126
        -- STR: 111 
        sets.midcast.RA.Mod.Bow = set_combine(sets.midcast.RA.Bow, {
            ear1="Volley Earring",
            hands="Sylvan Glovelettes +2",
            back="Lutian Cape",
            legs="Arcadian Braccae +1",
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
            legs="Nahtirah Trousers",
            waist="Elanid Belt",
            feet="Orion Socks +1"
        })
        sets.midcast.RA.Mod.Decoy = sets.midcast.RA.Mod.Bow
        -- 1-handed weapon set used when decoy shot is ON
        sets.midcast.RA.Decoy1H = set_combine(sets.midcast.RA.Decoy, {
            back="Sylvan Chlamys",
            legs="Aetosaur Trousers +1"
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
        sets.Coronach = {}
        sets.Detonator = {}
        sets.LastStand = {}
        sets.Namas = {}
        sets.Jishnus = {}
        sets.Sidewinder = {}
        sets.Wildfire = {}

        sets.precast.CustomWS = {}
        sets.precast.CustomWS = {
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Flame Pearl",
            ear2="Flame Pearl",
            body="Kyujutsugi",
            hands="Arcadian Bracers +1",
            ring1="Rajas Ring",
            ring2="Pyrosoul Ring",
            back="Sylvan Chlamys",
            waist="Elanid Belt",
            legs="Nahtirah Trousers",
            feet="Arcadian Socks +1"
        }
        sets.precast.WS = set_combine(sets.precast.CustomWS, sets.earring)
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
            legs="Shneddick Tights",
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
       
        -- Barrage Set
        sets.BarrageMid = {
            head="Umbani Cap",
            neck="Rancor Collar",
            ear1="Volley Earring",
            ear2="Clearview Earring",
            body="Orion Jerkin +1",
            hands="Orion Bracers +1",
            ring1="Paqichikaji Ring",
            ring2="Longshot Ring",
            back="Lutian Cape",
            waist="Elanid Belt",
            legs="Arcadian Braccae +1",
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

function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then -- Auto WS/Decoy Shot/Double Shot --
        if player.tp >= 100 and state.AutoRA and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
function job_precast(spell, action, spellMap, eventArgs)
        if spell.type:lower() == 'weaponskill' then
            --if player.status ~= "Engaged" or player.tp < 100 then
            if player.tp < 100 then
                    eventArgs.cancel = true
                    return
            end
            if ((spell.target.distance >8 and spell.skill ~= 'Archery' and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
                -- Cancel Action if distance is too great, saving TP
                add_to_chat(122,"Outside Ranged WS Range! /Canceling")
                eventArgs.cancel = true
                return

            elseif state.Defense.Active then
                -- Don't gearswap for weaponskills when Defense is on.
                eventArgs.handled = true
            end
        end
        -- add support for RangedMode toggles to EES
        if spell.english == 'Eagle Eye Shot' then
            classes.JAMode = state.RangedMode
        end
       
        if spell.type == 'Waltz' then
                refine_waltz(spell, action, spellMap, eventArgs)
        end
       
        if spell.name == "Ranged" or spell.type:lower() == 'weaponskill' then
                -- If ammo is empty, or special ammo being used without buff, replace with default ammo
                if U_Shot_Ammo[player.equipment.ammo] and not buffactive['unlimited shot'] or player.equipment.ammo == 'empty' then
                        if DefaultAmmo[player.equipment.range] and player.inventory[DefaultAmmo[player.equipment.range]] then
                                add_to_chat(122,"Unlimited Shot not Active or Ammo Empty, Using Default Ammo")
                                equip({ammo=DefaultAmmo[player.equipment.range]})
                        else
                                add_to_chat(122,"Either Default Ammo is Unavailable or Unknown Weapon. Staying empty")
                                equip({ammo=empty})
                        end
                end
                if not buffactive['unlimited shot'] then
                        -- If not empty, and if unlimited shot is not active
                        -- Not doing it for unlimited shot to avoid excessive log
                        if player.equipment.ammo ~= 'empty' then
                                if player.inventory[player.equipment.ammo].count < 15 then
                                        add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
                                end
                        end
                end
        end
end
 
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
-- This is where you place gear swaps you want in precast but applied on top of the precast sets
function job_post_precast(spell, action, spellMap, eventArgs)
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    elseif state.Buff.Overkill then
        equip(sets.Overkill.Preshot)
    end
    sets.earring = select_earring()
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    -- add support for SAM set
    --if spell.action_type == 'Ranged Attack' then
	--    if player.sub_job == 'SAM' then
    --        add_to_chat(122, 'SAM SUB')
    --        classes.CustomClass = 'SAM'
    --    end
    --end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
        -- If sneak is active when using, cancel before completion
        send_command('cancel 71')
    end
end

 
-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if buffactive.barrage then
        equip(sets.BarrageMid)
    end
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
        equip(sets.Overkill)
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' and state.AutoRA then
        use_ra()
    end
    if not spell.interrupted then
        if state.Buff[spell.name] ~= nil then
            state.Buff[spell.name] = true
        end

        if state.Buff['Camouflage'] then
            send_command('@wait .5;gs disable body')
        else
            enable('body')
        end
    end
end
 
-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)
 
end
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    sets.earring = select_earring()
end
 
function customize_idle_set(idleSet)
	if state.Buff.Camouflage then
		idleSet = set_combine(idleSet, sets.buff.Camouflage)
	end
    return idleSet
end
 
function customize_melee_set(meleeSet)
    if state.Buff.Camouflage then
    	meleeSet = set_combine(meleeSet, sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
    	meleeSet = set_combine(meleeSet, sets.Overkill)
    end
    return meleeSet
end
 
function job_status_change(newStatus, oldStatus, eventArgs)
    if camo_active() then
        send_command('@wait .5;gs disable body')
    else
        enable('body')
    end
	determine_ranged()
end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --if S{"courser's roll"}:contains(buff:lower()) then
    --if string.find(buff:lower(), 'samba') then

    if state.Buff[buff] ~= nil then
        state.Buff[buff] = gain
	    determine_ranged()
        handle_equipping_gear(player.status)
    end

end
 
function select_earring()
    -- world.time is given in minutes into each day
    -- 7:00 AM would be 420 minutes
    -- 17:00 PM would be 1020 minutes
    if world.time >= (18*60) or world.time <= (8*60) and use_night_earring then
        return sets.NightEarring
    else
        return sets.DayEarring
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
end
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    determine_ranged()
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false
    state.Buff.Overkill = buffactive.overkill or false
    state.Buff['Decoy Shot'] = buffactive['Decoy Shot'] or false

    if camo_active() then
        send_command('@wait .5;gs disable body')
    else
        enable('body')
    end
end
 
-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
--function get_custom_wsmode(spell, action, default_wsmode)
--	if state.RangedMode ~= 'Normal' and S(options.WeaponskillModes):contains(state.RangedMode) then
--		return state.RangedMode
--	end
--end

-- Job-specific toggles.
function job_toggle(field)
    if field:lower() == 'autora' then
        state.AutoRA = not state.AutoRA
        --return "Use Auto RA", state.AutoRA
        return state.AutoRA
    end
end
 
-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_option_modes(field)
    if field:lower() == 'autora' then
        return state.AutoRA
    end
end
 
-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_option_mode(field, val)
    if field:lower() == 'autora' then
        state.AutoRA = val
        return true
    end
end
 
-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
 
end
 
-- Handle notifications of user state values being changed.
function job_state_change(stateField, newValue, oldValue)
 
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    if state.AutoRA then
        msg = '[Auto RA: ON]'
    else
        msg = '[Auto RA: OFF]'
    end

    add_to_chat(122, 'Ranged: '..state.RangedMode..'/'..state.DefenseMode..', WS: '..state.WeaponskillMode..', '..msg)
    
    eventArgs.handled = true
 
end

function determine_ranged()
    -- cleanup everything each time function is called
	classes.CustomRangedGroups:clear()
	classes.CustomMeleeGroups:clear()

    if player.equipment.range == gear.Bow then
        -- if decoy is up 
        if buffactive['Decoy Shot'] then
            -- default decoy set assumes staff is used. 
            if player.equipment.main == gear.Stave then
                classes.CustomMeleeGroups:append('Decoy')
		        classes.CustomRangedGroups:append('Decoy')
            else -- append the 1 handed weapon class
                classes.CustomMeleeGroups:append('Decoy1H')
		        classes.CustomRangedGroups:append('Decoy1H')
            end
        else
            if player.equipment.main == gear.Stave then
                classes.CustomMeleeGroups:append('Bow')
		        classes.CustomRangedGroups:append('Bow')
            else -- one handed weapon setup
                classes.CustomMeleeGroups:append('Bow1H')
		        classes.CustomRangedGroups:append('Bow1H')
            end
        end

    elseif player.equipment.range == gear.Gun then

        if player.equipment.main == gear.Stave then
	        classes.CustomRangedGroups:append('Gun2H')
            classes.CustomMeleeGroups:append('Gun2H')
        else -- The default sets.midcast.RangedAttack applies
	        classes.CustomRangedGroups:clear()
	        classes.CustomMeleeGroups:clear()
        end

    end
end

function use_weaponskill()
    if player.equipment.range == gear.Bow then
        send_command('input /ws "Namas Arrow" <t>')
    elseif player.equipment.range == gear.Gun then
        send_command('input /ws "Coronach" <t>')
    end
end

function use_ra()
    send_command('@wait 2.7; input /ra <t>')
end

function camo_active()
    return state.Buff['Camouflage']
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR'then
		    set_macro_page(3, 5)
	elseif player.sub_job == 'SAM' then
		    set_macro_page(4, 5)
	else
		set_macro_page(3, 5)
	end
end

