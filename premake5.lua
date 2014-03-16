function defaultAction(osName, actionName)
  if os.is(osName) then
    _ACTION = _ACTION or actionName
  end
end

defaultAction("linux", "gmake")

solution "projectname"
  configurations { "Release", "Debug" }
  flags { "FatalWarnings" }
  warnings "Extra"
  includedirs { "src" }
  location "build"

  configuration "gmake"
    buildoptions "-std=c++11"

  configuration "Debug"
    defines { "DEBUG" }
    flags { "Symbols" }
    targetdir "build/bin/debug"

  configuration "Release"
    optimize "On"
    targetdir "build/bin/release"

  project "gmock"
    kind "StaticLib"
    language "C++"
    includedirs {
      "external/googletest/include",
      "external/googletest",
      "external/googlemock/include",
      "external/googlemock"
    }
    files {
      "external/googletest/src/gtest-all.cc",
      "external/googletest/src/gtest_main.cc",
      "external/googlemock/src/gmock-all.cc"
    }
    buildoptions { "-Wno-missing-field-initializers" } -- NOTE: this may be problematic when supporting more platforms

  project "consoleapp"
    kind "ConsoleApp"
    language "C++"
    files { "src/main.cpp" }
    links { "staticlib" }

  project "staticlib"
    kind "StaticLib"
    language "C++"
    files { "src/**" }
    excludes { "src/main.cpp" }

  project "test"
    kind "ConsoleApp"
    language "C++"
    includedirs { "external/googletest/include", "external/googlemock/include" }
    files { "test/**" }
    links { "staticlib", "gmock", "pthread" }
