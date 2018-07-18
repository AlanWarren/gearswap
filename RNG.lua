-- Owner: AlanWarren, aka ~ Orestes 
-- current file resides @ https://github.com/AlanWarren/gearswap
--[[ 

 === Notes ===
 -- Set format is as follows:
    sets.midcast.RA.[CustomClass][CombatForm][CombatWeapon][RangedMode][CustomRangedGroup]
    ex: sets.midcast.RA.SAM.Bow.Mid.SamRoll = {}
    you can also append CustomRangedGroups to each other
 
 -- These are the available sets per category
 -- CustomClass = SAM
 -- CombatForm = DW
 -- CombatWeapon = weapon name, ex: Yoichinoyumi  (you can make new sets for any ranged weapon)
 -- RangedMode = Normal, Mid, Acc
 -- CustomRangedGroup = SamRoll

 -- SamRoll is applied automatically whenever you have the roll on you. 
 -- SAM is used when you're RNG/SAM 

 * Auto RA
 - You can use the built in hotkey (CTRL -) or create a macro. (like below) Note "AutoRA" is case sensitive
   /console gs c toggle AutoRA
 - You have to shoot once after toggling autora for it to begin.
 - AutoRA will use weaponskills @ 1000TP, depending on which weapon you're using. However, this will only
   work if you set gear.Gun or gear.Bow to the weapon you're using. You also have to specify the desired
   ws it should use, with the settings auto_gun_ws and auto_bow_ws. 
 
 === Helpful Commands ===
    //gs validate
    //gs showswaps
    //gs debugmode

--]]
 
function get_sets()
        mote_include_version = 2
        -- Load and initialize the include file.
        include('Mote-Include.lua')
        include('organizer-lib')
end

-- setup vars that are user-independent.
function job_setup()
        state.Buff.Barrage = buffactive.Barrage or false
        state.Buff.Camouflage = buffactive.Camouflage or false
        state.Buff.Overkill = buffactive.Overkill or false
        state.Buff['Double Shot'] = buffactive['Double Shot'] or false

        -- settings
        state.CapacityMode = M(false, 'Capacity Point Mantle')

        state.AutoRA = M{['description']='Auto RA', 'Normal', 'Shoot', 'WS' }
        auto_gun_ws = "Coronach"
        auto_bow_ws = "Namas Arrow"


        gear.Gun = "Annihilator"
        gear.Bow = "Yoichinoyumi"
        --gear.Bow = "Hangaku-no-Yumi"
       
        rng_sub_weapons = S{'Malevolence', 'Vanir Knife', 'Perun', 
            'Eminent Axe', 'Odium', 'Aphotic Kukri', 'Atoyac'}
        
        sam_sj = player.sub_job == 'SAM' or false

          DefaultAmmo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Achiyalabopa bullet"}
        U_Shot_Ammo = {[gear.Bow] = "Achiyalabopa arrow", [gear.Gun] = "Achiyalabopa bullet"} 

        update_combat_form()
        get_custom_ranged_groups()
end
 
function user_setup()
        -- Options: Override default values
        state.OffenseMode:options('Normal', 'Melee')
        state.RangedMode:options('Normal', 'Mid', 'Acc')
        state.HybridMode:options('Normal', 'PDT')
        state.IdleMode:options('Normal', 'PDT')
        state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
        state.PhysicalDefenseMode:options('PDT')
        state.MagicalDefenseMode:options('MDT')
 
        select_default_macro_book()

        send_command('bind != gs c toggle CapacityMode')
        send_command('bind f9 gs c cycle RangedMode')
        send_command('bind !f9 gs c cycle OffenseMode')
        send_command('bind ^f9 gs c cycle HybridMode')
        send_command('bind ^] gs c cycle WeaponskillMode')
        send_command('bind !- gs equip sets.crafting')
        send_command('bind ^- gs c cycle AutoRA')
        send_command('bind ^[ input /lockstyle on')
        send_command('bind ![ input /lockstyle off')
end

-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind f9')
    send_command('unbind ^f9')
    send_command('unbind ^[')
    send_command('unbind ![')
    send_command('unbind !=')
    send_command('unbind ^=')
    send_command('unbind @=')
    send_command('unbind ^-')
end
 
function init_gear_sets()
        -- Augmented gear
        TaeonHands = {}
        TaeonHands.TA = {name="Taeon Gloves", augments={'DEX+6','Accuracy+17 Attack+17','"Triple Atk."+2'}}
        TaeonHands.Snap = {name="Taeon Gloves", augments={'"Snapshot"+5', 'Attack+22','"Snapshot"+3'}}
        
        TaeonHead = {}
        TaeonHead.Snap = { name="Taeon Chapeau", augments={'Accuracy+20 Attack+20','"Snapshot"+5','"Snapshot"+4',}}
        
        Belenus = {}
        Belenus.STP = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
        Belenus.Snap = {name="Belenus's Cape", augments={'"Snapshot"+10',}}

        sets.Organizer = {
            main="Annihilator",
            sub="Nusku Shield",
            ammo="Perun +1",
            range="Yoichinoyumi",
            hands="Taeon Gloves",
            feet="Legion Scutum"
        }
        -- Misc. Job Ability precasts
        sets.precast.JA['Bounty Shot'] = {hands="Amini Glovelettes +1"}
        sets.precast.JA['Double Shot'] = {head="Amini Gapette"}
        sets.precast.JA['Camouflage'] = {body="Orion Jerkin +2"}
        sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
        sets.precast.JA['Velocity Shot'] = {body="Amini Caban +1", back=Belenus.Snap }
        sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}

        sets.CapacityMantle = {back="Mecistopins Mantle"}

        sets.precast.JA['Eagle Eye Shot'] = set_combine(sets.midcast.RA, {
            head="Meghanada Visor +1", 
            ear1="Flame Pearl",
            ear2="Flame Pearl",
            neck="Rancor Collar",
            body="Orion Jerkin +2",
            back="Buquwik Cape",
            hands="Meghanada Gloves +2",
            ring1="Ifrit Ring",
            ring2="Apate Ring",
            legs="Amini Brague +1", 
            feet="Thereoid Greaves"
        })
        sets.precast.JA['Eagle Eye Shot'].Mid = set_combine(sets.precast.JA['Eagle Eye Shot'], {
            back="Lutian Cape",
            ring2="Longshot Ring",
            feet="Meghanada Jambeaux +2"
        })
        sets.precast.JA['Eagle Eye Shot'].Acc = set_combine(sets.precast.JA['Eagle Eye Shot'].Mid, {
            neck="Iqabi Necklace",
            waist="Kwahu Kachina Belt"
        })

        sets.precast.FC = {
            head="Herculean Helm",
            ear1="Loquacious Earring",
            body="Samnuha Coat",
            legs="Quiahuiz Trousers",
            hands="Leyline Gloves",
            ring1="Prolix Ring"
        }
        sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads" })
        
        sets.idle = {
            --sub="Nusku Shield",
            head="Arcadian Beret +1",
            neck="Sanctity Necklace",
            ear1="Enervating Earring",
            ear2="Tripudio Earring",
            body="Orion Jerkin +2",
            hands="Meghanada Gloves +2",
            ring1="Paguroidea Ring",
            ring2="Karieyh Ring",
            back="Solemnity Cape",
            waist="Kwahu Kachina Belt",
            legs="Meghanada Chausses +1",
            feet="Jute Boots +1"
        }
        sets.idle.Regen = set_combine(sets.idle, {
            --head="Ocelomeh Headpiece +1",
            --body="Kheper Jacket",
            neck="Sanctity Necklace",
            ring2="Paguroidea Ring"
        })
        sets.idle.PDT = set_combine(sets.idle, {
            head="Meghanada Visor +1",
            body="Meghanada Cuirie +1",
            hands="Meghanada Gloves +2",
            legs="Meghanada Chausses +1",
            ring1="Dark Ring",
            ring2="Defending Ring"
        })
        sets.idle.Town = set_combine(sets.idle, {
            head="Orion Beret +2",
            body="Orion Jerkin +2",
            ring1="Defending Ring",
            ring2="Karieyh Ring",
            hands="Adhemar Wristbands",
            legs="Meghanada Chausses +1",
            back=Belenus.STP,
            feet="Jute Boots +1"
        })
 
        -- Engaged sets
        sets.engaged =  {
            sub="Nusku Shield",
            head="Arcadian Beret +1",
            neck="Twilight Torque",
            ear1="Enervating Earring",
            ear2="Tripudio Earring",
            body="Orion Jerkin +2",
            hands="Meghanada Gloves +2",
            ring1="Defending Ring",
            ring2="Karieyh Ring",
            waist="Impulse Belt",
            back=Belenus.STP,
            legs="Meghanada Chausses +1", 
            feet="Jute Boots +1"
        }
        sets.engaged.PDT = set_combine(sets.engaged, {
            hands="Meghanada Gloves +2",
    	    back="Solemnity Cape",
            ring1="Dark Ring",
        })
        sets.engaged.Bow = set_combine(sets.engaged, {})

        sets.engaged.Melee = {
            head="Herculean Helm",
            neck="Lissome Necklace",
            ear1="Brutal Earring",
            ear2="Trux Earring",
            body="Herculean Vest",
            hands="Herculean Gloves",
            ring1="Petrov Ring",
            ring2="Epona's Ring",
            back="Bleating Mantle",
            waist="Windbuffet Belt +1",
            legs="Meghanada Chausses +1", 
            feet="Herculean Boots"
        }
        sets.engaged.Bow.Melee = sets.engaged.Melee

        sets.engaged.Melee.PDT = set_combine(sets.engaged.Melee, {
            neck="Twilight Torque",
            ring1="Patricius Ring",
            ring2="Defending Ring",
            back="Solemnity Cape",
        })

        sets.engaged.DW = set_combine(sets.engaged, {})

        sets.engaged.DW.Melee = set_combine(sets.engaged.Melee, {
            head="Herculean Helm",
            ear1="Eabani Earring",
            ear2="Suppanomimi",
            body="Samnuha Coat",
            hands="Floral Gauntlets",
            back="Bleating Mantle",
            waist="Patentia Sash",
            legs="Carmine Cuisses +1",
            feet="Taeon Boots"
        })

        ------------------------------------------------------------------
        -- Preshot / Snapshot sets 
        -- 50 snap in gear will cap
        -- Pieces that provide delay reduction via velocity shot, do NOT
        -- count towards cap.
        ------------------------------------------------------------------
        sets.precast.RA = {
            head=TaeonHead.Snap, -- 9
            neck="Scout's gorget", -- 2
            body="Amini Caban +1", -- 7% VS
            hands=TaeonHands.Snap, --8
            back=Belenus.Snap, -- 2% VS / 10 snap (for now)
            legs="Adhemar Kecks", -- 9
            waist="Impulse Belt", -- 2
            feet="Meghanada Jambeaux +2" -- 10
        }
        sets.precast.RA.F1 = set_combine(sets.precast.RA, {
            head="Orion Beret +2"
        })
        sets.precast.RA.F2 = set_combine(sets.precast.RA.F1, {
            -- waist="Yemaya Belt",
            -- feet="Pursuer's Gaiters"
        })
        
        ------------------------------------------------------------------
        -- Default Base Gear Sets for Ranged Attacks. Geared for Gun
        ------------------------------------------------------------------
        sets.midcast.RA = { 
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Enervating Earring",
            ear2="Tripudio Earring", 
            body="Orion Jerkin +2", 
            hands="Adhemar Wristbands",
            ring1="Rajas Ring",
            ring2="Apate Ring",
            back=Belenus.STP,
            waist="Kwahu Kachina Belt", 
            legs="Amini Brague +1", 
            feet="Meghanada Jambeaux +2"
        }
        sets.midcast.RA.Mid = set_combine(sets.midcast.RA, {
            head="Meghanada Visor +1",
            ring2="Cacoethic Ring +1",
        })
        sets.midcast.RA.Acc = set_combine(sets.midcast.RA.Mid, {
            -- head="Orion Beret +2",
            neck="Scout's Gorget", 
            ring1="Longshot Ring",
            hands="Meghanada Gloves +2",
            legs="Adhemar Kecks", 
        })

        sets.midcast.RA.DoubleShot = set_combine(sets.midcast.RA, {
            -- head="Oshosi Mask",
            -- body="Arcadian Jerkin +1",
            -- feet="Oshosi Leggings"
        })
        sets.midcast.RA.Mid.DoubleShot = set_combine(sets.midcast.RA.Mid, {})
        sets.midcast.RA.Acc.DoubleShot = set_combine(sets.midcast.RA.Acc, {})
    
        -- -- Samurai Roll sets 
        -- sets.midcast.RA.SamRoll = set_combine(sets.midcast.RA, {
        --     body="Arcadian Jerkin +1",
        --     ring2="Longshot Ring",
        -- })
        -- sets.midcast.RA.Mid.SamRoll = set_combine(sets.midcast.RA.SamRoll, {
        --     ring2="Longshot Ring",
        --     body="Amini Caban +1",
        --     back="Lutian Cape",hands="Amini Glovelettes +1",
        --     legs="Adhemar Kecks",
        -- })
        -- sets.midcast.RA.Acc.SamRoll = set_combine(sets.midcast.RA.Mid.SamRoll, {
        --     neck="Iqabi Necklace", 
        --     ring1="Hajduk Ring", 
        --     ring2="Longshot Ring",
        --     legs="Adhemar Kecks",
        -- })
        
        -- SAM Subjob
        -- sets.midcast.RA.SAM = {
        --     head="Arcadian Beret +1",
        --     neck="Ocachi Gorget",
        --     ear1="Enervating Earring",
        --     ear2="Tripudio Earring", 
        --     body="Pursuer's Doublet",
        --     hands="Amini Glovelettes +1",
        --     ring1="Rajas Ring", 
        --     ring2="K'ayres Ring",
        --     back="Lutian Cape",
        --     waist="Kwahu Kachina Belt",
        --     legs="Amini Brague +1", 
        --     feet="Thereoid Greaves"
        -- }
        -- sets.midcast.RA.SAM.Mid = set_combine(sets.midcast.RA.SAM, { 
        --     hands="Amini Glovelettes +1",
        --     body="Amini Caban +1",
        --     feet="Orion Socks +1"
        -- })
        -- sets.midcast.RA.SAM.Acc = set_combine(sets.midcast.RA.SAM.Mid, {
        --     back="Lutian Cape", 
        --     neck="Iqabi Necklace", 
        --     ring2="Longshot Ring",
        --     waist="Eschan Stone"
        -- })

        -- -- Samurai Roll for /sam, assume we're using a staff
        -- sets.midcast.RA.SAM.SamRoll = set_combine(sets.midcast.RA.SAM, {
        --     hands="Amini Glovelettes +1"
        -- })
        -- sets.midcast.RA.SAM.Mid.SamRoll = set_combine(sets.midcast.RA.SAM.Mid, {
        --     ear1="Enervating Earring",
        --     hands="Meghanada Gloves +1",
        --     legs="Adhemar Kecks", 
        -- })
        -- sets.midcast.RA.SAM.Acc.SamRoll = set_combine(sets.midcast.RA.SAM.Acc, {
        --     hands="Meghanada Gloves +1",
        -- })

        -- Bow base set.
        sets.midcast.RA.Bow = {
            head="Arcadian Beret +1",
            neck="Ocachi Gorget",
            ear1="Enervating Earring",
            ear2="Tripudio Earring",
            body="Orion Jerkin +2", 
            hands="Amini Glovelettes +1",
            ring1="Rajas Ring",
            ring2="Petrov Ring",
            back=Belenus.STP,
            waist="Kwahu Kachina Belt",
            legs="Amini Brague +1", 
            feet="Meghanada Jambeaux +2"
        }
        sets.midcast.RA.Bow.Mid = set_combine(sets.midcast.RA.Bow, {
            neck="Yarak Torque",
            hands="Adhemar Wristbands",
            legs="Adhemar Kecks",
            body="Orion Jerkin +2", 
            ring1="Cacoethic Ring +1",
        })
        sets.midcast.RA.Bow.Acc = set_combine(sets.midcast.RA.Bow.Mid, {
            head="Orion Beret +2",
            hands="Meghanada Gloves +2",
            ring2="Longshot Ring",
        })
       
        -- Bow Sam roll
        -- sets.midcast.RA.Bow.SamRoll = set_combine(sets.midcast.RA.Bow, {
        --     body="Arcadian Jerkin +1",
        --     hands="Meghanada Gloves +1",
        --     ring2="Longshot Ring",
        --     back="Lutian Cape"
        -- })
        -- sets.midcast.RA.Bow.Mid.SamRoll = set_combine(sets.midcast.RA.Bow.SamRoll, {
        --     body="Pursuer's Doublet",
        -- })
        -- sets.midcast.RA.Bow.Acc.SamRoll = set_combine(sets.midcast.RA.Bow.Mid.SamRoll, {
        --     neck="Yarak Torque",
        --     hands="Meghanada Gloves +1",
        --     body="Amini Caban +1",
        --     ring1="Longshot Ring",
        --     feet="Meghanada Jambeaux +1"
        -- })
        
        -- Sam SJ / Bow 
        -- sets.midcast.RA.SAM.Bow = set_combine(sets.midcast.RA.SAM, {
        --     feet="Meghanada Jambeaux +1"
        -- })
        -- sets.midcast.RA.SAM.Bow.Mid = set_combine(sets.midcast.RA.SAM.Mid, {
        --     feet="Meghanada Jambeaux +1"
        -- })
        -- sets.midcast.RA.SAM.Bow.Acc = set_combine(sets.midcast.RA.SAM.Acc, {})

        -- Sam SJ / Bow / Sam's Roll
        -- sets.midcast.RA.SAM.Bow.SamRoll = set_combine(sets.midcast.RA.SAM.Bow, {
        --     waist="Kwahu Kachina Belt",
        --     feet="Meghanada Jambeaux +1"
        -- })

        -- sets.midcast.RA.SAM.Bow.Mid.SamRoll = set_combine(sets.midcast.RA.SAM.Bow.Mid, {
        --     waist="Kwahu Kachina Belt",
        -- })
        -- sets.midcast.RA.SAM.Bow.Acc.SamRoll = set_combine(sets.midcast.RA.SAM.Bow.Acc, {})


        -- Weaponskill sets  
        sets.precast.WS = {
            head="Orion Beret +2",
            neck="Ocachi Gorget",
            ear1="Ishvara Earring",
            ear2="Flame Pearl",
            body="Herculean Vest",
            hands="Meghanada Gloves +2",
            ring1="Apate Ring",
            ring2="Karieyh Ring",
            back="Buquwik Cape",
            waist="Kwahu Kachina Belt",
            legs="Amini Brague +1", 
            feet="Meghanada Jambeaux +2"
        }
        sets.precast.WS.Mid = set_combine(sets.precast.WS, {
            legs="Meghanada Chausses +1", 
        })
        sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
            -- head="Meghanada Visor +1",
        })

        -- WILDFIRE
        sets.Wildfire = {
            head="Orion Beret +2",
            ear1="Friomisi Earring",
            ear2="Crematio Earring",
            neck="Sanctity Necklace",
            hands="Meghanada Gloves +2",
            body="Samnuha Coat",
            ring1="Garuda Ring",
            ring2="Karieyh Ring",
            back=Belenus.STP,
            waist="Eschan Stone",
            legs="Meghanada Chausses +1",
            feet="Herculean Boots"
        }
        sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS, sets.Wildfire)
        sets.precast.WS['Wildfire'].Mid = set_combine(sets.precast.WS.Mid, sets.Wildfire)
        sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS.Acc, sets.Wildfire)
        
        sets.Trueflight = set_combine(sets.Wildfire, {ear2="Moonshade Earring"})
        sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS, sets.Trueflight)
        sets.precast.WS['Trueflight'].Mid = set_combine(sets.precast.WS.Mid, sets.Trueflight)
        sets.precast.WS['Trueflight'].Acc = set_combine(sets.precast.WS.Acc, sets.Trueflight)

        sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Wildfire']

        -- CORONACH
        sets.Coronach = {
            neck="Breeze Gorget",
            waist="Thunder Belt",
            back=Belenus.STP,
        }
        sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, sets.Coronach)
        sets.precast.WS['Coronach'].Mid = set_combine(sets.precast.WS.Mid, sets.Coronach)
        sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS.Acc, sets.Coronach)

        -- sets.precast.WS['Coronach'].SAM = set_combine(sets.precast.WS, {
        --     neck="Ocachi Gorget",
        --     ear1="Enervating Earring",
        --     ear2="Tripudio Earring",
        --     hands="Amini Glovelettes +1",
        --     legs="Amini Brague +1", 
        -- })

        -- LAST STAND
        sets.LastStand = {
            head="Orion Beret +2",
            neck="Aqua Gorget",
            ear2="Moonshade Earring",
            back=Belenus.STP,
            waist="Light Belt",
            feet="Meghanada Jambeaux +2"
        }
        sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, sets.LastStand)
        sets.precast.WS['Last Stand'].Mid = set_combine(sets.precast.WS.Mid, sets.LastStand)
        sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS.Acc, sets.LastStand)

        -- sets.precast.WS['Last Stand'].SAM = set_combine(sets.precast.WS, {
        --     neck="Aqua Gorget",
        --     ear1="Tripudio Earring",
        --     ear2="Moonshade Earring",
        --     hands="Amini Glovelettes +1",
        --     ring2="Garuda Ring",
        --     waist="Light Belt",
        --     legs="Amini Brague +1", 
        -- })
        
        -- DETONATOR
        sets.Detonator = {
           ear2="Moonshade Earring",
           neck="Flame Gorget",
           waist="Light Belt",
        }
        sets.precast.WS['Detonator'] = set_combine(sets.precast.WS, sets.Detonator)
        sets.precast.WS['Detonator'].Mid = set_combine(sets.precast.WS.Mid, sets.Detonator)
        sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS.Acc, sets.Detonator)
        
        -- SLUG SHOT
        sets.SlugShot = {
           neck="Breeze Gorget",
           ear2="Moonshade Earring",
           waist="Light Belt",
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
            back=Belenus.STP
        }
        sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, sets.Namas)
        sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS.Mid, sets.Namas)
        sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS.Acc, sets.Namas)
        
        -- sets.precast.WS['Namas Arrow'].SAM = set_combine(sets.precast.WS, {
        --     neck="Aqua Gorget",
        --     ear1="Enervating Earring",
        --     ear2="Tripudio Earring",
        --     waist="Light Belt",
        --     back="Sylvan Chlamys",
        --     legs="Amini Brague +1", 
        -- })

        -- JISHNUS
        sets.Jishnus = {
            neck="Flame Gorget",
            ear2="Moonshade Earring",
            waist="Light Belt",
            ring2="Rajas Ring",
            back="Rancorous Mantle",
            legs="Herculean Trousers",
            feet="Thereoid Greaves"
        }
        sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, sets.Jishnus)
        sets.precast.WS['Jishnu\'s Radiance'].Mid = set_combine(sets.precast.WS.Mid, {
            neck="Flame Gorget",
            ear2="Moonshade Earring",
            waist="Light Belt",
            legs="Adhemar Kecks",
            ring2="Rajas Ring",

        })
        sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS.Acc, {
            neck="Flame Gorget",
            ear2="Moonshade Earring",
            waist="Light Belt"
        })

        -- SIDEWINDER
        sets.Sidewinder = {
            neck="Aqua Gorget",
            ear2="Moonshade Earring",
            waist="Light Belt",
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
            head="Meghanada Visor +1",
            neck="Scout's gorget", 
            ear1="Enervating Earring",
            ear2="Flame Pearl",
            body="Orion Jerkin +2",
            hands="Orion Bracers +1",
            ring1="Apate Ring",
            ring2="Mummu Ring",
            back=Belenus.STP,
            waist="Kwahu Kachina Belt",
            legs="Meghanada Chausses +1", 
            feet="Meghanada Jambeaux +2"
        }
        -- placeholder until I can get to it
        sets.buff.Barrage.Mid = sets.buff.Barrage
        sets.buff.Barrage.Acc = set_combine(sets.buff.Barrage, {
            hands="Meghanada Gloves +2",
            ring1="Cacoethic Ring +1"
        })
        sets.buff.Camouflage =  {body="Orion Jerkin +2"}

        sets.Overkill =  {
            body="Arcadian Jerkin +1"
        }
        sets.Overkill.Preshot = set_combine(sets.precast.RA, sets.Overkill)

end

function job_pretarget(spell, action, spellMap, eventArgs)
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
    -- If autora enabled, use WS automatically at 100+ TP
    if spell.action_type == 'Ranged Attack' then
        if player.tp >= 1000 and state.AutoRA.value == 'WS' and not buffactive.amnesia then
            cancel_spell()
            use_weaponskill()
        end
    end
end 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
 
function job_precast(spell, action, spellMap, eventArgs)
        
        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
        --add_to_chat(8, state.CombatForm)
        if sam_sj then
            classes.CustomClass = 'SAM'
        end

        if spell.action_type == 'Ranged Attack' and player.equipment.range == gear.Bow then
            state.CombatWeapon:set('Bow')
        end
        -- add support for RangedMode toggles to EES
        if spell.english == 'Eagle Eye Shot' then
            classes.JAMode = state.RangedMode.value
        end
        -- Safety checks for weaponskills 
        if spell.type:lower() == 'weaponskill' then
            if player.tp < 1000 then
                    eventArgs.cancel = true
                    return
            end
            if ((spell.target.distance >8 and spell.skill ~= 'Archery' and spell.skill ~= 'Marksmanship') or (spell.target.distance >21)) then
                -- Cancel Action if distance is too great, saving TP
                add_to_chat(122,"Outside WS Range! /Canceling")
                eventArgs.cancel = true
                return
            
            elseif state.DefenseMode.value ~= 'None' then
                -- Don't gearswap for weaponskills when Defense is on.
                eventArgs.handled = true
            end
        end
        -- Ammo checks
        if spell.action_type == 'Ranged Attack' or
          (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
            check_ammo(spell, action, spellMap, eventArgs)
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
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end
 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    -- Barrage
    if spell.action_type == 'Ranged Attack' and state.Buff.Barrage then
        if state.RangedMode.current == 'Mid' then
            equip(sets.buff.Barrage.Mid)
        elseif state.RangedMode.current == 'Acc' then
            equip(sets.buff.Barrage.Acc)
        else
            equip(sets.buff.Barrage.Acc)
        end
        eventArgs.handled = true
    end
    if state.Buff.Camouflage then
        equip(sets.buff.Camouflage)
    end
    if state.Buff.Overkill then
        equip(sets.Overkill)
    end
    if spell.action_type == 'Ranged Attack' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
    end
end

 
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- autora
    if state.AutoRA.value ~= 'Normal' then
        use_ra(spell)
    end

    if state.Buff[spell.name] ~= nil then
        state.Buff[spell.name] = not spell.interrupted or buffactive[spell.english]
    end

end
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    --if S{"courser's roll"}:contains(buff:lower()) then
    --if string.find(buff:lower(), 'samba') then

    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    end
    if buff == 'Velocity Shot' and gain then
        windower.send_command('wait 290;input /echo **VELOCITY SHOT** Wearing off in 10 Sec.')
    elseif buff == 'Double Shot' and gain then
        windower.send_command('wait 90;input /echo **DOUBLE SHOT OFF**;wait 90;input /echo **DOUBLE SHOT READY**')
    elseif buff == 'Decoy Shot' and gain then
        windower.send_command('wait 170;input /echo **DECOY SHOT** Wearing off in 10 Sec.];wait 120;input /echo **DECOY SHOT READY**')
    end

    if  buff == "Samurai Roll" or buff == "Courser's Roll" or string.find(buff:lower(), 'flurry') then
        classes.CustomRangedGroups:clear()

        if (buff == "Samurai Roll" and gain) or buffactive['Samurai Roll'] then
            classes.CustomRangedGroups:append('SamRoll')
        end
       
    end
    
    -- DoubleShot CombatForm
    if (buff == 'Double Shot' and gain or buffactive['Double Shot']) then
        state.CombatForm:set('DoubleShot')
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    else
        state.CombatForm:reset()
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
    
    -- Flurry I = 265, Flurry II = 581
    if (string.find(buff:lower(), 'flurry') and gain) then
        if buffactive[265] then
            classes.CustomRangedGroups:append('F1')
        elseif buffactive[581] then
            classes.CustomRangedGroups:append('F2')
        end
    end

    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end

    if buff == "Camouflage" or buff == "Overkill" or buff == "Samurai Roll" or buff == "Courser's Roll" then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end
 
-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)
    --select_earring()
end
 
function customize_idle_set(idleSet)
    if state.HybridMode.value == 'PDT' then
        state.IdleMode.value = 'PDT'
    elseif state.HybridMode.value ~= 'PDT' then
        state.IdleMode.value = 'Normal'
    end
    if state.Buff.Camouflage then
        idleSet = set_combine(idleSet, sets.buff.Camouflage)
    end
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
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
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    return meleeSet
end
 
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        update_combat_form()
    end
    if newStatus == "Engaged" and player.equipment.range == gear.Bow then
         state.CombatWeapon:set('Bow')
    end
    if camo_active() then
        disable('body')
    else
        enable('body')
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
    update_combat_form()
    get_custom_ranged_groups()
    sam_sj = player.sub_job == 'SAM' or false
    -- called here incase buff_change failed to update value
    state.Buff.Camouflage = buffactive.camouflage or false
    state.Buff.Overkill = buffactive.overkill or false

    if camo_active() then
        disable('body')
    else
        enable('body')
    end
end
 
---- Job-specific toggles.
--function job_toggle_state(field)
--    if field:lower() == 'autora' then
--        state.AutoRA = not state.AutoRA
--        return state.AutoRA
--    end
--end
 
---- Request job-specific mode lists.
---- Return the list, and the current value for the requested field.
--function job_get_option_modes(field)
--    if field:lower() == 'autora' then
--        return state.AutoRA
--    end
--end
-- 
---- Set job-specific mode values.
---- Return true if we recognize and set the requested field.
--function job_set_option_mode(field, val)
--    if field:lower() == 'autora' then
--        state.AutoRA = val
--        return true
--    end
--end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = ''
    if state.AutoRA.value ~= 'Normal' then
        msg = '[Auto RA: ON]['..state.AutoRA.value..']'
    else
        msg = '[Auto RA: OFF]'
    end

    add_to_chat(122, 'Ranged: '..state.RangedMode.value..'/'..state.HybridMode.value..', WS: '..state.WeaponskillMode.value..', '..msg)
    
    eventArgs.handled = true
 
end

-- Special WS mode for Sam subjob
function get_custom_wsmode(spell, spellMap, ws_mode)
    if spell.skill == 'Archery' or spell.skill == 'Marksmanship' then
        if player.sub_job == 'SAM' then
            return 'SAM'
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function update_combat_form()
    if S{'NIN', 'DNC'}:contains(player.sub_job) and rng_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
    else
        if state.CombatForm.current ~= 'DoubleShot' then
            state.CombatForm:reset()
        end
    end
    if state.Buff['Double Shot'] then
        state.CombatForm:set('DoubleShot')
    else
        if state.CombatForm.current ~= 'DW' then
            state.CombatForm:reset()
        end
    end
end

function get_custom_ranged_groups()
    classes.CustomRangedGroups:clear()
    
    if buffactive['Samurai Roll'] then
        classes.CustomRangedGroups:append('SamRoll')
    end
    
    -- Flurry I = 265, Flurry II = 581
    if buffactive[265] then
        classes.CustomRangedGroups:append('F1')
    elseif buffactive[581] then
        classes.CustomRangedGroups:append('F2')
    end

end

function use_weaponskill()
    if player.equipment.range == gear.Bow then
        send_command('input /ws "'..auto_bow_ws..'" <t>')
    elseif player.equipment.range == gear.Gun then
        send_command('input /ws "'..auto_gun_ws..'" <t>')
    end
end

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Auto RA' then
        if newValue ~= 'Normal' then
            send_command('@wait 2.5; input /ra <t>')
        end
    end
end

function use_ra(spell)
    
    local delay = '2.2'
    -- BOW
    if player.equipment.range == gear.Bow then
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25'
         else
             if buffactive["Courser's Roll"] then
                 delay = '0.7' -- MAKE ADJUSTMENT HERE
             elseif buffactive["Flurry II"] or buffactive.Overkill then
                 delay = '0.5'
             else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    else
    -- GUN 
        if spell.type:lower() == 'weaponskill' then
            delay = '2.25' 
        else
            if buffactive["Courser's Roll"] then
                delay = '0.7' -- MAKE ADJUSTMENT HERE
            elseif buffactive.Overkill or buffactive['Flurry II'] then
                delay = '0.5'
            else
                delay = '1.05' -- MAKE ADJUSTMENT HERE
            end
        end
    end
    send_command('@wait '..delay..'; input /ra <t>')
end

function camo_active()
    return state.Buff['Camouflage']
end
-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
    -- Filter ammo checks depending on Unlimited Shot
    if state.Buff['Unlimited Shot'] then
        if player.equipment.ammo ~= U_Shot_Ammo[player.equipment.range] then
            if player.inventory[U_Shot_Ammo[player.equipment.range]] or player.wardrobe[U_Shot_Ammo[player.equipment.range]] then
                add_to_chat(122,"Unlimited Shot active. Using custom ammo.")
                equip({ammo=U_Shot_Ammo[player.equipment.range]})
            elseif player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
                add_to_chat(122,"Unlimited Shot active but no custom ammo available. Using default ammo.")
                equip({ammo=DefaultAmmo[player.equipment.range]})
            else
                add_to_chat(122,"Unlimited Shot active but unable to find any custom or default ammo.")
            end
        end
    else
        if player.equipment.ammo == U_Shot_Ammo[player.equipment.range] and player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
            if DefaultAmmo[player.equipment.range] then
                if player.inventory[DefaultAmmo[player.equipment.range]] then
                    add_to_chat(122,"Unlimited Shot not active. Using Default Ammo")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                else
                    add_to_chat(122,"Default ammo unavailable.  Removing Unlimited Shot ammo.")
                    equip({ammo=empty})
                end
            else
                add_to_chat(122,"Unable to determine default ammo for current weapon.  Removing Unlimited Shot ammo.")
                equip({ammo=empty})
            end
        elseif player.equipment.ammo == 'empty' then
            if DefaultAmmo[player.equipment.range] then
                if player.inventory[DefaultAmmo[player.equipment.range]] then
                    add_to_chat(122,"Using Default Ammo")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                else
                    add_to_chat(122,"Default ammo unavailable.  Leaving empty.")
                end
            else
                add_to_chat(122,"Unable to determine default ammo for current weapon.  Leaving empty.")
            end
        elseif player.inventory[player.equipment.ammo].count < 15 then
            add_to_chat(122,"Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low ("..player.inventory[player.equipment.ammo].count..")")
        end
    end
end
-- Orestes uses Samurai Roll. The total comes to 5!
--function detect_cor_rolls(old,new,color,newcolor)
--    if string.find(old,'uses Samurai Roll. The total comes to') then
--        add_to_chat(122,"SAM Roll")
--    end
--end
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

