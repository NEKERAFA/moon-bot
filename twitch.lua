-- twitch.lua - NEKERAFA - 8th february 2022
-- A wrapper of Twitch IRC API using LuaSocket and LuaSec
--
-- Under GNU General Public License v3.0
-- Copyright (c) 2022 - Rafael Alcalde Azpiazu (NEKERAFA)

local socket = require "socket"
local ssl = require "ssl"

local params <const> = {
    mode = "client",
    protocol = "any",
    cafile = "/etc/ssl/certs/ca-certificates.crt",
    verify = "peer",
    options = "all"
}

local await_time <const> = 2

local function print_recv(data)
    for _, str in ipairs(data) do
        print(string.format("> %s", str))
    end
end

local function print_send(data)
    print(string.format("< %s", data))
end

local function receive(conn)
    local data = {}
    local recv

    conn:settimeout(await_time)
    while not recv do
        recv = conn:receive("*l")
        if not recv then
            break
        end

        table.insert(data, recv)
        recv = nil
    end
    conn:settimeout()

    if (#data > 0) then print_recv(data) end

    return data
end

local twitch = {
    join = function (self, channel)
        table.insert(self.channels, channel)
        print_send(string.format("JOIN #%s", channel))
        assert(self.socket:send(string.format("JOIN #%s\r\n", channel)))
        print()

        receive(self.socket)
        print()
    end,

    leave = function (self, channel)
        local index = -1
        for i, chl in ipairs(self.channels) do
            if chl == channel then
                index = i
                break
            end
        end

        if index > -1 then
            table.remove(self.channels, index)
            print_send(string.format("PART #%s", channel))
            assert(self.socket:send(string.format("PART #%s\r\n", channel)))
            print()

            receive(self.socket)
            print()
        end
    end,

    message = function (self, channel, text)
        if text == nil then
            for _, chl in ipairs(self.channels) do
                print_send(string.format("PRIVMSG #%s :%s", chl, channel))
                assert(self.socket:send(string.format("PRIVMSG #%s :%s\r\n", chl, channel)))
                print()
            end
        else
            print_send(string.format("PRIVMSG #%s :%s", channel, text))
            assert(self.socket:send(string.format("PRIVMSG #%s :%s\r\n", channel, text)))
            print()
        end
    end,

    insert = function (self, command, func_command)
    end,

    remove = function (self, command)
    end,

    close = function (self)
        for _, channel in ipairs(self.channels) do
            self:leave(channel)
        end

        print("socket closed")
        self.socket:close()
    end,
}

return setmetatable({ 
    connect = function (nickname, token)
        local obj = setmetatable({
            channels = {},
            commands = {}
        }, {
            __index = twitch,
            __close = twitch.close 
        })
        
        local sock = socket.connect("irc.chat.twitch.tv", 6697)

        obj.socket = assert(ssl.wrap(sock, params))
        assert(obj.socket:dohandshake())

        print_send("PASS ****")
        obj.socket:send(string.format("PASS %s\r\n", token))
        print_send(string.format("NICK %s", nickname))
        obj.socket:send(string.format("NICK %s\r\n", nickname))
        print()

        receive(obj.socket)
        print()

        return obj
    end
}, { __index = twitch })
