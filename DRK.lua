--[[     
 === Notes ===
 -- Set format is as follows:
    sets.engaged.[CombatForm][CombatWeapon][Offense or DefenseMode]
    CombatForm = War
    CombatWeapon = Scythe

    The default sets are for Sam subjob with a Greatsword.
    The above set format allows you to build sets for war and sam sub with either scythe or gs
--]]
--
    -- Initialization function for this job file.
    function get_sets()
            -- Load and initialize the include file.
            include('Mote-Include.lua')
    end
     
     
    -- Setup vars that are user-independent.
    function job_setup()
        --state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
        --buffactive['Aftermath: Lv.2'] or
        --buffactive['Aftermath: Lv.3']
        --or false
        state.Buff.Souleater = buffactive.souleater or false
        state.Buff['Last Resort'] = buffactive['Last Resort'] or false
	    adjust_engaged_sets()
    end
     
     
    -- Setup vars that are user-dependent.  Can override this function in a sidecar file.
    function user_setup()
            -- Options: Override default values
            options.OffenseModes = {'Normal', 'Mid', 'Acc'}
            options.DefenseModes = {'Normal', 'PDT', 'Reraise'}
            options.WeaponskillModes = {'Normal', 'Mid', 'Acc'}
            options.CastingModes = {'Normal'}
            options.IdleModes = {'Normal'}
            options.RestingModes = {'Normal'}
            options.PhysicalDefenseModes = {'PDT', 'Reraise'}
            options.MagicalDefenseModes = {'MDT'}
     
            state.Defense.PhysicalMode = 'PDT'
			
            war_sj = player.sub_job == 'WAR' or false
			
            adjust_engaged_sets()
            get_combat_form()
	    	determine_haste_group()

            -- Additional local binds
            send_command('bind ^` input /ja "Hasso" <me>')
            send_command('bind !` input /ja "Seigan" <me>')
            send_command('bind ^[ input /lockstyle on')
            send_command('bind ![ input /lockstyle off')
     
            select_default_macro_book()
    end
     
    -- Called when this job file is unloaded (eg: job change)
    function file_unload()
            if binds_on_unload then
                    binds_on_unload()
            end
     
            send_command('unbind ^`')
            send_command('unbind !-')
    end
     
           
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
     
            sets.NightAccAmmo = {ammo="Fire Bomblet"}
            sets.DayAccAmmo = {ammo="Tengu-no-Hane"}
            sets.RegularAmmo = {ammo="Hagneia Stone"}
            sets.Ammo = select_static_ammo() 
            
            -- Waltz set (chr and vit)
            sets.precast.Waltz = {
               head="Yaoyotl Helm",
               body="Fallen's Cuirass +1",
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
                ring1="Sangoma Ring",
                ring2="Mediator's Ring",
                back="Abyss Cape",
                waist="Zoran's Belt",
                legs="Bale Flanchard +2",
                feet="Ignominy sollerets"
            }
           
		    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Dark Magic'], {
                head="Otomi Helm",
                feet="Scamp's Sollerets",
                waist="Zoran's Belt",
                back="Abyss Cape"
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
                back="Toro Cape",
                feet="Ignominy Sollerets"
            }
		   
            sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
                --head="Fallen's Burgeonet +1",
                body="Bale Cuirass +2",
                hands="Boor Braceletes",
                ring1="Beeline Ring",
                ring2="K'ayres Ring",
                back="Repulse Mantle",
                legs="Ignominy Flanchard +1",
                feet="Ejekamal Boots"
            })
            
            sets.midcast.Drain = sets.midcast['Dark Magic'] 
            sets.midcast.Aspir = sets.midcast.Drain

            sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
                back="Chuparrosa Mantle",
            })

            sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {
                hands="Bale Gauntlets +2"
            })

            -- Weaponskill sets
            sets.precast.WS = {
                ammo="Fracas Grenade",
                head="Otomi Helm",
                neck="Bale Choker",
                ear1="Brutal Earring",
                ear2="Bale Earring",
                body="Fallen's Cuirass +1",
                hands="Mikinaak Gauntlets",
                ring1="Ifrit Ring",
                ring2="Pyrosoul Ring",
                back="Niht Mantle",
                waist="Windbuffet Belt",
                legs="Ignominy Flanchard +1",
                feet="Fallen's Sollerets +1"
            }
            sets.precast.WS.Mid = set_combine(sets.precast.WS, {
                head="Yaoyotl Helm",
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
                head="Ighwa Cap",
                neck="Shadow Gorget",
                back="Atheling Mantle",
                ring1="Diamond Ring",
                waist="Soil Belt",
                feet="Ejekamal Boots"
            })
            sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS, {
                head="Ignominy burgeonet +1",
                neck="Stoicheion Medal",
                ear1="Friomisi Earring",
                ear2="Crematio Earring",
                body="Fallen's Cuirass +1",
                hands="Fallen's Finger Gauntlets",
                --legs="Haruspex Slops",
                legs="Ignominy Flanchard +1",
                ring1="Diamond Ring",
                ring2="Acumen Ring",
                back="Toro Cape",
                feet="Ignominy Sollerets"
            })
            sets.precast.WS['Entropy'].Mid = set_combine(sets.precast.WS['Entropy'], {waist="Caudata Belt"})
            sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'].Mid, {
                ear1="Bladeborn Earring",
                ear2="Steelflash Earring",
            })

            sets.precast.WS['Requiscat'] = set_combine(sets.precast.WS, {
                head="Ighwa Cap",
                neck="Shadow Gorget",
                hands="Umuthi Gloves",
                back="Atheling Mantle",
                waist="Soil Belt",
                feet="Whirlpool Greaves"
            })
     
            sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
                ear1="Brutal Earring",
                ear2="Bale Earring",
                neck="Breeze Gorget",
                --hands="Boor Bracelets",
                back="Niht Mantle",
                waist="Soil Belt",
            })
            sets.precast.WS['Resolution'].Mid = set_combine(sets.precast.WS['Resolution'], {
                head="Yaoyotl Helm",
                hands="Mikinaak Gauntlets",
                feet="Ejekamal Boots"
            })
            sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {
                neck="Breeze Gorget",
                waist="Soil Belt"
            })
            sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
                body="Phorcys Korazin",
                neck="Aqua Gorget",
                waist="Caudata Belt"
            })
            -- 60% STR / 60% MND
            sets.precast.WS['Cross Reapter'] = set_combine(sets.precast.WS, {
                hands="Cizin Mufflers +1",
                neck="Aqua Gorget",
                waist="Caudata belt"
             })
            -- 50% STR / 50% INT 
            sets.precast.WS['Spiral Hell'] = set_combine(sets.precast.WS['Entropy'], {
                head="Ighwa Cap",
                body="Phorcys Korazin",
                neck="Aqua Gorget",
                waist="Caudata belt",
             })
           
            sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Entropy'], {
                head="Ignominy burgeonet +1",
                neck="Aqua Gorget",
                ear1="Friomisi Earring",
                ear2="Crematio Earring",
                hands="Fallen's Finger Gauntlets",
                waist="Windbuffet Belt",
                back="Toro Cape",
                feet="Ignominy Sollerets"
             })
            -- Sets to return to when not performing an action.
           
            -- Resting sets
            sets.resting = {
                head="Twilight Helm",
                neck="Bale Choker",
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
                body="Ares' Cuirass +1",
                hands="Ares' Gauntlets +1",
                ring1="Ifrit Ring",
                ring2="Patricius Ring",
                back="Atheling Mantle",
                waist="Windbuffet Belt",
                legs="Crimson Cuisses",
                feet="Fallen's Sollerets +1"
            }
           
            sets.idle.Field = set_combine(sets.idle.Town, {
                head="Twilight Helm",
                neck="Bale Choker",
                body="Ares' Cuirass +1",
                hands="Cizin Mufflers +1",
                ring1="Dark Ring",
                ring2="Paguroidea Ring",
                back="Repulse Mantle",
                legs="Crimson Cuisses",
                feet="Fallen's Sollerets +1"
            })
     
            sets.idle.Weak = {
                head="Twilight Helm",
                neck="Bale Choker",
                body="Twilight Mail",
                ring1="Dark Ring",
                ring2="Paguroidea Ring",
                back="Atheling Mantle",
                waist="Windbuffet Belt",
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
                body="Xaddi Mail",
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
                neck="Agitator's Collar",
                ring2="Patricius Ring",
                legs="Cizin Breeches +1"
            }
            sets.Defensive_Mid = {
                head="Ighwa Cap",
                neck="Agitator's Collar",
                hands="Cizin Mufflers +1",
                ring2="Patricius Ring",
                legs="Cizin Breeches +1"
            }
            sets.Defensive_Acc = {
                head="Ighwa Cap",
                neck="Agitator's Collar",
                hands="Umuthi Gloves",
                ring1="Beeline Ring",
                ring2="Patricius Ring",
                legs="Cizin Breeches +1",
                feet="Cizin Greaves +1"
            }
     
            -- Engaged set 
            -- Crobaci +2 = needs 35 STP TP &  24 STP in WS
            sets.engaged = {
                --sub="Bloodrain Strap",
                ammo="Hagneia Stone",
	        	head="Otomi Helm",
                neck="Asperity Necklace", 
                ear1="Brutal Earring",
                ear2="Tripudio Earring",
	        	body="Xaddi Mail",
                hands="Cizin Mufflers +1",
                ring1="Rajas Ring",
                ring2="K'ayres Ring",
	        	back="Atheling Mantle",
                waist="Windbuffet Belt",
                legs="Xaddi Cuisses",
                feet="Ejekamal Boots"
            }
	        sets.engaged.Mid = set_combine(sets.engaged, {
                ammo="Fire Bomblet",
                head="Yaoyotl Helm",
                ear1="Bladeborn Earring",
                ear2="Steelflash Earring",
            })

	        sets.engaged.Acc = set_combine(sets.engaged.Mid, {
                neck="Iqabi Necklace",
                ring1="Mars's Ring",
                ring2="Patricius Ring",
                hands="Buremte Gloves",
                waist="Anguinus Belt",
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
                ammo="Fire Bomblet",
                ear1="Bladeborn Earring",
                ear2="Steelflash Earring",
            })
            sets.engaged.LDGS.Acc = sets.engaged.Acc
            sets.engaged.LDGS.PDT = set_combine(sets.engaged.LDGS, sets.Defensive)
            sets.engaged.LDGS.Mid.PDT = set_combine(sets.engaged.LDGS.Mid, sets.Defensive_Mid)
            sets.engaged.LDGS.Acc.PDT = sets.engaged.Acc.PDT

            -- GS war sub 
            sets.engaged.War = set_combine(sets.engaged, {
                ear1="Brutal Earring",
                ear2="Tripudio Earring",
                head="Yaoyotl Helm",
                legs="Phorcys Dirs"
            })
            sets.engaged.War.Mid = set_combine(sets.engaged.War, {
                ammo="Hagneia Stone",
                ear1="Bladeborn Earring",
                ear2="Steelflash Earring",
                legs="Xaddi Cuisses",
                feet="Ejekamal Boots"
            })
            sets.engaged.War.Acc = set_combine(sets.engaged.War.Mid, {
                neck="Iqabi Necklace",
                hands="Buremte Gloves",
                ring1="Mars's Ring",
                ring2="Patricius Ring",
                waist="Anguinus Belt"
            })
            sets.engaged.War.PDT = set_combine(sets.engaged.War, sets.Defensive)
            sets.engaged.War.Mid.PDT = set_combine(sets.engaged.War.Mid, sets.Defensive_Mid)
            sets.engaged.War.Acc.PDT = set_combine(sets.engaged.War.Acc, sets.Defensive_Acc)

            -- Scythe 
            sets.engaged.Scythe = set_combine(sets.engaged, {
                --sub="Pole Grip",
                ammo="Hagneia Stone",
                legs="Cizin Breeches +1",
                feet="Ejekamal Boots"
            })
            sets.engaged.Scythe.Mid = set_combine(sets.engaged.Scythe, {
                head="Yaoyotl Helm",
                ear1="Bladeborn Earring",
                ear2="Steelflash Earring",
                legs="Xaddi Cuisses"
            })
            sets.engaged.Scythe.Acc = set_combine(sets.engaged.Scythe.Mid, { 
                neck="Iqabi Necklace",
                hands="Buremte Gloves",
                ring1="Mars's Ring",
                ring2="Patricius Ring",
                waist="Anguinus Belt"
            })

            sets.engaged.Scythe.PDT = set_combine(sets.engaged.Scythe, sets.Defensive)
            sets.engaged.Scythe.Mid.PDT = set_combine(sets.engaged.Scythe.Mid, sets.Defensive_Mid)
            sets.engaged.Scythe.Acc.PDT = set_combine(sets.engaged.Scythe.Acc, sets.Defensive_Acc)
            
            -- Scythe war sub (aim for 40 stp)
            sets.engaged.War.Scythe = {
                --sub="Bloodrain Strap",
                ammo="Hagneia Stone",
	        	head="Otomi Helm",
                neck="Asperity Necklace", 
                ear1="Brutal Earring",
                ear2="Tripudio Earring",
	        	body="Xaddi Mail",
                hands="Cizin Mufflers +1",
                ring1="Rajas Ring",
                ring2="K'ayres Ring",
	        	back="Atheling Mantle",
                waist="Windbuffet Belt",
                legs="Xaddi Cuisses",
                feet="Mikinaak Greaves"
            }
            sets.engaged.War.Scythe.Mid = set_combine(sets.engaged.War.Scythe, {
                head="Yaoyotl Helm",
                ear1="Bladeborn Earring",
                ear2="Steelflash Earring",
                feet="Ejekamal Boots"
            })
            sets.engaged.War.Scythe.Acc = set_combine(sets.engaged.War.Scythe.Mid, {
                neck="Iqabi Necklace",
                hands="Buremte Gloves",
                ring1="Mars's Ring",
                ring2="Patricius Ring",
                waist="Anguinus Belt",
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
                waist="Windbuffet Belt",
            })

            sets.engaged.MaxHaste = sets.engaged.HighHaste
            sets.engaged.EmbravaHaste = sets.engaged.HighHaste

            sets.engaged.LastResort = {
                feet="Fallen's Sollerets +1"
            }

            sets.buff.Souleater = { head="Ignominy burgeonet +1" }
    end
     
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    -- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
    function job_precast(spell, action, spellMap, eventArgs)
        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = true
        end
        if spell.action_type == 'Magic' then
            equip(sets.precast.FC)
        end
    end
     
    function job_post_precast(spell, action, spellMap, eventArgs)
        if spell.type == 'WeaponSkill' then
            if state.Buff.Souleater then
                equip(sets.buff.Souleater)
            end
        end
    end
     
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    function job_midcast(spell, action, spellMap, eventArgs)
        if spell.action_type == 'Magic' then
            equip(sets.midcast.FastRecast)
        end
    end
     
    -- Run after the default midcast() is done.
    -- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
    function job_post_midcast(spell, action, spellMap, eventArgs)
        if state.DefenseMode == 'Reraise' or
            (state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
            equip(sets.Reraise)
        end
    end
     
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    function job_aftercast(spell, action, spellMap, eventArgs)
        if state.Buff[spell.english] ~= nil then
            state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
        end
    end
     
    -------------------------------------------------------------------------------------------------------------------
    -- Customization hooks for idle and melee sets, after they've been automatically constructed.
    -------------------------------------------------------------------------------------------------------------------
    -- Called before the Include starts constructing melee/idle/resting sets.
    -- Can customize state or custom melee class values at this point.
    -- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
    function job_handle_equipping_gear(status, eventArgs)
        sets.Ammo = select_static_ammo()
    end
    -- Modify the default idle set after it was constructed.
    function customize_idle_set(idleSet)
        if player.mpp < 50 then
            idleSet = set_combine(idleSet, sets.refresh)
        end
        return idleSet
    end
     
    -- Modify the default melee set after it was constructed.
    function customize_melee_set(meleeSet)
        meleeSet = set_combine(meleeSet, sets.Ammo)
	    if state.Buff.Souleater then
	    	meleeSet = set_combine(meleeSet, sets.buff.Souleater)
        end
        return meleeSet
    end
     
    -------------------------------------------------------------------------------------------------------------------
    -- General hooks for other events.
    -------------------------------------------------------------------------------------------------------------------
     
    -- Called when the player's status changes.
    function job_status_change(newStatus, oldStatus, eventArgs)
        sets.Ammo = select_static_ammo()
        if newStatus == "Engaged" then
            adjust_engaged_sets()
	    	determine_haste_group()
        end
        if souleater_active() then
            disable('head')
        else
            enable('head')
        end
    end
     
    -- Called when a player gains or loses a buff.
    -- buff == buff gained or lost
    -- gain == true if the buff was gained, false if it was lost.
    function job_buff_change(buff, gain)

	    --if S{'haste','march','embrava','haste samba', 'last resort'}:contains(buff:lower()) then
	    if S{'last resort'}:contains(buff:lower()) then
	    	determine_haste_group()
	    	handle_equipping_gear(player.status)
        end

	    if state.Buff[buff] ~= nil then
	    	state.Buff[buff] = gain
	    	handle_equipping_gear(player.status)
	    end

        -- Some informative output
        if buff == 'Nether Void' and gain then
            add_to_chat(122, 'Next Absorb or Drain potency +75%!')
        elseif buff == 'Dark Seal' and gain then
            add_to_chat(122, 'Enhanced Dark Magic Accuracy!')
        end

    end
     
     
    -------------------------------------------------------------------------------------------------------------------
    -- User code that supplements self-commands.
    -------------------------------------------------------------------------------------------------------------------
     
    -- Called by the 'update' self-command, for common needs.
    -- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    
    war_sj = player.sub_job == 'WAR' or false
	adjust_engaged_sets()
    get_combat_form()
    sets.Ammo = select_static_ammo()

    if souleater_active() then
        disable('head')
    else
        enable('head')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_combat_form()
    if war_sj then
        state.CombatForm = "War"
    else
        state.CombatForm = nil
    end
end

function souleater_active()
    return state.Buff.Souleater
end

function adjust_engaged_sets()
    if S{ 'Xbalanque', 'Anahera Scythe', 'Tajabit', 'Twilight Scythe' }:contains(player.equipment.main) then
        state.CombatWeapon = "Scythe"
    elseif S{ 'Tunglmyrkvi', 'Ukudyoni', 'Kaquljaan' }:contains(player.equipment.main) then
        state.CombatWeapon = "LDGS"
    else -- use regular set
        state.CombatWeapon = nil
    end
	--adjust_melee_groups()
	determine_haste_group()
end

function select_static_ammo()
    if state.OffenseMode == 'Acc' or state.OffenseMode == 'Mid' then
	    if world.time >= (18*60) or world.time <= (6*60) then
            return sets.NightAccAmmo
        else
            return sets.DayAccAmmo
	    end
    else
        return sets.RegularAmmo
    end
end

--function adjust_melee_groups()
--	classes.CustomMeleeGroups:clear()
--	if state.Buff.Aftermath then
--		classes.CustomMeleeGroups:append('AM')
--	end
--end
function determine_haste_group()

    -- This section only applies to LR being up
    --
    -- 1) uncapped delay reduction: 26% gear haste + LR's 25% JA haste
    -- 2) HighHaste - Marches: 16% gear haste with march+3, 14% with march+4, 12% with march+5
    -- 3) EmbravaHaste - embrava: 21% gear haste if sch is naked alt, 17% if it's capped potency
    -- 4) MaxHaste - capped magic haste: 12% gear haste
	
	classes.CustomMeleeGroups:clear()
	
	--if buffactive.embrava and (buffactive['last resort'] or buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
	--	classes.CustomMeleeGroups:append('MaxHaste')
	--elseif buffactive.march == 2 and (buffactive.haste or buffactive['last resort']) then
	--	classes.CustomMeleeGroups:append('MaxHaste')
	--elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
	--	classes.CustomMeleeGroups:append('EmbravaHaste')
	--elseif buffactive.march == 1 and (buffactive['last resort'] or buffactive.haste or buffactive['haste samba']) then
	--	classes.CustomMeleeGroups:append('HighHaste')
	--elseif buffactive.march == 2 then
	--	classes.CustomMeleeGroups:append('HighHaste')
    if buffactive['last resort'] then
		classes.CustomMeleeGroups:append('LastResort')
	end
end

function select_default_macro_book()
        -- Default macro set/book
	    if player.sub_job == 'DNC' then
	    	set_macro_page(6, 2)
	    elseif player.sub_job == 'SAM' then
	    	set_macro_page(6, 4)
	    else
	    	set_macro_page(6, 2)
	    end
end
