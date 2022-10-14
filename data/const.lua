require('functions')

CONST = {}

CONST.active = true
CONST.disable = false 

CONST.mod_name = "__damage_effect__"
CONST.mods_list = {}

CONST.category = {
	["entity-ghost"] = {CONST.disable, expires = true, time_to_live = 800},
	["tile"] = {CONST.disable},
	["default"] = {"entity"}, -- default category entity

	["gun-turret"] = {"turret"},
	["artillery-turret"] = {"turret"},
	["flamethrower-turret"] = {"turret"},
	["laser-turret"] = {"turret"},
	
	["tank"] = {"car"},
	["car"] = {"car"},
	
	["stone-furnace"] = {"stone"},
	["steel-furnace"] = {"stone"},
	["gate"] = {"stone"},
}


CONST.no_effect = function(entity_name) 
	local list = {
		["wooden-chest"] = true,
		["iron-chest"] = true,
		["steel-chest"] = true,
		["small-electric-pole"] = true,
		["medium-electric-pole"] = true,
		["big-electric-pole"] = true,
		["stone-wall"] = true,
		--["storage-tank"] = true,
	}
	if entity_name:find "-damaged" then entity_name = split(entity_name, "-damaged")[1] end

	if list[entity_name] then return false else return true end
end

function enable_effects(opt) 
	local all = opt.all or false
	local fire = opt.fire or all
	local particle = opt.particle or all
	local smoke = opt.smoke or all
	return {["smoke"] = smoke, ["fire"] = fire, ["particle"] = particle}
end
CONST.effect_except = function(entity_name) 
	local list = {
		["gate"] = enable_effects{smoke = CONST.active},

		["transport-belt"] = enable_effects{smoke = CONST.active},
		["fast-transport-belt"] = enable_effects{smoke = CONST.active},
		["express-transport-belt"] = enable_effects{smoke = CONST.active},
		["underground-belt"] = enable_effects{smoke = CONST.active},
		["fast-underground-belt"] = enable_effects{smoke = CONST.active},
		["express-underground-belt"] = enable_effects{smoke = CONST.active},

		["splitter"] = enable_effects{smoke = CONST.active},
		["fast-splitter"] = enable_effects{smoke = CONST.active},
		["express-splitter"] = enable_effects{smoke = CONST.active},

		["chemical-plant"] = enable_effects{smoke = CONST.active, fire = CONST.active},

		["storage-tank"] = enable_effects{smoke = CONST.active},

		["logistic-chest-active-provider"] = enable_effects{smoke = CONST.active, fire = CONST.active},
		["logistic-chest-buffer"] = enable_effects{smoke = CONST.active, fire = CONST.active},
		["logistic-chest-passive-provider"] = enable_effects{smoke = CONST.active, fire = CONST.active},
		["logistic-chest-requester"] = enable_effects{smoke = CONST.active, fire = CONST.active},
		["logistic-chest-storage"] = enable_effects{smoke = CONST.active, fire = CONST.active},

		["programmable-speaker"] = enable_effects{smoke = CONST.active, fire = CONST.active},
		["arithmetic-combinator"] = enable_effects{smoke = CONST.active, fire = CONST.active},
		["decider-combinator"] = enable_effects{smoke = CONST.active, fire = CONST.active},
		["constant-combinator"] = enable_effects{smoke = CONST.active, fire = CONST.active},

		["accumulator"] = enable_effects{smoke = CONST.active},

		["boiler"] = enable_effects{smoke = CONST.active, fire = CONST.active},
		["heat-exchanger"] = enable_effects{smoke = CONST.active, fire = CONST.active},

		["burner-inserter"] = enable_effects{smoke = CONST.active},
		["fast-inserter"] = enable_effects{smoke = CONST.active},
		["filter-inserter"] = enable_effects{smoke = CONST.active},
		["inserter"] = enable_effects{smoke = CONST.active},
		["long-handed-inserter"] = enable_effects{smoke = CONST.active},
		["stack-filter-inserter"] = enable_effects{smoke = CONST.active},
		["stack-inserter"] = enable_effects{smoke = CONST.active},

		["steel-furnace"] = enable_effects{smoke = CONST.active, particle = CONST.active},
		["stone-furnace"] = enable_effects{smoke = CONST.active, particle = CONST.active},

	}
	if entity_name:find "-damaged" then entity_name = split(entity_name, "-damaged")[1] end

	return list[entity_name] or enable_effects{all = true}
end

CONST.build_effect_dying_explosion = function(_entity_) --- entity in global.entities
	--local entity = global.entities[tag]
	if _entity_.fx_run_effect then
		local rtm = {3000, 2000, 3500, 2500, 2800}
		local f, c = {3, 4}, {2, 3}
		local entity_name = (_entity_.name:find "-damaged" ~= nil) and split(_entity_.name, "-damaged")[1] or _entity_.name
		local list = {
			["stone-furnace"] = {name = "stone-furnace-explosion"},
			["steel-furnace"] = {name = "steel-furnace-explosion", fx = 2, random_mode_after_death = false},
			["electric-furnace"] = {name = "electric-furnace-explosion", fx = 2},
			["gate"] = {name = "gate-explosion"},
			["stone-wall"] = {name = "wall-explosion"},
			["gun-turret"] = {name = "gun-turret-explosion"},

			["assembling-machine-1"] = {name = "assembling-machine-1-explosion", fx = 3, random_mode_after_death = false},
			["assembling-machine-2"] = {name = "assembling-machine-2-explosion", fx = 3},
			["assembling-machine-3"] = {name = "assembling-machine-3-explosion", fx = 3},

			["steam-engine"] = {name = "steam-engine-explosion", fx = c[random(#c)],  random_mode_after_death = false},
			["steam-turbine"] = {name = "steam-turbine-explosion", fx = c[random(#c)],  random_mode_after_death = false},

			["artillery-turret"] = {name = "artillery-turret-explosion", fx = 2},
			["centrifuge"] = {name = "centrifuge-explosion", fx = 2},
			["chemical-plant"] = {name = "chemical-plant-explosion"},
			["oil-refinery"] = {name = "oil-refinery-explosion", fx = c[random(#c)]},
			["rocket-silo"] = {name = "rocket-silo-explosion", fx = f[random(#f)]},
			["wooden-chest"] = {name = "wooden-chest-explosion"},
			["steel-chest"] = {name = "steel-chest-explosion"},
			["iron-chest"] = {name = "iron-chest-explosion"},
			["lab"] = {name = "lab-explosion"},
			["solar-panel"] = {name = "solar-panel-explosion"},

			["transport-belt"] = {name = "transport-belt-explosion"},
			["fast-transport-belt"] = {name = "fast-transport-belt-explosion"},
			["express-transport-belt"] = {name = "express-transport-belt-explosion"},
			["underground-belt"] = {name = "underground-belt-explosion"},
			["fast-underground-belt"] = {name = "fast-underground-belt-explosion"},
			["express-underground-belt"] = {name = "express-underground-belt-explosion"},

			["beacon"] = {name = "beacon-explosion"},
			["programmable-speaker"] = {name = "programmable-speaker-explosion"},
			["arithmetic-combinator"] = {name = "arithmetic-combinator-explosion"},
			["decider-combinator"] = {name = "decider-combinator-explosion"},
			["constant-combinator"] = {name = "constant-combinator-explosion"},

			["small-electric-pole"] = {name = "small-electric-pole-explosion"},
			["medium-electric-pole"] = {name = "medium-electric-pole-explosion"},
			["big-electric-pole"] = {name = "big-electric-pole-explosion"},
			["substation"] = {name = "substation-explosion", fx = 2},
			["accumulator"] = {name = "accumulator-explosion", fx = 2},

			["logistic-chest-active-provider"] = {name = "active-provider-chest-explosion"},
			["logistic-chest-buffer"] = {name = "buffer-chest-explosion"},
			["logistic-chest-passive-provider"] = {name = "passive-provider-chest-explosion"},
			["logistic-chest-requester"] = {name = "requester-chest-explosion"},
			["logistic-chest-storage"] = {name = "storage-chest-explosion"},

			["storage-tank"] = {name = "storage-tank-explosion"},
			["pumpjack"] = {name = "pumpjack-explosion"},

			["burner-inserter"] = {name = "burner-inserter-explosion"},
			["fast-inserter"] = {name = "fast-inserter-explosion"},
			["filter-inserter"] = {name = "filter-inserter-explosion"},
			["inserter"] = {name = "inserter-explosion"},
			["long-handed-inserter"] = {name = "long-handed-inserter-explosion"},
			["stack-filter-inserter"] = {name = "stack-filter-inserter-explosion"},
			["stack-inserter"] = {name = "storage-tank-explosion"},

			["boiler"] = {name = "boiler-explosion"},
			["heat-exchanger"] = {name = "heat-exchanger-explosion"},

			["nuclear-reactor"] = {name = "nuclear-reactor-explosion", death_effect = {name = "nuke-explosion", rtm = 800} , fx = c[random(#c)]},
		}
		if list[entity_name] then
			if list[entity_name].fx and not list[entity_name].death_effect then --and not list[entity_name].after_death_effect then
				_entity_.fx = {
					dying_explosion = list[entity_name].name, 
					count = list[entity_name].fx or 0, 
					run = true, 
					special_explosion = nil, 
					random_mode_after_death = list[entity_name].random_mode_after_death or true, -- default
					rtm = rtm, -- time
					on_player_mined_entity = false, -- stop explosion effect after entity is mined  
				}
			else
				_entity_.surface.create_entity{name = list[entity_name].name , position = _entity_.position}
			end

			if list[entity_name].death_effect then
				--print("build_effect_dying_explosion   death_effect "..entity_name.." tag "..tag)
				_entity_.fx.special_explosion = {run = false, name = list[entity_name].death_effect.name, rtm = list[entity_name].death_effect.rtm} --- <<
				--- run = false  << only run this if entity is dead
			end
			_entity_.fx_run_effect = false
			--global.entities[entity.tag] = entity
		end
	end
end
CONST.death_effect = function(tag)
	local e = global.entities[tag]
	if e and e.fx.special_explosion then 
		e.fx.special_explosion.run = true 
	end
end
CONST.special_explosion = function(entity)
	--local e = global.entities[tag]
	local e = entity
	if --[[e and ]] e.fx.special_explosion and e.fx.special_explosion.run then
		if game.tick % e.fx.special_explosion.rtm == 0 then
			e.surface.create_entity{name = e.fx.special_explosion.name , position = {e.position.x, e.position.y-5}}
			e.surface.create_entity{name="huge-scorchmark", position = e.position}
			e.fx.special_explosion.run = false --- << stoped effect
			--e.destroy = true --- << delete data = global.entities
		end

		if not e.entity.valid and not e.fx.special_explosion.run then
			--table.remove(global.entities, e.tag) --- << delete data = global.entities
			--print("const:211 remove global.entities["..e.tag.."]")
			e.destroy = true
		end
	end
end
CONST.multiple_effect_explosion = function(tag)
	e = global.entities[tag]
	if e then
		local active = (not e.fx.random_mode_after_death and e.entity.valid) or e.fx.random_mode_after_death -- check after death

		--e.surface.find_entities_filtered{name = nm.."-remmants", position = e.position, radius = 1}
		local nm = (e.name:find "-damaged" ~= nil) and split(e.name, "-damaged")[1] or e.name
		local remmants = e.entity.valid or e.surface.find_entity(nm.."-remnants", e.position) and true
		local st_fire = {valid = true}
		--p = e.entity.valid and e.entity.position or e.position

		if e.fx.rtm and active and remmants--[[and not e.fx.on_player_mined_entity and e.name:find "-damaged"]] then
			if ( e.fx.count > 0 and ( game.tick % e.fx.rtm[random(5)] == 0 ) ) or e.fx.run then --- <<
				e.surface.create_entity{name = e.fx.dying_explosion , position = e.position}
				if not e.entity.valid then e.surface.create_entity{name = "fire-on", position = e.position} end
				e.fx.run = false

				--if st_fire.valid then st_fire = e.surface.create_entity{name = "fire-on", position = e.position} end temp

				--if e.fx.count == 0 and not e.fx.special_explosion then e.destroy = true end --- << delete data = global.entities
				if e.fx.count <= 0 and not e.entity.valid and not e.fx.special_explosion then 
					e.destroy = true 
				end
				e.fx.count = e.fx.count - 1
			end
			
		end

		CONST.special_explosion(e)
	end
end
CONST.build_effect = function(entity_name) 
	local list = {
		["gun-turret"] = {op = true, defines_inventory = {defines.inventory.turret_ammo}},

		-- assembling machine
		["assembling-machine-1"] = {op = true, defines_inventory = {defines.inventory.assembling_machine_input, defines.inventory.assembling_machine_output, defines.inventory.assembling_machine_modules}},
		["assembling-machine-2"] = {op = true, defines_inventory = {defines.inventory.assembling_machine_input, defines.inventory.assembling_machine_output, defines.inventory.assembling_machine_modules}},
		["assembling-machine-3"] = {op = true, defines_inventory = {defines.inventory.assembling_machine_input, defines.inventory.assembling_machine_output, defines.inventory.assembling_machine_modules}},
		["centrifuge"] = {op = true, defines_inventory = {defines.inventory.assembling_machine_input, defines.inventory.assembling_machine_output, defines.inventory.assembling_machine_modules}},
		["oil-refinery"] = {op = true, defines_inventory = {defines.inventory.assembling_machine_input, defines.inventory.assembling_machine_output, defines.inventory.assembling_machine_modules}},
		["chemical-plant"] = {op = true, defines_inventory = {defines.inventory.assembling_machine_input, defines.inventory.assembling_machine_output, defines.inventory.assembling_machine_modules}},
		["rocket-silo"] = {
			op = true, 
			defines_inventory = {
				defines.inventory.rocket_silo_rocket,
				defines.inventory.rocket_silo_result,
				defines.inventory.rocket_silo_input,
				defines.inventory.rocket_silo_output,
				defines.inventory.rocket_silo_modules,
				defines.inventory.rocket
			}
		},
		-- assembling machine

		-- chest
		["wooden-chest"] = {op = true, defines_inventory = {defines.inventory.chest}},
		["steel-chest"] = {op = true, defines_inventory = {defines.inventory.chest}},
		["iron-chest"] = {op = true, defines_inventory = {defines.inventory.chest}},
		-- chest

		-- logistic-container
		["logistic-chest-active-provider"] = {op = true, defines_inventory = {defines.inventory.chest}},
		["logistic-chest-buffer"] = {op = true, defines_inventory = {defines.inventory.chest}},
		["logistic-chest-passive-provider"] = {op = true, defines_inventory = {defines.inventory.chest}},
		["logistic-chest-requester"] = {op = true, defines_inventory = {defines.inventory.chest}},
		["logistic-chest-storage"] = {op = true, defines_inventory = {defines.inventory.chest}},
		-- logistic-container

		-- circuit-network
		["programmable-speaker"] = {op = true, defines_inventory = {}},
		["arithmetic-combinator"] = {op = true, defines_inventory = {}},
		["decider-combinator"] = {op = true, defines_inventory = {}},
		["constant-combinator"] = {op = true, defines_inventory = {}},
		-- circuit-network
		
		["accumulator"] = {op = true, defines_inventory = {}},

		["nuclear-reactor"] = {op = true, defines_inventory = {defines.inventory.fuel, defines.inventory.burnt_result}},

		["lab"] = {op = true, defines_inventory = {defines.inventory.lab_input, defines.inventory.lab_modules}},
		
		["beacon"] = {op = true, defines_inventory = {defines.inventory.beacon_modules}},
		
		["solar-panel"] = {op = true, defines_inventory = {}},

		["roboport"] = {op = true, defines_inventory = {defines.inventory.roboport_robot, defines.inventory.roboport_material}},

		["storage-tank"] = {op = true, defines_inventory = {}},

		-- electric-pole
		["small-electric-pole"] = {op = true, defines_inventory = {}},
		["medium-electric-pole"] = {op = true, defines_inventory = {}},
		["big-electric-pole"] = {op = true, defines_inventory = {}},
		["substation"] = {op = true, defines_inventory = {}},
		-- electric-pole
		
		-- furnace
		["electric-furnace"] = {op = true, defines_inventory = {defines.inventory.furnace_source, defines.inventory.furnace_result, defines.inventory.furnace_modules}},
		["steel-furnace"] = {op = true, defines_inventory = {defines.inventory.furnace_source, defines.inventory.furnace_result, defines.inventory.fuel}},
		-- furnace

		-- stone
		["stone-furnace"] = {op = true, defines_inventory = {defines.inventory.furnace_source, defines.inventory.furnace_result, defines.inventory.fuel}},
		["stone-wall"] = {op = true, defines_inventory = {}},
		["gate"] = {op = true, defines_inventory = {}},
		-- stone

		-- transport-belt
		["transport-belt"] = {op = true, defines_inventory = {}},
		["fast-transport-belt"] = {op = true, defines_inventory = {}},
		["express-transport-belt"] = {op = true, defines_inventory = {}},
		-- transport-belt

		-- underground-belt
		["underground-belt"] = {op = true, defines_inventory = {}},
		["fast-underground-belt"] = {op = true, defines_inventory = {}},
		["express-underground-belt"] = {op = true, defines_inventory = {}},
		-- underground-belt

		-- mining-drill
		["pumpjack"] = {op = true, defines_inventory = {defines.inventory.mining_drill_modules}},
		-- mining-drill

		-- generator
		["steam-engine"] = {op = true, defines_inventory = {}},
		["steam-turbine"] = {op = true, defines_inventory = {}},
		-- generator

		-- boiler 
		["boiler"] = {op = true, defines_inventory = {defines.inventory.fuel}},
		["heat-exchanger"] = {op = true, defines_inventory = {}},
		-- boiler
	}
	
	if list[entity_name] then return list[entity_name] end
	
	return {op = false, defines_inventory = nil}
end

CONST.setting = {fire = {"fire-on", "no-fire-tree"}}

CONST.DAMAGE = {}
CONST.DAMAGE["%"] = {60, 45, 25} -- damage_high, damage_medium, damage_low... per cent
CONST.DAMAGE.define = {high="damage_high", medium="damage_medium", low="damage_low"}
CONST.DAMAGE.default = {["damage_high"] = false, ["damage_medium"] = false, ["damage_low"] = false} -- boolean: damage_high, damage_medium, damage_low

CONST.dimension = {["very_small"] = 0, ["small"] = 1, ["medium"] = 2, ["big"] = 3, ["very_big"] = 4}

CONST.tick = 100