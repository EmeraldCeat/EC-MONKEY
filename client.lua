local emerald = vector3(-1344.1509, -1443.3422, 4.4111)

Citizen.CreateThread(function()
  for k, v in pairs(Config.MonkeyCoords) do
    RequestModel(GetHashKey(v[7]))
    while not HasModelLoaded(GetHashKey(v[7])) do
      Wait(1)
    end
    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
      Wait(1)
    end
    ped = CreatePed(4, v[6],v[1],v[2],v[3], 3374176, false, true)
    SetEntityHeading(ped, v[5])
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
end)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    if onScreen then
        SetTextScale(0.0, 0.40)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local kolkodalece = 2000

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

          if Vdist2(GetEntityCoords(PlayerPedId(), false), emerald) < 13 then
              Draw3DText(emerald.x,emerald.y,emerald.z, "E")
              if IsControlJustPressed(0, 38) then
                TriggerEvent('ec-monkey:Armor')
                TriggerEvent('ec-monkey:Health')
            end
        end
    end
end)

RegisterNetEvent('ec-monkey:Armor')
AddEventHandler('ec-monkey:Armor', function ()
    local player = GetPlayerPed(-1)
    local maxHealth = GetEntityMaxHealth(playerPed)
    if GetPedArmour(player) > 49 then
  else
    GetPedArmour(player)
        SetPedArmour(player, 100)
  end
end)

RegisterNetEvent('ec-monkey:Health')
AddEventHandler('ec-monkey:Health', function ()
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	local health = GetEntityHealth(playerPed)
	SetEntityHealth(playerPed, maxHealth)
end)