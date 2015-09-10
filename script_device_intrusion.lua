detectionDelay = '30'

function detectImmediateIntrusion(dc)
  if (dc['Motion Livingroom'] == 'On') then return true
  elseif (dc['Tamper Livingroom'] == 'On') then return true
  elseif (dc['Tamper Stairs'] == 'On') then return true
  elseif (dc['Door South'] == 'Open') then return true
  elseif (dc['Door West'] == 'Open') then return true
  else return false
  end
end

function detectDelayedIntrusion(dc)
  if (dc['Motion Stairs'] == 'On') then return true
  elseif (dc['Door Front'] == 'Open') then return true
  else return false
  end
end

commandArray = {}

if (devicechanged['Armed'] == 'Off') then
  commandArray['Intrusion'] = 'Off'
  print('**** Armed off -> Intrusion off')
else
  isImmediateIntrusion = detectImmediateIntrusion(devicechanged)
  isDelayedIntrusion = detectDelayedIntrusion(devicechanged)
  if (isImmediateIntrusion or isDelayedIntrusion) then
    if (otherdevices['Armed'] == 'On' and otherdevices['Intrusion'] == 'Off') then
      if (isImmediateIntrusion) then
        commandArray['Intrusion'] = 'On'
        print("**** Immediate Intrusion")
      else
        commandArray['Intrusion'] = 'On AFTER '..detectionDelay
        print("**** Delayed Intrusion")
      end
    end
  end
end

return commandArray
