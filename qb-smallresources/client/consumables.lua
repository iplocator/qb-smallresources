local alcoholCount = 0
local onWeed = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(10)
        if alcoholCount > 0 then
            Citizen.Wait(1000 * 60 * 15)
            alcoholCount = alcoholCount - 1
        else
            Citizen.Wait(2000)
        end
    end
end)
RegisterNetEvent("consumables:client:UseJoint")
AddEventHandler("consumables:client:UseJoint", function()
    QBCore.Functions.Progressbar("smoke_joint", "Lighting joint..", 1500, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["joint"], "remove")
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            TriggerEvent('animations:client:EmoteCommandStart', {"smoke3"})
        else
            TriggerEvent('animations:client:EmoteCommandStart', {"smokeweed"})
        end
        TriggerEvent("evidence:client:SetStatus", "weedsmell", 300)
        TriggerEvent('animations:client:SmokeWeed')
    end)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function EquipParachuteAnim()
    loadAnimDict("clothingshirt")        
    TaskPlayAnim(PlayerPedId(), "clothingshirt", "try_shirt_positive_d", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end

local ParachuteEquiped = false

RegisterNetEvent("consumables:client:UseParachute")
AddEventHandler("consumables:client:UseParachute", function()
    EquipParachuteAnim()
    QBCore.Functions.Progressbar("use_parachute", "parachute using..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        local ped = PlayerPedId()
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "remove")
        GiveWeaponToPed(ped, GetHashKey("GADGET_PARACHUTE"), 1, false)
        local ParachuteData = {
            outfitData = {
                ["bag"]   = { item = 7, texture = 0},  -- Nek / Das
            }
        }
        TriggerEvent('qb-clothing:client:loadOutfit', ParachuteData)
        ParachuteEquiped = true
        TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    end)
end)

RegisterNetEvent("consumables:client:ResetParachute")
AddEventHandler("consumables:client:ResetParachute", function()
    if ParachuteEquiped then 
        EquipParachuteAnim()
        QBCore.Functions.Progressbar("reset_parachute", "Packing parachute..", 40000, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            local ped = PlayerPedId()
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["parachute"], "add")
            local ParachuteRemoveData = { 
                outfitData = { 
                    ["bag"] = { item = 0, texture = 0} -- Nek / Das
                }
            }
            TriggerEvent('qb-clothing:client:loadOutfit', ParachuteRemoveData)
            TaskPlayAnim(ped, "clothingshirt", "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            TriggerServerEvent("qb-smallpenis:server:AddParachute")
            ParachuteEquiped = false
        end)
    else
        QBCore.Functions.Notify("U dont have a parachute!", "error")
    end
end)

-- RegisterNetEvent("consumables:client:UseRedSmoke")
-- AddEventHandler("consumables:client:UseRedSmoke", function()
--     if ParachuteEquiped then
--         local ped = PlayerPedId()
--         SetPlayerParachuteSmokeTrailColor(ped, 255, 0, 0)
--         SetPlayerCanLeaveParachuteSmokeTrail(ped, true)
--         TriggerEvent("inventory:client:Itembox", QBCore.Shared.Items["smoketrailred"], "remove")
--     else
--         QBCore.Functions.Notify("You need to have a paracute to activate smoke!", "error")    
--     end
-- end)

RegisterNetEvent("consumables:client:UseArmor")
AddEventHandler("consumables:client:UseArmor", function()
    QBCore.Functions.Progressbar("use_armor", "Putting on the body armour..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["armor"], "remove")
        TriggerServerEvent('hospital:server:SetArmor', 75)
        TriggerServerEvent("QBCore:Server:RemoveItem", "armor", 1)
        SetPedArmour(PlayerPedId(), 75)
    end)
end)
local currentVest = nil
local currentVestTexture = nil
RegisterNetEvent("consumables:client:UseHeavyArmor")
AddEventHandler("consumables:client:UseHeavyArmor", function()
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()
    QBCore.Functions.Progressbar("use_heavyarmor", "Putting on body armour..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["heavyarmor"], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", "heavyarmor", 1)
        SetPedArmour(ped, 100)
    end)
end)

RegisterNetEvent("consumables:client:ResetArmor")
AddEventHandler("consumables:client:ResetArmor", function()
    local ped = PlayerPedId()
    if currentVest ~= nil and currentVestTexture ~= nil then 
        QBCore.Functions.Progressbar("remove_armor", "Removing the body armour..", 2500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            --SetPedComponentVariation(ped, 9, currentVest, currentVestTexture, 2)
            SetPedArmour(ped, 0)
            TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["heavyarmor"], "add")
            TriggerServerEvent("QBCore:Server:AddItem", "heavyarmor", 1)
        end)
    else
        QBCore.Functions.Notify("You\'re not wearing a vest..", "error")
    end
end)

RegisterNetEvent("consumables:client:DrinkAlcohol")
AddEventHandler("consumables:client:DrinkAlcohol", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    QBCore.Functions.Progressbar("snort_coke", "Drinking liquor..", math.random(3000, 6000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerServerEvent("QBCore:Server:RemoveItem", itemName, 1)
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
        alcoholCount = alcoholCount + 1
        if alcoholCount > 1 and alcoholCount < 4 then
            TriggerEvent("evidence:client:SetStatus", "alcohol", 200)
        elseif alcoholCount >= 4 then
            TriggerEvent("evidence:client:SetStatus", "heavyalcohol", 200)
        end
        
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Cancelled..", "error")
    end)
end)

RegisterNetEvent("consumables:client:Cokebaggy")
AddEventHandler("consumables:client:Cokebaggy", function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("snort_coke", "Quick sniff..", math.random(5000, 8000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "cokebaggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["cokebaggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 200)
        CokeBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent("consumables:client:Crackbaggy")
AddEventHandler("consumables:client:Crackbaggy", function()
    local ped = PlayerPedId()
    QBCore.Functions.Progressbar("snort_coke", "Smoking crack..", math.random(7000, 10000), false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "switch@trevor@trev_smoking_meth",
        anim = "trev_smoking_meth_loop",
        flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "crack_baggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["crack_baggy"], "remove")
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        CrackBaggyEffect()
    end, function() -- Cancel
        StopAnimTask(ped, "switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 1.0)
        QBCore.Functions.Notify("Canceled..", "error")
    end)
end)

RegisterNetEvent('consumables:client:EcstasyBaggy')
AddEventHandler('consumables:client:EcstasyBaggy', function()
    QBCore.Functions.Progressbar("use_ecstasy", "Pops Pills", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "xtcbaggy", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["xtcbaggy"], "remove")
        EcstasyEffect()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent("consumables:client:Eat")
AddEventHandler("consumables:client:Eat", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"eat"})
    QBCore.Functions.Progressbar("eat_something", "Eating..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Consumeables[itemName])
        TriggerServerEvent('hud:server:RelieveStress', math.random(2, 4))
    end)
end)

RegisterNetEvent("consumables:client:Drink")
AddEventHandler("consumables:client:Drink", function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {"drink"})
    QBCore.Functions.Progressbar("drink_something", "Drinking..", 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[itemName], "remove")
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Consumeables[itemName])
    end)
end)

--IP ADDED BITS

RegisterNetEvent('consumables:client:Acid')
AddEventHandler('consumables:client:Acid', function()
    QBCore.Functions.Progressbar("use_ecstasy", "Taking Acid", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "acid", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["acid"], "remove")
        AcidEffect()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:AcidBook')
AddEventHandler('consumables:client:AcidBook', function()
    QBCore.Functions.Progressbar("use_ecstasy", "Tearing Sheet Of Acid", 3000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "acidbook", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["acidbook"], "remove")
        Citizen.Wait(1000)
        TriggerServerEvent("QBCore:Server:AddItem", "acid", 100)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["acid"], "add")
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:UseTurbo')
AddEventHandler('consumables:client:UseTurbo', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("UseTurbo", "Installing Turbo", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "turbo", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["turbo"], "remove")
        InstallTurbo()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallEngineGrade1')
AddEventHandler('consumables:client:InstallEngineGrade1', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallEngineGrade1", "Installing Grade 1 Engine", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "engine1", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["engine1"], "remove")
        InstallEngineGrade1()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallEngineGrade2')
AddEventHandler('consumables:client:InstallEngineGrade2', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallEngineGrade2", "Installing Grade 2 Engine", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "engine2", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["engine2"], "remove")
        InstallEngineGrade2()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallEngineGrade3')
AddEventHandler('consumables:client:InstallEngineGrade3', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallEngineGrade3", "Installing Grade 3 Engine", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "engine3", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["engine3"], "remove")
        InstallEngineGrade3()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallEngineGrade4')
AddEventHandler('consumables:client:InstallEngineGrade4', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallEngineGrade4", "Installing Grade 4 Engine", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "engine4", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["engine4"], "remove")
        InstallEngineGrade4()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallEngineGrade5')
AddEventHandler('consumables:client:InstallEngineGrade5', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallEngineGrade5", "Installing Grade 5 Engine", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "engine5", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["engine5"], "remove")
        InstallEngineGrade5()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallBrakeGrade1')
AddEventHandler('consumables:client:InstallBrakeGrade1', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallBrakeGrade1", "Installing Grade 1 Brakes", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "brake1", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["brake1"], "remove")
        InstallBrakeGrade1()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallBrakeGrade2')
AddEventHandler('consumables:client:InstallBrakeGrade2', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallBrakeGrade2", "Installing Grade 2 Brakes", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "brake2", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["brake2"], "remove")
        InstallBrakeGrade2()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallBrakeGrade3')
AddEventHandler('consumables:client:InstallBrakeGrade3', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallBrakeGrade3", "Installing Grade 3 Brakes", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "brake3", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["brake3"], "remove")
        InstallBrakeGrade3()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallBrakeGrade4')
AddEventHandler('consumables:client:InstallBrakeGrade4', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallBrakeGrade4", "Installing Grade 4 Brakes", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "brake4", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["brake4"], "remove")
        InstallBrakeGrade4()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallTransGrade1')
AddEventHandler('consumables:client:InstallTransGrade1', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallTransGrade1", "Installing Grade 1 Transmission", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "trans1", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["trans1"], "remove")
        InstallTransGrade1()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallTransGrade2')
AddEventHandler('consumables:client:InstallTransGrade2', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallTransGrade2", "Installing Grade 2 Transmission", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "trans2", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["trans2"], "remove")
        InstallTransGrade2()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallTransGrade3')
AddEventHandler('consumables:client:InstallTransGrade3', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallTransGrade3", "Installing Grade 3 Transmission", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "trans3", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["trans3"], "remove")
        InstallTransGrade3()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallTransGrade4')
AddEventHandler('consumables:client:InstallTransGrade4', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallTransGrade4", "Installing Grade 4 Transmission", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "trans4", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["trans4"], "remove")
        InstallTransGrade4()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallSuspGrade1')
AddEventHandler('consumables:client:InstallSuspGrade1', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallSuspGrade1", "Installing Grade 1 Suspension", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "susp1", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["susp1"], "remove")
        InstallSuspGrade1()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallSuspGrade2')
AddEventHandler('consumables:client:InstallSuspGrade2', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallSuspGrade2", "Installing Grade 2 Suspension", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "susp2", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["susp2"], "remove")
        InstallSuspGrade2()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallSuspGrade3')
AddEventHandler('consumables:client:InstallSuspGrade3', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallSuspGrade3", "Installing Grade 3 Suspension", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "susp3", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["susp3"], "remove")
        InstallSuspGrade3()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallSuspGrade4')
AddEventHandler('consumables:client:InstallSuspGrade4', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallSuspGrade4", "Installing Grade 4 Suspension", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "susp4", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["susp4"], "remove")
        InstallSuspGrade4()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallSuspGrade5')
AddEventHandler('consumables:client:InstallSuspGrade5', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallSuspGrade5", "Installing Grade 5 Suspension", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "susp5", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["susp5"], "remove")
        InstallSuspGrade5()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallArmGrade1')
AddEventHandler('consumables:client:InstallArmGrade1', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallArmGrade1", "Installing Grade 1 Armour", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "arm1", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["arm1"], "remove")
        InstallArmGrade1()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallArmGrade2')
AddEventHandler('consumables:client:InstallArmGrade2', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallArmGrade2", "Installing Grade 2 Armour", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "arm2", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["arm2"], "remove")
        InstallArmGrade2()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallArmGrade3')
AddEventHandler('consumables:client:InstallArmGrade3', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallArmGrade3", "Installing Grade 3 Armour", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "arm3", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["arm3"], "remove")
        InstallArmGrade3()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallArmGrade4')
AddEventHandler('consumables:client:InstallArmGrade4', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallArmGrade4", "Installing Grade 4 Armour", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "arm4", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["arm4"], "remove")
        InstallArmGrade4()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallArmGrade5')
AddEventHandler('consumables:client:InstallArmGrade5', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallArmGrade5", "Installing Grade 5 Armour", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "arm5", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["arm5"], "remove")
        InstallArmGrade5()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

RegisterNetEvent('consumables:client:InstallArmGrade6')
AddEventHandler('consumables:client:InstallArmGrade6', function()
    local playerVeh = GetPlayersLastVehicle()
    SetVehicleDoorOpen(playerVeh, 4, false, false)
    QBCore.Functions.Progressbar("InstallArmGrade6", "Installing Grade 6 Armour", 10000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(GetPlayerPed(-1), "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("QBCore:Server:RemoveItem", "arm6", 1)
        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["arm6"], "remove")
        InstallArmGrade6()
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mini@repair", "fixing_a_player", 1.0)
        QBCore.Functions.Notify("Failed", "error")
    end)
end)

function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
end

function AcidEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    exports["acidtrip"]:DoAcid(300000)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    startStamina = 0
end

-- Turbo

function InstallTurbo()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    ToggleVehicleMod(myCar, 18, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Turbo Installed", "success")
end

-- Engine Level 1 - 5

function InstallEngineGrade1()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 11, -1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 1 Engine Installed", "success")
end

function InstallEngineGrade2()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 11, 0, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 2 Engine Installed", "success")
end

function InstallEngineGrade3()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 11, 1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 3 Engine Installed", "success")
end

function InstallEngineGrade4()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 11, 2, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 4 Engine Installed", "success")
end

function InstallEngineGrade5()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 11, 3, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 5 Engine Installed", "success")
end

--Brakes Level 1 - 4

function InstallBrakeGrade1()
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 12, -1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 1 Brakes Installed", "success")
end

function InstallBrakeGrade2()
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 12, 0, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 2 Brakes Installed", "success")
end

function InstallBrakeGrade3()
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 12, 1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 3 Brakes Installed", "success")
end

function InstallBrakeGrade4()
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 12, 2, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 4 Brakes Installed", "success")
end

-- Transmission Level 1 - 4 

function InstallTransGrade1()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 13, -1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 1 Transmission Installed", "success")
end

function InstallTransGrade2()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 13, 0, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 2 Transmission Installed", "success")
end

function InstallTransGrade3()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 13, 1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 3 Transmission Installed", "success")
end

function InstallTransGrade4()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 13, 2, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 4 Transmission Installed", "success")
end

-- Suspension Level 1 - 5

function InstallSuspGrade1()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 15, -1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 1 Suspension Installed", "success")
end

function InstallSuspGrade2()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 15, 0, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 2 Suspension Installed", "success")
end

function InstallSuspGrade3()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 15, 1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 3 Suspension Installed", "success")
end

function InstallSuspGrade4()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 15, 2, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 4 Suspension Installed", "success")
end

function InstallSuspGrade5()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 15, 3, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 5 Suspension Installed", "success")
end

-- Armour Level 1 - 6

function InstallArmGrade1()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 16, -1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 1 Armour Installed", "success")
end

function InstallArmGrade2()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 16, 0, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 2 Armour Installed", "success")
end

function InstallArmGrade3()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 16, 1, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 3 Armour Installed", "success")
end

function InstallArmGrade4()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 16, 2, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 4 Armour Installed", "success")
end

function InstallArmGrade5()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 16, 3, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 5 Armour Installed", "success")
end

function InstallArmGrade6()
    local src = source
    local myCar = GetPlayersLastVehicle()
    local UpdateCar = QBCore.Functions.GetVehicleProperties(myCar)
    SetVehicleMod(myCar, 16, 4, true)
    TriggerServerEvent('updateVehicle', UpdateCar)
    SetVehicleDoorShut(myCar, 4, false)
    QBCore.Functions.Notify("Level 6 Armour Installed", "success")
end

--IP END

function JointEffect()
    -- if not onWeed then
    --     local RelieveOdd = math.random(35, 45)
    --     onWeed = true
    --     local weedTime = Config.JointEffectTime
    --     Citizen.CreateThread(function()
    --         while onWeed do 
    --             SetPlayerHealthRechargeMultiplier(PlayerId(), 1.8)
    --             Citizen.Wait(1000)
    --             weedTime = weedTime - 1
    --             if weedTime == RelieveOdd then
    --                 TriggerServerEvent('hud:Server:RelieveStress', math.random(14, 18))
    --             end
    --             if weedTime <= 0 then
    --                 onWeed = false
    --             end
    --         end
    --     end)
    -- end
end

function CrackBaggyEffect()
    local startStamina = 8
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.3)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 60 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 2000), math.random(1000, 2000), 3, 0, 0, 0)
        end
        if math.random(1, 100) < 51 then
            AlienEffect()
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function CokeBaggyEffect()
    local startStamina = 20
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do 
        Citizen.Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            AlienEffect()
            Citizen.Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Citizen.Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Citizen.Wait(math.random(5000, 8000))    
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end
