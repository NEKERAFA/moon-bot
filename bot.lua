-- bot.lua - NEKERAFA - 8th february 2022
-- An example of Twitch bot using twitch.lua wrapper
--
-- Under GNU General Public License v3.0
-- Copyright (c) 2022 - Rafael Alcalde Azpiazu (NEKERAFA)

local twitch = require "twitch"
require "auth"

-- Connect to Twitch server
local client <close> = twitch.connect(_NICKNAME, _TOKEN_AUTH)

-- Join to our channel
client:join("nekerafa")
-- Send a message in our channel
client:message("nekerafa", "hello world")
-- Leave our channel
client:leave("nekerafa")
