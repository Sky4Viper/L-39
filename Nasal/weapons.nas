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



# for Bombs

drop_Bomb = func {
				var FAB250mounted14 = (getprop("sim/weight[0]/selected") == "FAB-250 bomb");
				var FAB250mounted23 = (getprop("sim/weight[1]/selected") == "FAB-250 bomb");
                MasterArm = getprop("controls/armament/master-arm");
                BombsON = getprop("controls/armament/bombs-sel");
				if(MasterArm and BombsON and (FAB250mounted14 or FAB250mounted23)) {
				if(FAB250mounted14) {
					#setprop("/sim/multiplay/generic/int[13]", 1);
					#setprop("/sim/weight[0]/selected", "none");
					#setprop("/sim/weight[3]/selected", "none");
					#setprop("sim/weight[0]/weight-lb", 0);
					#setprop("sim/weight[3]/weight-lb", 0);
					release250_1_4.singleShot = 1; # timer will only be run once
					release250_1_4.start();
				}
				if(FAB250mounted23) {
					#setprop("/sim/multiplay/generic/int[14]", 1);
					#setprop("/sim/weight[1]/selected", "none");
					#setprop("/sim/weight[2]/selected", "none");
					#setprop("sim/weight[1]/weight-lb", 0);
					#setprop("sim/weight[2]/weight-lb", 0);
					release250_2_3.singleShot = 1; # timer will only be run once
					release250_2_3.start();
				}
				}
		   }

stop_Bomb = func {
			setprop("/sim/multiplay/generic/int[13]", 0);
			setprop("/sim/multiplay/generic/int[14]", 0); 
		   }

var flash_trigger3 = props.globals.getNode("sim/multiplay/generic/int[13]", 0);
var flash_trigger4 = props.globals.getNode("sim/multiplay/generic/int[14]", 0);

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
