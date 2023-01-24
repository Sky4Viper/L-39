##### low level animation loop

setlistener("/sim/signals/fdm-initialized", func {

settimer(metric_loop, 1);
});

var metric_loop = func {

var dmekn = getprop("instrumentation/dme/indicated-distance-nm");
var dmekm = dmekn *1.852;
var navtgtset = getprop("controls/navigation/target-range");
var navtgtkm = navtgtset -dmekm;
setprop("l-39za/instrumentation/dme/indicated-distance-km", dmekm);
setprop("l-39za/instrumentation/dme/nav-target-km", navtgtkm);

#if((calt <= 300) and (cspd >= 450)) {
#setprop("controls/state/low_level", 1);
#} elsif ((calt <= 300) and ((burn0 == 1) or (burn1 == 1))) {
#setprop("controls/state/low_level", 1);
#  } else {
#setprop("controls/state/low_level", 0);
#    }

settimer(metric_loop, 1);
}

