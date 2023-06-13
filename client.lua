local Monkeys = {
  [1] = {
      coords = vec3(-1344.1509, -1443.3422, 3.1111),
      "Monkey",
      heading = 215.6034,
      model = 'a_c_chimp'
  }
};

CreateThread(function()
  for i = 1, #Monkeys do
    local monkey = Monkeys[i];
    local model = monkey.model;
    RequestModel(model)
    while not HasModelLoaded(model) do
      Wait(10);
    end 

    local dict = 'mini@strip_club@idles@bouncer@base';
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Wait(10);
    end

    local coords = monkey.coords;
    monkey.ped = CreatePed(4, model, coords.x, coords.y, coords.z, 3374176, false, true);
    SetEntityHeading(monkey.ped, monkey.heading);
    FreezeEntityPosition(monkey.ped, true);
    SetEntityInvincible(monkey.ped, true);
    SetBlockingOfNonTemporaryEvents(monkey.ped, true);
    TaskPlayAnim(monkey.ped, dict, 'base', 8.0, 0.0, -1, 1, 0, false, false, false);
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

CreateThread(function()
    while true do
        for i = 1, #Monkeys do
          local monkey = Monkeys[i];
          local coords = monkey.coords;
          local distance = #(coords - GetEntityCoords(PlayerPedId()));
          if distance <= 10 then
            Draw3DText(coords.x, coords.y, coords.z, '[E] To maxHealth');
            if IsControlJustPressed(0, 38) then
              SetPedArmour(PlayerPedId(), 100)
              local maxHealth = GetEntityMaxHealth(PlayerPedId());
              SetEntityHealth(PlayerPedId(), maxHealth);
            end
          end
          break;
        end
        Wait(3);
    end
end)