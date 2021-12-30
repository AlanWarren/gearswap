-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
--Ionis Zones
--Anahera Blade (4 hit): 52
--Tsurumaru (4 hit): 49
--Kogarasumaru (or generic 450 G.katana) (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Non Ionis Zones:
--Anahera Blade (4 hit): 52
--Tsurumaru (5 hit): 24
--Kogarasumaru (5 hit): 40
--Amanomurakumo/Masamune 437 (5 hit): 46
--
--Aftermath sets
-- Koga AM1/AM2 = sets.engaged.Kogarasumaru.AM
-- Koga AM3 = sets.engaged.Kogarasumaru.AM3
-- Amano AM = sets.engaged.Amanomurakumo.AM
-- Using Namas Arrow while using Amano will cancel STPAM set

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
	-- Load and initialize the include file.
    mote_include_version = 2
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('None')
    get_combat_form()
    --get_combat_weapon()
    update_melee_groups()
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')

    state.YoichiAM = M(false, 'Cancel Yoichi AM Mode')
    -- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Tachi: Shoha'}

    gear.RAarrow = {name="Eminent Arrow"}
    LugraWSList = S{'Tachi: Fudo', 'Tachi: Shoha', 'Namas Arrow', 'Impulse Drive', 'Stardiver'}

    state.Buff.Sekkanoki = buffactive.sekkanoki or false
    state.Buff.Sengikori = buffactive.sengikori or false
    state.Buff['Third Eye'] = buffactive['Third Eye'] or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    -- Options: Override default values
    state.OffenseMode:options('Normal', 'Mid', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
    state.IdleMode:options('Normal', 'Sphere')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDT')
    
    -- Additional local binds
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
    send_command('bind != gs c toggle CapacityMode')
    
    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind ^[')
    send_command('unbind !=')
    send_command('unbind ![')
end

--[[
-- SC's
Rana > Shoha > Fudo > Kasha > Shoha > Fudo - light
Rana > Shoha > Fudo > Kasha > Rana > Fudo - dark

Kasha > Shoha > Fudo
Fudo > Kasha > Shoha > fudo
Shoha > Fudo > Kasha > Shoha > Fudo

--]]
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    Valorous = {}
    Valorous.Hands = {}
    Valorous.Hands.TP = { name="Valorous Mitts", augments={'Accuracy+26','"Store TP"+6','AGI+10',}}
    Valorous.Hands.WS = { name="Valorous Mitts", augments={'Accuracy+27','Weapon skill damage +4%','Accuracy+5 Attack+5','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}


    Valorous.Feet = {}
    Valorous.Feet.WS ={ name="Valorous Greaves", augments={'Weapon skill damage +5%','STR+9','Accuracy+15','Attack+11',}}
    Valorous.Feet.TH = { name="Valorous Greaves", augments={'CHR+13','INT+1','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}

    sets.TreasureHunter = { 
        head="White rarab cap +1", 
        waist="Chaac Belt",
        feet=Valorous.Feet.TH
     }
    sets.precast.JA['Provoke'] = { 
        -- ear1="Cryptic Earring",
        head="White rarab cap +1", 
        waist="Chaac Belt",
        feet=Valorous.Feet.TH
    }
    
    Smertrios = {}
    Smertrios.TP = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    Smertrios.WS = {name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {
        head="Wakido Kabuto +2",
        hands="Sakonji Kote +3",
        back=Smertrios.TP
    }
    sets.precast.JA.Sekkanoki = {hands="Unkai Kote +2" }
    sets.precast.JA.Seigan = {head="Unkai Kabuto +2"}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +2"}
    sets.precast.JA['Third Eye'] = {legs="Sakonji Haidate"}
    --sets.precast.JA['Blade Bash'] = {hands="Saotome Kote +2"}
   
    sets.precast.FC = {
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        hands="Leyline Gloves",
        ring1="Prolix Ring",
        ring2="Weatherspoon Ring"
    }
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    sets.Organizer = {
        grip="Pearlsack",
        waist="Linkpearl",
        head="Masamune",
        hands="Shining One",
        legs="Dojikiri Yasutsuna",
        feet="Fusenaikyo"
    }
    sets.precast.RA = {
        head="Volte Tiara",
        hands="Buremte Gloves",
        ring2="Crepuscular Ring",
        feet="Ejekamal Boots",
        legs="Volte Tights",
        waist="Yemaya Belt"
    }
    sets.midcast.RA = {
        head="Nyame Helm",
        body="Kendatsuba Samue +1",
        legs="Kendatsuba Hakama +1",
        neck="Sanctity Necklace",
        hands="Kendatsuba Tekko +1",
        waist="Chaac Belt",
        ear1="Telos Earring",
        ear2="Crepuscular Earring",
        ring1="Cacoethic Ring +1",
        ring2="Crepuscular Ring",
        feet="Kendatsuba Sune-ate +1"
    }	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.CapacityMantle  = { back="Mecistopins Mantle" }
    --sets.Berserker       = { neck="Berserker's Torque" }
    sets.WSDayBonus      = { head="Gavialis Helm" }
    sets.LugraMoonshade  = { ear1="Lugra Earring +1", ear2="Moonshade Earring" }
    sets.BrutalMoonshade = { ear1="Brutal Earring", ear2="Moonshade Earring" }
    --sets.LugraFlame      = { ear1="Lugra Earring +1", ear2="Flame Pearl" }
    --sets.FlameFlame      = { ear1="Flame Pearl", ear2="Flame Pearl" }
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        neck="Samurai's Nodowa +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        body="Sakonji Domaru +3",
        hands=Valorous.Hands.WS,
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back=Smertrios.WS,
        waist="Sailfi Belt +1",
        legs="Wakido Haidate +3",
        feet=Valorous.Feet.WS
    }
    sets.precast.WS.Mid = set_combine(sets.precast.WS, {
        hands="Nyame Gauntlets"
        -- head="Rao Kabuto",
    })
    sets.precast.WS.Acc = set_combine(sets.precast.WS.Mid, {
        feet="Flamma Gambieras +2",
    })
    
    sets.precast.WS['Namas Arrow'] = {
        ammo=gear.RAarrow,
        head="Mpaca's Cap",
        neck="Samurai's Nodowa +2",
        ear1="Thrud Earring",
        ear2="Ishvara Earring",
        body="Nyame Mail",
        legs="Nyame Flanchard",
        hands="Nyame Gauntlets",
        back=Smertrios.WS,
        ring1="Ilabrat Ring",
        ring2="Regal Ring",
        waist="Eschan Stone",
        -- legs="Hizamaru Hizayoroi +2",
        feet=Valorous.Feet.WS
    }
    sets.precast.WS['Namas Arrow'].Mid = set_combine(sets.precast.WS['Namas Arrow'], {
        body="Nyame Mail",
    })
    sets.precast.WS['Namas Arrow'].Acc = set_combine(sets.precast.WS['Namas Arrow'].Mid, {
        ring2="Crepuscular Ring"
    })
    
    sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS['Namas Arrow'], {
        neck="Breeze Gorget",
        body="Nyame Mail",
        ring2="Regal Ring"
    })
    sets.precast.WS['Apex Arrow'].Mid = sets.precast.WS['Apex Arrow']
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {
        ring2="Crepuscular Ring"
    })
    
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
        head="Mpaca's Cap",
        ammo="Knobkierrie",
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
    })
    sets.precast.WS['Tachi: Fudo'].Mid = set_combine(sets.precast.WS['Tachi: Fudo'], {
        head="Mpaca's Cap",
        ammo="Knobkierrie",
        --waist="Light Belt"
    })
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'].Mid, {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        feet="Flamma Gambieras +2",
    })
    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
        head="Mpaca's Cap",
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        feet=Valorous.Feet.WS
    })
    sets.precast.WS['Impulse Drive'].Mid = set_combine(sets.precast.WS['Impulse Drive'], {
        head="Mpaca's Cap",
        hands=Valorous.Hands.WS,
    })
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'].Mid, {
        feet="Flamma Gambieras +2",
    })
    
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
        head="Mpaca's Cap",
        ear1="Schere Earring",
        --head="Flamma Zucchetto +2",
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        back=Smertrios.WS,
        feet="Flamma Gambieras +2",
    })
    sets.precast.WS['Tachi: Shoha'].Mid = set_combine(sets.precast.WS['Tachi: Shoha'], {
        waist="Thunder Belt",
    })
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS['Tachi: Shoha'].Mid, {})

    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS['Tachi: Shoha'], {
        head="Mpaca's Cap",
        ear1="Schere Earring",
        neck="Samurai's Nodowa +2",
        waist="Soil Belt"
    })
    sets.precast.WS['Stardiver'].Mid = set_combine(sets.precast.WS['Stardiver'], {})
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'].Mid, {})
    
    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
        head="Mpaca's Cap",
        neck="Samurai's Nodowa +2",
        waist="Soil Belt",
    })
    sets.precast.WS['Tachi: Rana'].Mid = set_combine(sets.precast.WS['Tachi: Rana'], {
        body="Sakonji Domaru +3",
    })
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {
        neck="Shadow Gorget",
        waist="Soil Belt",
    })
    -- CHR Mod
    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
        head="Flamma Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flamma Manopolas +2",
        feet="Flamma Gambieras +2",
        back=Smertrios.WS,
        ring2="Weatherspoon Ring",
        legs="Wakido Haidate +3",
        waist="Soil Belt",
    })
    
    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {waist="Light Belt"})
    
    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Aqua Gorget",waist="Windbuffet Belt +1"})
    
    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Breeze Gorget",waist="Windbuffet Belt +1"})
    
    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        neck="Shadow Gorget",
        waist="Soil Belt",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
    })
    
    sets.midcast['Blue Magic'] = set_combine(sets.precast.WS['Tachi: Ageha'], {
        ear2="Crepuscular Earring", -- 3
        waist="Eschan Stone", -- 5
        ring1="Crepuscular Ring", -- 10
        ring2="Weatherspoon Ring", -- 10 macc
        back="Aput Mantle",
    })
    -- Midcast Sets
    sets.midcast.FastRecast = {
    	-- head="Otomi Helm",
    	-- legs="Wakido Haidate +1",
        -- feet="Ejekamal Boots"
        waist="Sailfi Belt +1"
    }
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        ring2="Paguroidea Ring"
    }
    
    sets.idle.Town = {
        ammo="Coiste Bodhar",
        head="Kendatsuba Jinpachi +1",
        neck="Samurai's Nodowa +2",
        ear1="Telos Earring",
        ear2="Dedition Earring",
   	    --body="Kendatsuba Samue +1",
        body="Tatenashi Haramaki +1",
        --hands="Wakido Kote +3",
        hands="Tatenashi Gote +1",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back=Smertrios.TP,
        waist="Windbuffet Belt +1",
        legs="Tatenashi Haidate +1",
        feet="Danzo Sune-ate"
    }
    -- sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {
    --     body="Councilor's Garb"
    -- })
    
    sets.idle.Field = set_combine(sets.idle.Town, {
        ammo="Staunch Tathlum",
        head="Nyame Helm",
        neck="Sanctity Necklace",
        ear1="Etiolation Earring",
        ear2="Genmei Earring",
   	    body="Nyame Mail",
        hands="Nyame Gauntlets",
        ring1="Dark Ring",
        ring2="Defending Ring",
        back=Smertrios.TP,
        waist="Flume Belt",
        legs="Nyame Flanchard",
        feet="Danzo Sune-ate"
    })

    sets.idle.Regen = set_combine(sets.idle.Field, {
        head="Rao Kabuto",
        neck="Sanctity Necklace",
        ring2="Paguroidea Ring",
        ear2="Infused Earring",
        head="Rao Kabuto",
   	    body="Hizamaru Haramaki +2",
        back=Smertrios.TP,
        feet="Danzo Sune-ate"
    })

    sets.idle.Sphere = set_combine(sets.idle, { body="Makora Meikogai"  })
    
    sets.idle.Weak = set_combine(sets.idle.Field, {
    })
    
    -- Defense sets
    sets.defense.PDT = {
        head="Nyame Helm",
        ammo="Crepuscular Pebble",
        neck="Agitator's Collar",
   	    body="Nyame Mail",
        hands="Nyame Gauntlets",
        --ring1="Dark Ring",
        ring2="Defending Ring",
    	back=Smertrios.TP,
        --waist="Flume Belt",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets"
    }
    sets.idle.PDT = set_combine(sets.idle, sets.defense.PDT)
    
    sets.defense.Reraise = set_combine(sets.defense.PDT, {
    	head="Nyame Helm",
    	body="Nyame Mail"
    })
    
    sets.defense.MDT = set_combine(sets.defense.PDT, {
         --neck="Twilight Torque",
    	back=Smertrios.TP,
    })
    
    sets.Kiting = {feet="Danzo Sune-ate"}
    
    sets.Reraise = {head="Nyame Helm",body="Nyame Mail"}
    
    -- Engaged sets
    
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- I generally use Anahera outside of Adoulin areas, so this set aims for 47 STP + 5 from Anahera (52 total)
    -- Note, this set assumes use of Cibitshavore (hence the arrow as ammo)
    sets.engaged = {
        sub="Utu Grip",
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        --neck="Moonbeam Nodowa",
        neck="Samurai's Nodowa +2",
        ear1="Schere Earring",
        ear2="Dedition Earring",
        body="Tatenashi Haramaki +1",
        hands="Wakido Kote +3",
        ring1="Niqmaddu Ring", 
        ring2="Petrov Ring", 
        back=Smertrios.TP,
        waist="Sailfi Belt +1",
        --legs="Ryuo Hakama",
        legs="Tatenashi Haidate +1",
        --feet="Flamma Gambieras +2"
        feet="Tatenashi Sune-ate +1"
    }
    
    sets.engaged.Mid = set_combine(sets.engaged, {
        -- hands=Valorous.Hands.TP,
        neck="Samurai's Nodowa +2",
        body="Kendatsuba Samue +1",
        --ear1="Telos Earring",
        ear1="Schere Earring",
        ear2="Cessance Earring",
        legs="Kendatsuba Hakama +1",
        waist="Ioskeha Belt",
        ring1="Niqmaddu Ring", 
        ring2="Flamma Ring",
        feet="Flamma Gambieras +2"
        --body="Kendatsuba Samue",
        --legs="Kendatsuba Hakama",
    })

    sets.engaged.Acc = set_combine(sets.engaged.Mid, {
        ear1="Telos Earring",
        --ear2="Crepuscular Earring", 
        ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",
        neck="Samurai's Nodowa +2",
        hands="Kendatsuba Tekko +1",
        body="Kendatsuba Samue +1",
        legs="Kendatsuba Hakama +1",
        ring2="Regal Ring",
        feet="Kendatsuba Sune-ate +1"
    })

    sets.engaged.PDT = set_combine(sets.engaged, {
        head="Mpaca's Cap",
   	    body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
    })
    sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, {
        head="Mpaca's Cap",
   	    body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
    })
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {
        head="Mpaca's Cap",
   	    body="Mpaca's Doublet",
        hands="Mpaca's Gloves",
        legs="Mpaca's Hose",
        feet="Mpaca's Boots"
    })
    
    sets.engaged.Amanomurakumo = set_combine(sets.engaged, {
    })
    sets.engaged.Amanomurakumo.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM = set_combine(sets.engaged, {
    })
    sets.engaged.Kogarasumaru.AM3 = set_combine(sets.engaged, {
    })
    
    sets.buff.Sekkanoki = {hands="Unkai kote +2"}
    sets.buff.Sengikori = {}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate +1"}
    
    sets.thirdeye = {head="Unkai Kabuto +2", legs="Sakonji Haidate"}
    --sets.seigan = {hands="Otronif Gloves +1"}
    sets.bow = {ammo=gear.RAarrow}
    
    -- sets.MadrigalBonus = {
    --     hands="Composer's Mitts"
    -- }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		-- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
		if player.equipment.main =='Nativus Halberd' or player.equipment.main =='Quint Spear' then
			if spell.english:startswith("Tachi:") then
				send_command('@input /ws "Stardiver" '..spell.target.raw)
				eventArgs.cancel = true
			end
		end
	end
    if state.Buff[spell.english] ~= nil then
        state.Buff[spell.english] = true
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    --if spell.english == 'Third Eye' and not buffactive.Seigan then
    --    cancel_spell()
    --    send_command('@wait 0.5;input /ja Seigan <me>')
    --    send_command('@wait 1;input /ja "Third Eye" <me>')
    --end
end
-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        if is_sc_element_today(spell) then
            if wsList:contains(spell.english) then
                equip(sets.WSDayBonus)
            end
        end
        -- if LugraWSList:contains(spell.english) then
        --     if world.time >= (17*60) or world.time <= (7*60) then
        --         if spell.english:lower() == 'namas arrow' then
        --             equip(sets.LugraFlame)
        --         else
        --             equip(sets.LugraMoonshade)
        --         end
        --     else
        --         if spell.english:lower() == 'namas arrow' then
        --             equip(sets.FlameFlame)
        --         else
        --             equip(sets.BrutalMoonshade)
        --         end
        --     end
        -- end
		if state.Buff['Meikyo Shisui'] then
			equip(sets.buff['Meikyo Shisui'])
		end
	end
    if spell.english == "Seigan" then
        -- Third Eye gearset is only called if we're in PDT mode
        if state.HybridMode.value == 'PDT' or state.PhysicalDefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
    if spell.name == 'Spectral Jig' and buffactive.sneak then
            -- If sneak is active when using, cancel before completion
            send_command('cancel 71')
    end
    update_am_type(spell)
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
	-- Effectively lock these items in place.
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
            equip(sets.thirdeye)
        else
            equip(sets.seigan)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = not spell.interrupted or buffactive[spell.english]
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.Buff['Seigan'] then
        if state.DefenseMode.value == 'PDT' then
    	    meleeSet = set_combine(meleeSet, sets.thirdeye)
        else
            meleeSet = set_combine(meleeSet, sets.seigan)
        end
    end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
    if player.equipment.range == 'Yoichinoyumi' then
        meleeSet = set_combine(meleeSet, sets.bow)
    end
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Engaged' then
        if player.inventory['Eminent Arrow'] then
            gear.RAarrow.name = 'Eminent Arrow'
        elseif player.inventory['Tulfaire Arrow'] then
            gear.RAarrow.name = 'Tulfaire Arrow'
        elseif player.equipment.ammo == 'empty' then
            add_to_chat(122, 'No more Arrows!')
        end
    elseif newStatus == 'Idle' then
        determine_idle_group()
    end
end
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
    	state.Buff[buff] = gain
        handle_equipping_gear(player.status)
    end

    -- if S{'madrigal'}:contains(buff:lower()) then
    --     if buffactive.madrigal and state.OffenseMode.value == 'Acc' then
    --         equip(sets.MadrigalBonus)
    --     end
    -- end
    if S{'aftermath'}:contains(buff:lower()) then
        classes.CustomMeleeGroups:clear()
       
        if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
            classes.CustomMeleeGroups:clear()
        elseif player.equipment.main == 'Kogarasumaru'  then
            if buff == "Aftermath: Lv.3" and gain or buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('AM3')
            end
        elseif buff == "Aftermath" and gain or buffactive.Aftermath then
            classes.CustomMeleeGroups:append('AM')
        end
    end
    
    if not midaction() then
        handle_equipping_gear(player.status)
    end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
	get_combat_form()
    update_melee_groups()
    --get_combat_weapon()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--function get_combat_weapon()
--    if player.equipment.range == 'Yoichinoyumi' then
--        if player.equipment.main == 'Amanomurakumo' then
--            state.CombatWeapon:set('AmanoYoichi')
--        else
--            state.CombatWeapon:set('Yoichi')
--        end
--    else
--        state.CombatWeapon:set(player.equipment.main)
--    end
--end
-- Handle zone specific rules
-- windower.register_event('Zone change', function(new,old)
--     determine_idle_group()
-- end)

function determine_idle_group()
    classes.CustomIdleGroups:clear()
    -- if areas.Adoulin:contains(world.area) then
    -- 	classes.CustomIdleGroups:append('Adoulin')
    -- end
end

function get_combat_form()
    -- if areas.Adoulin:contains(world.area) and buffactive.ionis then
    -- 	state.CombatForm:set('Adoulin')
    -- else
    --     state.CombatForm:reset()
    -- end
end

function seigan_thirdeye_active()
    return state.Buff['Seigan'] or state.Buff['Third Eye']
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()

    if player.equipment.main == 'Amanomurakumo' and state.YoichiAM.value then
        -- prevents using Amano AM while overriding it with Yoichi AM
        classes.CustomMeleeGroups:clear()
    elseif player.equipment.main == 'Kogarasumaru' then
        if buffactive['Aftermath: Lv.3'] then
            classes.CustomMeleeGroups:append('AM3')
        end
    else
        if buffactive['Aftermath'] then
            classes.CustomMeleeGroups:append('AM')
        end
    end
end
-- call this in job_post_precast() 
function update_am_type(spell)
    if spell.type == 'WeaponSkill' and spell.skill == 'Archery' and spell.english == 'Namas Arrow' then
        if player.equipment.main == 'Amanomurakumo' then
            -- Yoichi AM overwrites Amano AM
            state.YoichiAM:set(true)
        end
    else
        state.YoichiAM:set(false)
    end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
    	set_macro_page(1, 2)
    else
    	set_macro_page(1, 1)
    end
end

