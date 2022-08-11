#pragma once

#include "Core.h"
#include "Events/Event.h"

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
