-- Lua library path for C modules for mldap
package.cpath = request.get_app_basepath() .. "/lib/mldap/?.so" .. ";" .. package.cpath