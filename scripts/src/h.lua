require "lmkbuild"

local assert = assert
local append = lmkbuild.append_local
local cp = lmkbuild.cp
local file_newer = lmkbuild.file_newer
local ipairs = ipairs
local is_valid = lmkbuild.is_valid
local mkdir = lmkbuild.mkdir
local print = print
local resolve = lmkbuild.resolve
local rm = lmkbuild.rm
local split = lmkbuild.split
local sys = lmkbuild.system ()
local verbose = lmkbuild.verbose

module (...)

function main (files)
   if sys == "iphone" then
      mkdir ("$(lmk.includeDir)dmz/")
      append ("localIncludes", "$(lmk.includePathFlag)$(lmk.includeDir)dmz/")
   else
      mkdir ("$(lmk.includeDir)$(name)")
      append ("localIncludes", "$(lmk.includePathFlag)$(lmk.includeDir)$(name)/")
   end
   for index, item in ipairs (files) do
      local file = nil
      local item = resolve (item)
      local p, f, e = split (item)
      if sys == "iphone" then file = "$(lmk.includeDir)dmz/" .. f .. "." .. e
      else
         file = "$(lmk.includeDir)$(name)/" .. f
         if e then file = file .. "." .. e end
      end
      if file_newer (item, file) then
         if verbose () then  print ("Exporting: " .. item) end
         assert (
            cp (item, file),
            "Failed copying file: " .. item .. " to " .. resolve (file))
      end
   end
end

function test (files)
   main (files)
end

function clean (files)
   for index, item in ipairs (files) do
      local file = nil
      local p, f, e = split (item)
      if sys == "iphone" then file = resolve ("$(lmk.includeDir)dmz/" .. f .. "." .. e)
      else
         file = "$(lmk.includeDir)$(name)/" .. f
         if e then file = file .. "." .. e end
      end
      if is_valid (file) then rm (file) end
   end
end

function clobber (files)
   clean (files)
end
