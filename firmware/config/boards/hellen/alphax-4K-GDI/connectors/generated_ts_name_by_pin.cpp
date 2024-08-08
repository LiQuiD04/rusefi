//DO NOT EDIT MANUALLY, let automation work hard.

// auto-generated by PinoutLogic.java based on config/boards/hellen/alphax-4K-GDI/connectors/gdi-A.yaml
// auto-generated by PinoutLogic.java based on config/boards/hellen/alphax-4K-GDI/connectors/gdi-B.yaml
#include "pch.h"

// see comments at declaration in pin_repository.h
const char * getBoardSpecificPinName(brain_pin_e brainPin) {
	switch(brainPin) {
		case Gpio::C13: return "14A Ignition 1";
		case Gpio::D2: return "5B MAIN";
		case Gpio::E3: return "11A Ignition 4";
		case Gpio::E4: return "12A Ignition 3";
		case Gpio::E5: return "13A Ignition 2";
		case Gpio::G11: return "7B Fuel Pump";
		default: return nullptr;
	}
	return nullptr;
}
