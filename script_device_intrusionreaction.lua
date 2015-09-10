intrusionDuration = '300'
commandArray = {}

function interestingSortedDevices()
  local devices = {}
  local skip = {
    ['CPU_Usage'] = 1,
    ['General'] = 1,
    ['HDD /'] = 1,
    ['HDD /boot'] = 1,
    ['Internal Temperature'] = 1,
    ['Memory Usage'] = 1,
    ['Unknown'] = 1,
    ['Lux Stairs'] =1,
    ['Lux Livingroom'] = 1,
    ['Temp Livingroom'] = 1,
    ['Temp Stairs'] = 1
  }
  for n in pairs(otherdevices) do
    if (skip[n] == nil) then
      table.insert(devices, n)
    end
  end
  table.sort(devices)
  return devices
end

function collectDeviceInfo()
  local result = ''
  local devices = interestingSortedDevices()
  for _, v in pairs(devices) do
    result = result..string.format('%s : %s', v, otherdevices[v])..'<br>'
  end
  return result
end

-- Variables need to be declared in Web UI first!
lights = {'Light Livingroom East', 'Light Livingroom West'}
rollos = {'Rollo West', 'Rollo SouthWest', 'Rollo South'}
function storeState()
  for _, v in pairs(lights) do commandArray['Variable:'..v] = otherdevices[v] end
  for _, v in pairs(rollos) do commandArray['Variable:'..v] = otherdevices[v] end
end
function restoreState()
  for _, v in pairs(lights) do commandArray[v] = uservariables[v] end
  for _, v in pairs(rollos) do
    if (uservariables[v] == 'Off') then commandArray[v] = 'Off' end
  end
end

if (devicechanged['Intrusion'] == 'On') then
  -- Delayed intrusion could be triggered after disarming.
  if (otherdevices['Armed'] == 'On') then
    storeState()
    commandArray['Intrusion'] = 'Off AFTER '..intrusionDuration
    commandArray['Group:Light Livingroom'] = 'On'
    commandArray['Group:Rollos'] = 'On'
    commandArray['Siren'] = 'On'
    commandArray['SendEmail']='Intrusion detected '..os.date()..'#'..collectDeviceInfo()..'#christian@deger.eu'
    print("**** Alert on")
  else
    -- Turn off
    commandArray['Intrusion'] = 'Off'
  end
elseif (devicechanged['Intrusion'] == 'Off') then
  restoreState()
  commandArray['Siren'] = 'Off'
  print("**** Alert off")
end

-- print("**** commandArray:")
-- for k, v in pairs(commandArray) do print(k..' -> '..v) end

return commandArray
