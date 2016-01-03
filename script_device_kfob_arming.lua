commandArray = {}

armingDelay = '30'

if (devicechanged['KFOB-C-1'] == 'On') then
  commandArray['Armed'] = 'On AFTER '..armingDelay
elseif (devicechanged['KFOB-C-3'] == 'On') then
  commandArray['Armed'] = 'Off'
  commandArray['Intrusion'] = 'Off'
end

return commandArray
