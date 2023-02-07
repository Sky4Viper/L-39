
props.globals.initNode("/sim/is-MP-Aircraft", 0, "BOOL");

#GSh-23 cannon trigger

#initialize triggers
props.globals.initNode("/controls/armament/trigger", 0, "BOOL");
setprop("/controls/armament/trigger", 0);


props.globals.initNode("/controls/armament/trigger-PK3-out", 0, "BOOL");
props.globals.initNode("/controls/armament/trigger-PK3-in", 0, "BOOL");

props.globals.initNode("/sim/multiplay/generic/int[11]", 0, "INT");
props.globals.initNode("/sim/multiplay/generic/int[12]", 0, "INT");

#ammo counter
props.globals.initNode("/controls/armament/PK3Left", 1500, "INT");
props.globals.initNode("/controls/armament/PK3Count", 1500, "DOUBLE");
var reload = func {
	if( getprop("/gear/gear[0]/wow") and getprop("/gear/gear[1]/wow") and getprop("/gear/gear[2]/wow") and (getprop("/velocities/groundspeed-kt") < 2) ) {
		setprop("/controls/armament/PK3Left", 1500);
		setprop("/controls/armament/PK3Count", 1500);
		screen.log.write("PK-3 pods reloaded (1500 rounds per pod)", 1, 0.6, 0.1);
	}
	else {
		screen.log.write("You must be still on the ground to reaload! ", 1, 0.6, 0.1);
	}
}

#A resource friendly way of ammo counting: Instead of counting every bullet, I set an interpolate on float variant of ammo counter. But I need a timer to cut off fire when out of ammo. 

var outOfAmmo = maketimer(1.0, 
	func { 
		#print("Out of rockets! ");
		screen.log.write("PK-3 out of ammo! ", 1, 0.6, 0.1);
		setprop("/controls/armament/trigger-PK3-out", 0);
		setprop("/controls/armament/trigger-PK3-in", 0);
        setprop("/sim/multiplay/generic/int[11]", 0);
        setprop("/sim/multiplay/generic/int[12]", 0);
		setprop("/controls/armament/PK3Count", 0);
		setprop("/controls/armament/PK3Left", 0);
	}
);
outOfAmmo.singleShot = 1;

#trigger control with ammo counting
var triggerControl = func {
	triggerState = getprop("controls/armament/trigger");
    MasterArm = getprop("controls/armament/master-arm");
	if(triggerState and MasterArm and getprop("/controls/armament/PK3Left") > 0) {
		var PK3mounted1L = (getprop("sim/weight[0]/selected") == "PK-3 MG pod");
		var PK3mounted2L = (getprop("sim/weight[1]/selected") == "PK-3 MG pod");
        PK3OuterON = getprop("controls/armament/pk3-outer-sel");
        PK3InnerON = getprop("controls/armament/pk3-inner-sel");
		
		if(PK3mounted1L or PK3mounted2L) {
			var fireTime = 2.05714; #continuous fire for 3500 r/min
			if(PK3mounted1L and PK3OuterON) {
				setprop("/controls/armament/trigger-PK3-out", 1);
			}
			if(PK3mounted2L and PK3InnerON) {
				setprop("/controls/armament/trigger-PK3-in", 1);
			}
			var PK3Left = getprop("/controls/armament/PK3Left");
			setprop("/controls/armament/PK3Count", PK3Left);
			interpolate("/controls/armament/PK3Count", 0, 
				fireTime*(PK3Left/1500));
			outOfAmmo.restart(fireTime*(PK3Left/1500));
		}
	}
	else {
		setprop("/controls/armament/trigger-PK3-out", 0);
		setprop("/controls/armament/trigger-PK3-in", 0);
        setprop("/sim/multiplay/generic/int[11]", 0);
        setprop("/sim/multiplay/generic/int[12]", 0);
		
		setprop("/controls/armament/PK3Left", 
			getprop("/controls/armament/PK3Count"));#gets truncated
		interpolate("/controls/armament/PK3Count", 
			getprop("/controls/armament/PK3Left"), 0);
		outOfAmmo.stop();
		#ammo count report on trigger release
		if(getprop("/controls/armament/report-ammo"))
			screen.log.write("PK-3 rounds left: " ~ getprop("/controls/armament/PK3Left") ~ ((getprop("/sim/weight[2]/payload-int") == 2 and  getprop("/sim/weight[6]/payload-int") == 2)?" x2":""), 1, 0.6, 0.1);
	}
}

setlistener("controls/armament/trigger", triggerControl);

