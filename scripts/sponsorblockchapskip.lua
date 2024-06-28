local mp = require 'mp'

-- Function to get the total number of chapters
function getTotalChapters()
    local chapters = {}
    -- Assuming chapters are stored under the 'chapters' tag in mpv's properties
    local props = mp.get_property_number('chapters')
    if props then
        for i = 1, props do
            table.insert(chapters, i)
        end
        return #chapters
    else
        return 0
    end
end

function go_to_end_of_video()
    -- Check if the current time is near the end of the video
    local duration = mp.get_property_number("duration")
    -- local current_time = mp.get_property_number("time-pos")
    mp.command(string.format('seek %f', duration))
end

function string_contains(str1, str2)
    -- Split str2 into words
    local words = {}
    for word in string.gmatch(str2, "%S+") do
        table.insert(words, word)
    end

    -- Check if any word from str2 exists in str1
    for _, word in ipairs(words) do
        if str1:find(word) then
            return true
        end
    end

    return false
end

function skippp()
  local chapters = mp.get_property_number("chapter")
  local chapter_count = getTotalChapters()
  -- print(getTotalChapters())
  if chapters then
          local chapter_num = mp.get_property("chapter")
          -- local title = mp.get_property_string("chapter-title", i)
		      local title_str ="chapter-list/" .. chapter_num .. "/title"
      		local title = mp.get_property(title_str)
          -- print("Chapter Title ".. i.. ": ".. title)
          local str1 = "Sponsor"
          -- print(chapter_count .. "eof")
          if string_contains(title, str1) then
            print(chapter_num)
            print(chapter_count)
            matched_num = chapter_num + 1
            -- print("str2 is contained in str1")
            if matched_num == chapter_count then
              print("eofd")
              go_to_end_of_video()
            else
              print(title .. " skipped")
              mp.set_property("chapter", chapter_num + 1)
            end
          else
            -- print("str2 is not contained in str1")
end
  else
      print("No chapters found.")
  end
end

mp.add_periodic_timer(1, skippp)
