local stage = 0
local movingForward = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local ped = PlayerPedId()
        if not IsPedSittingInAnyVehicle(ped) and not IsPedFalling(ped) then
            if IsControlJustReleased(0, 36) then
                stage = stage + 1
                if stage == 1 then
                    -- Crouch stuff
                    ClearPedTasks(ped)
                    RequestAnimSet("move_ped_crouched")
                    while not HasAnimSetLoaded("move_ped_crouched") do
                        Citizen.Wait(0)
                    end

                    SetPedMovementClipset(ped, "move_ped_crouched",1.0)    
                    SetPedWeaponMovementClipset(ped, "move_ped_crouched",1.0)
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing",1.0)
                elseif stage > 2 then
                    stage = 0
                    ClearPedTasksImmediately(ped)
                    ResetAnimSet()
                    SetPedStealthMovement(ped,0,0)
                end
            end

            if stage == 1 then
                if GetEntitySpeed(ped) > 1.0 then
                    SetPedWeaponMovementClipset(ped, "move_ped_crouched",1.0)
                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing",1.0)
                elseif GetEntitySpeed(ped) < 1.0 and (GetFollowPedCamViewMode() == 4 or GetFollowVehicleCamViewMode() == 4) then
                    ResetPedWeaponMovementClipset(ped)
                    ResetPedStrafeClipset(ped)
                end
            end
        else
            stage = 0
            Citizen.Wait(1000)
        end
    end
end)

local walkSet = "default"
RegisterNetEvent("crouchprone:client:SetWalkSet")
AddEventHandler("crouchprone:client:SetWalkSet", function(clipset)
    walkSet = clipset
end)


function ResetAnimSet()
    local ped = PlayerPedId()
    if walkSet == "default" then
        ResetPedMovementClipset(ped)
        ResetPedWeaponMovementClipset(ped)
        ResetPedStrafeClipset(ped)
    else
        ResetPedMovementClipset(ped)
        ResetPedWeaponMovementClipset(ped)
        ResetPedStrafeClipset(ped)
        Citizen.Wait(100)
        RequestWalking(walkSet)
        SetPedMovementClipset(ped, walkSet, 1)
        RemoveAnimSet(walkSet)
    end
end

function RequestWalking(set)
    RequestAnimSet(set)
    while not HasAnimSetLoaded(set) do
        Citizen.Wait(1)
    end 
end