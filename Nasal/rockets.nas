
props.globals.initNode("/sim/is-MP-Aircraft", 0, "BOOL");

#GSh-23 cannon trigger

#initialize triggers
props.globals.initNode("/controls/armament/pickle", 0, "BOOL");
setprop("/controls/armament/pickle", 0);


props.globals.initNode("/controls/armament/trigger-S-5-L", 0, "BOOL");
props.globals.initNode("/controls/armament/trigger-S-5-R", 0, "BOOL");

props.globals.initNode("/sim/multiplay/generic/int[9]", 0, "INT");
props.globals.initNode("/sim/multiplay/generic/int[10]", 0, "INT");

#ammo counter
props.globals.initNode("/controls/armament/rocketsLeft", 16, "INT");
props.globals.initNode("/controls/armament/rocketsCount", 16, "DOUBLE");
var reload = func {
	if( getprop("/gear/gear[0]/wow") and getprop("/gear/gear[1]/wow") and getprop("/gear/gear[2]/wow") and (getprop("/velocities/groundspeed-kt") < 2) ) {
		setprop("/controls/armament/rocketsLeft", 16);
		setprop("/controls/armament/rocketsCount", 16);
		screen.log.write("S-5 rockets reloaded (16 rockets per pod)", 1, 0.6, 0.1);
	}
	else {
		screen.log.write("You must be still on the ground to reaload! ", 1, 0.6, 0.1);
	}
}

#A resource friendly way of ammo counting: Instead of counting every bullet, I set an interpolate on float variant of ammo counter. But I need a timer to cut off fire when out of ammo. 

var outOfAmmo = maketimer(1.0, 
	func { 
		#print("Out of rockets! ");
		screen.log.write("UB-16 out of rockets! ", 1, 0.6, 0.1);
		setprop("/controls/armament/trigger-S-5-L", 0);
		setprop("/controls/armament/trigger-S-5-R", 0);
        setprop("/sim/multiplay/generic/int[9]", 0);
        setprop("/sim/multiplay/generic/int[10]", 0);
		setprop("/controls/armament/rocketsCount", 0);
		setprop("/controls/armament/rocketsLeft", 0);
	}
);
outOfAmmo.singleShot = 1;

#trigger control with ammo counting
var triggerControl = func {
	triggerState = getprop("controls/armament/pickle");
    MasterArm = getprop("controls/armament/master-arm");
    RocketsON = getprop("controls/armament/rockets-sel");
	if(triggerState and MasterArm and RocketsON and getprop("/controls/armament/rocketsLeft") > 0) {
		var mounted1L = (getprop("sim/weight[0]/selected") == "UB-16 rockets pod");
		var mounted2L = (getprop("sim/weight[1]/selected") == "UB-16 rockets pod");
		
		if(mounted1L or mounted2L) {
			var fireTime = 0.75; #continuous fire for 0.15s intervals
			if(mounted1L) {
				setprop("/controls/armament/trigger-S-5-L", 1);
			}
			if(mounted2L) {
				setprop("/controls/armament/trigger-S-5-R", 1);
			}
			var rocketsLeft = getprop("/controls/armament/rocketsLeft");
			setprop("/controls/armament/rocketsCount", rocketsLeft);
			interpolate("/controls/armament/rocketsCount", 0, 
				fireTime*(rocketsLeft/16));
			outOfAmmo.restart(fireTime*(rocketsLeft/16));
		}
	}
	else {
		setprop("/controls/armament/trigger-S-5-L", 0);
		setprop("/controls/armament/trigger-S-5-R", 0);
        	setprop("/sim/multiplay/generic/int[9]", 0);
        	setprop("/sim/multiplay/generic/int[10]", 0);
		
		setprop("/controls/armament/rocketsLeft", 
			getprop("/controls/armament/rocketsCount"));#gets truncated
		interpolate("/controls/armament/rocketsCount", 
			getprop("/controls/armament/rocketsLeft"), 0);
		outOfAmmo.stop();
		#ammo count report on trigger release
		if(getprop("/controls/armament/report-ammo"))
			#screen.log.write("S-5 rockets left: " ~ getprop("/controls/armament/rocketsLeft") ~ ((getprop("/sim/weight[2]/payload-int") == 2 and  getprop("/sim/weight[6]/payload-int") == 2)?" x2":""), 1, 0.6, 0.1);
			screen.log.write("S-5 rockets left: " ~ getprop("/controls/armament/rocketsLeft"), 1, 0.6, 0.1);
	}
}

setlistener("controls/armament/pickle", triggerControl);

