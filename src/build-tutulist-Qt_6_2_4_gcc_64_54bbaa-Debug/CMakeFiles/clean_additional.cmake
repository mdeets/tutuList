# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/tutulist_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/tutulist_autogen.dir/ParseCache.txt"
  "tutulist_autogen"
  )
endif()
