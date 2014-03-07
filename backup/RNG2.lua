--GearSwap Version 0.823
--File Created 2-16-13

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

function get_sets()
	TP_Index = 1
	Idle_Index = 1	
	DefensePDT_Index = 1
	DefenseMDT_Index = 1
	Midshot_Index = 1
	Barrage_Index = 1
	Coronach_Index = 1
	LS_Index = 1 --Last Stand
	NA_Index = 1 --Namas Arrow
	JR_Index = 1 --Jishnu's Radiance
	SW_Index = 1 --Sidewinder
	
	--Default Macro Set for RNG
	send_command('input /macro book 1;wait .1;input /macro set 3')

	--PreSets Below (Snapshot/JA's)
	sets.precast = {}
	sets.precast.bullet = {ammo="Achiyalabopa Bullet"}
	sets.precast.arrow = {ammo="Achiyal. Arrow"}
	sets.precast.trialsammo = {ammo="Gargouille Arrow"}
	sets.precast['Double Shot'] = {head="Sylvan Gapette +2"}
	sets.precast['Velocity Shot'] = {body="Sylvan Caban +2"}
	sets.precast['Camouflage'] = {body="Orion Jerkin +1"}	
	sets.precast['Bounty Shot'] = {hands="Syl. Glvltte. +2"}
	sets.precast['Sharpshot'] = {legs="Orion Braccae +1"}
	sets.precast['Scavenge'] = {feet="Orion socks +1"}
	sets.precast['Shadowbind'] = {hands="Orion Bracers +1"}

    sets.STPEarring = {ear2="Tripudio earring"}
    sets.NightEarring = {ear2="Fenrir's earring"}
    sets.DayEarring = {ear2="Clearview earring"}

    sets.earring = select_earring()
	
	sets.precast['Eagle Eye Shot'] = {
		head="Arcadian Beret +1",
		neck="Ocachi Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Rajas Ring",
		ring2="Pyrosoul Ring",
		back="Lutian Cape",
		waist="Scout's Belt",
		legs="Scout's Braccae +2",
		feet="Orion Socks +1"
    }
						
	sets.precast.PreShot = {
		head="Orion Beret +1",							
		body="Sylvan Caban +2",
		hands="Iuitl Wristbands",
		waist="Impulse Belt",
		legs="Nahtirah Trousers",
		feet="Arcadian Socks +1"
    }
		
	-- Magic Sets Below		
	sets.precast.FastCast = {
		head="Whirlpool Mask",
		neck="Twilight Torque",		
		hands="Iuitl Wristbands",
		ring1="Rajas Ring",
		ring2="Dark Ring",
		back="Shadow Mantle",		
		legs="Nahtirah Trousers",
		feet="Iuitl Gaiters"
    }
	
	sets.precast.Utsusemi = set_combine(sets.precast.FastCast,{neck="Magoraga Beads"})		
						
	--Midshot Sets Below
	Midshot_Set_Names = {'LightAcc','FullAcc','STP'}
	sets.Midshot = {}
	sets.Midshot.LightAcc = {
		head="Arcadian Beret +1",
		neck="Ocachi gorget",
		ear1="Volley Earring",
		ear2="Clearview Earring",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Rajas ring",
		ring2="Paqichikaji Ring",
		back="Lutian Cape",
		waist="Scout's Belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"
    }
				
	sets.Midshot.FullAcc = {
		head="Arcadian Beret +1",
		neck="Huani collar",
		ear1="Volley Earring",
		ear2="Clearview Earring",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Hajduk ring",
		ring2="Paqichikaji Ring",
		back="Lutian Cape",
		waist="Scout's Belt",
		legs="Orion Braccae +1",
		feet="Orion Socks +1"
    }
		
	sets.Midshot.STP = {
		head="Arcadian Beret +1",
		neck="Ocachi Gorget",
		ear1="Volley Earring",
		ear2="Tripudio Earring",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Rajas Ring",
		ring2="Paqichikaji Ring",
		back="Sylvan Chlamys",
		waist="Scout's Belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"
    }

	--Barrage Sets Below
	Barrage_Set_Names = {'BarrageAcc','BarrageCrit','BarrageSTP'}
	sets.Barrage = {}

	sets.Barrage.BarrageAcc = {
		head="Arcadian Beret +1",
		neck="Huani collar",
		ear1="Volley Earring",
		ear2="Clearview Earring",
		body="Kyujutsugi",
		hands="Orion Bracers +1",
		ring1="Hajduk ring",
		ring2="Paqichikaji Ring",
		back="Lutian Cape",
		waist="Scout's Belt",
		legs="Orion Braccae +1",
		feet="Orion Socks +1"
    }

	sets.Barrage.BarrageCrit = {
		head="Uk'uxkaj cap",
		neck="Rancor collar",
		ear1="Flame Pearl",
		ear2="Flame Pearl",
		body="Kyujutsugi",
		hands="Orion Bracers +1",
		ring1="Hajduk ring",
		ring2="Paqichikaji Ring",
		back="Lutian Cape",
		waist="Scout's Belt",
		legs="Sylvan Bragues +2",
		feet="Orion Socks +1"
    }
				
	sets.Barrage.BarrageSTP = {
		head="Arcadian Beret +1",
		neck="Ocachi Gorget",
		ear1="Volley Earring",
		ear2="Tripudio Earring",
		body="Kyujutsugi",
		hands="Orion Bracers +1",
		ring1="Hajduk Ring",
		ring2="Pyrosoul Ring",
		back="Lutian Cape",
		waist="Scout's Belt",
		legs="Orion Braccae +1",
		feet="Orion Socks +1"}						
	
	-- Coronach Sets Below
	Coronach_Set_Names = {'Normal','Acc','Atk'}
	sets.Coronach = {}
	sets.Coronach.Normal = {
		head="Arcadian Beret +1",
		neck="Breeze Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Orion Bracers +1",
		ring1="Rajas Ring",
		ring2="Pyrosoul Ring",
		back="Buquwik Cape",
		waist="Thunder belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"}

	sets.Coronach.Acc = {
		head="Arcadian Beret +1",
		neck="Breeze Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Rajas ring",
		ring2="Paqichikaji Ring",
		back="Lutian Cape",
		waist="Thunder belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"}
						
	sets.Coronach.Atk = {
		head="Arcadian Beret +1",
		neck="Ocachi Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Orion Bracers +1",
		ring1="Rajas Ring",
		ring2="Pyrosoul Ring",
		back="Buquwik Cape",
		waist="Thunder belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"}
	
	-- Last Stand Sets Below
	LS_Set_Names = {'Normal','Acc','Atk'}
	sets.LS = {}
	sets.LS.Normal = {
		head="Arcadian Beret +1",
		neck="Aqua Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Orion Bracers +1",
		ring1="Stormsoul Ring",
		ring2="Pyrosoul Ring",
		back="Buquwik Cape",
		waist="Light belt",
		legs="Nahtirah Trousers",
		feet="Arcadian Socks +1"}

	sets.LS.Acc = {
		head="Arcadian Beret +1",
		neck="Aqua Gorget",
		ear1="Clearview Earring",
		ear2="Volley Earring",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Hajduk ring",
		ring2="Pyrosoul Ring",
		back="Lutian Cape",
		waist="Light belt",
		legs="Orion Braccae +1",
		feet="Arcadian Socks +1"}
						
	sets.LS.Atk = {
		head="Arcadian Beret +1",
		neck="Ocachi Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Stormsoul Ring",
		ring2="Pyrosoul Ring",
		back="Buquwik Cape",
		waist="Light belt",
		legs="Nahtirah Trousers",
		feet="Arcadian Socks +1"}
	
	-- Namas Arrow Sets Below
	NA_Set_Names = {'Normal','Acc','Atk'}
	sets.NA = {}
	sets.NA.Normal = {}

	sets.NA.Acc = {}
						
	sets.NA.Atk = {}
	
	-- Jishnu's Radiance Sets Below
	JR_Set_Names = {'Normal','Acc','Atk'}
	sets.JR = {}
	sets.JR.Normal = {
		head="Uk'uxkaj cap",
		neck="Light Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Orion Bracers +1",
		ring1="Rajas Ring",
		ring2="Pyrosoul Ring",
		back="Libeccio Mantle",
		waist="Light belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"}

	sets.JR.Acc = {
		head="Uk'uxkaj cap",
		neck="Light Gorget",
		ear1="Clearview Earring",
		ear2="Volley Earring",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Rajas Ring",
		ring2="Pyrosoul Ring",
		back="Libeccio Mantle",
		waist="Light belt",
		legs="Orion Braccae +1",
		feet="Orion Socks +1"}
						
	sets.JR.Atk = {
		head="Orion Beret +1",
		neck="Ocachi Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Orion Bracers +1",
		ring1="Strigoi Ring",
		ring2="Pyrosoul Ring",
		back="Libeccio Mantle",
		waist="Prosilio belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"}
	
	-- Sidewinder Sets Below
	SW_Set_Names = {'Normal','Acc','Atk'}
	sets.SW = {}
	sets.SW.Normal = {
		head="Arcadian Beret +1",
		neck="Aqua Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Orion Bracers +1",
		ring1="Vulcan's Ring",
		ring2="Pyrosoul Ring",
		back="Buquwik Cape",
		waist="Light belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"}

	sets.SW.Acc = {
		head="Arcadian Beret +1",
		neck="Aqua Gorget",
		ear1="Flame pearl",
		ear2="Flame pearl",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Hajduk ring",
		ring2="Paqichikaji Ring",
		back="Lutian Cape",
		waist="Light belt",
		legs="Orion Braccae +1",
		feet="Orion Socks +1"}
						
	sets.SW.Atk = {}
	
	-- TP Sets Below(I don't really use for RNG but feel free to add your own)
	TP_Set_Names = {"ACC","ATK","PDT","MDT"}
	sets.TP = {}
	sets.TP['ACC'] = {}
		
	sets.TP['ATK'] = {}
		
	sets.TP['MDT'] = {
		head="Orion Beret +1",
		neck="Huani collar",
		ear1="Merman's Earring",
		ear2="Merman's Earring",
		body="Kyujutsugi",
		hands="Orion Bracer's +1",
		ring1="Hajduk ring",
		ring2="Paqichikaji Ring",
		back="Tuilha Cape",
		waist="Resolute Belt",
		legs="Nahtirah Trousers",
		feet="Iuitl Gaiters"}
		
	sets.TP['PDT'] = {
		head="Whirlpool Mask",
		neck="Twilight Torque",
		ear1="Clearview Earring",
		ear2="Volley Earring",
		body="Kyujutsugi",
		hands="Iuitl Wristbands",
		ring1="Rajas Ring",
		ring2="Dark Ring",
		back="Shadow Mantle",
		waist="Scout's Belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"
    }

	
	--Idle Sets Below
	Idle_Set_Names = {'Regen','Normal','Town'}
	sets.Idle = {}
	sets.Idle.Normal = {
		head="Arcadian Beret +1",
		neck="Twilight Torque",
		ear1="Volley Earring",
		ear2="Tripudio Earring",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Rajas ring",
		ring2="Dark Ring",
		back="Shadow Mantle",
		waist="Scout's Belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"}
						
	sets.Idle.Town = {
		head="Arcadian Beret +1",
		neck="Ocachi Gorget",
		ear1="Fenrir's Earring",
		ear2="Tripudio Earring",
		body="Kyujutsugi",
		hands="Sigyn's Bazubands",
		ring1="Rajas ring",
		ring2="Pyrosoul Ring",
		back="Lutian Cape",
		waist="Impulse Belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"}					
				
	sets.Idle.Regen = set_combine(sets.Idle.Normal,{
		ring1="Paguroidea Ring",
		})	
	
	PDT_Set_Names = {'PDT'}
	sets.DefensePDT = {}
	sets.DefensePDT.PDT = {
		head="Whirlpool Mask",
		neck="Twilight Torque",
		ear1="Clearview Earring",
		ear2="Volley Earring",
		body="Kyujutsugi",
		hands="Iuitl Wristbands",
		ring1="Rajas Ring",
		ring2="Dark Ring",
		back="Shadow Mantle",
		waist="Scout's Belt",
		legs="Nahtirah Trousers",
		feet="Iuitl Gaiters"}
		
    MDT_Set_Names = {'MDT'}
	sets.DefenseMDT = {}
	sets.DefenseMDT.MDT = set_combine(sets.DefensePDT.PDT,{		
		head="Whirlpool Mask",
		body="Kyujutsugi",		
        hands="Orion Bracers +1",
        legs="Nahtirah Trousers",
        feet="Orion Socks +1"
		})
end

function precast(spell)	
	if sets.precast[spell.english] then
                equip(sets.precast[spell.english])
		elseif spell.type == 'WeaponSkill' then
			if spell.target.distance > 21.0  then						
			add_to_chat(167,''..spell.target.name..' is too far can not use '..spell.name..'!!!. Cancelling WeaponSkill ')                           
            cancel_spell()
            return			
			elseif spell.name == "Coronach" then
                equip(sets.Coronach[Coronach_Set_Names[Coronach_Index]])
			elseif spell.name == "Last Stand" then
                equip(sets.LS[LS_Set_Names[LS_Index]])
			elseif spell.name == "Namas Arrow" then
                equip(sets.NA[NA_Set_Names[NA_Index]])
			elseif spell.name == "Jishnu's Radiance" then
                equip(sets.JR[JR_Set_Names[JR_Index]])
			elseif spell.name == "Sidewinder" then
                equip(sets.SW[SW_Set_Names[SW_Index]])			
		end		
		elseif spell.name == "Ranged" then
			equip(sets.precast.PreShot)
			if player.equipment.range == 'Ajjub Bow' then
			    equip(sets.precast.arrow)            
			elseif player.equipment.range == 'Yoichinoyumi' then
			    equip(sets.precast.arrow)            
			elseif player.equipment.range == 'Annihilator' then
			    equip(sets.precast.bullet)            
		end
		elseif spell.type == "Ninjutsu" then
			if string.find(spell.english,'Utsusemi') then
				if buffactive['Copy Image (3)'] or buffactive['Copy Image (4)'] then
					cancel_spell()
					add_to_chat(167, spell.english .. ' Canceled: [3+ Images]')
					return
			else
				equip(sets.precast.Utsusemi)
			end
			else
				equip(sets.precast.FastCast)
		end
		elseif spell.english == 'Spectral Jig' and buffactive.Sneak then
			cast_delay(0.2)
			send_command('cancel Sneak')        
    end
end

function midcast(spell)
    sets.earring = select_earring()
	if spell.name == "Ranged" then
		--equip(sets.Midshot[Midshot_Set_Names[Midshot_Index]])
            midSet = set_combine(sets.Midshot[Midshot_Set_Names[Midshot_Index]], sets.earring)
		    equip(midSet)
		if buffactive.Barrage then
			--equip(sets.Barrage[Barrage_Set_Names[Barrage_Index]])						
            barrageSet = set_combine(sets.Barrage[Barrage_Set_Names[Barrage_Index]], sets.earring)
		    equip(barrageSet)
		end
	end
end

function aftercast(spell)	
	if player.status=='Engaged' then
        sets.earring = select_earring()
        meleeSet = set_combine(sets.TP[TP_Set_Names[TP_Index]], sets.earring)
		equip(meleeSet)
	else		
		equip(sets.Idle[Idle_Set_Names[Idle_Index]])		
	end
end

function status_change(new,old)
	if T{'Idle','Resting'}:contains(new) then		
		equip(sets.Idle[Idle_Set_Names[Idle_Index]]) 
	elseif new == 'Engaged' then
        sets.earring = select_earring()
        meleeSet = set_combine(sets.TP[TP_Set_Names[TP_Index]], sets.earring)
		equip(meleeSet)
	end
end

function buff_change(name,gain_or_loss)
    -- lock orion jerkin +1 during camo
    if status == "Camouflage" then
        if gain_or_loss == "gain" then
                        send_command('@wait .5;gs disable body')
        else
            enable('body')
        end
    end
	--if name == 'Battlefield' and not gain_or_loss then
		--send_command('wait 3; input /ja "Scavenge" <me>')
	--end
end

--Toggle Self Commands with //gs c [command name] 
--Example type in chat //gs c tp (case sensitive)
--Example Make a macro /console gs c tp (case sensitive)
function self_command(command)
	if command == 'tp' then
		TP_Index = TP_Index +1		
		if TP_Index > #TP_Set_Names then TP_Index = 1 end
		add_to_chat(207,'TP Set Changed to: '..TP_Set_Names[TP_Index]..'')
	elseif command == 'idle' then
		Idle_Index = Idle_Index +1
		if Idle_Index > #Idle_Set_Names then Idle_Index = 1 end
		add_to_chat(207,'Idle Set Changed to: '..Idle_Set_Names[Idle_Index]..'')		
		equip(sets.Idle[Idle_Set_Names[Idle_Index]])	
	elseif command == 'pdt' then
		DefensePDT_Index = DefensePDT_Index +1
		if DefensePDT_Index > #PDT_Set_Names then DefensePDT_Index = 1 end
		add_to_chat(207,'PDT Set Changed to: '..PDT_Set_Names[DefensePDT_Index]..'')		
		equip(sets.DefensePDT[PDT_Set_Names[DefensePDT_Index]])				
	elseif command == 'mdt' then
		DefenseMDT_Index = DefenseMDT_Index +1
		if DefenseMDT_Index > #MDT_Set_Names then DefenseMDT_Index = 1 end
		add_to_chat(207,'MDT Set Changed to: '..MDT_Set_Names[DefenseMDT_Index]..'')		
		equip(sets.DefenseMDT[MDT_Set_Names[DefenseMDT_Index]])
	elseif command == 'midshot' then
		Midshot_Index = Midshot_Index +1
		if Midshot_Index > #Midshot_Set_Names then Midshot_Index = 1 end
		add_to_chat(207,'Midshot Set Changed to: '..Midshot_Set_Names[Midshot_Index]..'')		
	elseif command == 'barrage' then
		Barrage_Index = Barrage_Index +1
		if Barrage_Index > #Barrage_Set_Names then Barrage_Index = 1 end
		add_to_chat(207,'Barrage Set Changed to: '..Barrage_Set_Names[Barrage_Index]..'')
	elseif command == 'relicgunws' then
		Coronach_Index = Coronach_Index +1
		if Coronach_Index > #Coronach_Set_Names then Coronach_Index = 1 end
		add_to_chat(207,'Coronach Set Changed to: '..Coronach_Set_Names[Coronach_Index]..'')		
	elseif command == 'meritws' then
		LS_Index = LS_Index +1
		if LS_Index > #LS_Set_Names then LS_Index = 1 end
		add_to_chat(207,'Last Stand Set Changed to: '..LS_Set_Names[LS_Index]..'')		
	elseif command == 'relicbowws' then
		NA_Index = NA_Index +1
		if NA_Index > #NA_Set_Names then NA_Index = 1 end
		add_to_chat(207,'Namas Arrow Set Changed to: '..NA_Set_Names[NA_Index]..'')		
	elseif command == 'empws' then
		JR_Index = JR_Index +1
		if JR_Index > #JR_Set_Names then JR_Index = 1 end
		add_to_chat(207,'Jishnu\'s Radiance Set Changed to: '..JR_Set_Names[JR_Index]..'')		
	elseif command == 'sidewinderws' then
		SW_Index = SW_Index +1
		if SW_Index > #Coronach_Set_Names then SW_Index = 1 end
		add_to_chat(207,'Sidewinder Set Changed to: '..SW_Set_Names[SW_Index]..'')		
	elseif command == 'update' then
		status_change(player.status)	
	elseif command == 'active' then
		add_to_chat(207,'Idle Set Active: '..Idle_Set_Names[Idle_Index]..'')
		add_to_chat(207,'PDT Set Active: '..PDT_Set_Names[DefensePDT_Index]..'')
		add_to_chat(207,'MDT Set Active: '..MDT_Set_Names[DefenseMDT_Index]..'')
		add_to_chat(207,'TP Set Active: '..TP_Set_Names[TP_Index]..'')
		add_to_chat(207,'Midshot Set Active: '..Midshot_Set_Names[Midshot_Index]..'')
		add_to_chat(207,'Barrage Set Active: '..Barrage_Set_Names[Barrage_Index]..'')
		add_to_chat(207,'Coronach Set Active: '..Coronach_Set_Names[Coronach_Index]..'')
		add_to_chat(207,'Last Stand Set Active: '..LS_Set_Names[LS_Index]..'')
		add_to_chat(207,'Namas Arrow Set Active: '..NA_Set_Names[NA_Index]..'')
		add_to_chat(207,'Jishnu\'s Radiance Set Active: '..JR_Set_Names[JR_Index]..'')
		add_to_chat(207,'Sidewinder Set Active: '..SW_Set_Names[SW_Index]..'') 		
	end
end
