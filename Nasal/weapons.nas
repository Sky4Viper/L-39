# for Rockets
fire_Rocket = func {
                      setprop("/controls/armament/pickle", 1);
			 }

stop_Rocket = func {
			    setprop("/controls/armament/pickle", 0); 
			 }

var flash_trigger1 = props.globals.getNode("controls/armament/pickle", 0);

# for Gun
fire_MG = func {
	            setprop("/controls/armament/trigger", 1);
		   }

stop_MG = func {
			setprop("/controls/armament/trigger", 0); 
		   }

var flash_trigger = props.globals.getNode("controls/armament/trigger", 0);

# for Flares 
fire_FL = func {
	            setprop("/controls/armament/trigger2", 1);
		   }

stop_FL = func {
			setprop("/controls/armament/trigger2", 0); 
		   }

var flash_trigger2 = props.globals.getNode("controls/armament/trigger2", 0);



# for Combine Bombs or Rockets release

Pickle = func {
				var FAB250mounted1 = (getprop("sim/weight[0]/selected") == "FAB-250 bomb");
				var FAB250mounted2 = (getprop("sim/weight[1]/selected") == "FAB-250 bomb");
				var FAB250mounted3 = (getprop("sim/weight[2]/selected") == "FAB-250 bomb");
				var FAB250mounted4 = (getprop("sim/weight[3]/selected") == "FAB-250 bomb");
				var S5mounted14 = (getprop("sim/weight[0]/selected") == "UB-16 rockets pod");
				var S5mounted23 = (getprop("sim/weight[1]/selected") == "UB-16 rockets pod");
				var Pylons14_ON = (getprop("controls/armament/pylon-outer-sel") == 1);
				var Pylons23_ON = (getprop("controls/armament/pylon-inner-sel") == 1);
				
                MasterArm = getprop("controls/armament/master-arm");
                BombsON = getprop("controls/armament/bombs-sel");
				BombMode = getprop("controls/armament/bomb-mode");
                S5RocketsON = getprop("controls/armament/rockets-sel");
				if(MasterArm and BombsON and (FAB250mounted1 or FAB250mounted4 or FAB250mounted2 or FAB250mounted3)) {

					if((FAB250mounted1 or FAB250mounted4) and Pylons14_ON) {
						if(BombMode ==0){
							release250_1_4.singleShot = 1; # timer will only be run once
							release250_1_4.start();
						}
						if(BombMode >0 and FAB250mounted1 and FAB250mounted4){
							release250_1.singleShot = 1; # timer will only be run once
							release250_1.start();
						}
						if(BombMode >0 and !FAB250mounted1 and FAB250mounted4){
							release250_4.singleShot = 1; # timer will only be run once
							release250_4.start();
						}
					}
					if((FAB250mounted2 or FAB250mounted3) and Pylons23_ON) {
						if(BombMode ==0){
							release250_2_3.singleShot = 1; # timer will only be run once
							release250_2_3.start();
						}
						if(BombMode >0 and FAB250mounted2 and FAB250mounted3 and ((Pylons14_ON and !FAB250mounted4) or !Pylons14_ON)) {
							release250_2.singleShot = 1; # timer will only be run once
							release250_2.start();
						}
						if(BombMode >0 and !FAB250mounted2 and FAB250mounted3 and ((Pylons14_ON and !FAB250mounted4) or !Pylons14_ON)) {
							release250_3.singleShot = 1; # timer will only be run once
							release250_3.start();
						}
					}
				}
				if(MasterArm and S5RocketsON and (S5mounted14 or S5mounted23)) {
                    setprop("/controls/armament/pickle", 1);
				}
		   }

stop_Pickle = func {
			setprop("/sim/multiplay/generic/int[13]", 0);
			setprop("/sim/multiplay/generic/int[14]", 0);
            setprop("/controls/armament/pickle", 0);  
		   }

var flash_trigger1 = props.globals.getNode("controls/armament/pickle", 0);
var flash_trigger3 = props.globals.getNode("sim/multiplay/generic/int[13]", 0);
var flash_trigger4 = props.globals.getNode("sim/multiplay/generic/int[14]", 0);
var flash_trigger3 = props.globals.getNode("sim/multiplay/generic/int[18]", 0);
var flash_trigger4 = props.globals.getNode("sim/multiplay/generic/int[19]", 0);

#ammo left reporting
props.globals.initNode("/controls/armament/report-ammo", 0, "BOOL");

#timers########################################################################################################

var release250_1_4 = maketimer(0.2, func(){
	setprop("/sim/multiplay/generic/int[13]", 1);
	print("Released FAB-250 from pylons 1 and 4" );
    setprop("/sim/weight[0]/payload-int", "0");
	setprop("/sim/weight[0]/selected", "none");
    setprop("/sim/weight[0]/payload-int", "0");
	setprop("/sim/weight[3]/selected", "none");
	setprop("sim/weight[3]/weight-lb", 0);
	setprop("sim/weight[3]/weight-lb", 0);
	setprop("controls/armament/pickle", 0);
	#screen.log.write("Pylons 1 and 4 released! ", 1, 0.6, 0.1);
});

var release250_2_3 = maketimer(0.2, func(){
	setprop("/sim/multiplay/generic/int[14]", 1);
	print("Released FAB-250 from pylons 2 and 3" );
    setprop("/sim/weight[1]/payload-int", "0");
	setprop("/sim/weight[1]/selected", "none");
    setprop("/sim/weight[2]/payload-int", "0");
	setprop("/sim/weight[2]/selected", "none");
	setprop("sim/weight[1]/weight-lb", 0);
	setprop("sim/weight[2]/weight-lb", 0);
	setprop("controls/armament/pickle", 0);
	#screen.log.write("Pylons 1 and 4 released! ", 1, 0.6, 0.1);
});

################################################################

var release250_1 = maketimer(0.3, func(){
	setprop("/sim/multiplay/generic/int[13]", 1);
	print("Released FAB-250 from pylon 1" );
    setprop("/sim/weight[0]/payload-int", "0");
	setprop("/sim/weight[0]/selected", "none");
	setprop("sim/weight[0]/weight-lb", 0);
	setprop("controls/armament/pickle", 0);
		if (getprop("/controls/armament/bomb-mode") == 1) {
			release250_1.stop();
		}
		if (getprop("/controls/armament/bomb-mode") == 2) {
			release250_4.start();
			release250_1.stop();
		}
	#screen.log.write("Pylons 1 and 4 released! ", 1, 0.6, 0.1);
});

var release250_2 = maketimer(0.3, func(){
	setprop("/sim/multiplay/generic/int[14]", 1);
	print("Released FAB-250 from pylon 2" );
    setprop("/sim/weight[1]/payload-int", "0");
	setprop("/sim/weight[1]/selected", "none");
	setprop("sim/weight[1]/weight-lb", 0);
	setprop("controls/armament/pickle", 0);
		if (getprop("/controls/armament/bomb-mode") == 1) {
			release250_2.stop();
		}
		if (getprop("/controls/armament/bomb-mode") == 2) {
			release250_3.start();
			release250_2.stop();
		}
	#screen.log.write("Pylons 1 and 4 released! ", 1, 0.6, 0.1);
});

var release250_3 = maketimer(0.3, func(){
	setprop("/sim/multiplay/generic/int[18]", 1);
	print("Released FAB-250 from pylon 3" );
    setprop("/sim/weight[2]/payload-int", "0");
	setprop("/sim/weight[2]/selected", "none");
	setprop("sim/weight[2]/weight-lb", 0);
	setprop("controls/armament/pickle", 0);
	release250_3.stop();
	#screen.log.write("Pylons 1 and 4 released! ", 1, 0.6, 0.1);
});

var release250_4 = maketimer(0.4, func(){
	setprop("/sim/multiplay/generic/int[19]", 1);
	print("Released FAB-250 from pylon 4" );
    setprop("/sim/weight[3]/payload-int", "0");
	setprop("/sim/weight[3]/selected", "none");
	setprop("sim/weight[3]/weight-lb", 0);
	setprop("controls/armament/pickle", 0);
		if (getprop("/controls/armament/bomb-mode") == 2 and getprop("controls/armament/pylon-inner-sel") == 1) {
			release250_2.start();
			release250_4.stop();
		}
	#screen.log.write("Pylons 1 and 4 released! ", 1, 0.6, 0.1);
});
