local HRarithmetic_combinator = "__damage_effect__/graphics/combinator/hr-arithmetic-combinator.png"
local HRdecider_combinator = "__damage_effect__/graphics/combinator/hr-decider-combinator.png"
local HRconstant_combinator = "__damage_effect__/graphics/combinator/hr-constant-combinator.png"

local HRcombinator_displays = "__damage_effect__/graphics/combinator/hr-combinator-displays.png"

function generate_arithmetic_combinator(combinator)
  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = "__base__/graphics/entity/combinator/arithmetic-combinator.png",
          width = 74,
          height = 64,
          frame_count = 1,
          shift = util.by_pixel(1, 8),
          hr_version =
          {
            scale = 0.5,
            filename = HRarithmetic_combinator,--"__base__/graphics/entity/combinator/hr-arithmetic-combinator.png",
            width = 144,
            height = 124,
            frame_count = 1,
            shift = util.by_pixel(0.5, 7.5)
          }
        },
        {
          filename = "__base__/graphics/entity/combinator/arithmetic-combinator-shadow.png",
          width = 76,
          height = 78,
          frame_count = 1,
          shift = util.by_pixel(14, 24),
          draw_as_shadow = true,
          hr_version =
          {
            scale = 0.5,
            filename = "__base__/graphics/entity/combinator/hr-arithmetic-combinator-shadow.png",
            width = 148,
            height = 156,
            frame_count = 1,
            shift = util.by_pixel(13.5, 24.5),
            draw_as_shadow = true
          }
        }
      }
    })

  combinator.activity_led_sprites =
  {
    north = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/arithmetic-combinator-LED-N.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(8, -12),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-arithmetic-combinator-LED-N.png",
        width = 16,
        height = 14,
        frame_count = 1,
        shift = util.by_pixel(8.5, -12.5)
      }
    },
    east = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/arithmetic-combinator-LED-E.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(17, -1),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-arithmetic-combinator-LED-E.png",
        width = 14,
        height = 14,
        frame_count = 1,
        shift = util.by_pixel(16.5, -1)
      }
    },
    south = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/arithmetic-combinator-LED-S.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(-8, 7),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-arithmetic-combinator-LED-S.png",
        width = 16,
        height = 16,
        frame_count = 1,
        shift = util.by_pixel(-8, 7.5)
      }
    },
    west = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/arithmetic-combinator-LED-W.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(-16, -12),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-arithmetic-combinator-LED-W.png",
        width = 14,
        height = 14,
        frame_count = 1,
        shift = util.by_pixel(-16, -12.5)
      }
    }
  }

  -- [ plus_symbol_sprites ]
  combinator.plus_symbol_sprites = 
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  -- [ plus_symbol_sprites ]

  -- [ minus_symbol_sprites ]
  combinator.minus_symbol_sprites = 
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename =  HRcombinator_displays,
          x = 60,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename =  HRcombinator_displays,
          x = 60,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  -- [ minus_symbol_sprites ]

  -- [ multiply_symbol_sprites ]
  combinator.multiply_symbol_sprites =
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  -- [ multiply_symbol_sprites ]

  -- [ divide_symbol_sprites ]
  combinator.divide_symbol_sprites = 
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  -- [ divide_symbol_sprites ]
  
  -- [ modulo_symbol_sprites ]
  combinator.modulo_symbol_sprites = 
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }

  -- [ modulo_symbol_sprites ]
  
  -- [ power_symbol_sprites ]
  combinator.power_symbol_sprites =
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }

  -- [ power_symbol_sprites ]
 
  -- [ left_shift_symbol_sprites ]
  combinator.left_shift_symbol_sprites = 
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }

  -- [ left_shift_symbol_sprites ]

  -- [ right_shift_symbol_sprites ]
  combinator.right_shift_symbol_sprites =
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }

  -- [ right_shift_symbol_sprites ]

  -- [ and_symbol_sprites ]
  combinator.and_symbol_sprites =
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }
  -- [ and_symbol_sprites ]

  -- [ or_symbol_sprites ]
  combinator.or_symbol_sprites =
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  }

  -- [ or_symbol_sprites ]
  
  -- [ xor_symbol_sprites ] 
  combinator.xor_symbol_sprites = 
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        y = 11,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -10.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          y = 22,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -10.5)
        }
      }
  } 

  -- [ xor_symbol_sprites ]

  return combinator
end

function generate_decider_combinator(combinator)
  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = "__base__/graphics/entity/combinator/decider-combinator.png",
          width = 78,
          height = 66,
          frame_count = 1,
          shift = util.by_pixel(0, 7),
          hr_version =
          {
            scale = 0.5,
            filename = HRdecider_combinator,--"__base__/graphics/entity/combinator/hr-decider-combinator.png",
            width = 156,
            height = 132,
            frame_count = 1,
            shift = util.by_pixel(0.5, 7.5)
          }
        },
        {
          filename = "__base__/graphics/entity/combinator/decider-combinator-shadow.png",
          width = 78,
          height = 80,
          frame_count = 1,
          shift = util.by_pixel(12, 24),
          draw_as_shadow = true,
          hr_version =
          {
            scale = 0.5,
            filename = "__base__/graphics/entity/combinator/hr-decider-combinator-shadow.png",
            width = 156,
            height = 158,
            frame_count = 1,
            shift = util.by_pixel(12, 24),
            draw_as_shadow = true
          }
        }
      }
    })
  
  -- [ greater_symbol_sprites ] 
  combinator.greater_symbol_sprites =
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      }
  }

  -- [ greater_symbol_sprites ] 

  -- [ less_symbol_sprites ]
  combinator.less_symbol_sprites = 
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 15,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 30,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      }
  }

  -- [ less_symbol_sprites ]

  -- [ equal_symbol_sprites ] 
  combinator.equal_symbol_sprites = 
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 30,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 60,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      }
  }

  -- [ equal_symbol_sprites ]
  
  -- [ not_equal_symbol_sprites ] 
  combinator.not_equal_symbol_sprites =
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 45,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 90,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      }
  }

  -- [ not_equal_symbol_sprites ]

  -- [ less_or_equal_symbol_sprites ] 
  combinator.less_or_equal_symbol_sprites =
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 60,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 120,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      }
  }

  -- [ less_or_equal_symbol_sprites ]

  -- [ greater_or_equal_symbol_sprites ] 
  combinator.greater_or_equal_symbol_sprites = 
  {
    north = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    east = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      },
    south = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -4.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -4.5)
        }
      },
    west = util.draw_as_glow
      {
        filename = "__base__/graphics/entity/combinator/combinator-displays.png",
        x = 75,
        y = 22,
        width = 15,
        height = 11,
        shift = util.by_pixel(0, -13.5),
        hr_version =
        {
          scale = 0.5,
          filename = HRcombinator_displays,
          x = 150,
          y = 44,
          width = 30,
          height = 22,
          shift = util.by_pixel(0, -13.5)
        }
      }
  }
  -- [ greater_or_equal_symbol_sprites ]

  return combinator
end

function generate_constant_combinator(combinator)
  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = "__base__/graphics/entity/combinator/constant-combinator.png",
          width = 58,
          height = 52,
          frame_count = 1,
          shift = util.by_pixel(0, 5),
          hr_version =
          {
            scale = 0.5,
            filename = HRconstant_combinator,--"__base__/graphics/entity/combinator/hr-constant-combinator.png",
            width = 114,
            height = 102,
            frame_count = 1,
            shift = util.by_pixel(0, 5)
          }
        },
        {
          filename = "__base__/graphics/entity/combinator/constant-combinator-shadow.png",
          width = 50,
          height = 34,
          frame_count = 1,
          shift = util.by_pixel(9, 6),
          draw_as_shadow = true,
          hr_version =
          {
            scale = 0.5,
            filename = "__base__/graphics/entity/combinator/hr-constant-combinator-shadow.png",
            width = 98,
            height = 66,
            frame_count = 1,
            shift = util.by_pixel(8.5, 5.5),
            draw_as_shadow = true
          }
        }
      }
    })

  return combinator
end
