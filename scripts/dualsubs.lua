local options = require 'mp.options'

local o = {
     save_period = 10,
     disabled = false
}

options.read_options(o)

if o.disabled then
     msg.verbose("stopping: autoload disabled")
     return
end


secondarySubtitleLanguages = { "jpn", "eng" }

function setSecondarySubtitle()
     local languagePriorities = {}
     for index, language in ipairs(secondarySubtitleLanguages) do
          languagePriorities[language] = index
     end

     local secondaryTrackNumber
     for trackNumber = 0, mp.get_property_number("track-list/count") do
          if getTrackListProperty("type", trackNumber) == "sub" then
               local trackLang = getTrackListProperty("lang", trackNumber)

               if languagePriorities[trackLang] and
                   (
                   not secondaryTrackNumber or
                       languagePriorities[trackLang] <
                       languagePriorities[getTrackListProperty("lang", secondaryTrackNumber)]) then
                    secondaryTrackNumber = trackNumber
               end
          end
     end

     if secondaryTrackNumber then
          mp.set_property_number("secondary-sid", getTrackListProperty("id", secondaryTrackNumber))
     else
          print("No suitable secondary subtitle found.")
     end
end

function getTrackListProperty(subProperty, trackNumber)
     return mp.get_property("track-list/" .. trackNumber .. "/" .. subProperty)
end

mp.register_event("file-loaded", setSecondarySubtitle)
