-- bot.lua - NEKERAFA - 8th february 2022
-- An example of Twitch bot using twitch.lua library
--
-- Under GNU General Public License v3.0
-- Copyright (c) 2022 - Rafael Alcalde Azpiazu (NEKERAFA)

require "packages"
require "auth"

local twitch = require "twitch.twitch"

-- Connects to Twitch server
local client = twitch.connect(_USERNAME, _TOKEN_AUTH)

-- Creates an "echo" command
local function echo(client, channel, username, ...)
    local msg = ""
    for _, value in ipairs({...}) do
        msg = msg .. value .. " "
    end

    client:send(channel, string.format("@%s %s", username, msg))
end

-- Joins to our channel
client:join(_CHANNEL)
-- Sends a message in our channel
client:send(_CHANNEL, "Hello world!")
-- Adds a command
client:attach("echo", _CHANNEL, echo)
-- Adds a not found command
function client:commandnotfound(channel, _, command)
    self:send(channel, string.format("Command !%s not found", command))
end
-- Adds a timer
client:settimer("timer", 2 * 30, function ()
    client:send(_CHANNEL, "A timer!! :)")
end)

-- Runs commands
client:loop()
