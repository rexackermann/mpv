function on_speed_change(name, value)
    speed=mp.get_property_native("speed")
    if speed == 1 then
        mp.set_property("speed", "2")
    elseif speed == 2 then
    	mp.set_property("speed", "3")
    elseif speed == 3 then
    	mp.set_property("speed", "1")
    else
    	mp.set_property("speed", "2")
    end
    speed=mp.get_property_native("speed")
    mp.osd_message(speed, 1)
end
mp.add_key_binding(nil, "speed", on_speed_change)
-- mp.add_forced_key_binding("\\", "float", on_speed_change)


