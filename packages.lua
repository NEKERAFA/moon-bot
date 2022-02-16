local lua_version = _VERSION:match("%d+%.%d+")

_DEBUG = true

package.path = './rocks/share/lua/' .. lua_version .. '/?.lua;' .. package.path
package.path = './rocks/share/lua/' .. lua_version .. '/?/init.lua;' .. package.path
package.path = './deps/?.lua;' .. package.path
package.cpath = './rocks/lib/lua/' .. lua_version .. '/?.so;' .. package.cpath
package.cpath = './rocks/lib/lua/' .. lua_version .. '/?.dll;' .. package.cpath
