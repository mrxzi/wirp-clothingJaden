local QBCore = exports['qb-core']:GetCoreObject()

-- // COMMANDS //

-- RegisterCommand("outfits" , function ()
--     TriggerEvent('qb-clothing:client:openOutfitMenu', true)
-- end)

RegisterCommand("clothing" , function ()
    TriggerEvent('qb-clothing:client:openMenu', false , false)
end)

RegisterCommand("register", function ()
    TriggerEvent('wirp-clothing:firstCharacterMenu', false) -- false = not free , true = free
end)

RegisterCommand("barber" , function ()
    TriggerEvent('wirp-clothing:openBarber', false)
end)

-- // EVENTS //

RegisterNetEvent('qb-clothing:client:openMenu', function()
    TriggerEvent('wirp-clothing:openClothing', true)
end)


-- RegisterNetEvent('qb-clothing:client:openOutfitMenu', function()
--     TriggerEvent('wirp-clothing:outfits', true)
-- end)

RegisterNetEvent('qb-clothing:client:openBarberMenu', function()
    TriggerEvent('wirp-clothing:openBarber', false) -- false = not free , true = free
end)