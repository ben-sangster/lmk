#!/home/rebarker/lua-5.1.2/src/lua

local info = {}

info.src = "lmkbase.c"

local cpp = ""
local link = ""

if arg[1] == "macos" then
   info.lua_lib = "/Users/barker/devel/src/lua-5.1.1/src"
   info.lua_inc = "/Users/barker/devel/src/lua-5.1.1/src"
   cpp = nil
   link =
      'export MACOSX_DEPLOYMENT_TARGET="10.3"; gcc -arch i386 -arch ppc ' ..
      "-bundle -undefined dynamic_lookup " ..
      " -I" .. info.lua_inc .. " " ..
      info.src .. "  -o lmkbase.so"
elseif arg[1] == "linux" then
   info.lua_lib = "/home/rebarker/lua-5.1.2/src"
   info.lua_inc = "/home/rebarker/lua-5.1.2/src"
   cpp = nil
   link =
      "gcc -shared "  ..
      " -I" .. info.lua_inc .. " " ..
      info.src .. "  -o lmkbase.so"
elseif arg[1] == "win32" then
   info.lua_lib = 'c:/cygwin/home/"Randall Barker"/lua-5.1.1/src'
   info.lua_inc = 'c:/cygwin/home/"Randall Barker"/lua-5.1.1/src'
   cpp = "cl /nologo /O2 /W3 /c /D_CRT_SECURE_NO_DEPRECATE /I" .. info.lua_inc .. " " .. info.src
   link = "link /nologo /DLL /LIBPATH:" .. info.lua_lib .. " lua51.lib lmkbase.obj /out:lmkbase.dll"
else
   print ("Error: Unknown platform type: " .. (arg[1] or "None specified"));
   os.exit (-1)
end

if cpp then print (cpp); os.execute (cpp) end
if link then print (link); os.execute (link) end

