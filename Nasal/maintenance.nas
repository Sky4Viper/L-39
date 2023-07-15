
# Maintenance.nas

    print("Loading Maintenance");

    var rm_root = "sim/maintenance";
	
	var airframe_load_speed = 60; # Speed in Kt at which airframe is under load, i.e. (simply) rotate speed
	
	var airframe_seconds = aircraft.timer.new(rm_root~"/airframe-seconds", 60, 0);
	var engine0_seconds = aircraft.timer.new(rm_root~"/engine[0]/operating-seconds", 60, 0);
	#var engine1_seconds = aircraft.timer.new(rm_root~"/engine[1]/operating-seconds", 60, 0);
	
	var rm_loop = func {
		 airframe_load();    
		 airframe_hours();
		 #engine_hours();
		}

	var service = func {
		if( getprop("/gear/gear[0]/wow") and getprop("/gear/gear[1]/wow") and getprop("/gear/gear[2]/wow") and (getprop("/velocities/groundspeed-kt") < 2) ) {
			setprop("sim/maintenance/airframe-seconds", 0.0);
			setprop("sim/maintenance/airframe-hours", 0.0);
			setprop("l-39/effect/rust-outside", 0);
			screen.log.write("Aircraft has been serviced", 1, 0.6, 0.1);
			}
		else {
		screen.log.write("You must be still on the ground to service! ", 1, 0.6, 0.1);
			}
		}	     
		

	var airframe_hours = func {
		 var afh_prop = props.globals.getNode(rm_root~"/airframe-seconds",1);
		 var speedup = props.globals.getNode("sim/speed-up").getValue();
		 var hrs =  ( ( afh_prop.getValue() / 3600 ) * speedup );
         var hrs_f = sprintf("%5.2f",hrs);
         props.globals.getNode(rm_root~"/airframe-hours",1).setValue(hrs);
	     if (props.globals.getNode("sim/maintenance/airframe-hours").getValue() > 0.1 ) {
            setprop("l-39/effect/rust-outside", 1);
            setprop("l-39/effect/rust-factor", ( afh_prop.getValue() / 3600 ) * 0.0025);
            print("Rusty fuselage" );
			}
		}	
	
	var airframe_load = func {
	     if ( props.globals.getNode("velocities/airspeed-kt").getValue() > airframe_load_speed ) {
		     airframe_seconds.start();
			}
		 else {
		     airframe_seconds.stop();
			}
		}
		
	var report = func {
	     var rep = {};
		 rep.afhours = "Airframe Hours: "~sprintf("%5.1f",getprop(rm_root~"/airframe-hours"));
		 var out = rep.afhours;
		 return out;
		}
		
	
