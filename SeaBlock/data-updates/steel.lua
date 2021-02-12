--     {
--       type = "recipe",
--       name = "angels-plate-steel-pre-heating",
--       category = "advanced-crafting",
--       subgroup = "angels-steel-casting",
--       normal = {
--         enabled = false,
--         energy_required = 4,
--         ingredients = {
--           {type = "item", name = "angels-plate-hot-iron", amount = 8}
--         },
--         results = {
--           {type = "item", name = "angels-plate-steel", amount = 1}
--         }
--       },
--       expensive = {
--         enabled = false,
--         energy_required = 4,
--         ingredients = {
--           {type = "item", name = "angels-plate-hot-iron", amount = 8 * intermediatemulti}
--         },
--         results = {
--           {type = "item", name = "angels-plate-steel", amount = 1}
--         }
--       },

if angelsmods then
    if data.raw.recipe["angels-plate-steel-pre-heating"].normal then
        data.raw.recipe["angels-plate-steel-pre-heating"].normal.energy_required = 3
        data.raw.recipe["angels-plate-steel-pre-heating"].normal.ingredients = {
            { type = "item", name = "angels-plate-hot-iron", amount = 6 }
        }
    end
    -- dont change marathon
end
