workspace "Hazel"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"
IncludeDir = {}
IncludeDir["GLFW"] = "Hazel/vendors/glfw/include"

include "Hazel/vendors/glfw"

project "Hazel"
	location "Hazel"
	kind "SharedLib"
	language "C++"
	
	targetdir("bin/" .. outputdir .. "/%{prj.name}")
	-- objdir("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
	pchsource "src/hzpch.cpp"

	files
	{
		"src/**.h",
		"src/**cpp"
	}

	includedirs 
	{
		"src",	
		"%{prj.name}/vendors/spdlog/include/",
		"%{IncludeDir.GLFW}"
	}

	links
	{
		"GLFW",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL",
			"_WINDLL"
		}

		postbuildcommands
		{
			-- ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "../../Sandbox/bin/%{cfg.buildtarget.relpath}/Sandbox/")
			("{COPY} C:/Users/kashy/source/repos/Hazel/bin/Release-windows-x86_64/Hazel/ C:/Users/kashy/source/repos/Sandbox/bin/Release-windows-x86_64/Sandbox/")
		}

		filter "configurations:Debug"
			defines "HZ_DEBUG"
			symbols "On"

		filter "configurations:Release"
			defines "HZ_RELEASE"
			optimize "On"

		filter "configurations:Debug"
			defines "HZ_RELEASE"
			optimize "On"

		filter { "system:windows", "configurations:Release" }
			buildoptions "/MT"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	
	targetdir("../%{prj.name}/bin/" .. outputdir .. "/%{prj.name}")
	-- targetdir("../%{prj.name}/bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"../%{prj.name}/src/**.h",
		"../%{prj.name}/src/**cpp"
	}

	includedirs
	{
		"Hazel/vendors/spdlog/include/",
		"src/"
	}

	links
	{
		"Hazel"
	}

	filter "system:windows"
		cppdialect "C++20"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HZ_PLATFORM_WINDOWS",
		}
	
	filter "configurations:Debug"
			defines "HZ_DEBUG"
			symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"

	filter "configurations:Debug"
		defines "HZ_RELEASE"
		optimize "On"

	filter { "system:windows", "configurations:Release" }
		buildoptions "/MT"
