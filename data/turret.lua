-- <<<<<<temp>>>>>>


--local data = require '__storage__.util'
--global.deff.effect["gun-turret"] = {}
--local dur = math.floor(math.random()*7)+2
turret = {}
local count = 0
fire = {}
particle = {}

---if not global.deff.effect["gun-turret"] then global.deff.effect["gun-turret"] = {} end 

--global.deff.effect["gun-turret"].create_damage_effect = function(p) -- position, surface, direction, state, particle_count
turret.damage_effect = function(p)
	local surface = p.surface
	local x, y = p.position.x, p.position.y
	local tag = p.tag
	local e = global.entities[tag]
	local particle_count = p.particle_count
	local name = split(p.name, '-damaged')[1]
	
	function more(n, m)
		if n < 0 then return n-m end
		if n > 0 then return n+m end
	end
	function less(n, m)
		if n < 0 then return n+m end
		if n > 0 then return n-m end
	end
	
	position = {
		['north'] = {
			['gun-turret'] = {x, y},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
			
		},
		['northeast'] = {
			['gun-turret'] = {less(x, 0.5), y},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['east'] = {
			['gun-turret'] = {less(x, 0.5), more(y, 0.5)},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['southeast'] = {
			['gun-turret'] = {less(x, 1), more(y, 1)},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['south'] = {
			['gun-turret'] = {x, more(y, 1)},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['southwest'] = {
			['gun-turret'] = {more(x, 1), more(y, 1)},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['west'] = {
			['gun-turret'] = {more(x, 1), more(y, 0.5)},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['northwest'] = {
			['gun-turret'] = {more(x, 1), less(y, 0.5)},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		}
	}
	
	position = {
		['north'] = {
			['gun-turret'] = {x, y},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
			
		},
		['northeast'] = {
			['gun-turret'] = {x-0.5, y},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['east'] = {
			['gun-turret'] = {x-0.5, y+0.5},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['southeast'] = {
			['gun-turret'] = {x-1, y+1},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['south'] = {
			['gun-turret'] = {x, y+1},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['southwest'] = {
			['gun-turret'] = {x+1, y+1},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['west'] = {
			['gun-turret'] = {x+1, y+0.5},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
		['northwest'] = {
			['gun-turret'] = {x+1, y-0.5},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, more(y, 1)},
		},
	}
	
	fire_position = {
		['north'] = {
			['gun-turret'] = {x, y - 0.5},--{x, more(y, 0.5)},
			['flamethrower-turret'] = {x, more(y, 0.5)},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, y},
		},
		['northeast'] = {
			['gun-turret'] = {x, y - 0.5},
			['flamethrower-turret'] = {less(x, 0.5), y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, y},
		},
		['east'] = {
			['gun-turret'] = {x, y - 0.5},
			['flamethrower-turret'] = {less(x, 0.5), y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, y},
		},
		['southeast'] = {
			['gun-turret'] = {x, y - 0.5},
			['flamethrower-turret'] = {less(x, 0.5), y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, y},
		},
		['south'] = {
			['gun-turret'] = {x, y - 0.5},
			['flamethrower-turret'] = {x, y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, y},
		},
		['southwest'] = {
			['gun-turret'] = {x, y - 0.5},
			['flamethrower-turret'] = {more(x, 0.5), y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, y},
		},
		['west'] = {
			['gun-turret'] = {x, y - 0.5},
			['flamethrower-turret'] = {more(x, 0.5), y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, y},
		},
		['northwest'] = {
			['gun-turret'] = {x, y - 0.5},
			['flamethrower-turret'] = {more(x, 0.5), y},
			['artillery-turret'] = {x, more(y, 0.5)},
			['laser-turret'] = {x, y},
		},
	}
	
	movement = {
		['north'] =     {{0.00, 0.06}, {0.02, 0.06}, {-0.02, 0.06}},
		['northeast'] = {{-0.07, 0.06}, {-0.05, 0.06}, {-0.04, 0.06}},
		['east'] =      {{-0.05, 0.00},{-0.05, -0.02},{-0.05, 0.02}},
		['southeast'] = {{-0.07, -0.06}, {-0.05, -0.06}, {-0.04, -0.06}},
		['south'] =     {{0.00, -0.06}, {0.02, -0.06}, {-0.02, -0.06}},
		['southwest'] = {{0.07, -0.06}, {0.05, -0.06}, {0.04, -0.06}},
		['west'] =      {{0.05, -0.02}, {0.05, 0.00}, {0.05, 0.02}},
		['northwest'] = {{0.07, 0.06}, {0.05, 0.06}, {0.04, 0.06}}
	}
	
	if p.direction == defines.direction.north     then direction = "north" end
	if p.direction == defines.direction.northeast then direction = "northeast" end
	if p.direction == defines.direction.east      then direction = "east" end
	if p.direction == defines.direction.southeast then direction = "southeast" end
	if p.direction == defines.direction.south     then direction = "south" end
	if p.direction == defines.direction.southwest then direction = "southwest" end
	if p.direction == defines.direction.west      then direction = "west" end
	if p.direction == defines.direction.northwest then direction = "northwest" end
	
	particle_position = {
		['gun-turret'] = {x, y},
		['flamethrower-turret'] = {x, y},
		['artillery-turret'] = {more(x, 0.5), y},
		['laser-turret'] = {x, y}
	}
	
	l_particle = {
		"damaged-assembling-machine-mechanical-component-particle-medium",
		"damaged-assembling-machine-long-metal-particle-medium",
		"repaired-assembling-machine-metal-particle-big",
		"repaired-assembling-machine-long-metal-particle-medium",
		"gun-turret-metal-particle-big",
		"gun-turret-metal-particle-medium",
	}
	
	c_particle = {
		"assembling-machine-1-metal-particle-medium",
		"assembling-machine-1-metal-particle-big",
		"assembling-machine-2-metal-particle-medium",
		"assembling-machine-2-metal-particle-big",
		"assembling-machine-3-metal-particle-medium",
		"assembling-machine-3-metal-particle-big",
	}
	
	vertical_speed = {0.1, 0.08, 0.01, 0.2}
	height = {1, 0.6}
	timer_turrent = 10
	timer_set = {60, 200, 1, 150}
	
	if p.position then
	if p.state == CONST.DAMAGE.define.low then  --- DAMAGE LOW
		if game.tick % timer_turrent == 0 then
			surface.create_trivial_smoke{name="soft-fire-smoke", position = position[direction][name]}
			timer_turrent = timer_set[math.floor(math.random()*4)+1]
		end
	end
	
	if p.state == CONST.DAMAGE.define.medium then  --- DAMAGE MEDIUM
		if game.tick % 800 == 0 and count <= particle_count then 
			surface.create_particle{
				name = c_particle[math.floor(math.random()*6)+1], 
				movement = movement[direction][math.floor(math.random()*3)+1],
				height = height[math.floor(math.random()*2)+1],
				vertical_speed = vertical_speed[math.floor(math.random()*4)+1],
				frame_speed = 0.1, 
				position = particle_position[name]
			}
			count = count + 1
		end
		if game.tick % 5 == 0 then
			surface.create_trivial_smoke{name="soft-fire-smoke", position = position[direction][name]}
		end
		
		if game.tick % 200 == 0 then count = 0 end
	end
	
	if p.state == CONST.DAMAGE.define.high then  --- DAMAGE HIGH 
		if game.tick % 400 == 0 and count <= particle_count then 
			particle[tag] = surface.create_particle{
				name = l_particle[math.floor(math.random()*6)+1], 
				movement = movement[direction][math.floor(math.random()*3)+1],
				height = height[math.floor(math.random()*2)+1],
				vertical_speed = vertical_speed[math.floor(math.random()*4)+1],
				frame_speed = 0.1, 
				position = particle_position[name]
			}
			count = count + 1
		end
		
		--[[if e.is_fire_effect ~= "on_fire" then 
			fire[tag] = surface.create_entity{name = e.fire_effect_prototype, position = fire_position[direction][name]} 
			e.last_position_fire = fire[tag].position
			e.is_fire_effect  = "on_fire"
		end
		if not fire[tag].valid and game.tick % 1800 == 0 then 
			fire[tag] = surface.create_entity{name = e.fire_effect_prototype, position = fire_position[direction][name]}
			e.last_position_fire = fire[tag].position
		end]]
		
		if not fire[tag] then 
			fire[tag] = {} 
			fire[tag].prototype = surface.create_entity{name = "fire-on", position = {p.position.x, p.position.y-0.5}} 
		end
		
		if game.tick % 1200 == 0 and not fire[tag].prototype.valid then--and not fire[tag].prototype and not fire[tag].prototype.valid then 
			fire[tag].prototype = surface.create_entity{name = "fire-on", position = {p.position.x, p.position.y-0.5}} 
			global.entities[tag].last_position_fire = fire[tag].prototype.position --- add position
		end
		
		if game.tick % 600 == 0 then count = 0 end
		--[[if game.tick % 30 == 0 then
			surface.create_trivial_smoke{name="soft-fire-smoke", position = position[direction]}
		end]]
	end
	end
	--surface.create_trivial_smoke{name="fire-smoke-on-adding-fuel", position = position}
end 


turret.on_tick = function(tag, category) 
	if category:find("turret", 1, true) then
		e = global.entities[tag]
		state = "nil"
		if e.effect.damage_high   then state = "damage_high" end
		if e.effect.damage_medium then state = "damage_medium" end
		if e.effect.damage_low    then state = "damage_low" end
		
		if e.entity.valid then
			turret.damage_effect{
				position = e.entity.position, 
				surface = e.surface, 
				direction = e.entity.direction, 
				state = state,
				name = e.entity.name,
				particle_count = e.particle_count,
				tag = tag
			}
		end	
	end
end

--[[script.on_nth_tick(300, function(event) --5 
			tick = tick + 1 
			data.printAll("on_nth_tick: 5 secounds") 
			data.printAll("game.tick: "..game.tick) 
			data.printAll("game.tick % 1500 "..tick.." "..game.tick%1500) 5
			data.printAll("game.tick % 1000 "..tick.." "..game.tick%1000) 10
			data.printAll("game.tick % 2000 "..tick.." "..game.tick%2000) 20
			data.printAll("game.tick % 3500 "..tick.." "..game.tick%3500) 30
			
			
end)]]


--[[function vectorDelta (p1, p2)
	local vec = {
		['a'] = {x = p1.x, y = p1.y}
		['b'] = {x = p2.x, y = p2.y}
	}
	return {x = a.x - b.x, y = a.y - b.y}
end

function radio (vector, radio)
	local v = vector or nil and log("function radio in control.lua is nil")
	return {x = vector.x, y = vector.y}
end]]




