-- bot.lua - NEKERAFA - 8th february 2022
-- An example of Twitch bot using twitch.lua library
--
-- Under GNU General Public License v3.0
-- Copyright (c) 2022 - Rafael Alcalde Azpiazu (NEKERAFA)

require "packages"
require "auth"

local twitch = require "twitch.twitch"

-- Connect to Twitch server
local client = twitch.connect(_USERNAME, _TOKEN_AUTH)

-- Create a echo command
local function echo(client, channel, username, ...)
    local msg = ""
    for _, value in ipairs({...}) do
        msg = msg .. value .. " "
    end

    client:send(channel, string.format("@%s %s", username, msg))
end

-- Join to our channel
client:join(_CHANNEL)
-- Send a message in our channel
client:send(_CHANNEL, "Hello world!")
-- Add a command
client:attach("echo", _CHANNEL, echo)
-- Add a not found command
function client:commandnotfound(channel, username, command)
    self:send(channel, string.format("Command !%s not found", command))
end

-- Run commands
client:loop()
