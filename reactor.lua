function InitSensors()
    if not SENSORS then return end

    for port, sensor in pairs(SENSORS) do
        nxt.InputSetType(port, sensor.type, sensor.mode)
    end
end

function Ready()
    InitSensors()

    nxt.DisplayClear()
    Print("NXT ready!")

    -- Check that the Initialize function actually exists and run it.
    if Initialize then Initialize() end
end

function Print(text)
    nxt.DisplayScroll()
    nxt.DisplayText(text .. "\n")
end

function EventLoop()
    local last_button = 0
    local current_button
    local sensor_values = {}
    local current_value

    while true do
        current_button = nxt.ButtonRead()
        if last_button ~= current_button then
            if current_button ~= 0 then
                if OnButtonPress then OnButtonPress(current_button) end
            else
                if OnButtonRelease then OnButtonRelease(last_button) end
            end
            last_button = current_button
        end

        -- Handle sensor callbacks.
        if SENSORS then
            for port, sensor in pairs(SENSORS) do
                -- Check the touch sensor events, making sure that the callback
                -- exists first.
                if sensor.type == 1 and TouchSensorEvent then
                    current_value = nxt.InputGetStatus(port)

                    -- Initialize the old value.
                    if not sensor_values[port] then
                        sensor_values[port] = current_value
                    end

                    if (nxt.abs(sensor_values[port] - current_value) > 500) then
                        sensor_values[port] = current_value
                        TouchSensorEvent(port, current_value)
                    end
                end
            end
        end

        -- Call the MainLoop callback.
        if MainLoop then MainLoop() end
    end
end

Ready()
EventLoop()
