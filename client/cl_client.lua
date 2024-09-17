local QBCore = exports['qb-core']:GetCoreObject()

-- // IMPORTANT EVENT(S) //

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local gender = QBCore.Functions.GetPlayerData().charinfo.gender
    local model
    if gender == 0 or gender == 'man' then
        model = "mp_m_freemode_01"
    else
        model = "mp_f_freemode_01"
    end
    exports['wirp-clothing']:SetModel(model)
    TriggerEvent('qb-clothing:client:loadPlayerClothing' , PlayerData.cid, false)
end)

RegisterNetEvent('qb-clothes:client:CreateFirstCharacter', function()
    TriggerEvent('wirp-clothing:firstCharacterMenu', false) -- false = not free , true = free
end)

RegisterNetEvent('wirp-clothing:multichar:LoadClothing')
AddEventHandler('wirp-clothing:multichar:LoadClothing', function(data, cid,charPed)
    QBCore.Functions.TriggerCallback('qb-multicharacter:server:getSkin', function(model,nchub)
        exports['wirp-clothing']:SetModel(model)
        TriggerEvent('qb-clothing:client:loadPlayerClothing' ,cid or false, charPed or false)
    end, cid)
end)

Citizen.CreateThread(function()
    local blips = {
        {title="Clothing Store", colour=0, id=73, x=72.3, y=-1399.1, z=28.4},
        {title="Clothing Store", colour=0, id=73, x=-703.8, y=-152.3, z=36.4},
        {title="Clothing Store", colour=0, id=73, x=-167.9, y=-299.0, z=38.7},
        {title="Clothing Store", colour=0, id=73, x=428.7, y=-800.1, z=28.5},
        {title="Clothing Store", colour=0, id=73, x=-829.4, y=-1073.7, z=10.3},
        {title="Clothing Store", colour=0, id=73, x=-1447.8, y=-242.5, z=48.8},
        {title="Clothing Store", colour=0, id=73, x=11.6, y=6514.2, z=30.9},
        {title="Clothing Store", colour=0, id=73, x=123.6, y=-219.4, z=53.6},
        {title="Clothing Store", colour=0, id=73, x=1696.3, y=4829.3, z=41.1},
        {title="Clothing Store", colour=0, id=73, x=618.1, y=2759.6, z=41.1},
        {title="Clothing Store", colour=0, id=73, x=1190.6, y=2713.4, z=37.2},
        {title="Clothing Store", colour=0, id=73, x=-1193.4, y=-772.3, z=16.3},
        {title="Clothing Store", colour=0, id=73, x=-3172.5, y=1048.1, z=19.9},
        {title="Clothing Store", colour=0, id=73, x=-1108.4, y=2708.9, z=18.1},
        {title="Barbershop", colour=1, id=71, x=1932.075, y=3729.670, z=32.844},
        {title="Barbershop", colour=1, id=71, x=-278.190, y=6228.361, z=30.695},
        {title="Barbershop", colour=1, id=71, x=1211.990, y=-472.771, z=65.208},
        {title="Barbershop", colour=1, id=71, x=-33.224, y=-154.647, z=55.800},
        {title="Barbershop", colour=1, id=71, x=-1280.410, y=-1117.030, z=6.990},
        {title="Barbershop", colour=1, id=71, x=136.718, y=-1708.267, z=28.291},
        {title="Barbershop", colour=1, id=71, x=-815.590, y=-184.140, z=36.569},
    }

    for _, info in pairs(blips) do
        local blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(blip, info.id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.6)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, info.colour)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(info.title)
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNetEvent('qb-clothing:client:loadPlayerClothing')
AddEventHandler('qb-clothing:client:loadPlayerClothing', function(data, cid, charPed) -- EXAMPLE OF HOW THE PED CLOTHING IS LOADED !!!
    if type(cid) == "table" or not cid then
        local PlayerData = QBCore.Functions.GetPlayerData()
        cid = PlayerData.cid
    end
    QBCore.Functions.TriggerCallback('qb-multicharacter:server:getSkin', function(charPed, model,nchub)
        QBCore.Functions.TriggerCallback('nc-qb:getPedData', function(charPed, model2,headData)
            if not charPed then
                charPed = PlayerPedId()
            end
            exports['wirp-clothing']:LoadPedDefaults(charPed, nchub.customHeadModel)
            if nchub then
                exports['wirp-clothing']:ApplyPedClothing(charPed, nchub.drawables, nchub.props, nchub.hairColor, false);
            end
            if headData then
                exports['wirp-clothing']:ApplyPedData(charPed, headData.headblend, headData.features, headData.overlays, headData.eyeColor, nchub.customHeadModel);
            end
        end , cid)
    end, cid)
end)