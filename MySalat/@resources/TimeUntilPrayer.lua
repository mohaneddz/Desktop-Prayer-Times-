function Initialize()
    -- Script will update on every update cycle
end

function Update()
    -- Get current and target times
    local targetTimeStr = SELF:GetOption('TargetTime')
    local currentTimeStr = SELF:GetOption('CurrentTime')
    
    -- Check if either string is empty or nil
    if not targetTimeStr or targetTimeStr == "" or not currentTimeStr or currentTimeStr == "" then
        return "Calculating..."
    end
    
    -- Parse hours and minutes
    local targetHours, targetMinutes = string.match(targetTimeStr, "(%d+):(%d+)")
    local currentHours, currentMinutes = string.match(currentTimeStr, "(%d+):(%d+)")
    
    -- Convert to numbers
    targetHours = tonumber(targetHours)
    targetMinutes = tonumber(targetMinutes)
    currentHours = tonumber(currentHours)
    currentMinutes = tonumber(currentMinutes)
    
    -- Calculate total minutes for each
    local targetTotalMinutes = targetHours * 60 + targetMinutes
    local currentTotalMinutes = currentHours * 60 + currentMinutes
    
    -- Handle overnight case (if target time is before current time)
    if targetTotalMinutes < currentTotalMinutes then
        targetTotalMinutes = targetTotalMinutes + 24 * 60  -- Add 24 hours
    end
    
    -- Calculate difference in minutes
    local diffMinutes = targetTotalMinutes - currentTotalMinutes
    
    -- Convert to hours and minutes
    local hoursRemaining = math.floor(diffMinutes / 60)
    local minutesRemaining = diffMinutes % 60
    
    -- Format the output
    local result
    if hoursRemaining > 0 then
        result = string.format("%dh %dm remaining", hoursRemaining, minutesRemaining)
    else
        result = string.format("%dm remaining", minutesRemaining)
    end
    
    return result
end