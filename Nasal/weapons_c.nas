# for Rockets
fire_Rocket = func {
                      setprop("/controls/armament/fire_rockets", 1);
			 }

stop_Rocket = func {
			    setprop("/controls/armament/fire_rockets", 0); 
			 }

var flash_trigger_Rockets = props.globals.getNode("controls/armament/fire_rockets", 0);

# for Gun
fire_GSh = func {
	            setprop("/controls/armament/fire_gsh", 1);
		   }

stop_GSh = func {
			setprop("/controls/armament/fire_gsh", 0); 
		   }

var flash_trigger_GSh23 = props.globals.getNode("controls/armament/fire_gsh", 0);

# for PK3 pod
fire_PK3 = func {
	            setprop("/controls/armament/fire_pk3", 1);
		   }

stop_PK3 = func {
			setprop("/controls/armament/fire_pk3", 0); 
		   }

var flash_trigger_PK3 = props.globals.getNode("controls/armament/fire_pk3", 0);

# for Flares 
fire_FL = func {
	            setprop("/controls/armament/trigger2", 1);
		   }

stop_FL = func {
			setprop("/controls/armament/trigger2", 0); 
		   }

var flash_trigger2 = props.globals.getNode("controls/armament/trigger2", 0);



# for Single trigger Bombs or Rockets or Guns release

Pickle = func {

	if(getprop("controls/armament/trigger") == 1) {
				var FAB250mounted1 = (getprop("sim/weight[0]/selected") == "FAB-250 bomb");
				var FAB250mounted2 = (getprop("sim/weight[1]/selected") == "FAB-250 bomb");
				var S5mounted1 = (getprop("sim/weight[0]/selected") == "UB-16 rockets pod");
				var S5mounted2 = (getprop("sim/weight[1]/selected") == "UB-16 rockets pod");
				var PK3mounted1 = (getprop("sim/weight[0]/selected") == "PK-3 MG pod");
				var PK3mounted2 = (getprop("sim/weight[1]/selected") == "PK-3 MG pod");
				var Pylons14_ON = (getprop("controls/armament/pylon-outer-sel") == 1);
				var Pylons23_ON = (getprop("controls/armament/pylon-inner-sel") == 1);
				
				var PickleState = (getprop("controls/armament/trigger") ==1);

                MasterArm = getprop("controls/armament/master-arm");
				GunsON = getprop("controls/armament/guns-sel");
                BombsON = getprop("controls/armament/bombs-sel");
				BombMode = getprop("controls/armament/bomb-mode");
                S5RocketsON = getprop("controls/armament/rockets-sel");

				
				if(MasterArm and BombsON and (FAB250mounted1 or FAB250mounted2)) {

					#screen.log.write("Fire selected weapon: Bombs ", 1, 0.6, 0.1);
					print("Fire selected weapon: Bombs");

					if((FAB250mounted1 or FAB250mounted2) and Pylons14_ON) {
						if(BombMode ==0){
							release250_1_2.singleShot = 1; # timer will only be run once
							release250_1_2.start();
						}
						if(BombMode >0 and FAB250mounted1 and FAB250mounted2){
							release250_1.singleShot = 1; # timer will only be run once
							release250_1.start();
						}
						if(BombMode >0 and !FAB250mounted1 and FAB250mounted2){
							release250_2.singleShot = 1; # timer will only be run once
							release250_2.start();
						}
					}
				}
				if(MasterArm and S5RocketsON and (S5mounted1 or S5mounted2)) {
					#screen.log.write("Fire selected weapon: Rockets ", 1, 0.6, 0.1);
					print("Fire selected weapon: Rockets");
                    setprop("/controls/armament/fire_rockets", 1);
				}
				if(MasterArm and GunsON and (PK3mounted1 or PK3mounted2)) {
					#screen.log.write("Fire selected weapon: PK-3 pods ", 1, 0.6, 0.1);
					print("Fire selected weapon: PK-3");
                    setprop("/controls/armament/fire_pk3", 1);
				}
			}
			else {
					#screen.log.write("Stop weapons release", 1, 0.1, 0.1);
					print("Stop weapons release");
					setprop("/controls/armament/fire_gsh", 0);
					setprop("/controls/armament/fire_pk3", 0);
					setprop("/controls/armament/fire_rockets", 0);
			}
		   }

stop_Pickle = func {
			print("Stop all triggers");
			setprop("/sim/multiplay/generic/int[8]", 0); # Gsh-23
			setprop("/sim/multiplay/generic/int[9]", 0); # S5 outer
			setprop("/sim/multiplay/generic/int[10]", 0); # S5 inner
			setprop("/sim/multiplay/generic/int[11]", 0); # PK3 outer
			setprop("/sim/multiplay/generic/int[12]", 0); # PK3 inner
			setprop("/sim/multiplay/generic/int[13]", 0); # FAB-250-1
			setprop("/sim/multiplay/generic/int[14]", 0); # FAB-250-2
			setprop("/sim/multiplay/generic/int[18]", 0); # FAB-250-3
			setprop("/sim/multiplay/generic/int[19]", 0); # FAB-250-4
            setprop("/controls/armament/fire_gsh", 0);
			setprop("/controls/armament/fire_pk3", 0);
			setprop("/controls/armament/fire_rockets", 0);
			setprop("/controls/armament/trigger", 0);   
		   }

jettison_outer = func {
			jettison_1_4.singleShot = 1; # timer will only be run once
			jettison_1_4.start(); 
		   }

var flash_trigger_Rockets = props.globals.getNode("controls/armament/fire_rockets", 0);
var flash_trigger_GSh23 = props.globals.getNode("controls/armament/fire_gsh", 0);
var flash_trigger_PK3 = props.globals.getNode("controls/armament/fire_pk3", 0);
var flash_trigger1 = props.globals.getNode("sim/multiplay/generic/int[13]", 0);
var flash_trigger2 = props.globals.getNode("sim/multiplay/generic/int[14]", 0);
var flash_trigger3 = props.globals.getNode("sim/multiplay/generic/int[18]", 0);
var flash_trigger4 = props.globals.getNode("sim/multiplay/generic/int[19]", 0);

#ammo left reporting
props.globals.initNode("/controls/armament/report-ammo", 0, "BOOL");

#timers########################################################################################################

var release250_1_2 = maketimer(0.2, func(){
	setprop("/sim/multiplay/generic/int[13]", 1);
	setprop("/sim/multiplay/generic/int[19]", 1);
	print("Released FAB-250 from pylons 1 and 2" );
    setprop("/sim/weight[0]/payload-int", "0");
	setprop("/sim/weight[0]/selected", "none");
    setprop("/sim/weight[0]/payload-int", "0");
	setprop("/sim/weight[1]/selected", "none");
	setprop("sim/weight[1]/weight-lb", 0);
	setprop("sim/weight[1]/weight-lb", 0);
	setprop("controls/armament/fire_rockets", 0);
	release250_1_2.stop();
	#screen.log.write("Pylons 1 and 4 released! ", 1, 0.6, 0.1);
});

################################################################

var release250_1 = maketimer(0.3, func(){
	setprop("/sim/multiplay/generic/int[13]", 1);
	print("Released FAB-250 from pylon 1" );
    setprop("/sim/weight[0]/payload-int", "0");
	setprop("/sim/weight[0]/selected", "none");
	setprop("sim/weight[0]/weight-lb", 0);
	setprop("controls/armament/fire_rockets", 0);
		if (getprop("/controls/armament/bomb-mode") == 1) {
			release250_1.stop();
		}
		if (getprop("/controls/armament/bomb-mode") == 2) {
			release250_2.start();
			release250_1.stop();
		}
	#screen.log.write("Pylons 1 and 4 released! ", 1, 0.6, 0.1);
});

var release250_2 = maketimer(0.4, func(){
	setprop("/sim/multiplay/generic/int[19]", 1);
	print("Released FAB-250 from pylon 2" );
    setprop("/sim/weight[1]/payload-int", "0");
	setprop("/sim/weight[1]/selected", "none");
	setprop("sim/weight[1]/weight-lb", 0);
	setprop("controls/armament/fire_rockets", 0);
	release250_2.stop();
	#screen.log.write("Pylons 1 and 4 released! ", 1, 0.6, 0.1);
});

var jettison_1_4 = maketimer(0.2, func(){
	print("Jettison pylons 1 and 4" );
	if (getprop("/sim/weight[0]/selected") != "none" or getprop("/sim/weight[1]/selected") != "none") {

	setprop("/sim/multiplay/generic/int[20]", 1);

	# jettison rocket pods
	 if (getprop("/sim/weight[0]/selected") == "UB-16 rockets pod") {
		setprop("/controls/armament/jett-1-r", 1);
	 }
	 if (getprop("/sim/weight[1]/selected") == "UB-16 rockets pod") {
		setprop("/controls/armament/jett-4-r", 1); 
	 }
	 # jettison PK3 pods
	 if (getprop("/sim/weight[0]/selected") == "PK-3 MG pod") {
		setprop("/controls/armament/jett-1-p", 1);
	 }
	 if (getprop("/sim/weight[1]/selected") == "PK-3 MG pod") {
		setprop("/controls/armament/jett-4-p", 1);
	 }
	 # jettison fuel tanks
	 if (getprop("/sim/weight[0]/selected") == "150L fuel droptank") {
		setprop("/controls/armament/jett-1-t", 1);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);
	 }
	 if (getprop("/sim/weight[1]/selected") == "150L fuel droptank") {
		setprop("/controls/armament/jett-4-t", 1);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);
	 }

	setprop("/sim/weight[0]/payload-int", "0");
	setprop("/sim/weight[0]/selected", "none");
	setprop("sim/weight[0]/weight-lb", 0);
	setprop("/sim/weight[1]/payload-int", "0");
	setprop("/sim/weight[1]/selected", "none");
	setprop("sim/weight[1]/weight-lb", 0);

	jettison_stop.singleShot = 1; # timer will only be run once
	jettison_stop.start();
	}
});

var jettison_stop = maketimer(0.2, func(){
	print("Jettison stop" );
	setprop("/controls/armament/jett-1-r", 0);
	setprop("/controls/armament/jett-2-r", 0);
	setprop("/controls/armament/jett-3-r", 0);
	setprop("/controls/armament/jett-4-r", 0);
	setprop("/sim/multiplay/generic/int[20]", 0);
	setprop("/sim/multiplay/generic/int[21]", 0);
});

setlistener("controls/armament/trigger", Pickle);
