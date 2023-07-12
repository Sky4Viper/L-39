#HOWTO: add new weapon type
#-add new entry inside <weight> in -set.xml (for all pylons where
# it can be mounted)
#-add new int resolver in setLoadInt() below (with yet unused value)
#-add necessary animation/model show code in proper places in the
# Models folder

######################################
#                                    #
#        - R-60M                     #
#        - UB-16 rockets pod         #
#        - PK-3 MG pod               #
#        - FAB-250 bomb              #
#        - 150L fuel droptank        #
#                                    #
######################################

#initialize MP transferred ints
var weightsNode = props.globals.getNode("/sim");
var numWeights = 2;

for(var i=0; i<numWeights; i+=1) {
	props.globals.initNode("/sim/weight["~i~"]/payload-int", 0, "INT");
}



#props.globals.initNode("/sim/weight[9]/payload-int", 0, "INT");

#function for resolving MP transferred load type int
#all weapon types have this value identical on all pylons
#(even if some types are not available there)
var setLoadInt = func(pylon_index) {
	var payload = getprop("/sim/weight["~pylon_index~"]/selected");
	#print("Index:" ~ pylon_index ~ "  Payload: " ~ payload);
	if( payload == "none" )
		setprop("/sim/weight["~pylon_index~"]/payload-int", 0);
	else if( payload == "R-60M" )
		setprop("/sim/weight["~pylon_index~"]/payload-int", 1);
	else if( payload == "UB-16 rockets pod" )
		setprop("/sim/weight["~pylon_index~"]/payload-int", 2);
	else if( payload == "PK-3 MG pod" )
		setprop("/sim/weight["~pylon_index~"]/payload-int", 3);
	else if( payload == "FAB-250 bomb" )
		setprop("/sim/weight["~pylon_index~"]/payload-int", 4);
	else if( payload == "150L fuel droptank" )
		setprop("/sim/weight["~pylon_index~"]/payload-int", 5);
	
	#error case - weapon from payloads dialog not implemented here
	else setprop("/sim/weight["~pylon_index~"]/payload-int", -1);
}

forindex(var i; weightsNode.getChildren("weight")) {
	setlistener("/sim/weight["~i~"]/selected", func{setLoadInt(arg[0].getParent().getIndex());}, 1, 0); #need to get the node index in this way, if I just put in i it would use the highest number from last loop iteration at all times...
}


