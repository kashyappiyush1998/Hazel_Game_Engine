#pragma once


#ifdef HZ_PLATFORM_WINDOWS
extern Hazel::Application* Hazel::CreateApplication();

int main() {
	Hazel::Log::Init();
	HZ_CORE_WARN("Initialized Log!");
	HZ_CORE_INFO("Hello!");

	int a = 5;
	HZ_CORE_INFO("Hello! Var={0}", a);

	auto app = Hazel::CreateApplication();
	app->Run();
	delete app;

	return 0;
}

#endif 
