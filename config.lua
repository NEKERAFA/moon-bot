local lua_version = _VERSION:match("%d+%.%d+")

_DEBUG = true

package.path = 'dependencies/share/lua/' .. lua_version .. '/?.lua;' .. package.path
package.path = 'dependencies/share/lua/' .. lua_version .. '/?/init.lua;' .. package.path
package.cpath = 'dependencies/lib/lua/' .. lua_version .. '/?.so;' .. package.cpath
package.cpath = 'dependencies/lib/lua/' .. lua_version .. '/?.dll;' .. package.cpath
