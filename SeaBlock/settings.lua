if mods["LandfillPainting"] then
  local tiletypes = {
    'landfill-dirt-4',
    'landfill-dry-dirt',
    'landfill-grass-1',
    'landfill-landfill',
    'landfill-red-desert-1',
    'landfill-sand-3'
  }

  data:extend({
    {
      type = 'string-setting',
      name = 'sb-default-landfill',
      setting_type = 'startup',
      default_value = tiletypes[6],
      allowed_values = tiletypes
    }
  })
end

data:extend({
    {
        type = "double-setting",
        name = "sb-fuel-factor-solid",
        order = "effectivity-a1",
        setting_type = "startup",
        default_value = 2.0,
        minimum_value = 0.1,
        maximum_value = 5.0
    }})

data:extend({
    {
        type = "string-setting",
        name = "sb-fuel-tiers-solid",
        order = "effectivity-a2",
        setting_type = "startup",
        default_value = "0.75, 1.0, 1.2, 1.4, 1.6, 1.8",
    }})

data:extend({
    {
        type = "double-setting",
        name = "sb-fuel-factor-fluid",
        order = "effectivity-b1",
        setting_type = "startup",
        default_value = 1.0,
        minimum_value = 0.1,
        maximum_value = 5.0
    }})

data:extend({
    {
        type = "string-setting",
        name = "sb-fuel-tiers-fluid",
        order = "effectivity-b2",
        setting_type = "startup",
        default_value = "-, -, 1.0, 1.2, 1.4, 1.6",
    }})
