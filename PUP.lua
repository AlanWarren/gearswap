----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[

    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714

    ASCII Art Generator: http://www.network-science.de/ascii/
    
]]

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
    include('organizer-lib')
end

function user_setup()
    -- Alt-F10 - Toggles Kiting Mode.

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "Acc", "TP", "DT", "Regen", "Ranged")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[ 
        This will toggle the CP Mode 
        //gs c toggle CP 
    ]] 
    state.CP = M(false, "CP") 
    CP_CAPE = "Aptitude Mantle +1" 

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind end gs c toggle CP") 
    send_command("bind = gs c clear")

    select_default_macro_book()

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    -- pos_x = 2250
    -- pos_y = 370
    pos_x = 1400
    pos_y = 170
    setupTextWindow(pos_x, pos_y)
    
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")       
    send_command("unbind end")
    send_command("unbind =")
end

function job_setup()
    include("PUP-LIB.lua")
end

function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
    Animators = {}
    --Animators.Range = "Animator P II"
    Animators.Range = "Divinator II"
    Animators.Melee = "Animator P +1"
    --Animators.Melee = "Neo Animator"

    HercFeet = {}
    HercHead = {}
    HercHands = {}
    HercBody = {}

    HercHands.R = { name="Herculean Gloves", augments={'AGI+9','Accuracy+3','"Refresh"+1',}}
    --HercHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','INT+4','Mag. Acc.+8','"Mag.Atk.Bns."+13',}}
    HercHands.WSD = { name="Herculean Gloves", augments={'Accuracy+23 Attack+23','Weapon skill damage +3%','STR+10','Accuracy+10','Attack+1',}}
    
    HercHead.TP = { name="Herculean Helm", augments={'Accuracy+25','"Triple Atk."+4','AGI+6','Attack+14',}}
    HercHead.DM = { name="Herculean Helm", augments={'Pet: STR+9','Mag. Acc.+10 "Mag.Atk.Bns."+10','Weapon skill damage +9%','Accuracy+12 Attack+12',}}

    HercFeet.TP = { name="Herculean Boots", augments={'Accuracy+21 Attack+21','"Triple Atk."+4','DEX+8',}}
    
    HercBody.WSD = { name="Herculean Vest", augments={'"Blood Pact" ability delay -4','AGI+3','Weapon skill damage +9%','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}
    
    Visucius = {}
    Visucius.TP = { name="Visucius's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+8','"Dbl.Atk."+10',}}
    Visucius.PET = { name="Visucius's Mantle", augments={'Pet: Acc.+7 Pet: R.Acc.+7 Pet: Atk.+7 Pet: R.Atk.+7','Accuracy+20 Attack+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: Haste+10',}}
    
    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe +1"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas +1"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Puppetry Babouches +1"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +2" --Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe +2" --Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas +2" --Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pitre Churidars +2" --Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pitre Babouches +1" --Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto"
    Empy_Karagoz.Hands = "Karagoz Guanti"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni +1"
    Empy_Karagoz.Feet_Tatical = "Karagoz Scarpe +1"

    sets.organizer = { 
        main="Midnights",
        sub="Puppetry Tobe",
        ammo="Sakpata's Fists",
        ear1="Neo Animator",
        ear2="Ohtas",
        hands="Tali'ah Gages +1",
        legs="Puppetry Churidars",
        feet="Divinator II",
        body="Tali'ah Crackows +2"
    }
    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {
        main="Sakpata's Fists",
        --head="Pitre Taj",
        head="Nyame Helm",
        neck="Sanctity Necklace",
        ear1="Infused Earring",
        ear2="Genmei Earring",
        --body="Foire Tobe",
        body="Hizamaru Haramaki +2",
        hands="Nyame Gauntlets",
        ring1="Defending Ring",
        ring2="Paguroidea Ring",
        back=Visucius.PET,
        waist="Moonbow Belt",
        legs="Nyame Flanchard",
        feet="Hermes' Sandals"
    }

    -------------------------------------Fastcast
    sets.precast.FC = {
        head=HercHead.TP,
        ear1="Loquacious Earring",
        ring1="Weatherspoon Ring",
        ring2="Prolix Ring",
        legs="Quiahuiz Trousers",
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
       -- Add your set here 
    }

    -------------------------------------Kiting
    sets.Kiting = {feet = "Hermes' Sandals"}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads"})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {
        -- feet = Empy_Karagoz.Feet_Tatical
    }

    sets.precast.JA["Ventriloquy"] = {
        -- legs = Relic_Pitre.Legs_PMagic
    }

    sets.precast.JA["Role Reversal"] = {
        -- feet = Relic_Pitre.Feet_PMagic
    }

    sets.precast.JA["Overdrive"] = {
        body=Relic_Pitre.Body_PTP
    }

    sets.precast.JA["Repair"] = {
        ammo="Automat. Oil +3",
        feet="Foire Babouches +1"
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
        main="Midnights",
        neck="Buffoon's Collar",
        -- body = "Karagoz Farsetto",
        hands = Artifact_Foire.Hands_Mane_Overload,
        back=Visucius.PET,
        ear1="Burana Earring"
    }

    sets.precast.JA["Activate"] = {
        back=Visucius.PET,
        feet = "Mpaca's Boots"
    }

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       -- Add your set here 
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Mpaca's Cap",
        neck="Shulmanu Collar",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        body=HercBody.WSD,
        hands=HercHands.WSD,
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
        waist="Moonbow Belt",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = set_combine(sets.precast.WS, {})

    sets.precast.WS["Stringing Pummel"].Mod = set_combine(sets.precast.WS, {})

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
        ear1="Schere Earring",
        ear2="Moonshade Earring",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves'",
        neck="Breeze Gorget"
    })
    sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS["Victory Smite"], {
        ear1="Schere Earring",
        neck="Shulmanu Collar",
        body="Tali'ah Manteel +2",
    })

    sets.precast.WS["Shijin Spiral"] =
        set_combine(
        sets.precast.WS, {
            ear1="Schere Earring",
            head="Malignance Chapeau",
            neck="Flame Gorget",
            hands="Malignance Gloves",
            body="Tali'ah Manteel +2",
            waist="Moonbow Belt"
        }

    )

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
        main="Sakpata's Fists",
        head="Nyame Helm",
        neck="Sanctity Necklace",
        ear1="Infused Earring",
        ear2="Genmei Earring",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Defending Ring",
        ring2="Paguroidea Ring",
        back=Visucius.PET,
        waist="Moonbow Belt",
        legs="Nyame Flanchard",
        feet="Hermes' Sandals"
    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
        main="Sakpata's Fists",
        --head="Ryuo Somen",
        head=HercHead.TP,
        neck="Shulmanu Collar",
        ear1="Mache Earring",
        ear2="Schere Earring",
        --body="Tali'ah Manteel +2",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
        back=Visucius.TP,
        waist="Moonbow Belt",
        legs="Mpaca's Hose",
        feet=HercFeet.TP,
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = set_combine(sets.engaged.Master, {
        ear1="Cessance Earring",
    })

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = sets.engaged.Master

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = set_combine(sets.engaged.Master, { 
        head="Mpaca's Cap",
        ring2="Defending Ring"
    })

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
        main="Sakpata's Fists",
        head="Mpaca's Cap",
        neck="Shulmanu Collar",
        ear1="Crepuscular Earring",
        ear2="Mache Earring",
        body="Mpaca's Doublet",
        --body="Tali'ah Manteel +2",
        hands="Mpaca's Gloves",
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
        back=Visucius.TP,
        waist="Moonbow Belt",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
    }

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = set_combine(sets.engaged.MasterPet, {
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
    })

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = sets.engaged.MasterPet

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = set_combine(sets.engaged.MasterPet, {
        main="Midnights",
        head="Nyame Helm",
        legs="Nyame Flanchard",
    })

    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = sets.engaged.MasterPet

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = sets.engaged.MasterPet

    sets.midcast.Pet.Cure = sets.engaged.MasterPet

    sets.midcast.Pet["Healing Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Elemental Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Enfeebling Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Dark Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Divine Magic"] = sets.engaged.MasterPet

    sets.midcast.Pet["Enhancing Magic"] = sets.engaged.MasterPet

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = set_combine(sets.idle, {
        ear2="Burana Earring",
        ring2="Paguroidea Ring",
        --body="",
        -- feet="Hermes' Sandals"
    })

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting

        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = set_combine(sets.idle.Pet, {
        main="Ohtas",
        ring2="Defending Ring"
    })

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = sets.engaged.MasterPet

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = set_combine(sets.engaged.MasterPet, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        ring2="Defending Ring"
    })

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = set_combine(sets.engaged.MasterPet, {
        head="Rao Kabuto",
        main="Ohtas",
        body=Relic_Pitre.Body_PTP,
        waist="Klouskap Sash",
        ear1="Crepuscular Earring",
        ear2="Burana Earring",
        ring1="Varar Ring",
        ring2="Varar Ring",
        back=Visucius.PET,
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = set_combine(sets.engaged.MasterPet, {
        head="Rao Kabuto",
        main="Ohtas",
        back=Visucius.PET,
        body=Relic_Pitre.Body_PTP,
        waist="Klouskap Sash",
        ear1="Crepuscular Earring",
        ear2="Burana Earring",
        ring1="Varar Ring",
        ring2="Varar Ring",
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
    sets.idle.Pet.Engaged.TP = set_combine(sets.engaged.MasterPet, {
        head="Rao Kabuto",
        main="Ohtas",
        body=Relic_Pitre.Body_PTP,
        waist="Klouskap Sash",
        ear1="Crepuscular Earring",
        ear2="Burana Earring",
        ring1="Varar Ring",
        ring2="Varar Ring",
        back=Visucius.PET,
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
    sets.idle.Pet.Engaged.DT = set_combine(sets.engaged.MasterPet, {
        head="Rao Kabuto",
        main="Midnights",
        body="Mpaca's Doublet",
        ear1="Crepuscular Earring",
        ear2="Burana Earring",
        waist="Klouskap Sash",
        ring1="Varar Ring",
        ring2="Varar Ring",
        legs="Tali'ah Seraweels +1",
        back=Visucius.PET,
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = set_combine(sets.engaged.MasterPet, {
        ear2="Burana Earring",
        back=Visucius.PET,
    })

    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged =
        set_combine(
        sets.idle.Pet.Engaged,
        {
        back=Visucius.PET,
        }
    )

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
        -- head = Empy_Karagoz.Head_PTPBonus,
        main="Sakpata's Fists",
        head="Mpaca's Cap",
        --neck="Twilight Torque",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        ring1="Varar Ring",
        ring2="Gere Ring",
        back=Visucius.PET,
        waist="Klouskap Sash",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
       -- Add your set here
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = sets.midcast.Pet.WSNoFTP

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {
        main="Sakpata's Fists",
        head="Mpaca's Cap",
        --neck="Twilight Torque",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        ring1="Varar Ring",
        ring2="Gere Ring",
        back=Visucius.PET,
        waist="Klouskap Sash",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
    }

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =
        set_combine(
        sets.midcast.Pet.WSNoFTP,
        {
            -- Add your gear here that would be different from sets.midcast.Pet.WSNoFTP
            -- head = Empy_Karagoz.Head_PTPBonus
        }
    )

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(
        sets.midcast.Pet.WSFTP,
        {
            -- Add your gear here that would be different from sets.midcast.Pet.WSFTP
            -- head = Empy_Karagoz.Head_PTPBonus
        }
    )

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = set_combine(sets.idle, {
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        ring1="Niqmaddu Ring",
        ring2="Gere Ring",
    })

    -- Resting sets
    sets.resting = {
       -- Add your set here
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book

    set_macro_page(5, 11)
    -- if player.sub_job == "WAR" then
    --     set_macro_page(3, 1)
    -- elseif player.sub_job == "NIN" then
    --     set_macro_page(3, 1)
    -- elseif player.sub_job == "DNC" then
    --     set_macro_page(3, 1)
    -- else
    --     set_macro_page(3, 1)
    -- end
end

