local function convertInput(input)
    local splitInput = {}
    for str in string.gmatch(input, "([^:]+)") do
        table.insert(splitInput, tonumber(str))
    end
    return splitInput
end
local outfitOptions = {}

local function setOutfit(outfit)
    local ped = PlayerPedId()

    if (outfit.Gender == "Male" and GetEntityModel(ped) == GetHashKey("mp_m_freemode_01")) or (outfit.Gender == "Female" and GetEntityModel(ped) == GetHashKey("mp_f_freemode_01")) then
        SetPedComponentVariation(ped, 1, convertInput(outfit.Mask)[1], convertInput(outfit.Mask)[2], 0)
        SetPedComponentVariation(ped, 3, convertInput(outfit.UpperSkin)[1], convertInput(outfit.UpperSkin)[2], 0)
        SetPedComponentVariation(ped, 4, convertInput(outfit.Pants)[1], convertInput(outfit.Pants)[2], 0)
        SetPedComponentVariation(ped, 5, convertInput(outfit.Parachute)[1], convertInput(outfit.Parachute)[2], 0)
        SetPedComponentVariation(ped, 6, convertInput(outfit.Shoes)[1], convertInput(outfit.Shoes)[2], 0)
        SetPedComponentVariation(ped, 7, convertInput(outfit.Accessories)[1], convertInput(outfit.Accessories)[2], 0)
        SetPedComponentVariation(ped, 8, convertInput(outfit.UnderCoat)[1], convertInput(outfit.UnderCoat)[2], 0)
        SetPedComponentVariation(ped, 9, convertInput(outfit.Armor)[1], convertInput(outfit.Armor)[2], 0)
        SetPedComponentVariation(ped, 10, convertInput(outfit.Decal)[1], convertInput(outfit.Decal)[2], 0)
        SetPedComponentVariation(ped, 11, convertInput(outfit.Top)[1], convertInput(outfit.Top)[2], 0)

        if convertInput(outfit.Hat)[1] == -1 then
            ClearPedProp(ped, 0)
        else
            SetPedPropIndex(ped, 0, convertInput(outfit.Hat)[1], convertInput(outfit.Hat)[2], true)
        end

        if convertInput(outfit.Glasses)[1] == -1 then
            ClearPedProp(ped, 1)
        else
            SetPedPropIndex(ped, 1, convertInput(outfit.Glasses)[1], convertInput(outfit.Glasses)[2], true)
        end

        if convertInput(outfit.Watch)[1] == -1 then
            ClearPedProp(ped, 6)
        else
            SetPedPropIndex(ped, 6, convertInput(outfit.Watch)[1], convertInput(outfit.Watch)[2], true)
        end
    end
end


local outfits = json.decode(LoadResourceFile(GetCurrentResourceName(), "outfits.json"))  -- Load your outfits.json file

for _, outfitData in ipairs(outfits) do
    local label = outfitData.Gender .. " - " .. outfitData.Name
    table.insert(outfitOptions, {
        label = label,
        value = outfitData
    })
end

lib.registerMenu({
    id = 'EUP',
    title = 'EUP',
    position = 'top-right',
    options = outfitOptions
}, function(selected, scrollIndex, args)
    local selectedOutfit = outfitOptions[selected].value
    if selectedOutfit then
        setOutfit(selectedOutfit)
    end
end)

RegisterCommand('eup', function()
    lib.showMenu('EUP')
end)
