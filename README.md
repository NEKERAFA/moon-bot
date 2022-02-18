# moon-bot
🤖 A twitch bot powered by Lua 🌑

[![Powered by Lua](https://img.shields.io/badge/powered%20by-Lua-blue?logo=)](https://www.lua.org/) [![GitHub license](https://img.shields.io/github/license/NEKERAFA/moon-bot)](https://github.com/NEKERAFA/moon-bot/blob/main/LICENSE)

## Dependencies

- [Lua 5.4](http://www.lua.org/)
- [LuaSocket](https://github.com/diegonehab/luasocket)
- [LuaSec](https://github.com/brunoos/luasec)
- [twitch.lua](https://github.com/NEKERAFA/twitch.lua)

### Installing dependencies

**Using LuaRocks**

```sh
git submodule update --init
luarocks install luasocket --tree rocks
luarocks install luasec --tree rocks
```

## Configuration

To configure this proyect, you must create a `auth.lua` file containing the following values:

```lua
_USERNAME = "<BOT_USERNAME>" -- The account that uses to send message
_TOKEN_AUTH = "<OATH_TOKEN>" -- The token to authenticate your bot with Twitch's servers
_CHANNEL = "<CHANNEL_NAME>" -- The Twitch channel name where you want to run the bot.
```

> Note: Bot username and channel name may be the same. Also, many streamers choose to create another account to their bots.
