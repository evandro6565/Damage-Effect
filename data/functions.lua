 function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function tableContains(params) -- params = table, element, mode, deepsearch
  deep = params.deepsearch or true
  for _ , value in pairs(params.table) do
    -- print(_)
    if params.mode and params.mode == "element-content" and params.element == _ then
       -- print(_)
      return value
    elseif value == params.element then
      return value
    end
    
	if type(value) == "table" and deep then
		local valueOrFalse = tableContains{ table = value, element = params.element, mode = params.mode }
		if valueOrFalse then return value end
	end
  end
  return false
end

rem_content = function(name) -- << not used
    init_table()
    if name --[[and global.fmd.tabs[name]] then
        --global.fmd.tabs[name] = nil
        return true
    end
    return false
end

function scan(t, cv) -- table scan 
	if t then
		for i, c in pairs(t)do
			for v, j in pairs(c)do
				if v == cv then return true end
			end
		end
	end
	return false
end

function table_length(tab, return_) -- <<< e 
	if tab and type(tab) == "table" then return #tab end
	if return_ then return return_ else 
		log("__ERROR__: function.lua table_length(tab) return (nil)")
		return nil 
	end
end

function is_table_vector(tab, op, iq)
	local c = iq or "table"
	if type(tab) == "table" then
		for id, content in pairs(tab) do
			if type(content) == c then 
				if op then return content else return true end 
			else 
				if op then return nil else return false end
			end 
		end
	else return nil end
end 

--- random <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
function random(n) -- params n(number) or n(table) n={ option= ('zero', 0,'0', '0-1', '0..1' and 'one', 1, '1..', '1...' )  }  
	local opN, opP, num = {["zero"]=true, [0]=true, ['0']=true, ['0-1']=true, ['0..1']=true}, {["one"]=true, [1]=true, ['1..']=true, ['1...']=true}, nil
	if type(n) == "table" then 
		if opN[n.option] then num = 0 end
		if opP[n.option] then num = 1 end
		return math.floor(math.random()*n.number)+num
	else return math.floor(math.random()*n)+1 end
end
function rd(n) return random(n) end
function tabRandom(tab, length) length = length or #tab if type(tab)== "table" then return tab[random(length)]  end end

function random_position(opts) 
	local position = opts.position or opts.p
	local tab_positions = opts.position_list or opts.p_list
	local radius = opts.radius or nil
	local tlr = opts.radius and opts.length_in_radius or nil --table length in radius
	local mode = opts.mode or "default" --- > more or +, less or -, default(random) (more and less)

	if position and position[1] then position = {x = position[1], y = position[2]} end 
	
	rf = {[1] = function(n1, n2) return n1 - n2 end, [2] = function(n1, n2) return n1 + n2 end}
	
	if not tab_positions and position and radius and type(radius) == "table" then 
		if mode == "more" then return {rf[2](position.x, radius[random(#radius)]) , rf[2](position.y, radius[random(#radius)])} end
		if mode == "less" then return {rf[1](position.x, radius[random(#radius)]) , rf[1](position.y, radius[random(#radius)])} end
		return {rf[random(2)](position.x, radius[random(#radius)]) , rf[random(2)](position.y, radius[random(#radius)])}
	elseif not tab_positions and position and type(radius) == "number" then
		if mode == "more" then return {rf[2](position.x, radius) , rf[2](position.y, radius)} end
		if mode == "less" then return {rf[1](position.x, radius) , rf[1](position.y, radius)} end
		return {rf[random(2)](position.x, radius) , rf[random(2)](position.y, radius)}
	end
	
	if tab_positions and not radius then return tab_positions[random(#tab_positions)] end
	
	return nil
end
function creat_random_positions_vector(position, radius, ntab, mode)
	local count_tab = ntab or 5
	local mode = mode or "default"
	local vecPositions = {}
	for i = 1, count_tab do -- <<
		vecPositions[i] = random_position{position = position, radius = radius, mode}
	end
	return vecPositions
end
--- random <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

function print(text, color)
	color = color or {r = 1, g = 1, b = 1}
	if game then
		for _, p in pairs(game.players) do
			game.players[_].print(text, color)
		end
	end
end

function get_id(position, id) -- return string value --- >> utilizado para id array global.died_entities[] << ---
	--return "x"..tostring(position.x) .."..y" .. tostring(position.y)
	x = position[1] or position.x
    y = position[2] or position.y
    if id then
 		return tonumber(tostring(math.abs(x))..tostring(math.ceil(math.abs(y)))..tostring(id))
    end
    return tonumber(tostring(math.abs(x))..tostring(math.ceil(math.abs(y))))  
end

function stop_fire(status) -- for rocket não utilizado
	if status == defines.entity_status.preparing_rocket_for_launch and status == defines.entity_status.waiting_to_launch_rocket then
		return true
	end
	return false
end

--- table initEntity <<<<<<<<<<<<<<<<
function reset(e)
	e.effect = {["damage_high"] = false, ["damage_medium"] = false, ["damage_low"] = false}  -- boolean: damage_high, damage_medium, damage_low 
	e.particle_count = math.floor(math.random()*7)+2
	--e.fire_effect = nil
	e.effects.fires[e.id] = {}
end

function health_currenc_period(e, v)
	for id, __ in pairs (e.effect) do
		if id == v then 
			e.effect[id] = true 
		else 
			e.effect[id] = false 
		end
	end
end 

function r_corpse(corpses, name)
	local name = split(name, "-damaged")[1] or name
	local corpse = nil

	corpse = corpse or corpses["1x2-remnants"] and corpses["1x2-remnants"].name
	corpse = corpse or corpses["small-remnants"] and corpses["small-remnants"].name
	corpse = corpse or corpses["medium-remnants"] and corpses[name.."-remnants"].name
	corpse = corpse or corpses["big-remnants"] and corpses["big-remnants"].name
	corpse = corpses[name.."-remnants"] and corpses[name.."-remnants"].name

	return corpse
end

_update_ = false
function update()
	if game and not _update_ then
		for id, p in pairs(game.players) do
			if game.players[id].force.recipes["steam-engine-damaged"] then
				game.players[id].force.recipes["steam-engine-damaged"].enabled = false
				_update_ = true
			end
		end
	end
end
--- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--- ghost <<<<<<<<<<<<<<<<<<<<<<
function replace_entity_ghost(event)
	local filter, position, surface, new_ghost = nil, nil, nil, nil 
	if event.ghost and event.ghost.valid and event.ghost.ghost_name:find "-damaged" then 
		filter = split(event.ghost.ghost_name, "-damaged")[1]
		position = event.ghost.position
		surface = event.ghost.surface
		event.ghost.destroy()
		new_ghost = surface.create_entity{name = "entity-ghost", inner_name = filter, position = position, expires = true, force = "player"}
		new_ghost.time_to_live = 8000
	end 
end
function replace_entity_ghost_in_blueprint(surface, position, entity_name, g)
	local x, y, radius = 0, 0, nil
	local count = 0
	local entities = {}
	local filter = nil
	local move = nil

	if g.name:find("entity-ghost",1,true) and g.ghost_name:find "-damaged" then _cl_ = true end

	if entity_name:find("entity-ghost",1,true) and ghost_entity_area_selection.replace_ghost --[[and ghost_entity_area_selection]] and ghost_entity_area_selection.area then
		local left_top = {x=math.abs(ghost_entity_area_selection.area.left_top.x), y=math.abs(ghost_entity_area_selection.area.left_top.y)}
		local right_bottom = {x=math.abs(ghost_entity_area_selection.area.right_bottom.x), y=math.abs(ghost_entity_area_selection.area.right_bottom.y)}
		x = left_top.x + right_bottom.x
		y = left_top.y + right_bottom.y
		radius = (y * x)
		
		entities = surface.find_entities_filtered{position = position, radius = radius}
		--_delay.blueprint = game.tick + 10
		print("function")
		
		local f = #ghost_entity_area_selection.s_replace_ghost + 1
		if not ghost_entity_area_selection.s_replace_ghost[f] then
			ghost_entity_area_selection.s_replace_ghost[f] = {}
		end

		for _, entity in pairs(entities) do
			if entity.name:find("entity-ghost", 1, true) and entity.ghost_name:find "-damaged" then
				--print("replace_entity_ghost: "..entity.name)
				filter = split(entity.ghost_name, "-damaged")[1]
				target = entity.position
				entity.destroy()
				move = surface.create_entity{name = "entity-ghost", inner_name = filter, position = target, expires = false, force = "player"}
				count = count + 1
				print("ghost damage")
				if move then
					ghost_entity_area_selection.s_replace_ghost[f][count] = move
				end
			end
		end
		--replace_ghost_in_blueprint = false
		ghost_entity_area_selection.replace_ghost = false
	end
end
_cl_ = true
function ghost_ref()
	if _cl_ then
		ghost_entity_area_selection.replace_ghost = true
		_cl_ = false
	end
end
--- ghost <<<<<<<<<<<<<<<<<<<<<<

--- combinator <<<<<<<<<<<<<<<<<<<<<<
combinator_config = {["arithmetic-combinator"] = {parameters = {}}, ["decider-combinator"] = {parameters = {}}, ["constant-combinator"] = {parameters = {}, enabled = nil}}
function get_combinator(combinator) 
	local entity_name = combinator.valid and combinator.name
	local c = 1

	if entity_name:find "-damaged" then entity_name = split(entity_name, "-damaged")[1] end

	if combinator.valid then
		if entity_name == "constant-combinator" then 
			combinator_config["constant-combinator"].enabled = combinator.get_control_behavior().enabled
			for _, parameter_tab in pairs(combinator.get_control_behavior().parameters) do
				combinator_config["constant-combinator"].parameters[c] = parameter_tab
				c = c + 1
			end
		end 
		if entity_name == "decider-combinator" then
			combinator_config["decider-combinator"].parameters = combinator.get_control_behavior().parameters
		end
		if entity_name == "arithmetic-combinator" then 
			combinator_config["arithmetic-combinator"].parameters = combinator.get_control_behavior().parameters
		end
	end
end
function config_combinator(combinator) -- combinator = entity
	local entity_name = combinator.valid and combinator.name
	if entity_name:find "-damaged" then entity_name = split(entity_name, "-damaged")[1] end

	if entity_name == "constant-combinator" and combinator.get_control_behavior() then
		combinator.get_control_behavior().enabled = combinator_config["constant-combinator"].enabled
		combinator.get_control_behavior().parameters = combinator_config["constant-combinator"].parameters
	end
	if entity_name == "decider-combinator" and combinator.get_control_behavior() then
		combinator.get_control_behavior().parameters = combinator_config["decider-combinator"].parameters
	end
	if entity_name == "arithmetic-combinator" and combinator.get_control_behavior() then
		combinator.get_control_behavior().parameters = combinator_config["arithmetic-combinator"].parameters
	end
end
--- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--- underground-belt <<<<<<<<<<<<<<<<<<<<<<
neighbour = {}
tag_saf = nil
function set_neighbours_underground_belt(underground_belt)
	--local tag_ = nil
	if underground_belt.valid and underground_belt.type == "underground-belt" then
		if underground_belt.neighbours then
			--tag_ = underground_belt.neighbours.unit_number
			if not neighbour[underground_belt.unit_number] then 
				tag_saf =  underground_belt.neighbours.unit_number

				if not neighbour[tag_saf] then
					neighbour[tag_saf] = {underground_belt = nil}
					neighbour[tag_saf].underground_belt = underground_belt.neighbours
				end
			end
		end
	end
end
function config_neighbours_underground_belt(underground_belt)
	if underground_belt.valid and underground_belt.type == "underground-belt" then
		if neighbour[tag_saf] then
			if neighbour[tag_saf].underground_belt and neighbour[tag_saf].underground_belt.valid then
				neighbour[tag_saf].underground_belt.health = underground_belt.health 
			end
		end
	end
end
function is_underground_belt(check)
	if check.type == "underground-belt" and neighbour[check.unit_number] then
		--del_neighbour(check.unit_number)
		return fix_direction(check.direction) 
	end
	return nil
end
function fix_direction(direction)
	if direction == defines.direction.east then return defines.direction.west end
	if direction == defines.direction.west then return defines.direction.east end
	if direction == defines.direction.north then return defines.direction.south end
	if direction == defines.direction.south then return defines.direction.north end
end
function del_neighbour(tag)
	if neighbour[tag] then
		if not neighbour[tag].underground_belt.valid then
			neighbour = {} 
		end
	end
end
--- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--- transport-belt <<<<<<<<<<<<<<<<<<<<<<
function _transport_line_()
	inventory_transport_belt = {line_right = {}, line_left = {}, right_counter = 0, left_counter = 0}
end

function get_transport_line(transport_belt)
	local line_right, line_left = 1, 2
	local c = 1
	local belt = {["underground-belt"] = true, ["transport-belt"] = true}
	_transport_line_()

	if transport_belt.valid and belt[transport_belt.type] then
		for item_name, amount in pairs(transport_belt.get_transport_line(line_right).get_contents()) do
			inventory_transport_belt.line_right[c] = {item_name = item_name, count = amount}
			c = c + 1
			inventory_transport_belt.right_counter = c
		end
		c = 1
		for item_name, amount  in pairs(transport_belt.get_transport_line(line_left).get_contents()) do
			inventory_transport_belt.line_left[c] = {item_name = item_name, count = amount}
			c = c + 1
			inventory_transport_belt.left_counter = c
		end
	end
end
function config_transport_line(transport_belt)
	local belt = {["underground-belt"] = true, ["transport-belt"] = true}
	local position, p_length = {--[[e]]0.6, --[[p]]0.3, --[[m]]0.1, --[[b]]0}, 4
	local line_right, line_left = 1, 2
	local n_itens_right, n_itens_left = inventory_transport_belt.right_counter, inventory_transport_belt.left_counter

	if transport_belt.valid and belt[transport_belt.type] then
		if n_itens_right > 0 then
			for _, tab in pairs(inventory_transport_belt.line_right) do
				for i=1, tab.count do -- amount itens
					for c=1, p_length do -- positions list on belt
						local can_insert_at = transport_belt.get_transport_line(line_right).can_insert_at(position[c]) -- item can be inserted 
						if can_insert_at then transport_belt.get_transport_line(line_right).insert_at(position[c], {name = tab.item_name}) break end
					end
				end
			end
		end
		if n_itens_left > 0 then
			for _, tab in pairs(inventory_transport_belt.line_left) do
				for i=1, tab.count do -- amount itens
					for c=1, p_length do -- positions list on belt
						local can_insert_at = transport_belt.get_transport_line(line_left).can_insert_at(position[c]) -- item can be inserted 
						if can_insert_at then transport_belt.get_transport_line(line_left).insert_at(position[c], {name = tab.item_name}) break end
					end
				end
			end
		end
	end
end
--- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--- rocket-silo <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
var_rocket_silo = {rocket_parts = 0, auto_launch = nil, products_finished = 0}
function get_rocket_silo(rocket_silo)
	local check = {["rocket-silo"] = true}
	local current_status = {[defines.entity_status.preparing_rocket_for_launch] = true, [defines.entity_status.waiting_to_launch_rocket] = true, [defines.entity_status.launching_rocket] = true}

	if check[rocket_silo.name] then
		var_rocket_silo.auto_launch = rocket_silo.auto_launch 
		var_rocket_silo.products_finished = rocket_silo.products_finished
		var_rocket_silo.rocket_parts = rocket_silo.rocket_parts

		if current_status[rocket_silo.status] then
			var_rocket_silo.rocket_parts = 100
		end
	end
end

function config_rocket_silo(rocket_silo)
	local check = {["rocket-silo"] = true}
	if check[rocket_silo.name] then
		rocket_silo.rocket_parts = var_rocket_silo.rocket_parts
		rocket_silo.auto_launch = var_rocket_silo.auto_launch 
		rocket_silo.products_finished = var_rocket_silo.products_finished
	end
end
--- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--- boiler <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
get_var_boiler = {energy = nil, temperature = nil}
function get_boiler( boiler )
	if boiler.type == "boiler" then 
		get_var_boiler.energy = boiler.energy
		get_var_boiler.temperature = boiler.temperature
	end
end 

function config_boiler( boiler )
	if boiler.valid and get_var_boiler.energy then
		boiler.energy = get_var_boiler.energy or boiler.energy
		if get_var_boiler.temperature then
			boiler.temperature = get_var_boiler.temperature or boiler.temperature
		end
	end
end
--- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

--- mods
--[[function entity_under_attack(tag, target_force)
	if game.active_mods["Building_Time_With_Setting"] then 
		local e = global.entities[tag]
		
		if e and target_force.name:find("enemy",1,true) then
			print("enemy")
			e.entity_under_attack = true
		elseif e then
			e.entity_under_attack = false
		end 
	end
end

function building_complete( entity_data )
	if game.active_mods["Building_Time_With_Setting"] then 
		if not entity_data.entity_under_attack then
			if entity_data.entity.valid and entity_data.entity.health == entity_data.max_health and not entity_data.name:find "-damaged" then 
				entity_data.building_complete = true
				return entity_data.building_complete 
			end
			return entity_data.building_complete
		else
			e.entity_under_attack = false
			return not e.entity_under_attack
		end
	else
		return true
	end
end]]
-------