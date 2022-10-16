-- <<<<<<temp>>>>>>


--local data = require '__storage__.util'
--global.deff.effect["gun-turret"] = {}
--local dur = math.floor(math.random()*7)+2
car = {}
local count = 0
if not fire then fire = {} end

local last_fire = nil
---if not global.deff.effect["gun-turret"] then global.deff.effect["gun-turret"] = {} end 

--global.deff.effect["gun-turret"].create_damage_effect = function(p) -- position, surface, direction, state, particle_count
car.set_update = {fire = nil, target = nil}

car.damage_effect = function(p)
	local surface = p.surface
	local x, y = p.position.x, p.position.y
	local tag = p.tag
	local e = p.entity--global.entities[tag]
	--local particle_count = p.particle_count
	
	function more(n, m)
		if n < 0 then return n-m end
		if n > 0 then return n+m end
	end
	function less(n, m)
		if n < 0 then return n+m end
		if n > 0 then return n-m end
	end
	
	shift = 0.02
	movement = {
		['north'] =     {{0.00, 0.06-shift}, {0.02, 0.06-shift}, {-0.02, 0.06-shift}},
		['northeast'] = {{-0.07, 0.06-shift}, {-0.05, 0.06-shift}, {-0.04, 0.06-shift}},
		['east'] =      {{-0.05-shift, 0.00},{-0.05-shift, -0.02},{-0.05-shift, 0.02}},
		['southeast'] = {{-0.07, -0.06-shift}, {-0.05, -0.06-shift}, {-0.04, -0.06-shift}},
		['south'] =     {{0.00, -0.06-shift}, {0.02, -0.06-shift}, {-0.02, -0.06-shift}},
		['southwest'] = {{0.07, -0.06-shift}, {0.05, -0.06-shift}, {0.04, -0.06-shift}},
		['west'] =      {{0.05-shift, -0.02}, {0.05-shift, 0.00}, {0.05-shift, 0.02}},
		['northwest'] = {{0.07, 0.06-shift}, {0.05, 0.06-shift}, {0.04, 0.06-shift}}
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
	
	direction_f = {
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
		"damaged-assembling-machine-mechanical-component-particle-medium",
		"damaged-assembling-machine-long-metal-particle-medium",
		"repaired-assembling-machine-metal-particle-big",
		"tank-metal-particle-small",
		"repaired-assembling-machine-long-metal-particle-medium",
		"tank-metal-particle-medium"
	}
	
	c_particle = {
		"tank-metal-particle-small",
		"assembling-machine-1-metal-particle-big",
		"tank-metal-particle-medium",
		"tank-metal-particle-small",
		"assembling-machine-3-metal-particle-medium",
		"assembling-machine-3-metal-particle-big",
	}
	
	vertical_speed = {0.12, 0.07, 0.1, 0.09}
	height = {0.3, 0.6}
	timer = 10
	timer_set = {60, 200, 1, 150}
	
	if p.state == CONST.DAMAGE.define.low then  --- DAMAGE LOW
		if game.tick % timer == 0 then
			surface.create_trivial_smoke{name="soft-fire-smoke", position = p.position}
			timer = timer_set[math.floor(math.random()*4)+1]
		end
	end
	
	if p.state == CONST.DAMAGE.define.medium then  --- DAMAGE MEDIUM
		if game.tick % 800 == 0 and count <= e.particle_count then 
			surface.create_particle{
				name = c_particle[math.floor(math.random()*6)+1], 
				movement = movement[direction_f[math.floor(math.random()*8)+1]][math.floor(math.random()*3)+1],
				height = height[math.floor(math.random()*2)+1],
				vertical_speed = vertical_speed[math.floor(math.random()*4)+1],
				frame_speed = 0.1, 
				position = p.position
			}
			count = count + 1
		end
		if game.tick % 5 == 0 then
			surface.create_trivial_smoke{name="d-soft-fire-smoke", position = p.position}
		end
		
		if game.tick % 200 == 0 then count = 0 end
	end
	
	if p.state == CONST.DAMAGE.define.high then  --- DAMAGE HIGH
		if game.tick % 200 == 0 and count <= e.particle_count then 
			surface.create_particle{
				name = l_particle[math.floor(math.random()*6)+1], 
				movement = movement[direction_f[math.floor(math.random()*8)+1]][math.floor(math.random()*3)+1],
				height = height[math.floor(math.random()*2)+1],
				vertical_speed = vertical_speed[math.floor(math.random()*4)+1],
				frame_speed = 0.1, 
				position = p.position
			}
			count = count + 1
		end
		--if not fire[tag] then fire[tag] = {} end
		
		--if e.car_fire_effect.fires[tag] and not e.car_fire_effect.fires[tag].valid then e.car_fire_effect.run = true end

		if (e.car_fire_effect.fires[tag] and not e.car_fire_effect.fires[tag].valid) and (game.tick % 1200 == 0) or e.car_fire_effect.run then--and not fire[tag].prototype and not fire[tag].prototype.valid then 
			e.car_fire_effect.fires[tag] = surface.create_entity{name = "fire-on-car", position = {p.position.x, p.position.y-0.5}} 
			e.car_fire_effect.run = false
			--global.entities[tag].last_position_fire = fire[tag].prototype.position --- add position
		end
		
		--e.fire_effect_prototype = fire[tag].prototype.position
		--fire[tag].last_position = fire[tag].prototype.position
		--global.entities[tag].last_position_fire = fire[tag].prototype.position
		
		if p.is_moving and e.car_fire_effect.fires[tag] and e.car_fire_effect.fires[tag].valid and game.tick % 5 == 0 then e.car_fire_effect.fires[tag].teleport({p.position.x, p.position.y-0.2}) end
		--[[	car.set_update = {fire = e.car_fire_effect.fires[tag], target = e} 
		else
			car.set_update = {fire = nil, target = nil}
		end]]
		
		if game.tick % 200 == 0 then count = 0 end
		--[[if game.tick % 30 == 0 then
			surface.create_trivial_smoke{name="soft-fire-smoke", position = position[direction]}
		end]]
	end
end 


---/c game.player.surface.create_particle{name = "wall-stone-particle-medium", movement = {0.01, -0.03}, height = 0.1, vertical_speed = 0.07, frame_speed = 0.1, position = {15, -4}}

car.update_fire_position = function( parameters )
	delay = parameters.delay or 10
	local position = nil
	if game.tick % delay == 0 then
		if car.set_update.target and car.set_update.target.entity.valid then position = car.set_update.target.entity.position end
		if car.set_update.fire and car.set_update.fire.valid then car.set_update.fire.telepot({position.x, position.y-0.2}) end
	end
end

function car_explosion(ent)
	if ent.fx_run_effect then
		if ent.entity.type == "car" then
			ent.surface.create_entity{name = ent.entity.name.."-explosion", position = ent.entity.position} ent.fx_run_effect = false
		end
	end
end
function car_explosion_death(e)
	local tickr = {380, 500}
	if e and e.name:find("tank", 1, true) and not e.entity.valid and e.fx.count <= 2 and (game.tick % tickr[random(2)] == 0) then
		p = { {e.position.x+0.5, e.position.y-0.5}, {e.position.x-0.5, e.position.y+0.5} }
		e.surface.create_entity{name = e.name.."-explosion", position = p[random(2)]}
		e.fx.count = e.fx.count + 1
	elseif e.name:find("tank", 1, true) and e.fx.count >= 2 then
		e.destroy = true
	end
end

function moving_sen(speed) if speed ~= 0 then return true else return false end end 

car.on_tick = function(e) 
	if e.category:find("car", 1 ,true) then
		--e = global.entities[tag]
		state = "nil"
		if e.effect.damage_high   then state = "damage_high" end
		if e.effect.damage_medium then state = "damage_medium" end
		if e.effect.damage_low    then state = "damage_low" end
		
		if e.entity.valid --[[and building_complete( e )]] then
			car.damage_effect{
				position = e.entity.position, 
				surface = e.surface, 
				direction = e.entity.direction, 
				state = state,
				name = e.entity.name,
				entity = e,
				is_moving = moving_sen(e.entity.speed),
				--particle_count = e.particle_count,
				tag = tag
			}
		end
		--elseif fire[tag] and fire[tag].valid and (state == "good" or state == "nil") then fire[tag].destroy() end
	end
end


