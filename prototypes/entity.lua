local function make_4way_animation_from_spritesheet(animation)
  local function make_animation_layer(idx, anim)
    local start_frame = (anim.frame_count or 1) * idx
    local x = 0
    local y = 0
    if anim.line_length then
      y = anim.height * math.floor(start_frame / (anim.line_length or 1))
    else
      x = idx * anim.width
    end
    return
    {
      filename = anim.filename,
      priority = anim.priority or "high",
      flags = anim.flags,
      x = x,
      y = y,
      width = anim.width,
      height = anim.height,
      frame_count = anim.frame_count or 1,
      line_length = anim.line_length,
      repeat_count = anim.repeat_count,
      shift = anim.shift,
      draw_as_shadow = anim.draw_as_shadow,
      force_hr_shadow = anim.force_hr_shadow,
      apply_runtime_tint = anim.apply_runtime_tint,
      animation_speed = anim.animation_speed,
      scale = anim.scale or 1,
      tint = anim.tint,
      blend_mode = anim.blend_mode
    }
  end

  local function make_animation_layer_with_hr_version(idx, anim)
    local anim_parameters = make_animation_layer(idx, anim)
    if anim.hr_version and anim.hr_version.filename then
      anim_parameters.hr_version = make_animation_layer(idx, anim.hr_version)
    end
    return anim_parameters
  end

  local function make_animation(idx)
    if animation.layers then
      local tab = { layers = {} }
      for k,v in ipairs(animation.layers) do
        table.insert(tab.layers, make_animation_layer_with_hr_version(idx, v))
      end
      return tab
    else
      return make_animation_layer_with_hr_version(idx, animation)
    end
  end

  return
  {
    north = make_animation(0),
    east = make_animation(1),
    south = make_animation(2),
    west = make_animation(3)
  }
end

local function rep_recipe( name )
	local recipe = util.table.deepcopy(data.raw.recipe[name])
	recipe.name = name.."-damaged"
	if recipe.normal then 
		recipe.normal.ingredients = {{name, 1}}
		recipe.normal.result = name.."-damaged"

		recipe.expensive.ingredients = {{name, 2}}
		recipe.expensive.result = name.."-damaged"
		recipe.expensive.result_count = 2
	else
		recipe.ingredients = {{name, 1}}
		recipe.result = name.."-damaged"
	end
	recipe.enabled = false
	data:extend({recipe})
end
local function rep_item( name )
	local item = util.table.deepcopy(data.raw.item[name])
	item.name = name.."-damaged"
	item.order = item.order:gsub("b["..name.."]", "b["..name.."-damaged".."]")
	item.place_result = name.."-damaged"
	data:extend({item})
end

require (CONST.mod_name.."/graphics/combinator/combinator-pictures")

-------- [ gun-turret ]

entity = {}
entity = util.table.deepcopy(data.raw["ammo-turret"]["gun-turret"]) -- <<  [ gun-turret ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = "gun-turret-damaged"
entity.minable.result = entity.name
entity.fast_replaceable_group = "ammo-turret"

entity.base_picture.layers[1].hr_version.filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-base.png"
entity.base_picture.layers[2].hr_version.filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-base-mask.png"


entity.folded_animation.layers[1].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-raising.png"
entity.folded_animation.layers[1].width = 130
entity.folded_animation.layers[1].height = 126
entity.folded_animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-raising.png"

entity.preparing_animation.layers[1].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-raising.png"
entity.preparing_animation.layers[1].width = 130
entity.preparing_animation.layers[1].height = 126
entity.preparing_animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-raising.png"

entity.folding_animation.layers[1].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-raising.png"
entity.folding_animation.layers[1].width = 130
entity.folding_animation.layers[1].height = 126
entity.folding_animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-raising.png"


entity.prepared_animation.layers[1].stripes[1].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-1.png"
entity.prepared_animation.layers[1].stripes[2].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-2.png"
entity.prepared_animation.layers[1].stripes[3].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-3.png"
entity.prepared_animation.layers[1].stripes[4].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-4.png"
entity.prepared_animation.layers[1].width = 132
entity.prepared_animation.layers[1].height = 130
entity.prepared_animation.layers[1].hr_version.stripes[1].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-1.png"
entity.prepared_animation.layers[1].hr_version.stripes[2].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-2.png"
entity.prepared_animation.layers[1].hr_version.stripes[3].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-3.png"
entity.prepared_animation.layers[1].hr_version.stripes[4].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-4.png"

entity.attacking_animation.layers[1].stripes[1].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-1.png"
entity.attacking_animation.layers[1].stripes[2].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-2.png"
entity.attacking_animation.layers[1].stripes[3].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-3.png"
entity.attacking_animation.layers[1].stripes[4].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-4.png"
entity.attacking_animation.layers[1].width = 132
entity.attacking_animation.layers[1].height = 130
entity.attacking_animation.layers[1].hr_version.stripes[1].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-1.png"
entity.attacking_animation.layers[1].hr_version.stripes[2].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-2.png"
entity.attacking_animation.layers[1].hr_version.stripes[3].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-3.png"
entity.attacking_animation.layers[1].hr_version.stripes[4].filename = CONST.mod_name.."/graphics/gun-turret/hr-gun-turret-shooting-4.png"


data:extend({entity})
-------- [ gun-turret ]

-------- [ assembling-machine ]

-------- [ assembling-machine-1 ]
entity = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-1"]) -- <<  [ assembling-machine-1 ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name
entity.animation.layers[1].hr_version = nil
entity.animation.layers[1].filename = CONST.mod_name.."/graphics/assembling-machine-1/hr-assembling-machine-1.png"
entity.animation.layers[1].scale = 0.5
entity.animation.layers[1].width = 214
entity.animation.layers[1].height = 218

data:extend({entity}) --> assembling-machine-1

-------- [ assembling-machine-2 ]
entity = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"]) -- <<  [ assembling-machine-2 ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name
entity.animation.layers[1].hr_version = nil
entity.animation.layers[1].filename = CONST.mod_name.."/graphics/assembling-machine-2/hr-assembling-machine-2.png"
entity.animation.layers[1].scale = 0.5
entity.animation.layers[1].width = 214
entity.animation.layers[1].height = 218

data:extend({entity}) --> assembling-machine-2

-------- [ assembling-machine-3 ]
entity = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"]) -- <<  [ assembling-machine-3 ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name
entity.animation.layers[1].hr_version = nil
entity.animation.layers[1].filename = CONST.mod_name.."/graphics/assembling-machine-3/hr-assembling-machine-3.png"
entity.animation.layers[1].scale = 0.5
entity.animation.layers[1].width = 214
entity.animation.layers[1].height = 218

data:extend({entity}) --> assembling-machine-3

-------- [ centrifuge ]
entity = util.table.deepcopy(data.raw["assembling-machine"]["centrifuge"]) --> [ centrifuge ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name
entity.idle_animation.layers[1].hr_version.filename  = CONST.mod_name.."/graphics/centrifuge/hr-centrifuge-C.png"
entity.idle_animation.layers[3].hr_version.filename  = CONST.mod_name.."/graphics/centrifuge/hr-centrifuge-B.png"
entity.idle_animation.layers[5].hr_version.filename  = CONST.mod_name.."/graphics/centrifuge/hr-centrifuge-A.png"

entity.working_visualisations[2].animation.layers[3].hr_version.filename  = CONST.mod_name.."/graphics/centrifuge/hr-centrifuge-A-light.png"

data:extend({entity}) --> centrifuge

-------- [ oil-refinery ]
entity = util.table.deepcopy(data.raw["assembling-machine"]["oil-refinery"]) --> [ oil-refinery ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"

entity.animation = make_4way_animation_from_spritesheet({
	layers =
	{
		{
			filename = "__base__/graphics/entity/oil-refinery/oil-refinery.png",
			width = 337,
			height = 255,
			frame_count = 1,
			shift = {2.515625, 0.484375},
			hr_version =
			{
				filename = CONST.mod_name.."/graphics/oil-refinery/hr-oil-refinery.png", --- <<
				width = 386,
				height = 430,
				frame_count = 1,
				shift = util.by_pixel(0, -7.5),
				scale = 0.5
			}
		},
		{
			filename = "__base__/graphics/entity/oil-refinery/oil-refinery-shadow.png",
			width = 337,
			height = 213,
			frame_count = 1,
			shift = util.by_pixel(82.5, 26.5),
			draw_as_shadow = true,
			hr_version =
			{
				filename = "__base__/graphics/entity/oil-refinery/hr-oil-refinery-shadow.png",
				width = 674,
				height = 426,
				frame_count = 1,
				shift = util.by_pixel(82.5, 26.5),
				draw_as_shadow = true,
				force_hr_shadow = true,
				scale = 0.5
			}
		}
	}
})

data:extend({entity}) --> oil-refinery

-------- [ chemical-plant ]
entity = util.table.deepcopy(data.raw["assembling-machine"]["chemical-plant"]) --> [ chemical-plant ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged" 

-- entity.animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/chemical-plant/hr-chemical-plant.png"
entity.animation = make_4way_animation_from_spritesheet({ 
	layers =
    {
		{
			filename = "__base__/graphics/entity/chemical-plant/chemical-plant.png",
			width = 108,
			height = 148,
			frame_count = 24,
			line_length = 12,
			shift = util.by_pixel(1, -9),
			hr_version =
			{
				filename = CONST.mod_name.."/graphics/chemical-plant/hr-chemical-plant.png", --- <<
				width = 220,
				height = 292,
				frame_count = 24,
				line_length = 12,
				shift = util.by_pixel(0.5, -9),
				scale = 0.5
			}
		},
		{
			filename = "__base__/graphics/entity/chemical-plant/chemical-plant-shadow.png",
			width = 154,
			height = 112,
			repeat_count = 24,
			frame_count = 1,
			shift = util.by_pixel(28, 6),
			draw_as_shadow = true,
			hr_version =
			{
				filename = "__base__/graphics/entity/chemical-plant/hr-chemical-plant-shadow.png",
				width = 312,
				height = 222,
				repeat_count = 24,
				frame_count = 1,
				shift = util.by_pixel(27, 6),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
    }
})

data:extend({entity}) --> chemical-plant

-------- [ nuclear-reactor ]
entity = util.table.deepcopy(data.raw["reactor"]["nuclear-reactor"]) --> [ nuclear-reactor ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged" 

entity.picture.layers[1].hr_version.filename = CONST.mod_name.."/graphics/nuclear-reactor/hr-reactor.png"
entity.working_light_picture.hr_version.filename = CONST.mod_name.."/graphics/nuclear-reactor/hr-reactor-lights-color.png"

data:extend({entity}) --> nuclear-reactor

-------- [ assembling-machine ]

-------- [ rocket-silo ]
entity = util.table.deepcopy(data.raw["rocket-silo"]["rocket-silo"]) --> [ rocket-silo ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.arm_03_front_animation.hr_version.filename = CONST.mod_name.."/graphics/rocket-silo/hr-13-rocket-silo-arms-front.png"
 
entity.base_day_sprite.hr_version.filename = CONST.mod_name.."/graphics/rocket-silo/hr-06-rocket-silo.png"

entity.base_front_sprite.hr_version.filename = CONST.mod_name.."/graphics/rocket-silo/hr-14-rocket-silo-front.png"

entity.satellite_animation.hr_version.filename = CONST.mod_name.."/graphics/rocket-silo/hr-15-rocket-silo-turbine.png"

entity.red_lights_back_sprites.layers[2] = nil
entity.red_lights_front_sprites.layers[2] = nil

data:extend({entity}) --> rocket-silo 

-------- [ rocket-silo ]

-------- [ container - chest ]
entity = util.table.deepcopy(data.raw["container"]["wooden-chest"]) --> wooden-chest
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.picture.layers[1].hr_version.filename = CONST.mod_name.."/graphics/wooden-chest/hr-wooden-chest.png"

data:extend({entity}) --> wooden-chest

entity = util.table.deepcopy(data.raw["container"]["steel-chest"]) --> steel-chest
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.picture.layers[1].hr_version.filename = CONST.mod_name.."/graphics/steel-chest/hr-steel-chest.png"

data:extend({entity}) --> steel-chest

entity = util.table.deepcopy(data.raw["container"]["iron-chest"]) --> iron-chest
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.picture.layers[1].hr_version.filename = CONST.mod_name.."/graphics/iron-chest/hr-iron-chest.png"

data:extend({entity}) --> iron-chest

-------- [ container - chest ]

-------- [ lab ]
entity = util.table.deepcopy(data.raw["lab"]["lab"]) --> lab
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.off_animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/lab/hr-lab.png"
entity.on_animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/lab/hr-lab.png"

data:extend({entity}) --> lab

-------- [ lab ]

-------- [ beacon ]
entity = util.table.deepcopy(data.raw["beacon"]["beacon"]) --> beacon
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.graphics_set.animation_list[1].animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/beacon/hr-beacon-bottom.png"
entity.graphics_set.animation_list[2].animation.hr_version.filename = CONST.mod_name.."/graphics/beacon/hr-beacon-top.png"

data:extend({entity}) --> beacon

-------- [ beacon ]

-------- [ solar-panel ]
entity = util.table.deepcopy(data.raw["solar-panel"]["solar-panel"]) --> solar-panel
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.picture.layers[1].hr_version.filename  = CONST.mod_name.."/graphics/solar-panel/hr-solar-panel.png"

data:extend({entity}) --> solar-panel

-------- [ solar-panel ]

-------- [ electric-pole ]
entity = util.table.deepcopy(data.raw["electric-pole"]["small-electric-pole"]) --> small-electric-pole
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.pictures.layers[1].hr_version.filename  = CONST.mod_name.."/graphics/small-electric-pole/hr-small-electric-pole.png"

data:extend({entity}) --> small-electric-pole

entity = util.table.deepcopy(data.raw["electric-pole"]["medium-electric-pole"]) --> medium-electric-pole
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.pictures.layers[1].hr_version.filename  = CONST.mod_name.."/graphics/medium-electric-pole/hr-medium-electric-pole.png"
entity.pictures.layers[2].hr_version.filename  = CONST.mod_name.."/graphics/medium-electric-pole/hr-medium-electric-pole-shadow.png"

data:extend({entity}) --> medium-electric-pole

entity = util.table.deepcopy(data.raw["electric-pole"]["big-electric-pole"]) --> big-electric-pole
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.pictures.layers[1].hr_version.filename  = CONST.mod_name.."/graphics/big-electric-pole/hr-big-electric-pole.png" 

data:extend({entity}) --> big-electric-pole

entity = util.table.deepcopy(data.raw["electric-pole"]["substation"]) --> substation
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.pictures.layers[1].hr_version.filename  = CONST.mod_name.."/graphics/substation/hr-substation.png" 

data:extend({entity}) --> substation

-------- [ electric-pole ]

-------- [ circuit-network ]
entity = util.table.deepcopy(data.raw["programmable-speaker"]["programmable-speaker"]) --> [ programmable-speaker ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.sprite.layers[1].hr_version.filename = CONST.mod_name.."/graphics/programmable-speaker/hr-programmable-speaker.png"

data:extend({entity}) --> programmable-speaker

entity = util.table.deepcopy(data.raw["arithmetic-combinator"]["arithmetic-combinator"]) --> [ arithmetic-combinator ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged" 
entity.minable.result = entity.name

data:extend({generate_arithmetic_combinator(entity)}) --> arithmetic-combinator

entity = util.table.deepcopy(data.raw["decider-combinator"]["decider-combinator"]) --> [ decider-combinator ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged" 
entity.minable.result = entity.name

data:extend({generate_decider_combinator(entity)}) --> decider-combinator

entity = util.table.deepcopy(data.raw["constant-combinator"]["constant-combinator"]) --> [ constant_combinatorr ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged" 
entity.minable.result = entity.name

data:extend({generate_constant_combinator(entity)}) --> constant_combinator

-------- [ circuit-network ]


-------- [ logistic-container ]
entity = util.table.deepcopy(data.raw["logistic-container"]["logistic-chest-active-provider"]) --> [ logistic-chest-active-provider ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged" 
entity.minable.result = entity.name

entity.animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/logistic-chest/hr-logistic-chest-active-provider.png"

data:extend({entity}) --> logistic-chest-active-provider

entity = util.table.deepcopy(data.raw["logistic-container"]["logistic-chest-buffer"]) --> [ logistic-chest-buffer ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged" 
entity.minable.result = entity.name

entity.animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/logistic-chest/hr-logistic-chest-buffer.png"

data:extend({entity}) --> logistic-chest-buffer

entity = util.table.deepcopy(data.raw["logistic-container"]["logistic-chest-passive-provider"]) --> [ logistic-chest-passive-provider ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged" 
entity.minable.result = entity.name

entity.animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/logistic-chest/hr-logistic-chest-passive-provider.png"

data:extend({entity}) --> logistic-chest-passive-provider

entity = util.table.deepcopy(data.raw["logistic-container"]["logistic-chest-requester"]) --> [ logistic-chest-requester ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged" 
entity.minable.result = entity.name

entity.animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/logistic-chest/hr-logistic-chest-requester.png"

data:extend({entity}) --> logistic-chest-requester

entity = util.table.deepcopy(data.raw["logistic-container"]["logistic-chest-storage"]) --> [ logistic-chest-storage ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name 

entity.animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/logistic-chest/hr-logistic-chest-storage.png"

data:extend({entity}) --> logistic-chest-storage

-------- [ logistic-container ]

-------- [ storage-tank ] pictures
entity = util.table.deepcopy(data.raw["storage-tank"]["storage-tank"]) --> [ storage-tank ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name 

entity.pictures.picture.sheets[1].hr_version.filename = CONST.mod_name.."/graphics/storage-tank/hr-storage-tank.png"

data:extend({entity}) --> storage-tank

-------- [ storage-tank ]

-------- [ stone ]
local _entity_, _shadow_ = 1, 2
entity = util.table.deepcopy(data.raw["wall"]["stone-wall"]) --> stone-wall
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.pictures.single.layers[_entity_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-single.png"
entity.pictures.single.layers[_shadow_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-single-shadow.png"

entity.pictures.straight_vertical.layers[_entity_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-vertical.png"
entity.pictures.straight_vertical.layers[_shadow_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-vertical-shadow.png"
entity.pictures.straight_horizontal.layers[_entity_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-horizontal.png"
entity.pictures.straight_horizontal.layers[_shadow_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-horizontal-shadow.png"

entity.pictures.corner_right_down.layers[_entity_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-corner-right.png"
entity.pictures.corner_right_down.layers[_shadow_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-corner-right-shadow.png"
entity.pictures.corner_left_down.layers[_entity_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-corner-left.png"
entity.pictures.corner_left_down.layers[_shadow_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-corner-left-shadow.png"

entity.pictures.t_up.layers[_entity_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-t.png"
entity.pictures.t_up.layers[_shadow_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-t-shadow.png"

entity.pictures.ending_right.layers[_entity_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-ending-right.png"
entity.pictures.ending_right.layers[_shadow_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-ending-right-shadow.png"
entity.pictures.ending_left.layers[_entity_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-ending-left.png"
entity.pictures.ending_left.layers[_shadow_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-ending-left-shadow.png"

entity.pictures.filling.hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-filling.png"
entity.pictures.filling.hr_version.height = 70

entity.pictures.gate_connection_patch.sheets[_entity_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-gate.png"
entity.pictures.gate_connection_patch.sheets[_shadow_].hr_version.filename  = CONST.mod_name.."/graphics/wall/hr-wall-gate-shadow.png"

entity.wall_diode_green.sheet.hr_version.filename = CONST.mod_name.."/graphics/wall/hr-wall-diode-off.png"
entity.wall_diode_red.sheet.hr_version.filename = CONST.mod_name.."/graphics/wall/hr-wall-diode-off.png"

data:extend({entity}) --> stone-wall

entity = util.table.deepcopy(data.raw["furnace"]["stone-furnace"]) --> stone-furnace
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"

entity.animation.layers[_entity_].hr_version.filename = CONST.mod_name.."/graphics/stone-furnace/hr-stone-furnace.png"
entity.working_visualisations[2].animation.hr_version.filename = CONST.mod_name.."/graphics/stone-furnace/hr-stone-furnace-light.png"

data:extend({entity}) --> stone-furnace

-------- [ stone ]

-------- [ furnace ]

entity = util.table.deepcopy(data.raw["furnace"]["electric-furnace"]) --> electric-furnace
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"

entity.animation.layers[_entity_].hr_version.filename = CONST.mod_name.."/graphics/electric-furnace/hr-electric-furnace.png"
entity.working_visualisations[1].animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/electric-furnace/hr-electric-furnace-heater.png"
entity.working_visualisations[1].animation.layers[2].hr_version.filename = CONST.mod_name.."/graphics/electric-furnace/hr-electric-furnace-light.png"

data:extend({entity}) --> electric-furnace

entity = util.table.deepcopy(data.raw["furnace"]["steel-furnace"]) --> steel-furnace
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"

entity.animation.layers[_entity_].hr_version.filename = CONST.mod_name.."/graphics/steel-furnace/hr-steel-furnace.png"
entity.working_visualisations[3].animation.hr_version.filename = CONST.mod_name.."/graphics/steel-furnace/hr-steel-furnace-working.png"
entity.working_visualisations[3].animation.hr_version.width = 130

data:extend({entity}) --> steel-furnace

-------- [ furnace ]

-------- [ transport-belt ]
local _entity_, _shadow_ = 1, 2

entity = util.table.deepcopy(data.raw["transport-belt"]["transport-belt"]) --> transport-belt
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.belt_animation_set.animation_set.hr_version.filename = CONST.mod_name.."/graphics/transport-belt/hr-transport-belt.png"

data:extend({entity}) --> transport-belt

entity = util.table.deepcopy(data.raw["transport-belt"]["fast-transport-belt"]) --> fast-transport-belt
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.belt_animation_set.animation_set.hr_version.filename = CONST.mod_name.."/graphics/fast-transport-belt/hr-fast-transport-belt.png"

data:extend({entity}) --> fast-transport-belt

entity = util.table.deepcopy(data.raw["transport-belt"]["express-transport-belt"]) --> express-transport-belt
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.belt_animation_set.animation_set.hr_version.filename = CONST.mod_name.."/graphics/express-transport-belt/hr-express-transport-belt.png"

data:extend({entity}) --> express-transport-belt

-------- [ transport-belt ]

-------- [ underground-belt ]
entity = util.table.deepcopy(data.raw["underground-belt"]["underground-belt"]) --> underground-belt
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.structure.direction_in.sheet.hr_version.filename = CONST.mod_name.."/graphics/underground-belt/hr-underground-belt-structure.png"
entity.structure.direction_out.sheet.hr_version.filename = CONST.mod_name.."/graphics/underground-belt/hr-underground-belt-structure.png"
entity.structure.direction_in_side_loading.sheet.hr_version.filename = CONST.mod_name.."/graphics/underground-belt/hr-underground-belt-structure.png"
entity.structure.direction_out_side_loading.sheet.hr_version.filename = CONST.mod_name.."/graphics/underground-belt/hr-underground-belt-structure.png"

data:extend({entity}) --> underground-belt

entity = util.table.deepcopy(data.raw["underground-belt"]["fast-underground-belt"]) --> fast-underground-belt
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.structure.direction_in.sheet.hr_version.filename = CONST.mod_name.."/graphics/fast-underground-belt/hr-fast-underground-belt-structure.png"
entity.structure.direction_out.sheet.hr_version.filename = CONST.mod_name.."/graphics/fast-underground-belt/hr-fast-underground-belt-structure.png"
entity.structure.direction_in_side_loading.sheet.hr_version.filename = CONST.mod_name.."/graphics/fast-underground-belt/hr-fast-underground-belt-structure.png"
entity.structure.direction_out_side_loading.sheet.hr_version.filename = CONST.mod_name.."/graphics/fast-underground-belt/hr-fast-underground-belt-structure.png"

data:extend({entity}) --> fast-underground-belt

entity = util.table.deepcopy(data.raw["underground-belt"]["express-underground-belt"]) --> express-underground-belt
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.structure.direction_in.sheet.hr_version.filename = CONST.mod_name.."/graphics/express-underground-belt/hr-express-underground-belt-structure.png"
entity.structure.direction_out.sheet.hr_version.filename = CONST.mod_name.."/graphics/express-underground-belt/hr-express-underground-belt-structure.png"
entity.structure.direction_in_side_loading.sheet.hr_version.filename = CONST.mod_name.."/graphics/express-underground-belt/hr-express-underground-belt-structure.png"
entity.structure.direction_out_side_loading.sheet.hr_version.filename = CONST.mod_name.."/graphics/express-underground-belt/hr-express-underground-belt-structure.png"

data:extend({entity}) --> express-underground-belt

-------- [ underground-belt ]

-------- [ mining-drill ]
entity = util.table.deepcopy(data.raw["mining-drill"]["pumpjack"]) --> pumpjack
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.base_picture.sheets[1].hr_version.filename = CONST.mod_name.."/graphics/pumpjack/hr-pumpjack-base.png"
entity.animations.north.layers[1].hr_version.filename = CONST.mod_name.."/graphics/pumpjack/hr-pumpjack-horsehead.png"

data:extend({entity}) --> pumpjack

-------- [ mining-drill ]

-------- [ roboport ]
entity = util.table.deepcopy(data.raw["roboport"]["roboport"]) --> roboport
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.base.layers[1].hr_version.filename = CONST.mod_name.."/graphics/roboport/hr-roboport-base.png"
entity.base_patch.hr_version.filename = CONST.mod_name.."/graphics/roboport/hr-roboport-base-patch.png"
entity.door_animation_up.hr_version.filename = CONST.mod_name.."/graphics/roboport/hr-roboport-door-up.png"
entity.door_animation_down.hr_version.filename = CONST.mod_name.."/graphics/roboport/hr-roboport-door-down.png"

data:extend({entity}) --> roboport

-------- [ roboport ]

-------- [ accumulator ]
entity = util.table.deepcopy(data.raw["accumulator"]["accumulator"]) --> accumulator
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.picture.layers[1].hr_version.filename = CONST.mod_name.."/graphics/accumulator/hr-accumulator.png"

data:extend({entity}) --> accumulator

-------- [ accumulator ]

-------- [ generator ]
entity = util.table.deepcopy(data.raw["generator"]["steam-turbine"]) --> [ steam-turbine ]
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

table.insert(entity.flags, "not-in-made-in")

entity.horizontal_animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/steam-turbine/hr-steam-turbine-H.png"
entity.vertical_animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/steam-turbine/hr-steam-turbine-V.png"

data:extend({entity}) --> steam-turbine

entity = util.table.deepcopy(data.raw["generator"]["steam-engine"]) --> [ steam-engine ]
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

table.insert(entity.flags, "not-in-made-in")

entity.horizontal_animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/steam-engine/hr-steam-engine-H.png"
entity.vertical_animation.layers[1].hr_version.filename = CONST.mod_name.."/graphics/steam-engine/hr-steam-engine-V.png"

data:extend({entity}) --> steam-engine

-------- [ generator ]

-------- [ boiler ]
entity = util.table.deepcopy(data.raw["boiler"]["boiler"]) --> [ boiler ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.structure.north.layers[1].hr_version.filename = CONST.mod_name.."/graphics/boiler/hr-boiler-N-idle.png"
entity.structure.east.layers[1].hr_version.filename = CONST.mod_name.."/graphics/boiler/hr-boiler-E-idle.png"
entity.structure.south.layers[1].hr_version.filename = CONST.mod_name.."/graphics/boiler/hr-boiler-S-idle.png"
entity.structure.west.layers[1].hr_version.filename = CONST.mod_name.."/graphics/boiler/hr-boiler-W-idle.png"

entity.fire_glow.north.hr_version.filename = CONST.mod_name.."/graphics/boiler/hr-boiler-N-light.png"
entity.fire_glow.east.hr_version.filename = CONST.mod_name.."/graphics/boiler/hr-boiler-E-light.png"
entity.fire_glow.south.hr_version.filename = CONST.mod_name.."/graphics/boiler/hr-boiler-S-light.png"
entity.fire_glow.west.hr_version.filename = CONST.mod_name.."/graphics/boiler/hr-boiler-W-light.png"

data:extend({entity}) --> boiler

entity = util.table.deepcopy(data.raw["boiler"]["heat-exchanger"]) --> [ heat-exchanger ]
rep_recipe( entity.name )
rep_item( entity.name )
entity.name = entity.name.."-damaged"
entity.minable.result = entity.name

entity.structure.north.layers[1].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-N-idle.png"
entity.structure.east.layers[1].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-E-idle.png"
entity.structure.south.layers[1].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-S-idle.png"
entity.structure.west.layers[1].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-W-idle.png"

entity.energy_source.heat_picture.north.layers[1].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-N-heated.png"
entity.energy_source.heat_picture.east.layers[1].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-E-heated.png"
entity.energy_source.heat_picture.south.layers[1].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-S-heated.png"
entity.energy_source.heat_picture.west.layers[1].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-W-heated.png"

entity.energy_source.heat_picture.north.layers[2].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-N-heated.png"
entity.energy_source.heat_picture.east.layers[2].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-E-heated.png"
entity.energy_source.heat_picture.south.layers[2].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-S-heated.png"
entity.energy_source.heat_picture.west.layers[2].hr_version.filename = CONST.mod_name.."/graphics/heat-exchanger/hr-heatex-W-heated.png"

data:extend({entity}) --> heat-exchanger
-------- [ boiler ]