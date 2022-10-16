--local table = require('__stdlib__/stdlib/utils/table')
require('const') 
require('functions')

require('turret')
require('entity')
require('car')
require('stone')

local util = require('__core__.lualib.util')
local table = require("__flib__.table")
--//////// GLOBAL
function init()
	global = global or {}
	if not global.compare_tick then global.compare_tick = {} end

	if not global.died_entities then global.died_entities = {} end  -- removed or dead
	if not global.entities then global.entities = {} end
	--if not global.recorder then global.recorder = {} end


	--[[if not global.recorder.cars then global.recorder.cars = {} end
	if not global.recorder.turrets then global.recorder.turrets = {} end
	if not global.recorder.entities then global.recorder.entities = {} end
	if not global.recorder.stone_entities then global.recorder.stone_entities = {} end]]

	ghost_entity_area_selection = {area = nil, replace_ghost = false, s_replace_ghost = {}}
end
--s()

script.on_init(function() init() end)
script.on_load(function() init() end)

--//////// GLOBAL

--//////// on_event
--script.on_event(defines.events.on_gui_opened, function() update() end)

script.on_event(defines.events.on_entity_damaged, function(event) 
	--entity_under_attack(event.entity.unit_number, event.force) 
	--print("on_entity_damaged name: "..event.entity.name)
	register_entity(event.entity, true)
end)
script.on_event(defines.events.on_player_setup_blueprint, function(event)
	if type(event.mapping.get()) == "table" then
		--print("is table "..event.mapping.get()[4].name)
	end
	ghost_entity_area_selection.area = event.area
	ghost_entity_area_selection.replace_ghost = true
end) 
script.on_event(defines.events.on_pre_ghost_deconstructed, function(event) 
	local cn = #ghost_entity_area_selection.s_replace_ghost
	if cn > 0 then
		for _, ghost in pairs(ghost_entity_area_selection.s_replace_ghost[cn]) do
			if ghost.valid then
				ghost.destroy()
			end
		end
		table.remove(ghost_entity_area_selection.s_replace_ghost, cn)
	end
end)

script.on_event(defines.events.on_player_mined_entity, function(event) on_destroyed_mined_entity(event)  end)
script.on_event(defines.events.on_robot_mined_entity, function(event) on_destroyed_mined_entity(event)  end)
script.on_event(defines.events.on_entity_died, function(event) on_Destroyed(event) end)

script.on_event(defines.events.on_built_entity, function(event) onBuildHandler(event) end)
script.on_event(defines.events.on_robot_built_entity, function(event) onBuildHandler(event) end)

script.on_event(defines.events.on_post_entity_died, function(event) replace_entity_ghost(event) end)

--script.on_event(defines.events.on_selected_entity_changed, function(event) print("on_selected_entity_changed ") end) 

script.on_event(defines.events.on_tick, function() 
	update()
	car.update_fire_position{delay = 3}
	--if game.tick % 10 == 0 then
	 	run_tick({
			turret = turret,
			entity = entity,
			car = car,
			stone = stone,
		})
 	--end
end)
--//////// on_event

function health_periods(health)
	local function percent(level) -- params n = 'per cent' max = number
		local per_cent = level.n / 100 
		per_cent = level.max * per_cent
		content_targed = level.max - per_cent
		return math.floor(content_targed)
	end

	h = percent{n = CONST.DAMAGE["%"][1], max = health} -- damage_high
	m = percent{n = CONST.DAMAGE["%"][2], max = health} -- damage_medium
	l = percent{n = CONST.DAMAGE["%"][3], max = health} -- damage_low
	
	return {damage_high = h, damage_medium = m, damage_low = l}
end	

function register_entity(entity, on_entity_damaged)
	local category = nil
	if CONST.category[entity.name] then
		category = CONST.category[entity.name][1] 
	elseif CONST.category[entity.type] then
		category = CONST.category[entity.type][1]
	else 
		category = CONST.category["default"][1]
	end

	if entity and entity.force.name == "player" and category and not global.entities[entity.unit_number] then
		local tag = entity.unit_number
		local ent = nil

		--if tableContains{ table = global.entities, element = entity } then return end
		
		if not global.id then global.id = 1 else global.id = global.id + 1 end
		
		--smoke_cl(entity)
		
		new_entity = {
			category = category,
			name = entity.name,
			position = entity.position,
			--creation_position = get_id(entity.position, global.id),
			player = entity.last_user,
			entity = entity,
			surface = entity.surface,
			current_health = entity.health,
			max_health = entity.prototype.max_health,
			health_periods = health_periods(entity.prototype.max_health), -- damage_high = nil, damage_medium = nil, damage_low = nil
			effect = CONST.DAMAGE.default,  -- boolean: damage_high, damage_medium, damage_low 
			particle_count = math.floor(math.random()*7)+2,
			car_fire_effect = {fires = {}, run = true},
			corpse = r_corpse(entity.prototype.corpses, entity.name), -- used to allow or block the dead entity's ultimate effects
			--last_position_fire = {},
			inventory_id = nil,
			id = global.id,
			effects = {fires = {}, smokes = {}},
			effects_counter = 0, --count_effects = 0,
			fx_run_effect = true,
			fx = {
				dying_explosion = nil, 
				count = 0,
				run = true, 
				special_explosion = nil, 
				random_mode_after_death = nil, -- default
				rtm = nil,
				on_player_mined_entity = false,
			},

			--neighbour_underground_belt_tag = nil, -- only if it's underground belt
			tag = tag,
			destroy = false,
		}
		
		new_entity.effects.fires[global.id] = {} 
		

		--[[if entity.health > new_entity.health_periods.damage_low then
			new_entity.fx.on_player_mined_entity = false
			new_entity.fx.count = 0
		end]]

		global.entities[tag] = util.table.deepcopy(new_entity)--table_copy(new_entity)
		--[[global.entities[tag].surface = entity.surface
		global.entities[tag].entity = entity
		global.entities[tag].position = entity.position]]

		if not on_entity_damaged and entity.name:find "-damaged" and entity.health <= health_periods(entity.prototype.max_health).damage_medium then -- damage_high = nil, damage_medium = nil, damage_low = nil
			CONST.build_effect_dying_explosion(global.entities[tag])
			--CONST.multiple_effect_explosion(tag)
		end

		global.died_entities[get_id(entity.position)] = tag
	end
end

function onBuildHandler(event)
	local e = event.created_entity
	local status = health_periods(e.prototype.max_health) -- damage_high, damage_medium, damage_low

	ex_fire{event = {surface = e.surface, unit_number = e.unit_number, position = e.position}}

	if e.health and e.health <= status.damage_low then
		register_entity(e)	
	end
	ghost_ref()
	replace_entity_ghost_in_blueprint(e.surface, e.position, e.name, e)
end

function on_Destroyed(event)
	local destroyed_entity = event.entity
	local e = global.entities[destroyed_entity.unit_number]--global.entities[global.died_entities[get_id(destroyed_entity.position)]]
	--local entities = {}
	--print(destroyed_entity.unit_number)
	if e then
		CONST.death_effect(e.tag) -- active special_explosion
		--destroy_time(e)
		if not e.name:find("tank", 1, true) and not e.fx.special_explosion then e.destroy = true end
		--if not e.fx.special_explosion then table.remove(global.entities, e.tag) print("remove global.entities["..e.tag.."]") end
	end
	--smoke(event)
	--print("destroy")
end

function on_destroyed_mined_entity(event)
	ex_fire{event = {surface = event.entity.surface, unit_number = event.entity.unit_number, position = event.entity.position}}
	local e = global.entities[event.entity.unit_number]--global.entities[global.died_entities[get_id(event.entity.position)]]--event.entity.unit_number]

	if e then
		e.fx.on_player_mined_entity = true
		--global.inventary[e.id] = e
		--destroy_time(e)
		--table.remove(global.entities, event.entity.unit_number)
		if not e.name:find("tank", 1, true) then e.destroy = true end
		--print("effect:197 remove global.entities["..event.entity.unit_number.."]")
	end
end

function ex_fire(p)
	local e = nil
	local fire = nil
	local surface = nil
	local position = nil
	local radius = 2
	local ghost_entity = nil
	
	--stop_fire()
	
	if p.entity then
		e = p.entity
	end
	if p.event then
		tag = p.event.unit_number
		surface = p.event.surface
		position = p.event.position
		--e = global.entities[tag]
	end
	
	if e then--and e.last_position_fire then--and e.fire_effect_prototype then
		surface = e.surface
		if e.entity.valid then position = e.entity.position else position = e.position end
		
		if e.is_fire_effect and type(e.is_fire_effec) == "table" then
			for _, f in pairs(e.is_fire_effect)do
				if f and f.valid then f.destroy() end
			end
		end
	end
		
	if position then
		ghost_entity = surface.find_entity("entity-ghost", position)
		if not ghost_entity then
			fires = surface.find_entities_filtered{position = position, radius=radius, name={"fire-on-car", "fire-on", "no-fire-tree"}}
			--fire = e.surface.find_entity("fire-on", e.position)
			for _, e_fire in pairs(fires) do
				--print("ex_fire fires ")
				if e_fire and e_fire.valid then e_fire.destroy() end
			end
		end
	end
	
	if e and e.entity.valid then global.entities[e.entity.unit_number] = e end
end

--[[function smoke(event)
	local fire = nil
	local e = global.entities[event.entity.unit_number]

	if e and e.fire_effect_prototype then
		if CONST.category[e.name] ~= "car" then
			e.surface.create_entity{name = "fire-smoke", position = e.position}
		else
			e.surface.create_entity{name = "fire-on-car-crash", position = e.entity.position}
			e.surface.create_entity{name = "fire-smoke", position = e.entity.position}
		end
	end
end

function smoke_cl(e)
	local found_smoke = e.surface.find_entity("fire-smoke", e.position)
	if found_smoke then found_smoke.destroy() end
end]]

function check_health_status(entity)
	local transferred_entity = nil
	e = entity
	tag = e.tag
	
	if e.entity.health <= e.health_periods.damage_high then -- damage_high = nil, damage_medium = nil, damage_low = nil

		car_explosion(e)
		health_currenc_period(e, CONST.DAMAGE.define.high) -- define global.entities.effect 'damage_high' true

		transferred_entity = create_damaged_entity{entity = e, surface = e.surface, name = e.name}

	elseif not transferred_entity and e.entity.health > e.health_periods.damage_high and e.entity.health <= e.health_periods.damage_medium then

		car_explosion(e)
		health_currenc_period(e, CONST.DAMAGE.define.medium) -- define global.entities.effect 'damage_medium' true	

		transferred_entity = create_damaged_entity{entity = e, surface = e.surface, name = e.name}

	elseif not transferred_entity and e.entity.health > e.health_periods.damage_medium and e.entity.health <= e.health_periods.damage_low then
		
		ex_fire{entity = e}
		health_currenc_period(e, CONST.DAMAGE.define.low) -- define global.entities.effect 'damage_low' true
		e.destroy = false

	end
	
	--if e.entity.health == e.max_health then
	if not transferred_entity and e.entity.health > e.health_periods.damage_low then
		ex_fire{entity = e}
		--if e.fire_effect_prototype then e.fire_effect_prototype.destroy() end 
		reset(e) 
		create_recovered_entity{tag = tag, surface = e.surface, name = e.name}
		e.fx.run = false
		e.fx_run_effect = true
		if not e.name:find("tank", 1, true) then e.destroy = true end
	end	

	--[[if e.entity.health == e.health_periods.damage_low then
				
	end]]
	--if e.entity.health == e.max_health then e.destroy = true end
end

fires = {}
function run_tick(effect)
	table.for_n_of(global.entities, nil, 10, function(e, tag)  
		effect.entity.on_tick(e)
		effect.turret.on_tick(tag, e.category)
		effect.stone.on_tick(tag, e.category)
		effect.car.on_tick(e)
		if e.entity.valid --[[and not e.destroyand building_complete(e)]] then
			fires[e.id] = true
			--e.current_health = e.entity.health

			check_health_status(e)


		elseif fires[e.id] and not e.entity.valid then 
			fires[e.id] = e.surface.find_entities_filtered{position = e.position, radius=1, name={"fire-on-car", "fire-on", "no-fire-tree"}}
			if fires[e.id] then
				for _, e_fire in pairs(fires[e.id]) do
					if e_fire and e_fire.valid then e_fire.teleport(0, 0.5) end
				end
			end

			fires[e.id] = false
		end--[[
		elseif type(e.is_fire_effect) == "table" then
			--ex_fire{entity = e}
		end]]
		
		car_explosion_death(e)
		CONST.multiple_effect_explosion(tag)
		if game.tick % 30 then return nil, e.destroy end
	end)
end

function get_defines(entity_name) --- params entity_name to check list from function CONST.build_effect return nil if don't exist
	local name = nil
	if entity_name:find "-damaged" then name = split(entity_name, "-damaged")[1] else name = entity_name end
	
	return CONST.build_effect(name).defines_inventory -- list defines.inventory [type] exemple defines.inventory.turret_ammo
end

function inventory_transfer(opts) --- params defines (CONST.build_effect(entity_name).defines_inventory) inventory_a, inventory_b
	
	for _, inv in pairs(opts.inventories_contents) do
		--if inv.valid then 
			for item_name, count in pairs(inv.contents) do
				opts.target_entity.get_inventory(inv.index).insert{name = item_name, count = count}
			end
		--end
	end
			
end

function creat_inventories_list(opts)
	local contents, inv = {}, nil
	if opts.defines then
		for _, define in pairs(opts.defines) do
			inv = opts.entity.get_inventory(define)
			if inv then contents[#contents+1] = {contents = inv.get_contents(), index = inv.index} end -- index = define.inventory
		end
	end
	return contents
end

function create_damaged_entity(params) --- params[ tag, name, position, surface ]
	local damaged_entity, last = nil, params.entity--global.entities[params.tag]
	local reference = nil
	
	if last and last.entity.valid and (not last.entity.name:find "-damaged") and CONST.build_effect(last.entity.name).op then
		get_transport_line(last.entity)
		get_combinator(last.entity)
		set_neighbours_underground_belt(last.entity)
		get_rocket_silo(last.entity)
		get_boiler(last.entity)

		reference = {
			direction = is_underground_belt(last.entity) or last.entity.direction, 
			entity_position = last.entity.position,
			current_health = last.entity.health,
			relative_turret_orientation = last.entity.relative_turret_orientation,
			type = {["assembling-machine"] = true},
			recipe = nil,
			--dying_explosion = last.entity.prototype.dying_explosion,
			inventories_contents = creat_inventories_list{entity = last.entity, defines = get_defines(last.name)},

			name = last.entity.name,
		}
		if reference.type[last.entity.type] then reference.recipe = last.entity.get_recipe() end

		last.entity.destroy()
		--last.entity.die()

		damaged_entity = params.surface.create_entity{name = last.name.."-damaged", position = reference.entity_position, force = "player"} 
		
		if damaged_entity then
		
			--print("cond ok ")
			damaged_entity.health = reference.current_health -- << 

			if reference.direction then damaged_entity.direction = reference.direction end
			if reference.relative_turret_orientation then damaged_entity.relative_turret_orientation = reference.relative_turret_orientation end
			if reference.recipe then damaged_entity.set_recipe( reference.recipe ) end
			config_rocket_silo(damaged_entity)
			inventory_transfer{inventories_contents = reference.inventories_contents, target_entity = damaged_entity}
			
			config_combinator(damaged_entity)
			config_neighbours_underground_belt(damaged_entity)
			config_transport_line(damaged_entity)
			config_boiler(damaged_entity)

			del_neighbour(params.tag)

			if global.died_entities[get_id(reference.entity_position)] == last.tag then 
				table.remove(global.died_entities, get_id(reference.entity_position))
				global.died_entities[get_id(damaged_entity.position)] = damaged_entity.unit_number
			end
			
			local trans = util.table.deepcopy(last)
			local new_tag = damaged_entity.unit_number
			trans.name = damaged_entity.name
			trans.entity = damaged_entity
			trans.position = damaged_entity.position
			trans.surface = damaged_entity.surface
			trans.tag = damaged_entity.unit_number

			global.entities[new_tag] = util.table.deepcopy(trans)
			global.entities[new_tag].entity = damaged_entity
			--[[global.entities[damaged_entity.unit_number].surface = damaged_entity.surface
			global.entities[damaged_entity.unit_number].entity = damaged_entity
			global.entities[damaged_entity.unit_number].position = damaged_entity.position]]
			CONST.build_effect_dying_explosion(global.entities[new_tag])
			

			last.destroy = true
			return true
			--global.categories[last.category][ last.id ] = damaged_entity.unit_number -- register tag of effects 
		end
	end
end

function create_recovered_entity(params) -- tag, name, position, surface
	local recovered_entity, last = nil, global.entities[params.tag]
	local reference = {
		direction = last.entity.direction, 
		entity_position = last.entity.position,
		current_health = last.entity.health,
		relative_turret_orientation = last.entity.relative_turret_orientation,
		type = {["assembling-machine"] = true},
		recipe = nil,
		--dying_explosion = last.entity.prototype.dying_explosion,
		inventories_contents = creat_inventories_list{entity = last.entity, defines = get_defines(last.name)},

		--name = last.entity.name,
	}
	if reference.type[last.entity.type] then reference.recipe = last.entity.get_recipe() end

	if last.entity.valid and last.name:find "-damaged" then

		get_transport_line(last.entity)
		get_combinator(last.entity)
		set_neighbours_underground_belt(last.entity)
		get_rocket_silo(last.entity)
		get_boiler(last.entity)

		last.entity.destroy()

		recovered_entity = params.surface.create_entity{name = split(params.name, "-damaged")[1], direction = reference.direction, position = reference.entity_position, force = "player"}

		if recovered_entity then 

			if reference.relative_turret_orientation then recovered_entity.relative_turret_orientation = reference.relative_turret_orientation end
			if reference.recipe then recovered_entity.set_recipe( reference.recipe ) end -- move recipes 
			config_rocket_silo(recovered_entity)
			inventory_transfer{inventories_contents = reference.inventories_contents, target_entity = recovered_entity}

			config_combinator(recovered_entity)
			config_neighbours_underground_belt(recovered_entity)
			config_transport_line(recovered_entity)
			config_boiler(recovered_entity)

			del_neighbour(params.tag)

			if global.died_entities[get_id(reference.entity_position)] == last.tag then 
				table.remove(global.died_entities, get_id(reference.entity_position))
				global.died_entities[get_id(recovered_entity.position)] = recovered_entity.unit_number
			end


			recovered_entity.health = reference.current_health
			last.health = reference.current_health
			last.name = recovered_entity.name
			last.entity = recovered_entity
			last.position = recovered_entity.position
			last.surface = recovered_entity.surface
			last.tag = recovered_entity.unit_number

			--table.remove(global.entities, params.tag)

			global.entities[recovered_entity.unit_number] = util.table.deepcopy(last)  
			last.destroy = true
			--global.categories[last.category][ last.id ] = recovered_entity.unit_number -- register tag of effects 
		end
	end
end
