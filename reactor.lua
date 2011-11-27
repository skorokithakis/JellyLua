function Ready()
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
        if MainLoop then MainLoop() end
    end
end

Ready()
EventLoop()
