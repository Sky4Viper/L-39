
## DECU Attempt (!)


## Engines

#Initialise

      var engine1 = engines.Jet.new(0 , 0 , 0.01 , 5.21 , 4 , 4 , 0.02 , 1);

   engine1.init();


props.globals.initNode("/sim/autostart/started", 0, "BOOL");

var eng1fuelon = func { setprop("/controls/engines/engine[0]/cutoff", 0); }
var eng1fueloff = func { setprop("/controls/engines/engine[0]/cutoff", 1); }
var eng1starter = func { setprop("/controls/engines/engine[0]/starter", 1); }

var eng1start = func {
   eng1fueloff();
   eng1starter();
   settimer(eng1fuelon, 2);
}

var engstart = func {
   settimer(eng1start, 2);
}

var engstop = func {
   eng1fueloff();
}

var autostart = func {
   var startstatus = getprop("/sim/autostart/started");
   if ( startstatus == 0 ) {
      gui.popupTip("Autostarting...");
	  setprop("/sim/autostart/started", 1);
      setprop("/controls/electric/battery-switch", 1);
      settimer(engstart, 0.5);
	  gui.popupTip("Starting Engines");
	  }
   if ( startstatus == 1 ) {
      gui.popupTip("Shutting Down...");
      setprop("/sim/autostart/started", 0);
	  eng1fueloff();
   }
}

var autostop = func {
   eng1fueloff();
   apufueloff();
}
   
   




