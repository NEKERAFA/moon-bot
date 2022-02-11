-- bot.lua - NEKERAFA - 8th february 2022
-- An example of Twitch bot using twitch.lua library
--
-- Under GNU General Public License v3.0
-- Copyright (c) 2022 - Rafael Alcalde Azpiazu (NEKERAFA)

local twitch = require "twitch.twitch"
require "auth"

-- Connect to Twitch server
local client = twitch.connect(_USERNAME, _TOKEN_AUTH)

-- Join to our channel
client:join(_CHANNEL)
-- Send a message in our channel
client:message(_CHANNEL, "Hello world!")
-- Leave our channel
client:leave(_CHANNEL)
-- Closes client
client:close()