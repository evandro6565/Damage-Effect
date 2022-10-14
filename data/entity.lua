-- <<<<<<temp>>>>>>

entity = {}
fire = {}

entity.damage_effect = function(p)
	local x, y = p.position.x, p.position.y
	local tag = p.tag
	local e = p.entity--global.entities[tag]
	local surface = p.surface or e.surface
	--local particle_count = p.particle_count

	local is_active = p.effect_except
	
	function more(n, m)
		if n < 0 then return n-m end
		if n > 0 then return n+m end
	end
	function less(n, m)
		if n < 0 then return n+m end
		if n > 0 then return n-m end
	end
	
	selection_box = {{-2.5, -2.5}, {2.5, 2.5}}
	
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
	
	local shift = function(n, toggle_value, eq, random)
		if eq == 0 then n = n - toggle_value[random] end
		if eq == 1 then n = n + toggle_value[random] end
		return n
	end
	local toggle = {0.02, 0.03, 0.00, 0.09}
	local toggle_l = 4
	
	local movement_toggle = {
		['north'] = {
			{0.00, shift(0.06, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 )}, --- {x, random}
			{0.02, shift(0.06, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 )}, 
			{-0.02, shift(0.06, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 )}
		},
		['northeast'] = {
			{-0.07, shift(0.06, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 )}, --- {x, random}
			{-0.05, shift(0.06, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 )}, 
			{-0.04, shift(0.06, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 )}
		},
		['east'] = {
			{shift(-0.05, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 ), 0.00}, --- {random, x}
			{shift(-0.05, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 ), -0.02},
			{shift(-0.05, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 ), 0.02}
		},
		['southeast'] = {
			{-0.07, shift(-0.06, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 )}, --- {x, random}
			{-0.05, shift(-0.06, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 )},
			{-0.04, shift(-0.06, toggle, math.floor(math.random()*1), math.floor(math.random()*toggle_l)+1 )}
		},
		['south'] =     {{0.00, -0.06}, {0.02, -0.06}, {-0.02, -0.06}},
		['southwest'] = {{0.07, -0.06}, {0.05, -0.06}, {0.04, -0.06}},
		['west'] =      {{0.05, -0.02}, {0.05, 0.00}, {0.05, 0.02}},
		['northwest'] = {{0.07, 0.06}, {0.05, 0.06}, {0.04, 0.06}}
	}
	local mv_t_length = 3

	local movement = {
		['north'] =     {{0.00, 0.06}, {0.02, 0.06}, {-0.02, 0.06}},
		['northeast'] = {{-0.07, 0.06}, {-0.05, 0.06}, {-0.04, 0.06}},
		['east'] =      {{-0.05, 0.00},{-0.05, -0.02},{-0.05, 0.02}},
		['southeast'] = {{-0.07, -0.06}, {-0.05, -0.06}, {-0.04, -0.06}},
		['south'] =     {{0.00, -0.06}, {0.02, -0.06}, {-0.02, -0.06}},
		['southwest'] = {{0.07, -0.06}, {0.05, -0.06}, {0.04, -0.06}},
		['west'] =      {{0.05, -0.02}, {0.05, 0.00}, {0.05, 0.02}},
		['northwest'] = {{0.07, 0.06}, {0.05, 0.06}, {0.04, 0.06}}
	}
	local mv_length = 3

	--[[if p.direction == defines.direction.north     then direction = "north" end
	if p.direction == defines.direction.northeast then direction = "northeast" end
	if p.direction == defines.direction.east      then direction = "east" end
	if p.direction == defines.direction.southeast then direction = "southeast" end
	if p.direction == defines.direction.south     then direction = "south" end
	if p.direction == defines.direction.southwest then direction = "southwest" end
	if p.direction == defines.direction.west      then direction = "west" end
	if p.direction == defines.direction.northwest then direction = "northwest" end]]
	
	local direction = {
		"north",
		"northeast",
		"east",
		"southeast",
		"south",
		"southwest",
		"west",
		"northwest",
	}
	local di_lenght = 8
	
	--[[particle_position = {
		['gun-turret'] = {x, y},
		['flamethrower-turret'] = {x, y},
		['artillery-turret'] = {more(x, 0.5), y},
		['laser-turret'] = {x, y}
	}]]
	
	local l_particle = {
		"damaged-assembling-machine-mechanical-component-particle-medium",
		"damaged-assembling-machine-long-metal-particle-medium",
		"repaired-assembling-machine-metal-particle-big",
		"repaired-assembling-machine-long-metal-particle-medium"
	}
	local l_particle_length = 4

	c_particle = {
		"assembling-machine-1-metal-particle-medium",
		"assembling-machine-1-metal-particle-big",
		"assembling-machine-2-metal-particle-medium",
		"assembling-machine-2-metal-particle-big",
		"assembling-machine-3-metal-particle-medium",
		"assembling-machine-3-metal-particle-big",
	}
	c_particle_length = 6

	vertical_speed_s = {0.08, 0.06, 0.01, 0.03}
	vertical_speed = {0.1, 0.08, 0.01, 0.2}
	height_s = {0.6, 0.4}
	height = {1, 0.6}
	
	--- >>> params effect{
		--- tag, 
		--- compare_tick?,
		--- random_compare_tick{ tike_list(table) }?,
		--- position?,
		--- effect = {
		---	[	type(particle), particle_name, height?, movement?, vertical_speed?, direction?, position?]
		--- 	[	type(fire), fire_name, position?	], 
		---	[	type(smoke), smoke_name, position?	],
		--- }
	 --- }
	
	if p.state == CONST.DAMAGE.define.low then  --- DAMAGE LOW
	
		g_name = c_particle[math.floor(math.random()*c_particle_length)+1]
		g_movement = movement_toggle[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_t_length)+1 ]
		g_height = height_s[ math.floor(math.random()*2)+1 ]
		g_vertical_speed = vertical_speed_s[math.floor(math.random()*4)+1]
		
		if p.size <= 1 then -- >> small <<
			if is_active["smoke"] then
				effect{
					entity = e, random_compare_tick = {70, 100}, id = 1,
					effect = { type = "smoke", smoke_name = "soft-fire-smoke", position=p.position }
				}
			end

			if is_active["particle"] then
				effect{
					entity = e, compare_tick = 2800, id = 2,
					effect = { type = "particle", particle_name=g_name, height=g_height, movement=g_movement, vertical_speed=g_vertical_speed, position=p.position}
				}
			end
			e.effects_counter = 2
		end
		if p.size == CONST.dimension.medium then -- >> medium <<
			if is_active["smoke"] then
				effect{ entity = e, random_compare_tick = {50, 70}, id = 1, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-0.5, y-0.5} } }
				effect{ entity = e, random_compare_tick = {60, 70}, id = 2, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x+0.5, y+0.5} } }
			end

			if is_active["particle"] then
				effect{
					entity = e, random_compare_tick = {2700, 1600}, id = 3,
					effect = { type = "particle", particle_name=g_name, height=g_height, movement=g_movement, vertical_speed=g_vertical_speed, position={x-0.5, y-0.5} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 4,
					effect = { type = "particle", particle_name=g_name, height=g_height, movement=g_movement, vertical_speed=g_vertical_speed, position={x+0.5, y+0.5} }
				}
			end
			e.effects_counter = 4
		end
		if p.size == CONST.dimension.big then -- >> big <<
			g_b_name = c_particle[math.floor(math.random()*c_particle_length)+1]
			g_b_movement = movement[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_length)+1 ]
			g_b_height = height_s[ math.floor(math.random()*2)+1 ]
			g_b_vertical_speed = vertical_speed[math.floor(math.random()*4)+1]
			
			g_b_pos = {0.8, 0.6, -0.8, -0.6}
			
			if is_active["smoke"] then
				effect{ entity = e, random_compare_tick = {20, 70}, id = 1, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-tabRandom(g_b_pos), y-tabRandom(g_b_pos)} } }
				effect{ entity = e, random_compare_tick = {2, 7}, id = 2, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position=random_position{p={x,y},radius=0.8}} }--{x+0.8, y+0.8} } }
				effect{ entity = e, random_compare_tick = {200, 700}, id = 3, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x+0.8, y-0.8} } }
				effect{ entity = e, random_compare_tick = {2, 7}, id = 4, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-0.8, y+0.8} } }
				effect{ entity = e, random_compare_tick = {2, 7}, id = 5, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-1.5, y+1.5} } }
			end

			if is_active["particle"] then
				effect{
					entity = e, random_compare_tick = {1900, 3200}, id = 6,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x+0.8, y+0.8} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 2200}, id = 7,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-0.8, y+0.8} }
				}
				effect{
					entity = e, random_compare_tick = {2700, 2200}, id = 8,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x+0.8, y-0.8} }
				}
			end
			e.effects_counter = 8
		end
		if p.size == CONST.dimension.very_big then -- >> very big <<
			g_b_name = c_particle[math.floor(math.random()*c_particle_length)+1]
			g_b_movement = movement[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_length)+1 ]
			g_b_height = height_s[ math.floor(math.random()*2)+1 ]
			g_b_vertical_speed = vertical_speed[math.floor(math.random()*4)+1]
			
			g_b_pos = {0.8, 0.6, -0.8, -0.6}

			if is_active["smoke"] then -- < effect except
				effect{ entity = e, random_compare_tick = {2, 70}, id = 1, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-tabRandom(g_b_pos), y-tabRandom(g_b_pos)} } }
				effect{ entity = e, random_compare_tick = {2, 7}, id = 2, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position=random_position{p={x,y},radius=0.8}} }--{x+0.8, y+0.8} } }
				effect{ entity = e, random_compare_tick = {20, 7}, id = 3, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x+0.8, y-0.8} } }
				effect{ entity = e, random_compare_tick = {2, 7}, id = 4, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-0.8, y+0.8} } }
			end

			if is_active["particle"] then -- < effect except
				effect{
					entity = e, random_compare_tick = {2700, 1200}, id = 5,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-0.8, y-0.8} }
				}
				effect{
					entity = e, random_compare_tick = {1900, 3200}, id = 6,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x+0.8, y+0.8} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 2200}, id = 7,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-0.8, y+0.8} }
				}
				effect{
					entity = e, random_compare_tick = {2700, 2200}, id = 8,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x+0.8, y-0.8} }
				}
			end
			e.effects_counter = 8
		end
	end
	
	if p.state == CONST.DAMAGE.define.medium then   --- DAMAGE MEDIUM
		g_name = c_particle[math.floor(math.random()*c_particle_length)+1]
		g_movement = movement_toggle[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_t_length)+1 ]
		g_height = height_s[ math.floor(math.random()*2)+1 ]
		g_vertical_speed = vertical_speed_s[math.floor(math.random()*4)+1]
		
		if p.size <= 1 then -- >> small <<
			if is_active["smoke"] then
				effect{ entity = e, random_compare_tick = {2, 7}, id = 1, effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position=p.position } }
			end

			if is_active["particle"] then
				effect{
					entity = e, compare_tick = 1800, id = 2,
					effect = { type = "particle", particle_name=g_name, height=g_height, movement=g_movement, vertical_speed=g_vertical_speed, position=p.position}
				}
			end
			e.effects_counter = 2 
		end
		if p.size == CONST.dimension.medium then -- >> medium <<
			g_name = c_particle[math.floor(math.random()*c_particle_length)+1]
			g_movement = movement_toggle[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_t_length)+1 ]
			g_height = height_s[ math.floor(math.random()*2)+1 ]
			g_vertical_speed = vertical_speed_s[math.floor(math.random()*4)+1]
			
			if is_active["smoke"] then
				effect{ entity = e, random_compare_tick = {2, 7}, id = 1, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-0.5, y-0.5} } }
				effect{ entity = e, random_compare_tick = {2, 7}, id = 2, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x+0.5, y+0.5} } }
			end

			if is_active["particle"] then
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 3,
					effect = { type = "particle", particle_name=g_name, height=g_height, movement=g_movement, vertical_speed=g_vertical_speed, position={x-0.5, y-0.5} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 4,
					effect = { type = "particle", particle_name=g_name, height=g_height, movement=g_movement, vertical_speed=g_vertical_speed, position={x+0.5, y+0.5} }
				}
			end
			e.effects_counter = 4
		end
		if p.size == CONST.dimension.big then -- >> big <<
			g_b_name = c_particle[math.floor(math.random()*c_particle_length)+1]
			g_b_movement = movement[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_length)+1 ]
			g_b_height = height_s[ math.floor(math.random()*2)+1 ]
			g_b_vertical_speed = vertical_speed[math.floor(math.random()*4)+1]
			
			g_b_pos = {0.8, 0.6, -0.8, -0.6}
			
			if is_active["smoke"] then
				effect{ entity = e, random_compare_tick = {20, 70}, id = 1, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-tabRandom(g_b_pos), y-tabRandom(g_b_pos)} } }
				effect{ entity = e, random_compare_tick = {2, 7}, id = 2, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position=random_position{p={x,y},radius=0.8}} }--{x+0.8, y+0.8} } }
				effect{ entity = e, random_compare_tick = {2, 7}, id = 3, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x+0.8, y-0.8} } }
				effect{ entity = e, random_compare_tick = {2, 7}, id = 4, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-0.8, y+0.8} } }
			end

			if is_active["particle"] then
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 5,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-0.8, y-0.8} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 6,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x+0.8, y+0.8} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 7,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-0.8, y+0.8} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 8,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x+0.8, y-0.8} }
				}
			end
			e.effects_counter = 8
		end
		if p.size == CONST.dimension.very_big then -- >> very big <<
			g_b_name = c_particle[math.floor(math.random()*c_particle_length)+1]
			g_b_movement = movement[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_length)+1 ]
			g_b_height = height_s[ math.floor(math.random()*2)+1 ]
			g_b_vertical_speed = vertical_speed[math.floor(math.random()*4)+1]
			
			g_b_pos = {0.8, 0.6, -0.8, -0.6, -1, -1, 1, 1, 2}
			g_b_pos_length = 9
			
			effect{ entity = e, random_compare_tick = {20, 10}, id = 1, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-tabRandom(g_b_pos, g_b_pos_length), y-tabRandom(g_b_pos, g_b_pos_length)} } }
			effect{ entity = e, random_compare_tick = {2, 7}, id = 2, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position=random_position{p={x,y},radius=0.8}} }--{x+0.8, y+0.8} } }
			effect{ entity = e, random_compare_tick = {2, 7}, id = 3, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x+0.8, y-1} } }
			effect{ entity = e, random_compare_tick = {2, 7}, id = 4, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-1, y+0.8} } }
			effect{ entity = e, random_compare_tick = {2, 7}, id = 5, effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x-1, y+1} } }
			effect{
				entity = e, random_compare_tick = {1700, 1200}, id = 6,
				effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-tabRandom(g_b_pos, g_b_pos_length), y-tabRandom(g_b_pos, g_b_pos_length)} }
			}
			effect{
				entity = e, random_compare_tick = {1700, 1200}, id = 7,
				effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-tabRandom(g_b_pos, g_b_pos_length), y-tabRandom(g_b_pos, g_b_pos_length)} }
			}
			effect{
				entity = e, random_compare_tick = {1700, 1200}, id = 8,
				effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-tabRandom(g_b_pos, g_b_pos_length), y-tabRandom(g_b_pos, g_b_pos_length)} }
			}
			effect{
				entity = e, random_compare_tick = {1700, 1200}, id = 9,
				effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-tabRandom(g_b_pos, g_b_pos_length), y-tabRandom(g_b_pos, g_b_pos_length)} }
			}
			effect{
				entity = e, random_compare_tick = {1700, 1200}, 10,
				effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-tabRandom(g_b_pos, g_b_pos_length), y-tabRandom(g_b_pos, g_b_pos_length)}}
			}
			e.effects_counter = 10
		end
	end
	
	if p.state == CONST.DAMAGE.define.high then  --- DAMAGE HIGH
		g_name = c_particle[math.floor(math.random()*c_particle_length)+1]
		g_movement = movement_toggle[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_t_length)+1 ]
		g_height = height_s[ math.floor(math.random()*2)+1 ]
		g_vertical_speed = vertical_speed_s[math.floor(math.random()*4)+1]
		
		g_b_pos = {0.5, 0.2, -0.5, -0.2}
		g_b_pos_length = 4

		if p.size <= 1 then -- >> small <<
			if is_active["smoke"] then
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 1,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position=p.position }
				}
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 2,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position=p.position }
				}
			end
			if is_active["fire"] then
				effect{ entity = e, random_compare_tick = {2800, 2200}, id = 3, 
				effect = { type = "fire", fire_name = "fire-on", position={x-tabRandom(g_b_pos, g_b_pos_length), y-tabRandom(g_b_pos, g_b_pos_length)} } }
				--effect{ entity = e, random_compare_tick = {2700, 2800}, id = 2, effect = { type = "fire", fire_name = "fire-on", position=random_position{p={x,y},radius=0.2}} }
			end
			if is_active["particle"] then
				effect{
					entity = e, compare_tick = 1800, id = 4,
					effect = { type = "particle", particle_name=g_name, height=g_height, movement=g_movement, vertical_speed=g_vertical_speed, position=p.position}
				}
			end
			e.effects_counter = 4
		end
		if p.size == CONST.dimension.medium then -- >> medium <<
			if is_active["fire"] then
				effect{ entity = e, random_compare_tick = {2800, 2200}, id = 1, 
				effect = { type = "fire", fire_name = "fire-on", position={x-tabRandom(g_b_pos, g_b_pos_length), y-tabRandom(g_b_pos, g_b_pos_length)} } }
				--effect{ entity = e, random_compare_tick = {2700, 2800}, id = 2, effect = { type = "fire", fire_name = "fire-on", position=random_position{p={x,y},radius=0.2}} }
			end
			if is_active["smoke"] then
				effect{
					entity = e, compare_tick = 30--[[random_compare_tick = {2, 7}]], id = 2,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position={x-0.5, y-0.5} } 
				}
				effect{
					entity = e, compare_tick = 30--[[random_compare_tick = {2, 7}]], id = 3,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position={x+0.5, y+0.5} } 
				}
			end
			if is_active["particle"] then
				effect{
					entity = e, compare_tick = 2500--[[random_compare_tick = {2700, 2200}]], id = 4,
					effect = { type = "particle", particle_name=g_name, height=g_height, movement=g_movement, vertical_speed=g_vertical_speed, position={x-0.5, y-0.5} }
				}
				effect{
					entity = e, random_compare_tick = {2700, 2700}, id = 5,
					effect = { type = "particle", particle_name=g_name, height=g_height, movement=g_movement, vertical_speed=g_vertical_speed, position={x+0.5, y+0.5} }
				}
			end
			e.effects_counter = 5
		end
		if p.size == CONST.dimension.big then -- >> big <<
			g_b_name = c_particle[math.floor(math.random()*c_particle_length)+1]
			g_b_movement = movement_toggle[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_t_length)+1 ]
			g_b_height = height_s[ math.floor(math.random()*2)+1 ]
			g_b_vertical_speed = vertical_speed[math.floor(math.random()*4)+1]
			
			g_b_pos = {0.8, 1, -0.8, -1}
			g_b_pos_length = 4
			
			if is_active["fire"] then
				effect{ entity = e, random_compare_tick = {2800, 2200}, id = 1, 
					effect = { type = "fire", fire_name = "fire-on", position={x-tabRandom(g_b_pos, g_b_pos_length), y-tabRandom(g_b_pos, g_b_pos_length)} } 
				}
				effect{ entity = e, random_compare_tick = {2700, 2800}, id = 2, 
					effect = { type = "fire", fire_name = "fire-on", position=random_position{p={x,y},radius=1} }--{x+0.8, y+0.8} } 
				}
				effect{ entity = e, random_compare_tick = {2500, 2700}, id = 3, 
					effect = { type = "fire", fire_name = "fire-on", position=random_position{p={x,y},radius=1} }--{x+1, y-1} } 
				}
				effect{ entity = e, random_compare_tick = {2600, 2700}, id = 4, 
					effect = { type = "fire", fire_name = "fire-on", position=random_position{p={x,y},radius=1} } --{x-1, y+1} } 
				}
			end
			if is_active["smoke"] then
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 5,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position={x-0.8, y-0.8} } 
				}
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 6,
					effect = { type = "smoke", smoke_name = "soft-fire-smoke", position={x+0.8, y+0.8} } 
				}
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 7,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position={x-0.8, y+0.8} } 
				}
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 8,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position={x+0.8, y-0.8} } 
				}
			end
			if is_active["particle"] then
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 9,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-0.8, y-0.8} }
				}
				effect{
					entity = e, random_compare_tick = {700, 1200}, id = 10,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x+0.8, y+0.8} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 11,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-0.8, y+0.8} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 12,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x+0.8, y-0.8} }
				}
			end
			e.effects_counter = 12
		end
		if p.size == CONST.dimension.very_big then -- >> very big <<
			g_b_name = c_particle[math.floor(math.random()*c_particle_length)+1]
			g_b_movement = movement[ direction[math.floor(math.random()*di_lenght)+1] ][ math.floor(math.random()*mv_length)+1 ]
			g_b_height = height_s[ math.floor(math.random()*2)+1 ]
			g_b_vertical_speed = vertical_speed[math.floor(math.random()*4)+1]
			
			g_b_pos = {0.8, 1, -0.8, -1}
			
			if is_active["fire"] then
				effect{ entity = e, random_compare_tick = {2800, 2200}, id = 1, 
					effect = { type = "fire", fire_name = "fire-on", position = {x-tabRandom(g_b_pos), y-tabRandom(g_b_pos)} } 
				}
				effect{ entity = e, random_compare_tick = {2700, 2800}, id = 2, 
					effect = { type = "fire", fire_name = "fire-on", position = random_position{p={x,y},radius=1} } --{x+0.8, y+0.8}
				}
				effect{ entity = e, random_compare_tick = {2500, 2700}, id = 3, 
					effect = { type = "fire", fire_name = "fire-on", position=random_position{p={x,y},radius=1} } --{x+1, y-1}
				}
				effect{ entity = e, random_compare_tick = {2600, 2700}, id = 4, 
					effect = { type = "fire", fire_name = "fire-on", position=random_position{p={x,y},radius=1} } --{x-1, y+1}
				}
			end
			if is_active["smoke"] then
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 5,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position={x-0.8, y-0.8} } 
				}
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 6,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position={x+0.8, y+0.8} } 
				}
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 7,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position={x-0.8, y+0.8} } 
				}
				effect{
					entity = e, compare_tick = 25--[[random_compare_tick = {2, 7}]], id = 8,
					effect = { type = "smoke", smoke_name = "d-soft-fire-smoke", position={x+0.8, y-0.8} } 
				}
			end
			if is_active["particle"] then
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 9,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-tabRandom(g_b_pos), y-tabRandom(g_b_pos)} }
				}
				effect{
					entity = e, random_compare_tick = {700, 1200}, id = 10,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-tabRandom(g_b_pos), y-tabRandom(g_b_pos)} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 11,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-tabRandom(g_b_pos), y-tabRandom(g_b_pos)} }
				}
				effect{
					entity = e, random_compare_tick = {1700, 1200}, id = 12,
					effect = { type = "particle", particle_name = g_b_name, height=g_b_height, movement=g_b_movement, vertical_speed=g_b_vertical_speed, position={x-tabRandom(g_b_pos), y-tabRandom(g_b_pos)} }
				}
			end
			e.effects_counter = 12
		end
	end
	--surface.create_trivial_smoke{name="soft-fire-smoke", position = position[direction]}
	--surface.create_trivial_smoke{name="fire-smoke-on-adding-fuel", position = position}
	--global.entities[tag] = e -- add
end 

 --- >>> params 
 --- tag, 
 --- id,
 --- compare_tick?,
 --- random_compare_tick{ tike_list(table) }?,
 --- position?,
 --- mult? ( > 1),
 --- effect = {
 ---	[	type(particle), particle_name, height?, movement?, vertical_speed?, direction?, position?	]
 --- 	[	type(fire), fire_name, position?	], 
 ---	[	type(smoke), smoke_name, position?	],
 --- }
effect = function(opts) --- <<< params
	--local tag = opts.tag
	local e = opts.entity--global.entities[tag]
	local position = opts.position or opts.effect.position or e.position
	local surface = e.surface
	local id  = opts.id or 1

	local fire_name = opts.effect.fire_name 
	local smoke_name = opts.effect.smoke_name

	-- particle
	local particle_name = opts.effect.particle_name
	local height = opts.effect.height or 1
	local movement = opts.effect.movement
	local vertical_speed = opts.effect.vertical_speed or 0.1
	--local direction = opts.effect.direction or {"north","northeast","east","southeast","south","southwest","west","northwest"}
	local frame_speed = 0.1
	-- particle

	local random_compare_tick = opts.random_compare_tick or nil --{60, 200, 1, 150}

	if not global.compare_tick[e.id] then global.compare_tick[e.id] = {} end 
	
	local function set_time() if random_compare_tick then global.compare_tick[e.id][id] = random_compare_tick[math.floor(math.random()*#random_compare_tick+1)] end end
	
	if opts.random_compare_tick and not global.compare_tick[e.id][id] then global.compare_tick[e.id][id] = random_compare_tick[math.floor(math.random()*#random_compare_tick+1)] end
	
	if opts.compare_tick then global.compare_tick[e.id][id] = opts.compare_tick end
	


	
	if opts.effect.type == "fire" then --- <<< fire
		if not fire_name then log("fire_name is nil") return end  

		if (not e.effects.fires[e.id][id] or not e.effects.fires[e.id][id].valid) and game.tick % global.compare_tick[e.id][id] == 0 then
			if --[[stop_fire(e.entity.status) or]] ( not e.effects.fires[e.id][id] or not e.effects.fires[e.id][id].valid ) then
				e.effects.fires[e.id][id] = surface.create_entity{name = fire_name, position = position} 
			end
			set_time()
		end 
	end	--- <<< fire
	
	if opts.effect.type == "particle" then --- <<< particle
		if not particle_name then log("particle_name is nil") return end 

		if game.tick % global.compare_tick[e.id][id] == 0 then --- <<< time begin

			p_movement = movement or {0.00, 0.06} --no_nil(movement, _d_, math.floor(math.random()*table_length(movement,1))+1) or movement or {0.00, 0.06}
			p_height = height --no_nil(height, math.floor(math.random()*table_length(height,1))+1) or height
			p_vertical_speed = vertical_speed --no_nil(vertical_speed, math.floor(math.random()*table_length(vertical_speed,1))+1) or vertical_speed
			
			surface.create_particle{
				name = particle_name,--p_name, 
				movement = p_movement,
				height = p_height,
				vertical_speed = p_vertical_speed,
				frame_speed = frame_speed, 
				position = position
			}
			
			set_time()
		end  --- <<< time end
	end --- <<< particle
	
	if opts.effect.type == "smoke" then --- <<< smoke
		if not smoke_name then log("smoke_name is nil") return end

		if game.tick % global.compare_tick[e.id][id] == 0 then --- <<< time begin
			surface.create_trivial_smoke{name = smoke_name, position = position}
			set_time()
		end --- <<< time end
	end --- <<< smoke
	
	--global.entities[tag] = e
end 

function dimension(size_selection_box)
 local right_bottom = size_selection_box.right_bottom
	
	--print('right_bottom x: '..right_bottom.x.. ' y: '..right_bottom.y)
	if (right_bottom.x >= 3 or right_bottom.x <= 4.5) and (right_bottom.y >= 3 and right_bottom.y <= 4.5) then return CONST.dimension.very_big end
	if (right_bottom.x >= 2 or right_bottom.x <= 2.5) and (right_bottom.y >= 2 and right_bottom.y <= 2.5) then return CONST.dimension.big end
	if (right_bottom.x > 1 or right_bottom.x <= 1.5) and (right_bottom.y > 1 and right_bottom.y <= 1.5) then return CONST.dimension.medium end
	if (right_bottom.x > 0.5 or right_bottom.x <= 1) and (right_bottom.y > 0.5 and right_bottom.y <= 1) then return CONST.dimension.small end
	if (right_bottom.x >= 0.1 or right_bottom.x <= 0.5) and (right_bottom.y >= 0.1 and right_bottom.y <= 0.5) then return CONST.dimension.very_small end
	
	return -1
end

function destroy_time(e) 
	--local e = global.entities[tag]

	if e and (e.effects_counter > 0) then -- << update to space exploration
		--for effect_id, value in pairs(global.compare_tick[e.id]) do
		for i = 1, e.effects_counter do
			table.remove(global.compare_tick[e.id], i)
		end
		--end
	end 
end 

entity.on_tick = function(e) 
	if e.category:find("entity", 1, true) then
		--e = global.entities[tag]
		state = "nil"

		if e.effect.damage_high   then state = "damage_high" end
		if e.effect.damage_medium then state = "damage_medium" end
		if e.effect.damage_low    then state = "damage_low" end
		if not state then log("entity.on_tick: state is nil") end
		--print("state "..state)
		if e.entity.valid and CONST.no_effect(e.entity.name)--[[global.entities[tag].entity.name) and building_complete( e )]] then
			entity.damage_effect{
				position = e.entity.position, 
				surface = e.surface, 
				--direction = e.entity.direction, --turret
				effect_except = CONST.effect_except(e.entity.name),
				size = dimension(e.entity.prototype.selection_box),
				state = state,
				name = e.entity.name,
				particle_count = e.particle_count,
				entity = e
				--tag = e.tag
			}
		end
	end
end


---/c game.player.surface.create_particle{name = "wall-stone-particle-medium", movement = {0.01, -0.03}, height = 0.1, vertical_speed = 0.07, frame_speed = 0.1, position = {15, -4}}