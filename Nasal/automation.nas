var init = func {
	print("Init flight surfaces automation ...done");
	main_loop();
}

# Setup listener call to start update loop once the fdm is initialized
setlistener("sim/signals/fdm-initialized", init);

var reinit = func {
	setprop("/controls/flight/speedbrake", 0);
	print("ReInit flight surfaces automation ...done");
	
}
setlistener("/sim/signals/reinit", reinit);

#main loop
var main_loop = func {
	check_airspeed();
	settimer(main_loop, 0);
}

var	check_airspeed = func {
    var ac_speed_mach = getprop("/velocities/mach");
    var controls_speedbrake = getprop("/controls/flight/speedbrake");
	var ac_airspeed = getprop("/instrumentation/airspeed-indicator/indicated-speed-kt");
	var controls_flaps = getprop("/controls/flight/flaps");
	if (ac_speed_mach >0.79 and controls_speedbrake !=1){
		setprop("/controls/flight/speedbrake", 1);
        #screen.log.write("Overspeed! Speedbrake autodeployed!", 1, 0, 0);
	}
	else {
		if(ac_airspeed >189 and controls_flaps >0){
			setprop("/controls/flight/flaps",0);
			#screen.log.write("Flaps autoretracted!", 1, 0, 0);
		}
	}
}


