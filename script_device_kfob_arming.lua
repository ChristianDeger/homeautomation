commandArray = {}

if (devicechanged['KFOB-C-1'] == 'On') then
  commandArray['Light Livingroom'] = 'On'
elseif (devicechanged['KFOB-C-3'] == 'On') then
  commandArray['Light Livingroom'] = 'On'
end

return commandArray
