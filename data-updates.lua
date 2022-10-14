

data.raw["wall"]["stone-wall"].pictures.straight_vertical.layers[1].hr_version.filename = "__damage_effect__/graphics/wall/update_wall/hr-wall-vertical.png" 
data.raw["wall"]["stone-wall"].pictures.t_up.layers[1].hr_version.filename = "__damage_effect__/graphics/wall/update_wall/hr-wall-t.png"
data.raw["wall"]["stone-wall"].pictures.corner_right_down.layers[1].hr_version.filename = "__damage_effect__/graphics/wall/update_wall/hr-wall-corner-right.png"
data.raw["wall"]["stone-wall"].pictures.corner_left_down.layers[1].hr_version.filename = "__damage_effect__/graphics/wall/update_wall/hr-wall-corner-left.png"

local s = 2

local shift = util.by_pixel(0, 8)
local path = "__damage_effect__/graphics/"..s.."-alpha-health-bar-pips.png"
--local utility = data.raw["utility-sprites"]["default"]

data.raw["utility-sprites"]["default"].health_bar_green_pip.filename = path
data.raw["utility-sprites"]["default"].health_bar_green_pip.shift = shift

data.raw["utility-sprites"]["default"].health_bar_yellow_pip.shift = shift
data.raw["utility-sprites"]["default"].health_bar_yellow_pip.filename = path

data.raw["utility-sprites"]["default"].health_bar_red_pip.shift = shift
data.raw["utility-sprites"]["default"].health_bar_red_pip.filename = path

data.raw["utility-sprites"]["default"].ghost_bar_pip.shift = shift
data.raw["utility-sprites"]["default"].ghost_bar_pip.filename = path

data.raw["utility-sprites"]["default"].bar_gray_pip.shift = shift
data.raw["utility-sprites"]["default"].bar_gray_pip.filename = path

data.raw["utility-sprites"]["default"].shield_bar_pip.shift = shift
data.raw["utility-sprites"]["default"].shield_bar_pip.filename = path


data.raw.recipe["steam-engine-damaged"].enabled = false


data.raw.fire["fire-on"].initial_lifetime = 300
data.raw.fire["fire-on"].burnt_patch_lifetime = 300