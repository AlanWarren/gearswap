	

    -- Current Owner: AlanWarren, aka ~ Orestes 
    -- Orinal file credit KBEEZIE
    -- current file resides @ https://github.com/AlanWarren/gearswap

    -- //gs show_swaps()
     
    -- === Some Notes On Sets ===
    -- I've left in KBEEZIE's Unlimited Shot checks for now, but will remove soon since the JA no longer has
    -- any use.  
    
    -- === My Modes ===
    -- 1) STP is a  4/hit with Annihilator, but sacrifices some racc/ratk to get there.
    -- 3) Normal has a nice mixture of racc and stp for hard content. 
    -- 4) Racc is full blown racc. i.e. You're fighting VD MR and songs drop.  
    
    -- === Advanced Features ===
    -- Fenrir's Earring is equipped in midcast at night, and Clearview Earring during the day...
    -- Except in the following conditions: 
    -- If you're in STP mode, this feature is disabled in favor of Tripudio Earring
    -- If you have /SAM set as SJ, Tripudio is set during the day. 
    
    -- Orion Jerkin +1 is locked in place during Camouflage
    -- Arcadian Jerkin is locked in place during Overkill
    -- If Courser's Roll is active, we replace a few pieces of snapshot gear with rapidshot (still testing)

    -- === In Precast ===
    -- 1) Checks to make sure you're in an engaged state and have 100+ TP before firing a weaponskill
    -- 2) Checks the distance to target to prevent WS from being fired when target is too far (prevents TP loss)
    -- 3) Does not allow gear-swapping on weaponskills when Defense mode is enabled
    -- 4) Checks to see of "Unlimited Shot" buff is on, if there's any special ammo defined in sets equipped
    -- 5) Checks for empty ammo (or special without buff) and fills in the default ammunition for that weapon
    --    ^ keeps empty if that ammo cannot be found, or there is no match to the weapon equipped
    -- 6) Provides a low ammunition warning if current ammo in slot (counts all in inventory) is less than 15
    --    ^ If you have 5 Tulfaire arrows in slot, but 20 also in inventory it see's it as 25 total
     
    -- === In Midcast ===
    -- If Sneak is active, sends the cancel command before Spectral Jig finish casting
     
    -- === In Post-Midcast ===
    -- If Barrage Buff is active, equips sets.BarrageMid
     
    -- === In Buff Change ===
    -- If Camouflage is active, disable body swaping
    -- This is done to preserve the +100 Camouflage Duration given by Orion Jerkin
     
    function get_sets()
            -- Load and initialize the include file.
            include('Mote-Include.lua')
            init_include()
     
            -- UserGlobals may define additional sets to be added to the local ones.
            if define_global_sets then
                    define_global_sets()
            end
     
            -- Optional: load a sidecar version of the init and unload functions.
            --load_user_gear(player.main_job)
            --init_gear_sets()
     
            -- Global default binds
            binds_on_load()
     
            send_command('bind f9 gs c cycle RangedMode')
            send_command('bind ^f9 gs c cycle DefenseMode')
            send_command('bind !f9 gs c cycle WeaponskillMode')
    end

    function job_setup()
        state.Buff.Camouflage = buffactive.camouflage or false
        state.Buff.Overkill = buffactive.overkill or false
    end
     
    -- Called when this job file is unloaded (eg: job change)
    function file_unload()
            binds_on_unload()
    end
     
    function init_gear_sets()
            -- Overriding Global Defaults for this job
            -- gear.Staff = {} no need to set this, it's already set
            gear.Staff.PDT = ""
            gear.default.weaponskill_neck = "Sylvan Scarf"
            gear.default.weaponskill_waist = "Scout's Belt"
     
            -- List of ammunition that should only be used under unlimited shot
            U_Shot_Ammo = S{'Animikii Bullet'}
           
            -- Simply add a line of DefaultAmmo["Weapon"] = "Ammo Name"
            DefaultAmmo = {}
            DefaultAmmo["Annihilator"] = "Achiyalabopa bullet"
            DefaultAmmo["Ajjub Bow"] = "Achiyalabopa arrow"
            DefaultAmmo["Atetepeyorg"] = "Achiyalabopa bolt"
           
            --add_to_chat(123,'sidecar load')
            -- Options: Override default values
     
            options.OffenseModes = {'Normal', 'Melee'}
            options.RangedModes = {'Normal', 'ACC', 'STP' }
            options.DefenseModes = {'Normal', 'PDT'}
            options.WeaponskillModes = {'Normal', 'ACC'}
            options.PhysicalDefenseModes = {'PDT'}
            options.MagicalDefenseModes = {'MDT'}
            state.Defense.PhysicalMode = 'PDT'
     
            -- Misc. Job Ability precasts
            --sets.precast.Step = {ear2="Choreia Earring"}
            sets.precast.JA['Bounty Shot'] = {hands="Sylvan Glovelettes +2"}
            sets.precast.JA['Double Shot'] = {head="Sylvan Gapette +2"}
            sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
            sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
            sets.precast.JA['Velocity Shot'] = {body="Sylvan Caban +2"}
            sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
            sets.precast.JA['Eagle Eye Shot'] = {feet="Scout's Braccae +2"}

            sets.STPEarring = {ear2="Tripudio earring"}
            sets.NightEarring = {ear2="Fenrir's earring"}
            sets.NightEarring.STP = {ear2="Tripudio earring"}
            sets.DayEarring = {ear2="Clearview earring"}
            sets.DayEarring.STP = {ear2="Tripudio earring"}
            sets.earring = select_earring()

            select_default_macro_book()

            snapshot_mode = { "Normal", "RapidShot" }
            snapshot_index = 1

            -- Idle Set (My 'base')
            sets.idle = {
                head="Arcadian Beret +1",
                neck="Twilight torque",
                ear1="Volley Earring",
                ear2="Clearview Earring",
                body="Kyujutsugi",
                hands="Iuitl Wristbands",
                ring1="Dark Ring",
                ring2="Paguroidea Ring",
                back="Shadow Mantle",
                waist="Scout's Belt",
                legs="Nahtirah Trousers",
                feet="Orion Socks +1"
            }

            sets.idle.Town = set_combine(sets.idle, {
                    neck="Ocachi Gorget",
                    ear1="Fenrir's Earring",
                    ear2="Tripudio Earring",
                    ring1="Rajas Ring",
                    ring2="Pyrosoul Ring",
                    back="Lutian Cape"
            })
     
            -- Engaged sets

            sets.engaged =  {
                head="Arcadian Beret +1",
                neck="Ocachi Gorget",
                ear1="Volley Earring",
                ear2="Clearview Earring",
                body="Kyujutsugi",
                hands="Sigyn's Bazubands",
                ring1="Rajas Ring",
                ring2="Paguroidea Ring",
                back="Shadow Mantle",
                waist="Scout's Belt",
                legs="Nahtirah Trousers",
                feet="Orion Socks +1"
            }

            sets.engaged.Melee = {
                head="Whirlpool Mask",
                neck="Asperity Necklace",
                ear1="Bladeborn Earring",
                ear2="Steelflash Earring",
                body="Thaumas Coat",
                hands="Iuitl Wristbands",
                ring1="Rajas Ring",
                ring2="Epona's Ring",
                back="Atheling Mantle",
                waist="Cetl Belt",
                legs="Manibozho Brais",
                feet="Manibozho Boots"
            }
            -- Custom Sets
            sets.engaged.Yoichinoyumi = {}

            sets.engaged.Yoichinoyumi = set_combine(sets.engaged, {
                hands="Manibozho Gloves",
                feet="Arcadian Socks +1"
            })
           
            -- Ranged Attack Sets
            sets.precast.RangedAttack = set_combine(sets.engaged, {
                head="Sylvan Gapette +2",
                body="Sylvan Caban +2",
                hands="Iuitl Wristbands",
                legs="Nahtirah Trousers",
                waist="Impulse Belt",
                feet="Wurrukatte Boots"
            })
            -- we have a toggle for this in self_command()
            sets.precast.RangedAttack.Normal = sets.precast.RangedAttack
            sets.precast.RangedAttack.RapidShot = set_combine(sets.precast.RangedAttack, {
                head="Orion Beret +1",
                feet="Arcadian Socks +1"
            })

            sets.midcast.Ear = {}
            sets.midcast.Ear = set_combine(sets.engaged, sets.earring)
            
            sets.midcast.RangedAttack = set_combine(sets.midcast.Ear, {
                ring2="Paqichikaji Ring",
                back="Lutian Cape",
                legs="Aetosaur Trousers +1"
            })
            sets.midcast.RangedAttack.Acc = set_combine(sets.midcast.RangedAttack, {
                neck="Huani Collar",
                ring1="Hajduk Ring",
                ring2="Paqichikaji Ring",
                legs="Aetosaur Trousers +1"
            })
            sets.midcast.RangedAttack.STP = set_combine(sets.midcast.RangedAttack, {
                back="Sylvan Chlamys",
                ear2="Tripudio earring",
                legs="Aetosaur Trousers +1"
            })
            
            -- Yoichi
            sets.midcast.Yoichinoyumi = {}
            sets.midcast.Yoichinoyumi.Ear = {}
            sets.midcast.Yoichinoyumi.Ear = set_combine(sets.engaged.Yoichinoyumi, sets.earring)

            sets.midcast.RangedAttack.Yoichinoyumi = {}
            sets.midcast.RangedAttack.Yoichinoyumi = set_combine(sets.midcast.Yoichinoyumi.Ear, {
                ring2="Paqichikaji Ring",
                back="Sylvan Chlamys",
                legs="Aetosaur Trousers +1",
            })
            sets.midcast.RangedAttack.Yoichinoyumi.Acc = set_combine(sets.midcast.RangedAttack.Yoichinoyumi, {
                neck="Huani Collar",
                ring1="Hajduk Ring",
                ring2="Paqichikaji Ring",
                legs="Aetosaur Trousers +1"
            })
            sets.midcast.RangedAttack.Yoichinoyumi.STP = set_combine(sets.midcast.RangedAttack.Yoichinoyumi, {
               hands="Sylvan Glovelettes +2"
            })
                   
            -- Weaponskill sets
            sets.precast.WS = {
                head="Arcadian Beret +1",
                neck="Sylvan Scarf",
                ear1="Flame Pearl",
                ear2="Flame Pearl",
                body="Kyujutsugi",
                hands="Arcadian Bracers +1",
                ring1="Rajas Ring",
                ring2="Pyrosoul Ring",
                back="Buquwik Cape",
                waist="Scout's Belt",
                legs="Nahtirah Trousers",
                feet="Orion Socks +1"
            }
           
            sets.precast.WS.Acc = set_combine(sets.precast.WS, {
               legs="Orion Braccae +1",
               back="Lutian Cape"
            })

            sets.precast.WS.STP = set_combine(sets.precast.WS, {
               ear2="Tripudio Earring",
               back="Sylvan Chlamys"
            })

            -- CORONACH
            sets.precast.WS['Coronach'] = set_combine(sets.precast.WS, {
               neck="Breeze Gorget",
               waist="Thunder Belt"
            })
            sets.precast.WS['Coronach'].STP = set_combine(sets.precast.WS.STP, sets.precast.WS['Coronach'])
            sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS.Acc, {
                neck="Breeze Gorget",
                waist="Thunder Belt",
                hands="Sigyn's Bazubands"
            })

            -- LAST STAND
            sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS, {
               neck="Aqua Gorget",
               ring2="Stormsoul Ring",
               waist="Light Belt",
               feet="Arcadian Socks +1"
            })
            sets.precast.WS['Last Stand'].STP = set_combine(sets.precast.WS.STP, sets.precast.WS['Last Stand'])
            sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS.Acc, {
                neck="Aqua Gorget",
                ring2="Stormsoul Ring",
                waist="Light Belt",
                hands="Sigyn's Bazubands"
            })
            
            -- DETONATOR
            sets.precast.WS['Detonator'] = set_combine(sets.precast.WS, {
               neck="Flame Gorget",
               waist="Light Belt",
               feet="Arcadian Socks +1"
            })
            sets.precast.WS['Detonator'].STP = set_combine(sets.precast.WS.STP, sets.precast.WS['Detonator'])
            sets.precast.WS['Detonator'].Acc = set_combine(sets.precast.WS.Acc, {
               neck="Flame Gorget",
               waist="Light Belt",
               feet="Arcadian Socks +1",
               hands="Sigyn's Bazubands"
            })

            -- BOW

            sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS, {
                neck="Aqua Gorget",
                waist="Light Belt",
                back="Sylvan Chlamys",
                feet="Arcadian Socks +1"
            })
            sets.precast.WS['Namas Arrow'].STP = set_combine(sets.precast.WS['Namas Arrow'], {
                ear2="Tripudio Earring",
                hands="Sylvan Glovelettes +2"
            })
            sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'], {
                back="Lutian Cape",
                ring2="Paqichikaji Ring",
                legs="Orion Braccae +1"
            })

            sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, {
                head="Uk'uxkaj Cap",
                neck="Flame Gorget",
                waist="Light Belt",
                feet="Arcadian Socks +1",
                back="Rancorous Mantle"
            })
            sets.precast.WS['Jishnu\'s Radiance'].STP = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
                ear2="Tripudio Earring",
                legs="Sylvan Bragues +2",
                hands="Sylvan Glovelettes +2",
                back="Sylvan Chlamys"
            })

            sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
                back="Lutian Cape",
                ring2="Paqichikaji Ring",
                legs="Orion Braccae +1"
            })

            sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS, {
                neck="Aqua Gorget",
                waist="Light Belt",
                hands="Arcadian Bracers +1",
                back="Sylvan Chlamys",
                feet="Arcadian Socks +1"
            })
            sets.precast.WS['Sidewinder'].STP = set_combine(sets.precast.WS['Sidewinder'], {
                ring2="Tripudio Earring",
                hands="Sylvan Glovelettes +2",
                legs="Aetosaur Trousers +1"
            })
            sets.precast.WS['Sidewinder'].Acc = set_combine(sets.precast.WS['Sidewinder'], {
                legs="Aetosaur Trousers +1",
                hands="Manibozho Gloves",
                back="Lutian Cape"
            })

            sets.precast.WS['Refulgent Arrow'] = sets.precast.WS['Sidewinder']
            sets.precast.WS['Refulgent Arrow'].STP = sets.precast.WS['Sidewinder'].STP
            sets.precast.WS['Refulgent Arrow'].Acc = sets.precast.WS['Sidewinder'].Acc
           
            -- Resting sets
            sets.resting = {}
           
            -- Defense sets
            sets.defense.PDT = set_combine(sets.idle, {})
            sets.defense.MDT = set_combine(sets.idle, {})
            --sets.Kiting = {feet="Fajin Boots"}
           
            -- Barrage Set
            sets.BarrageMid = set_combine(sets.midcast.RangedAttack.Acc, {
                neck="Rancor Collar",
                hands="Orion Bracers +1",
                legs="Orion Braccae +1"
            })

            sets.buff.Camouflage =  {body="Orion Jerkin +1"}
            sets.buff.Overkill =  {body="Arcadian Jerkin"}
    end

     
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    -- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
     
    function job_precast(spell, action, spellMap, eventArgs)
            if spell.type:lower() == 'weaponskill' then
                    if player.status ~= "Engaged" or player.tp < 100 then
                            eventArgs.cancel = true
                            return
                    end
                    if (spell.target.distance >8 and not bow_gun_weaponskills:contains(spell.english)) or (spell.target.distance >21) then
                            -- Cancel Action if distance is too great, saving TP
                            add_to_chat(122,"Distance too great for WeaponSkill /Canceling")
                            eventArgs.cancel = true
                            return
                    elseif state.Defense.Active then
                            -- Don't gearswap for weaponskills when Defense is on.
                            eventArgs.handled = true
                    end
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
                                    add_to_chat(122,"Either Defaul Ammo is Unavailable or Unknown Weapon. Staying empty")
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
        if spell.english == "Camouflage" then
            equip(sets.buff.Camouflage)
        elseif spell.english == "Overkill" then
            equip(sets.buff.Overkill)
        end
        sets.earring = select_earring()
    end
     
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    function job_midcast(spell, action, spellMap, eventArgs)
        if spell.name == 'Spectral Jig' and buffactive.sneak then
                -- If sneak is active when using, cancel before completion
                send_command('cancel 71')
        end
    end
     
    -- Run after the default midcast() is done.
    -- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
    function job_post_midcast(spell, action, spellMap, eventArgs)
        if buffactive["Barrage"] then
            equip(sets.BarrageMid)
        end
        if state.Buff['Camouflage'] then
            equip(sets.buff.Camouflage)
        end
        if state.Buff['Overkill'] then
            equip(sets.buff.Overkill)
        end
        sets.earring = select_earring()
    end
     
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    function job_aftercast(spell, action, spellMap, eventArgs)
     
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
    	if state.Buff['Camouflage'] then
    		idleSet = set_combine(idleSet, sets.buff.Camouflage)
    	end
    	if state.Buff['Overkill'] then
    		idleSet = set_combine(idleSet, sets.buff.Overkill)
    	end
        return idleSet
    end
     
    function customize_melee_set(meleeSet)
        meleeSet = set_combine(meleeSet, select_earring())
	    if state.Buff['Camouflage'] then
	    	meleeSet = set_combine(meleeSet, sets.buff.Camouflage)
	    end
	    if state.Buff['Overkill'] then
	    	meleeSet = set_combine(meleeSet, sets.buff.Overkill)
	    end
        return meleeSet
    end
     
    function job_status_change(newStatus, oldStatus, eventArgs)
          if newStatus == 'Engaged' then
              if state.Buff['Camouflage'] then
                  equip(sets.buff.Camouflage)
              elseif state.Buff['Overkill'] then
                  equip(sets.buff.Overkill)
              end
          else 
              if state.Buff['Camouflage'] then
                  equip(sets.buff.Camouflage)
              end
          end
          if camo_active() or overkill_active() then
              eventArgs.handled = true
          end
    end
     
    -- Called when a player gains or loses a buff.
    -- buff == buff gained or lost
    -- gain == true if the buff was gained, false if it was lost.
    function job_buff_change(buff, gain)
	    --if S{"courser's roll"}:contains(buff:lower()) then
        if state.Buff[buff] ~= nil then
	        state.Buff[buff] = gain
	    end

        if not camo_active() or overkill_active() then
            handle_equipping_gear(player.status)
        end
    end
     
    function select_earring()
        -- world.time is given in minutes into each day
        -- 7:00 AM would be 420 minutes
        -- 17:00 PM would be 1020 minutes
        -- If I'm rng/sam use STP earring
        -- otherwise, STP isn't going to make or break me
        -- so I'd like to use Fenrir's at night
        if player.sub_job == 'SAM' then
            return sets.STPEarring
        elseif world.time >= (18*60) or world.time <= (8*60) then
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
    	state.CombatWeapon = player.equipment.range
    end
     
    -- Job-specific toggles.
    function job_toggle(field)
     
    end
     
    -- Request job-specific mode lists.
    -- Return the list, and the current value for the requested field.
    function job_get_mode_list(field)
     
    end
     
    -- Set job-specific mode values.
    -- Return true if we recognize and set the requested field.
    function job_set_mode(field, val)
     
    end
     
    -- Handle auto-targetting based on local setup.
    function job_auto_change_target(spell, action, spellMap, eventArgs)
     
    end
     
    -- Handle notifications of user state values being changed.
    function job_state_change(stateField, newValue)
     
    end
     
    -- Set eventArgs.handled to true if we don't want the automatic display to be run.
    function display_current_job_state(eventArgs)
     
    end

    function camo_active()
    	return state.Buff['Camouflage']
    end

    function overkill_active()
    	return state.Buff['Overkill']
    end

    -- //gs c Toggle Snapshot Mode 
    function self_command(command)
        if command == 'Toggle' then
            snapshot_index = snapshot_index + 1
            if snapshot_index > #snapshot_index then 
                snapshot_index = 1 
                sets.precast.RangedAttack = sets.precast.RangedAttack.Normal
            end
            sets.precast.RangedAttack = sets.precast.RangedAttack.Rapid
            add_to_chat(8, 'Switching snapshot mode to ' .. snapshot_mode[snapshot_index])
        end
    end
     
    -------------------------------------------------------------------------------------------------------------------
    -- Utility functions specific to this job.
    -------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(3, 5)
	elseif player.sub_job == 'SAM' then
		set_macro_page(3, 2)
	else
		set_macro_page(3, 1)
	end
end

