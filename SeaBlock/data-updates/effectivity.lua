local fuel_tiers_solid = settings.startup['sb-fuel-tiers-solid'].value
local fuel_tiers_fluid = settings.startup['sb-fuel-tiers-fluid'].value

local fuel_factor_solid = settings.startup['sb-fuel-factor-solid'].value
local fuel_factor_fluid = settings.startup['sb-fuel-factor-fluid'].value

log("solid tiers: "..fuel_tiers_solid.."solid factor: "..fuel_factor_solid)
log("fluid tiers: "..fuel_tiers_fluid.."fluid factor: "..fuel_factor_fluid)

local n = "([%d\\.\\-]+)" -- number pattern incl. - and .
local d = "[%s,]+"        -- delimiter pattern incl. whitespaces

local six_tiers_regex = "^"..n..d..n..d..n..d..n..d..n..d..n.."$"

local solid_tier0, solid_tier1, solid_tier2, solid_tier3, solid_tier4, solid_tier5 =
    fuel_tiers_solid:match(six_tiers_regex)

solid_tier0 = solid_tier0/fuel_factor_solid
solid_tier1 = solid_tier1/fuel_factor_solid
solid_tier2 = solid_tier2/fuel_factor_solid
solid_tier3 = solid_tier3/fuel_factor_solid
solid_tier4 = solid_tier4/fuel_factor_solid
solid_tier5 = solid_tier5/fuel_factor_solid

local _, _, fluid_tier2, fluid_tier3, fluid_tier4, fluid_tier5 =
    fuel_tiers_fluid:match(six_tiers_regex)

fluid_tier2 = fluid_tier2/fuel_factor_fluid
fluid_tier3 = fluid_tier3/fuel_factor_fluid
fluid_tier4 = fluid_tier4/fuel_factor_fluid
fluid_tier5 = fluid_tier5/fuel_factor_fluid

log(string.format("solid tiers: %s %s %s %s %s %s", solid_tier0, solid_tier1, solid_tier2, solid_tier3, solid_tier4, solid_tier5))
log(string.format("fluid tiers: %s %s %s %s"      , fluid_tier2, fluid_tier3, fluid_tier4, fluid_tier5))


-- type = "boiler",
-- name = "boiler",
-- energy_consumption = "1.8MW",
-- energy_source =
-- {
--     type = "burner",
--     fuel_category = "chemical",
--     effectivity = 0.5,
if data.raw["boiler"]["boiler"] then
    data.raw["boiler"]["boiler"].energy_source.effectivity = solid_tier1
end

if mods['bobpower'] then
    if data.raw["boiler"]["boiler-2"] then
        data.raw["boiler"]["boiler-2"].energy_source.effectivity = solid_tier2
    end
    if data.raw["boiler"]["boiler-3"] then
        data.raw["boiler"]["boiler-3"].energy_source.effectivity = solid_tier3
    end
    if data.raw["boiler"]["boiler-4"] then
        data.raw["boiler"]["boiler-4"].energy_source.effectivity = solid_tier4
    end
    if data.raw["boiler"]["boiler-5"] then
        data.raw["boiler"]["boiler-5"].energy_source.effectivity = solid_tier5
    end
    
    if data.raw["boiler"]["oil-boiler"] then
        data.raw["boiler"]["oil-boiler"].energy_source.effectivity = fluid_tier2
    end
    if data.raw["boiler"]["oil-boiler-2"] then
        data.raw["boiler"]["oil-boiler-2"].energy_source.effectivity = fluid_tier3
    end
    if data.raw["boiler"]["oil-boiler-3"] then
        data.raw["boiler"]["oil-boiler-3"].energy_source.effectivity = fluid_tier4
    end
    if data.raw["boiler"]["oil-boiler-4"] then
        data.raw["boiler"]["oil-boiler-4"].energy_source.effectivity = fluid_tier5
    end
    
    if data.raw["burner-generator"]["bob-burner-generator"] then
        data.raw["burner-generator"]["bob-burner-generator"].burner.effectivity = solid_tier0
    end

    if data.raw["generator"]["fluid-generator"] then
        data.raw["generator"]["fluid-generator"].effectivity = fluid_tier2
    end
    if data.raw["generator"]["fluid-generator-2"] then
        data.raw["generator"]["fluid-generator-2"].effectivity = fluid_tier3
    end
    if data.raw["generator"]["fluid-generator-3"] then
        data.raw["generator"]["fluid-generator-3"].effectivity = fluid_tier4
    end
    
    if data.raw["generator"]["hydrazine-generator"] then
        data.raw["generator"]["hydrazine-generator"].effectivity = fluid_tier5 * 1.103 -- 1.103 is the original effectivity from bobs power
    end

    -- don't change heat exchanger, bc they are needed for nuclear too
    --data.raw.["boiler"]["heat-exchanger"].energy_source.effectivity = solid_tier3
    
    if data.raw["reactor"]["burner-reactor"] then
        data.raw["reactor"]["burner-reactor"].energy_source.effectivity = solid_tier3
    end
    if data.raw["reactor"]["burner-reactor-2"] then
        data.raw["reactor"]["burner-reactor-2"].energy_source.effectivity = solid_tier4
    end
    if data.raw["reactor"]["burner-reactor-3"] then
        data.raw["reactor"]["burner-reactor-3"].energy_source.effectivity = solid_tier5
    end

    -- for some reason, all bob's fluid-reactors share the same energy_source instance. So, first copy before adjusting
    if data.raw["reactor"]["fluid-reactor"] then
        data.raw["reactor"]["fluid-reactor"].energy_source = table.deepcopy(data.raw["reactor"]["fluid-reactor"].energy_source)
        data.raw["reactor"]["fluid-reactor"].energy_source.effectivity = fluid_tier3
    end
    if data.raw["reactor"]["fluid-reactor-2"] then
        data.raw["reactor"]["fluid-reactor-2"].energy_source = table.deepcopy(data.raw["reactor"]["fluid-reactor-2"].energy_source)
        data.raw["reactor"]["fluid-reactor-2"].energy_source.effectivity = fluid_tier4
    end
    if data.raw["reactor"]["fluid-reactor-3"] then
        data.raw["reactor"]["fluid-reactor-3"].energy_source = table.deepcopy(data.raw["reactor"]["fluid-reactor-3"].energy_source)
        data.raw["reactor"]["fluid-reactor-3"].energy_source.effectivity = fluid_tier5
    end
end

--ks power
if data.raw["boiler"]["oil-steam-boiler"] then
    data.raw["boiler"]["oil-steam-boiler"].energy_source.effectivity = fluid_tier2
end

if data.raw["generator"]["petroleum-generator"] then
    data.raw["generator"]["petroleum-generator"].effectivity = fluid_tier5
end

if data.raw["burner-generator"]["burner-generator"] then
    data.raw["burner-generator"]["burner-generator"].burner.effectivity = solid_tier0
end

if data.raw["burner-generator"]["big-burner-generator"] then
    data.raw["burner-generator"]["big-burner-generator"].burner.effectivity = solid_tier3
end

log("changed boiler effectivity")
