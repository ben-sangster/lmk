require "lmkbuild"
require "common_c" -- set up cc env vars

local add_files = lmkbuild.add_files
local clean_obj = common_c.clean_obj
local create_file_lists = common_c.create_file_lists
local exec = lmkbuild.exec

module (...)

function main (files)
   create_file_lists (files, "$(lmk.cppExec)")
end

function test (files)
   main (files)
end

function clean (files)
   clean_obj (files)
end

function clobber (files)
   clean_obj (files)
end

