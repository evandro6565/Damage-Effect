
stone = {}
local count = 0
fire = {}
st_fire = {valid = true}

stone.damage_effect = function(p)
	local surface = p.surface
	local x, y = p.position.x, p.position.y
	local tag = p.tag
	local e = global.entities[tag]
	local particle_count = p.particle_count
	local name = split(p.name, '-damaged')[1]
	
	local is_active = p.effect_except

	function more(n, m)
		if n < 0 then return n-m end
		if n > 0 then return n+m end
	end
	function less(n, m)
		if n < 0 then return n+m end
		if n > 0 then return n-m end
	end
	
	shift = 0.04
	movement = {
		['north'] =     {{0.00, 0.06}, {0.02, 0.06}, {-0.02, 0.06}},
		['northeast'] = {{-0.07+shift, 0.06}, {-0.05+shift, 0.06}, {-0.04+shift, 0.06}},
		['east'] =      {{-0.05, 0.00},{-0.05, -0.02},{-0.05, 0.02}},
		['southeast'] = {{-0.07+shift, -0.06}, {-0.05+shift, -0.06}, {-0.04+shift, -0.06}},
		['south'] =     {{0.00, -0.06}, {0.02, -0.06}, {-0.02, -0.06}},
		['southwest'] = {{0.07-shift, -0.06}, {0.05-shift, -0.06}, {0.04-shift, -0.06}},
		['west'] =      {{0.05, -0.02}, {0.05, 0.00}, {0.05, 0.02}},
		['northwest'] = {{0.07-shift, 0.06}, {0.05-shift, 0.06}, {0.04, 0.06}}
	}
	
	--[[if p.direction == defines.direction.north     then direction = "north" end
	if p.direction == defines.direction.northeast then direction = "northeast" end
	if p.direction == defines.direction.east      then direction = "east" end
	if p.direction == defines.direction.southeast then direction = "southeast" end
	if p.direction == defines.direction.south     then direction = "south" end
	if p.direction == defines.direction.southwest then direction = "southwest" end
	if p.direction == defines.direction.west      then direction = "west" end
	if p.direction == defines.direction.northwest then direction = "northwest" end]]

	directions = {
		"north",
		"northeast",
		"east",
		"southeast",
		"south",
		"southwest",
		"west",
		"northwest", 
	}
	
	l_particle = {
		"wall-stone-particle-medium",
		"wall-stone-particle-small",
		--"wall-stone-particle-tiny",
	}
	
	--[[c_particle = {
		"assembling-machine-1-metal-particle-medium",
		"assembling-machine-1-metal-particle-big",
		"assembling-machine-2-metal-particle-medium",
		"assembling-machine-2-metal-particle-big",
		"assembling-machine-3-metal-particle-medium",
		"assembling-machine-3-metal-particle-big",
	}]]
	
	vertical_speed = {0.1, 0.08, 0.01, 0.2}
	height = {0.3, 0.6}
	timer_stone = 10
	timer_set = {60, 200, 1, 150}
	 

	if p.position then
		if p.state == CONST.DAMAGE.define.low then  --- DAMAGE LOW
			if game.tick % timer_stone == 0 and is_active["smoke"] then
				surface.create_trivial_smoke{name="soft-fire-smoke", position = p.position}--position[direction][name]}
				timer_stone = timer_set[math.floor(math.random()*4)+1]
			end
		end
		
		if p.state == CONST.DAMAGE.define.medium then  --- DAMAGE MEDIUM
			direction = directions[math.floor(math.random()*(#directions))+1] 

			if game.tick % 800 == 0 and count <= particle_count and is_active["particle"] then 
				surface.create_particle{
					name = l_particle[math.floor(math.random()*#l_particle)+1], 
					movement = movement[direction][math.floor(math.random()*3)+1],
					height = height[math.floor(math.random()*2)+1],
					vertical_speed = vertical_speed[math.floor(math.random()*4)+1],
					frame_speed = 0.1, 
					position = p.position,--particle_position[name]
				}
				count = count + 1
			end
			if game.tick % 5 == 0 and is_active["smoke"] then
				surface.create_trivial_smoke{name="soft-fire-smoke", position = p.position}
			end
			
			if game.tick % 200 == 0 then count = 0 end
		end
		
		if p.state == CONST.DAMAGE.define.high then  --- DAMAGE HIGH
			direction = directions[math.floor(math.random()*(#directions))+1] 
			if game.tick % 400 == 0 and count <= particle_count and is_active["particle"] then 
				surface.create_particle{
					name = l_particle[math.floor(math.random()*(#l_particle))+1],
					movement = movement[direction][math.floor(math.random()*3)+1],
					height = height[math.floor(math.random()*2)+1],
					vertical_speed = vertical_speed[math.floor(math.random()*4)+1],
					frame_speed = 0.1, 
					position = p.position,--particle_position[name]
				}
				count = count + 1
			end

			if game.tick % 5 == 0 and is_active["smoke"] then
				surface.create_trivial_smoke{name="soft-fire-smoke", position = p.position}--position[direction][name]}
			end

			if st_fire.valid and game.tick % 2700 == 0 and is_active["fire"] then
				st_fire = surface.create_entity{name = "fire-on", position = p.position} 
			end
		end
	end
	--surface.create_trivial_smoke{name="fire-smoke-on-adding-fuel", position = position}
end 

stone.on_tick = function(tag, category) 
	if category:find("stone", 1, true) --[[and building_complete( e )]] then
		e = global.entities[tag]
		state = "nil"
		if e.effect.damage_high   then state = "damage_high" end
		if e.effect.damage_medium then state = "damage_medium" end
		if e.effect.damage_low    then state = "damage_low" end
		
		if e.entity.valid --[[and building_complete( e )]] then
			stone.damage_effect{
				position = e.entity.position, 
				surface = e.surface, 
				direction = e.entity.direction, 
				state = state,
				name = e.entity.name,
				particle_count = e.particle_count,
				effect_except = CONST.effect_except(e.entity.name),
				tag = tag
			}
		end
	end
end