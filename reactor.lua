function Initialize()
    nxt.DisplayClear()
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
                OnButtonPress(current_button)
            else
                OnButtonRelease(last_button)
            end
            last_button = current_button
        end
    end
end

Initialize()
Print("NXT ready!")
EventLoop()
