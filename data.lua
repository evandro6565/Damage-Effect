require("data.const")
require("prototypes.entity")


local fireutil = require("__base__.prototypes.fire-util")


smoke = util.table.deepcopy(data.raw["trivial-smoke"]["fire-smoke-without-glow"])
smoke.name = "fire-smoke-without-glow-dark"
smoke.color = util.premul_color{1,1,1, 0.70}
smoke.fade_in_duration = 90

data:extend({ smoke }) -- << smoke

smoke_s = util.table.deepcopy(smoke)
smoke_s.name = "fire-smoke-without-glow-slow-dark"
smoke_s.color = util.premul_color{1,1,1, 0.60}

data:extend({ smoke_s }) -- << smoke s

fire = util.table.deepcopy(data.raw["fire"]["fire-flame-on-tree"])
fire.name = "no-fire-tree"
fire.damage_per_tick = {amount = 0, type = "fire"}
fire.pictures = fireutil.create_fire_pictures({blend_mode = "additive", animation_speed = 1, scale = 0.1 * 1.25})
fire.maximum_spread_count = 50
fire.spread_delay_deviation = 20 -- ed
fire.spread_delay = 10
fire.fade_in_duration = 25*60
fire.fade_out_duration = 1600*60
fire.delay_between_initial_flames = 5
fire.smoke[1].name = "fire-smoke-without-glow-slow-dark"
fire.spawn_entity = ""
--[[for _, op in pairs(fire.pictures) do
	op.tint = {r=35,g=227,b=59,a=1}
end]]

data:extend({ fire })

fire = util.table.deepcopy(data.raw["fire"]["fire-flame-on-tree"])

fire.name = "fire-on"
fire.damage_per_tick = {amount = 0, type = "fire"}
fire.pictures = fireutil.create_fire_pictures({blend_mode = "additive", animation_speed = 1, scale = 0.1 * 1.25})
fire.maximum_spread_count = 50
fire.spread_delay_deviation = 20 -- ed
fire.spread_delay = 10
fire.fade_in_duration = 30--5*60--25*60
fire.fade_out_duration = 60 * 60 * 10 -- 15 minutes --60*1600
fire.delay_between_initial_flames = 5
--fire.smoke[1].name = "fire-smoke-without-glow-slow-dark"
--fire.spawn_entity = ""
--[[for _, op in pairs(fire.pictures) do
	op.tint = {r=35,g=227,b=59,a=1}
end]]

data:extend({ fire })

fire_medium = util.table.deepcopy(fire)
fire_medium.name = "fire-on-medium"
fire_medium.spread_delay = 10
fire_medium.spread_delay_deviation = 20
fire_medium.maximum_spread_count = 50
fire_medium.pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = 0.2})

fire_medium.smoke[1].name = "fire-smoke-without-glow-slow-dark"
fire_medium.smoke[1].frequency = 0.700 / 2
fire_medium.smoke[1].height = -0.50
fire_medium.smoke[1].deviation = {0.50, 0.50}

data:extend({ fire_medium })

fire_small = util.table.deepcopy(fire)
fire_small.name = "fire-on-small"
fire_small.spread_delay = 10
fire_small.spread_delay_deviation = 20
fire_small.maximum_spread_count = 50
fire_small.pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = 0.09})

fire_small.smoke[1].name = "fire-smoke-without-glow-slow-dark"
fire_small.smoke[1].frequency = 0.700 / 2
fire_small.smoke[1].height = -0.50
fire_small.smoke[1].deviation = {0.50, 0.50}

data:extend({ fire_small })

fire_car = util.table.deepcopy(fire)
fire_car.name = "fire-on-car"
--fire_car.fade_in_duration = 2
fire_car.fade_in_duration = 100
fire_car.fade_out_duration = 60 * 60 * 10 -- 15 minutes
fire_car.smoke_fade_in_duration = 70
--fire_car.smoke_fade_out_duration = 1200*60

fire_car.initial_lifetime = 12
fire_car.lifetime_increase_by = 150
fire_car.lifetime_increase_cooldown = 4
fire_car.maximum_lifetime = 180

fire_car.smoke[1].name = "fire-smoke-without-glow-dark"
fire_car.smoke[1].frequency = 0.700 / 2
fire_car.smoke[1].height = -0.50
fire_car.smoke[1].deviation = {0.50, 0.50}

data:extend({ fire_car })

fire_car_crash = util.table.deepcopy(fire)
fire_car_crash.name = "fire-on-car-crash"
fire_car_crash.fade_in_duration = 2
fire_car_crash.fade_out_duration = 200*60

data:extend({ fire_car_crash })

fire_smoke = util.table.deepcopy(fire)
fire_smoke.name = "fire-smoke"

fire_smoke.fade_in_duration = 1
fire_smoke.fade_out_duration = 1

fire_smoke.smoke_fade_in_duration = 100
fire_smoke.smoke_fade_out_duration = 1200*60
fire_smoke.working_sound = nil --{sound = {filename = ""}}
fire_smoke.spawn_entity = ""

fire_smoke.pictures = {
    {
      filename = CONST.mod_name.."/graphics/blank.png",
      width = 32,
      height = 32
    }
}

data:extend({ fire_smoke })



--data.raw.recipe["steam-engine-damaged"].enabled = false

smoke = util.table.deepcopy(data.raw["trivial-smoke"]["soft-fire-smoke"])
smoke.name = "d-soft-fire-smoke"
smoke.color = util.premul_color{0.3, 0.3, 0.3, 0.3}
smoke.end_scale = 1.4

data:extend({ smoke })

data.raw.fire["fire-on"].initial_lifetime = 30
data.raw.fire["fire-on"].burnt_patch_lifetime = 30


data:extend(
{
  {
     type = "sprite",
     name = "accumulator-sprite",
     filename = "__base__/graphics/entity/accumulator/accumulator.png",
     priority = "extra-high",
     width = 66,
     height = 94,
     shift = {0.7, -0.2}
  },
})