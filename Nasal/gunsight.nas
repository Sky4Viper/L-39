#Gunsight

# set startup configuration
init_gunsight = func 
{
  setprop("fdm/jsbsim/systems/headsight/serviceable", 1);
  setprop("fdm/jsbsim/systems/headsight/on", 0);
  setprop("fdm/jsbsim/systems/headsight/up-command", 1);
  setprop("fdm/jsbsim/systems/headsight/gyro-command", 1);
  setprop("fdm/jsbsim/systems/headsight/frame-command", 0);
  setprop("fdm/jsbsim/systems/headsight/brightness", 1);
  setprop("fdm/jsbsim/systems/headsight/target-size", 15);
  setprop("fdm/jsbsim/systems/headsight/target-distance", 400);
  setprop("fdm/jsbsim/systems/headsight/from-eye-to-sight", 0.4);
}

init_gunsight();
