commandArray = {}

if (devicechanged['KFOB-C-1'] == 'On') then
  commandArray['Group:Light Livingroom'] = 'On'
elseif (devicechanged['KFOB-C-3'] == 'On') then
  commandArray['Group:Light Livingroom'] = 'Off'
end

return commandArray
