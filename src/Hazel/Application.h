#pragma once

#include "Core.h"

namespace Hazel {
	class HAZEL_API Application
	{
	public:
		Application();

		void Run();

		virtual ~Application();

	};

	//To be defined in client
	Application* CreateApplication();

}
