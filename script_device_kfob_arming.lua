commandArray = {}

if (devicechanged['KFOB-C-1'] == 'On') then
  commandArray['Armed'] = 'On'
elseif (devicechanged['KFOB-C-3'] == 'On') then
  commandArray['Armed'] = 'Off'
end

return commandArray
