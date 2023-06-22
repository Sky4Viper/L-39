
props.globals.initNode("/sim/is-MP-Aircraft", 0, "BOOL");

#initialize triggers
props.globals.initNode("/controls/armament/pickle", 0, "BOOL");
setprop("/controls/armament/pickle", 0);

props.globals.initNode("/controls/armament/trigger-S-5-L", 0, "BOOL");
props.globals.initNode("/controls/armament/trigger-S-5-R", 0, "BOOL");

props.globals.initNode("/sim/multiplay/generic/int[9]", 0, "INT");
props.globals.initNode("/sim/multiplay/generic/int[10]", 0, "INT");

#ammo counter
props.globals.initNode("/controls/armament/rocketsLeft1", 16, "INT");
props.globals.initNode("/controls/armament/rocketsCount1", 16, "DOUBLE");

props.globals.initNode("/controls/armament/rocketsLeft2", 16, "INT");
props.globals.initNode("/controls/armament/rocketsCount2", 16, "DOUBLE");


var reload = func {
	if( getprop("/gear/gear[0]/wow") and getprop("/gear/gear[1]/wow") and getprop("/gear/gear[2]/wow") and (getprop("/velocities/groundspeed-kt") < 2) ) {

		setprop("/controls/armament/rocketsLeft1", 16);
		setprop("/controls/armament/rocketsCount1", 16);

		setprop("/controls/armament/rocketsLeft2", 16);
		setprop("/controls/armament/rocketsCount2", 16);

		screen.log.write("S-5 rockets reloaded (16 rockets per pod)", 1, 0.6, 0.1);
	}
	else {
		screen.log.write("You must be still on the ground to reaload! ", 1, 0.6, 0.1);
	}
}

#A resource friendly way of ammo counting: Instead of counting every bullet, I set an interpolate on float variant of ammo counter. But I need a timer to cut off fire when out of ammo. 

var outOfAmmo1 = maketimer(1.0, 
	func { 
		#print("Out of rockets! ");
		screen.log.write("Outer UB-16 out of rockets! ", 1, 0.6, 0.1);
		setprop("/controls/armament/trigger-S-5-L", 0);
        setprop("/sim/multiplay/generic/int[9]", 0);
		setprop("/controls/armament/rocketsCount1", 0);
		setprop("/controls/armament/rocketsLeft1", 0);
	}
);
outOfAmmo1.singleShot = 1;

var outOfAmmo2 = maketimer(1.0, 
	func { 
		#print("Out of rockets! ");
		screen.log.write("Inner UB-16 out of rockets! ", 1, 0.6, 0.1);
		setprop("/controls/armament/trigger-S-5-R", 0);
        setprop("/sim/multiplay/generic/int[10]", 0);
		setprop("/controls/armament/rocketsCount2", 0);
		setprop("/controls/armament/rocketsLeft2", 0);
	}
);
outOfAmmo2.singleShot = 1;

var Rockets_Stop = maketimer(0.1, 
	func { 
		#print("Rockets Stopped! ");
		setprop("/controls/armament/trigger-S-5-L", 0);
        setprop("/sim/multiplay/generic/int[9]", 0);
		setprop("/controls/armament/trigger-S-5-R", 0);
        setprop("/sim/multiplay/generic/int[10]", 0);
        setprop("controls/armament/pickle", 0);
        if(getprop("/controls/armament/report-ammo")) {
			screen.log.write("S-5 rockets Outer left: " ~ getprop("/controls/armament/rocketsLeft1"), 1, 0.6, 0.1);
			screen.log.write("S-5 rockets Inner left: " ~ getprop("/controls/armament/rocketsLeft2"), 1, 0.6, 0.1);
        }
	}
);
Rockets_Stop.singleShot = 1;

var Rockets_Ripple_1 = maketimer(0.1, 
	func { 
		#print("2x more rockets! ");
		screen.log.write("2 Rockets fired! ", 1, 0.6, 0.1);
		setprop("/controls/armament/trigger-S-5-L", 1);
		setprop("/controls/armament/trigger-S-5-R", 1);

	    var rocketsLeft1 = (getprop("/controls/armament/rocketsLeft1") -2);
		var rocketsLeft2 = (getprop("/controls/armament/rocketsLeft2") -2);

	    setprop("/controls/armament/rocketsCount1", rocketsLeft1);
		setprop("/controls/armament/rocketsCount2", rocketsLeft2);
        Rockets_Stop.start(0.1);
	}
);
Rockets_Ripple_1.singleShot = 1;

var Rockets_Ripple_1_OUT = maketimer(0.15, 
	func { 
		#print("2x more rockets! ");
		setprop("/controls/armament/trigger-S-5-L", 1);
		#screen.log.write("2 Rockets fired! ", 1, 0.6, 0.1);
		#var rocketsLeft1 = (getprop("/controls/armament/rocketsLeft1") -2);
		#setprop("/controls/armament/rocketsCount1", rocketsLeft1);
        Rockets_Stop.start(0.1);
        Rockets_Ripple_1_OUT.stop();
	}
);
Rockets_Ripple_1_OUT.singleShot = 1;

var Rockets_Ripple_1_IN = maketimer(0.15, 
	func { 
		#print("2x more rockets! ");
		setprop("/controls/armament/trigger-S-5-R", 1);
		#screen.log.write("2 Rockets fired! ", 1, 0.6, 0.1);
		#var rocketsLeft2 = (getprop("/controls/armament/rocketsLeft2") -2);
		#setprop("/controls/armament/rocketsCount2", rocketsLeft2);
        Rockets_Stop.start(0.1);
        Rockets_Ripple_1_IN.stop();
	}
);
Rockets_Ripple_1_IN.singleShot = 1;

#######

var Rockets_Ripple_2_OUT = maketimer(0.1, 
	func {
		        setprop("/controls/armament/trigger-S-5-L", 1);
		        #var rocketsLeft3 = (getprop("/controls/armament/rocketsLeft1") -2);
		        #setprop("/controls/armament/rocketsCount1", rocketsLeft3);
		        #screen.log.write("2 Rockets fired! ", 1, 0.6, 0.1);
                Rockets_Ripple_1_OUT.start();
                Rockets_Ripple_2_OUT.stop();
	      }
);
Rockets_Ripple_2_OUT.singleShot = 1;

var Rockets_Ripple_2_IN = maketimer(0.1, 
	func {
		        setprop("/controls/armament/trigger-S-5-R", 1);
		        #var rocketsLeft4 = (getprop("/controls/armament/rocketsLeft2") -2);
		        #setprop("/controls/armament/rocketsCount2", rocketsLeft4);
		        #screen.log.write("2 Rockets fired! ", 1, 0.6, 0.1);
                Rockets_Ripple_1_OUT.start();
                Rockets_Ripple_2_IN.stop();
	      }
);
Rockets_Ripple_2_IN.singleShot = 1;

#trigger control with ammo counting
var triggerControl = func {
	triggerState = getprop("controls/armament/pickle");
    MasterArm = getprop("controls/armament/master-arm");
    RocketsON = getprop("controls/armament/rockets-sel");
    RippleType = getprop("controls/armament/salvo-ripple");

	if(triggerState and MasterArm and RocketsON) {
		var mounted1L = (getprop("sim/weight[0]/selected") == "UB-16 rockets pod");
		var mounted2L = (getprop("sim/weight[1]/selected") == "UB-16 rockets pod");
		var PylonsOuter_ON = (getprop("controls/armament/pylon-outer-sel") == 1);
		var PylonsInner_ON = (getprop("controls/armament/pylon-inner-sel") == 1);
		
		if(mounted1L or mounted2L) {
			var fireTime1 = 0.75; #continuous fire for 0.15s intervals
			var fireTime2 = 0.75; #continuous fire for 0.15s intervals

			if(PylonsOuter_ON and PylonsInner_ON and getprop("/controls/armament/rocketsLeft1") > 0 and getprop("/controls/armament/rocketsLeft2") > 0  and RippleType ==0) {
				setprop("/controls/armament/trigger-S-5-L", 1);
				setprop("/controls/armament/trigger-S-5-R", 1);

			    var rocketsLeft1 = getprop("/controls/armament/rocketsLeft1");
			    var rocketsLeft2 = getprop("/controls/armament/rocketsLeft2");

			    setprop("/controls/armament/rocketsCount1", rocketsLeft1);
			    interpolate("/controls/armament/rocketsCount1", 0,
				fireTime1*(rocketsLeft1/16)); 

			    setprop("/controls/armament/rocketsCount2", rocketsLeft2);
			    interpolate("/controls/armament/rocketsCount2", 0,
				fireTime2*(rocketsLeft2/16));

			    outOfAmmo1.restart(fireTime1*(rocketsLeft1/16)); 
			    outOfAmmo2.restart(fireTime2*(rocketsLeft2/16));
			}

			if(mounted1L and PylonsOuter_ON and getprop("/controls/armament/rocketsLeft1") > 0 and RippleType ==0) {
				setprop("/controls/armament/trigger-S-5-L", 1);
			    var rocketsLeft1 = getprop("/controls/armament/rocketsLeft1");
			    setprop("/controls/armament/rocketsCount1", rocketsLeft1);
			    interpolate("/controls/armament/rocketsCount1", 0, 
				fireTime1*(rocketsLeft1/16));
			    outOfAmmo1.restart(fireTime1*(rocketsLeft1/16));
			}

			if(mounted2L and PylonsInner_ON and getprop("/controls/armament/rocketsLeft2") > 0  and RippleType ==0) {
				setprop("/controls/armament/trigger-S-5-R", 1);
			    var rocketsLeft2 = getprop("/controls/armament/rocketsLeft2");
			    setprop("/controls/armament/rocketsCount2", rocketsLeft2);
			    interpolate("/controls/armament/rocketsCount2", 0, 
				fireTime2*(rocketsLeft2/16));
			    outOfAmmo2.restart(fireTime2*(rocketsLeft2/16));

			}

			if(PylonsOuter_ON and getprop("/controls/armament/rocketsLeft1") > 0 and RippleType ==1) {
		        var rocketsLeft1 = (getprop("/controls/armament/rocketsLeft1") -2);
		        setprop("/controls/armament/rocketsCount1", rocketsLeft1);
                Rockets_Ripple_1_OUT.start();
			}

			if(PylonsInner_ON and getprop("/controls/armament/rocketsLeft2") > 0 and RippleType ==1) {
                var rocketsLeft2 = (getprop("/controls/armament/rocketsLeft2") -2);
		        setprop("/controls/armament/rocketsCount2", rocketsLeft2);
                Rockets_Ripple_1_IN.start();
			}

			if(PylonsOuter_ON and getprop("/controls/armament/rocketsLeft1") > 0 and RippleType ==2) {
		        var rocketsLeft1 = (getprop("/controls/armament/rocketsLeft1") -4);
		        setprop("/controls/armament/rocketsCount1", rocketsLeft1);
                Rockets_Ripple_2_OUT.start();
			}

			if(PylonsInner_ON and getprop("/controls/armament/rocketsLeft2") > 0 and RippleType ==2) {
                var rocketsLeft2 = (getprop("/controls/armament/rocketsLeft2") -4);
		        setprop("/controls/armament/rocketsCount2", rocketsLeft2);
                Rockets_Ripple_2_IN.start();
			}

		}
	}
	else {
		    setprop("/controls/armament/trigger-S-5-L", 0);
		    setprop("/controls/armament/trigger-S-5-R", 0);
        	setprop("/sim/multiplay/generic/int[9]", 0);
        	setprop("/sim/multiplay/generic/int[10]", 0);
		
		    setprop("/controls/armament/rocketsLeft1", 
			getprop("/controls/armament/rocketsCount1"));#gets truncated
		    interpolate("/controls/armament/rocketsCount1", 
			getprop("/controls/armament/rocketsLeft1"), 0);

            outOfAmmo1.stop();

		    setprop("/controls/armament/rocketsLeft2", 
			getprop("/controls/armament/rocketsCount2"));#gets truncated
		    interpolate("/controls/armament/rocketsCount2", 
			getprop("/controls/armament/rocketsLeft2"), 0);

		    outOfAmmo2.stop();

            Rockets_Ripple_1_OUT.stop();
            Rockets_Ripple_1_IN.stop();
            Rockets_Ripple_2_OUT.stop();
            Rockets_Ripple_2_IN.stop();

		    #ammo count report on trigger release
		    if(getprop("/controls/armament/report-ammo")) {
			screen.log.write("S-5 rockets Outer left: " ~ getprop("/controls/armament/rocketsLeft1"), 1, 0.6, 0.1);
			screen.log.write("S-5 rockets Inner left: " ~ getprop("/controls/armament/rocketsLeft2"), 1, 0.6, 0.1);
        }
	}
}

setlistener("controls/armament/pickle", triggerControl);

