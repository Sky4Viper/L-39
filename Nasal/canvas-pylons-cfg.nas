var showPylonsDlg = func{
var (width,height) = (1400,500);
var title = 'L-39ZA Payload:';
setprop("/sim/menubar/visibility",0);
setprop("/controls/armament/roundsLeft", 150);
setprop("/controls/armament/roundsCount", 150);
 
# create a new window, dimensions are WIDTH x HEIGHT, using the dialog decoration (i.e. titlebar)
var window = canvas.Window.new([width,height],"dialog").set('title',title);
 
# adding a canvas to the new window and setting up background colors/transparency
var myCanvas = window.createCanvas().set("background", canvas.style.getColor("bg_color"));
 
# creating the top-level/root group which will contain all other elements/group
var root = myCanvas.createGroup();
 
# create a new layout for the dialog:
var mainVBox = canvas.VBoxLayout.new();
# assign the layout to the Canvas

myCanvas.setLayout(mainVBox);

var bgimage = root.createChild("image")
     .setFile("Aircraft/L-39ZA/gui/dialogs/L-39ZA-Pylons-BG.png")
	 #.setTranslation(100, 10)
     .setSize(1400,500);

var TopSpaceFiller = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
TopSpaceFiller.setText("")
.setFixedSize(697,210);

mainVBox.addItem(TopSpaceFiller);

var Hbox1 = canvas.HBoxLayout.new(); # Labels
mainVBox.addItem(Hbox1);

var Hbox2 = canvas.HBoxLayout.new(); # Weapons Buttons
mainVBox.addItem(Hbox2);

var Hbox3 = canvas.HBoxLayout.new(); # Fuel tanks
mainVBox.addItem(Hbox3);

var Hbox1RW = canvas.HBoxLayout.new(); # Right wing
Hbox1.addItem(Hbox1RW);

var Hbox1C = canvas.VBoxLayout.new(); # Specs
Hbox1.addItem(Hbox1C);

var Hbox1LW = canvas.HBoxLayout.new(); # Left wing
Hbox1.addItem(Hbox1LW);

### weapons ###

var P4Ctls = canvas.VBoxLayout.new();
Hbox2.addItem(P4Ctls);

var P3Ctls = canvas.VBoxLayout.new();
Hbox2.addItem(P3Ctls);

var Vbox1C = canvas.VBoxLayout.new(); # Specs
Hbox2.addItem(Vbox1C);

var P2Ctls = canvas.VBoxLayout.new();
Hbox2.addItem(P2Ctls);

var P1Ctls = canvas.VBoxLayout.new();
Hbox2.addItem(P1Ctls);

### Fuel tanks ###

var P4Ctls2 = canvas.VBoxLayout.new();
Hbox3.addItem(P4Ctls2);

var P3Ctls2 = canvas.VBoxLayout.new();
Hbox3.addItem(P3Ctls2);

var P2Ctls2 = canvas.VBoxLayout.new();
Hbox3.addItem(P2Ctls2);

var P1Ctls2 = canvas.VBoxLayout.new();
Hbox3.addItem(P1Ctls2);


# Labels

#var Lbl_spacer = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0} )
#	.setText("")
#	.setFixedSize(80, 25);
#Hbox1RW.addItem(Lbl_spacer);

var Lbl_pyln4 = canvas.gui.widgets.Label.new(root, canvas.style, {} )
	.setText("P4:"~getprop("sim/weight[3]/selected"))
	.setFixedSize(100, 25);
#Hbox1RW.addItem(Lbl_pyln4);
P4Ctls.addItem(Lbl_pyln4);

var Lbl_pyln3 = canvas.gui.widgets.Label.new(root, canvas.style, {} )
	.setText("P3:"~getprop("sim/weight[2]/selected"))
	.setFixedSize(100, 25);
#Hbox1RW.addItem(Lbl_pyln3);
P3Ctls.addItem(Lbl_pyln3);

var Lbl_GSh23L = canvas.gui.widgets.Label.new(root, canvas.style, {} )
	.setText("GSh-23L: "~getprop("/controls/armament/roundsLeft"))
	.setFixedSize(100, 25);
Vbox1C.addItem(Lbl_GSh23L);

var Lbl_pyln2 = canvas.gui.widgets.Label.new(root, canvas.style, {} )
	.setText("P2:"~getprop("sim/weight[1]/selected"))
	.setFixedSize(100, 25);
#Hbox1LW.addItem(Lbl_pyln2);
P2Ctls.addItem(Lbl_pyln2);

var Lbl_pyln1 = canvas.gui.widgets.Label.new(root, canvas.style, {} )
	.setText("P1:"~getprop("sim/weight/selected"))
	.setFixedSize(100, 25);
#Hbox1LW.addItem(Lbl_pyln1);
P1Ctls.addItem(Lbl_pyln1);
#Hbox1LW.addItem(Lbl_spacer);

var P1_PTB = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 1})
	# .setText("kg" ~ getprop("consumables/fuel/tank[3]/level-kg"))
	.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[3]/level-kg")))
	.setFixedSize(95, 25);
var P2_PTB = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 1} )
	# .setText("kg:" ~ getprop("consumables/fuel/tank[4]/level-kg"))
	.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[4]/level-kg")))
	.setFixedSize(95, 25);
var P3_PTB = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 1} )
	# .setText("kg:" ~ getprop("consumables/fuel/tank[5]/level-kg"))
	.setText(sprintf("Fuel(kg): %3d", getprop("consumables/fuel/tank[5]/level-kg")))
	.setFixedSize(95, 25);
var P4_PTB = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 1} )
	# .setText("kg:" ~ getprop("consumables/fuel/tank[6]/level-kg"))
	.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[6]/level-kg")))
	.setFixedSize(95, 25);
var TotalFuelKg = canvas.gui.widgets.Label.new(root, canvas.style, {} )
	#.setText("Total Fuel (kg):" ~ getprop("consumables/fuel/total-fuel-kg"))
	.setText(sprintf("Total Fuel (kg): %4d", getprop("consumables/fuel/total-fuel-kg")))
	.setFixedSize(100, 25);

#Vbox1C.addItem(TotalFuelKg);

var pylons_update = func{
	Lbl_pyln1.setText("P1: "~getprop("sim/weight/selected"));
	Lbl_pyln2.setText("P2: "~getprop("sim/weight[1]/selected"));
	Lbl_pyln3.setText("P3: "~getprop("sim/weight[2]/selected"));
	Lbl_pyln4.setText("P4: "~getprop("sim/weight[3]/selected"));

	P1_PTB.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[3]/level-kg")));
	P2_PTB.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[4]/level-kg")));
	P3_PTB.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[5]/level-kg")));
	P4_PTB.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[6]/level-kg")));
	TotalFuelKg.setText(sprintf("Total Fuel (kg): %4d", getprop("consumables/fuel/total-fuel-kg")));
	}

######################################
#                                    #
# sim/weight[0]/weight-lb            #
# sim/weight[1]/weight-lb            #
# sim/weight[2]/weight-lb            #
# sim/weight[3]/weight-lb            #
#                                    #
######################################
#                                    #
# R-60M                              #
# UB-16 rockets pod                  #
# FAB-250 bomb                       #
# PK-3 MG pod                        #
# 150L fuel droptank                 #
# <lbs>278.025</lbs>                 #
# <gals>41.25</gals>                 #
#                                    #
######################################

######################################
#                                    #
#                /-\                 #
#  _____________/\_/\_____________   #
#    |     |    \___/    |    |      #
#                            1.L     #
#                            (0)     #
#                                    #
######################################
############## Pylon 1 ###############
######################################
#                                    #
#        - R-60M                     #
#        - UB-16 rockets pod         #
#        - PK-3 MG pod               #
#        - FAB-250 bomb              #
#        - 150L fuel droptank        #
#                                    #
######################################

# click button P1:none
var btn_P1_empty = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("none")
        .setFixedSize(90, 25);

btn_P1_empty.listen("clicked", func {
        # add code here to react on click on button.
		print("P1: none");
		setprop("sim/weight/selected","none");
        setprop("sim/weight/weight-lb", 0.0);
		setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);
		pylons_update();
		});
P1Ctls.addItem(btn_P1_empty);

# click button P1:R-60
var btn_P1_R60 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("R-60M")
        .setFixedSize(90, 25);

btn_P1_R60.listen("clicked", func {
        # add code here to react on click on button.
		print("P1: R-60M");
		setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);
		setprop("sim/weight/selected","R-60M");
		setprop("sim/weight/weight-lb",96);
		#setprop("fdm/jsbsim/inertia/pointmass-weight-lbs",96); # R-60 = 43.5 kg (96 lb)
		pylons_update();
		});
P1Ctls.addItem(btn_P1_R60);

# click button P1:UB-16
var btn_P1_UB16 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("UB-16")
        .setFixedSize(90, 25);

btn_P1_UB16.listen("clicked", func {
        # add code here to react on click on button.
		print("P1: UB-16");
		setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);
		setprop("sim/weight[0]/selected","UB-16 rockets pod");
		setprop("sim/weight[0]/weight-lb",304);
		setprop("/controls/armament/rocketsLeft", 16);
		setprop("/controls/armament/rocketsCount", 16);
		pylons_update();
		});
P1Ctls.addItem(btn_P1_UB16);

# click button P1:PK-3pod
var btn_P1_PK3 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("PK-3")
        .setFixedSize(90, 25);

btn_P1_PK3.listen("clicked", func {
        # add code here to react on click on button.
		print("P1: PK-3 pod");
		setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);
		setprop("sim/weight[0]/selected","PK-3 MG pod");
		setprop("sim/weight[0]/weight-lb",280);
		setprop("/controls/armament/PK3Left", 1500);
		setprop("/controls/armament/PK3Count", 1500);
		pylons_update();
		});
P1Ctls.addItem(btn_P1_PK3);

# click button P1:FAB-250
var btn_P1_FAB250 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("FAB-250")
        .setFixedSize(90, 25);

btn_P1_FAB250.listen("clicked", func {
        # add code here to react on click on button.
		print("P1: FAB-250");
		setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);
		setprop("sim/weight[0]/selected","FAB-250 bomb");
		setprop("sim/weight[0]/weight-lb",590);
		setprop("controls/armament/station[0]/release",0);
		pylons_update();
		});
P1Ctls.addItem(btn_P1_FAB250);

###################################
###                             ###
###       FuelTank 1-[0]-3      ###
###                             ###
###################################

# click button P1:PTB-150L
var btn_P1_PTB150 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("150L Tank")
        .setFixedSize(90, 25);

btn_P1_PTB150.listen("clicked", func {
        # add code here to react on click on button.
		print("P1: 150L droptank");
		setprop("/sim/weight[0]/selected","150L fuel droptank");
		setprop("sim/weight[0]/weight-lb",278.025);
		setprop("/consumables/fuel/tank[3]/selected", 1);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 41.25);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 41.25);
		pylons_update();
		});
P1Ctls.addItem(btn_P1_PTB150);


######################################
#                                    #
#                /-\                 #
#  _____________/\_/\_____________   #
#    |     |    \___/    |    |      #
#                       2.L          #
#                       (1)          #
#                                    #
######################################
############## Pylon 2 ###############
######################################
#                                    #
#        - R-60M                     #
#        - UB-16 rockets pod         #
#        - PK-3 MG pod               #
#        - FAB-250 bomb              #
#        - 150L fuel droptank        #
#                                    #
######################################

# click button P2:none
var btn_P2_empty = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("none")
        .setFixedSize(90, 25);

btn_P2_empty.listen("clicked", func {
        # add code here to react on click on button.
		print("P2: none");
		setprop("sim/weight[1]/selected","none");
		setprop("sim/weight[1]/weight-lb", 0.0);
		setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);
		pylons_update();
		});
P2Ctls.addItem(btn_P2_empty);

# click button P2:R-60
var btn_P2_R60 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("R-60M")
        .setFixedSize(90, 25);

btn_P2_R60.listen("clicked", func {
        # add code here to react on click on button.
		print("P1: R-60M");
		setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);
		setprop("sim/weight[1]/selected","R-60M");
		setprop("sim/weight[1]/weight-lb",96);
		pylons_update();
		});
P2Ctls.addItem(btn_P2_R60);

# click button P2:UB-16
var btn_P2_UB16 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("UB-16")
        #.move(300, 300)
        .setFixedSize(90, 25);

btn_P2_UB16.listen("clicked", func {
        # add code here to react on click on button.
		print("P2: UB-16");
		setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);
		setprop("sim/weight[1]/selected","UB-16 rockets pod");
		setprop("sim/weight[1]/weight-lb",304);
		setprop("/controls/armament/rocketsLeft", 16);
		setprop("/controls/armament/rocketsCount", 16);
		pylons_update();
		});
P2Ctls.addItem(btn_P2_UB16);

# click button P2:PK-3pod
var btn_P2_PK3 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("PK-3")
        .setFixedSize(90, 25);

btn_P2_PK3.listen("clicked", func {
        # add code here to react on click on button.
		print("P2: PK-3 pod");
		setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);
		setprop("sim/weight[1]/selected","PK-3 MG pod");
		setprop("sim/weight[1]/weight-lb",280);
		setprop("/controls/armament/PK3Left", 1500);
		setprop("/controls/armament/PK3Count", 1500);
		pylons_update();
		});
P2Ctls.addItem(btn_P2_PK3);

# click button P2:FAB-250
var btn_P2_FAB250 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("FAB-250")
        .setFixedSize(90, 25);

btn_P2_FAB250.listen("clicked", func {
        # add code here to react on click on button.
		print("P2: FAB-250");
		setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);
		setprop("sim/weight[1]/selected","FAB-250 bomb");
		setprop("sim/weight[1]/weight-lb",590);
		setprop("controls/armament/station[1]/release",0);
		pylons_update();
		});
P2Ctls.addItem(btn_P2_FAB250);

###################################
###                             ###
###       FuelTank 2-[1]-4      ###
###                             ###
###################################

# click button P2:PTB-150L
var btn_P2_PTB150 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("150L Tank")
        .setFixedSize(90, 25);

btn_P2_PTB150.listen("clicked", func {
        # add code here to react on click on button.
		print("P2: 150L droptank");
		setprop("/sim/weight[1]/selected","150L fuel droptank");
		setprop("sim/weight[1]/weight-lb",278.025);
		setprop("/consumables/fuel/tank[4]/selected", 1);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 41.25);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 41.25);
		pylons_update();
		});
P2Ctls.addItem(btn_P2_PTB150);

######################################
#                                    #
#                /-\                 #
#  _____________/\_/\_____________   #
#    |     |    \___/    |    |      #
#         3.R                        #
#         (2)                        #
#                                    #
######################################
############## Pylon 3 ###############
######################################
#                                    #
#        - R-60M                     #
#        - UB-16 rockets pod         #
#        - PK-3 MG pod               #
#        - FAB-250 bomb              #
#        - 150L fuel droptank        #
#                                    #
######################################

# click button P3:none
var btn_P3_empty = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("none")
        .setFixedSize(90, 25);

btn_P3_empty.listen("clicked", func {
        # add code here to react on click on button.
		print("P3: none");
		setprop("sim/weight[2]/selected","none");
		setprop("sim/weight[2]/weight-lb", 0.0);
		setprop("/consumables/fuel/tank[5]/selected", 0);
		setprop("/consumables/fuel/tank[5]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[5]/level-gal_us", 0.0);
		pylons_update();
		});
P3Ctls.addItem(btn_P3_empty);

# click button P3:R-60
var btn_P3_R60 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("R-60M")
        .setFixedSize(90, 25);

btn_P3_R60.listen("clicked", func {
        # add code here to react on click on button.
		print("P3: R-60M");
		setprop("/consumables/fuel/tank[5]/selected", 0);
		setprop("/consumables/fuel/tank[5]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[5]/level-gal_us", 0.0);
		setprop("sim/weight[2]/selected","R-60M");
		setprop("sim/weight[2]/weight-lb",96);
		pylons_update();
		});
P3Ctls.addItem(btn_P3_R60);

# click button P3:UB-16
var btn_P3_UB16 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("UB-16")
        .setFixedSize(90, 25);

btn_P3_UB16.listen("clicked", func {
        # add code here to react on click on button.
		print("P3: UB-16");
		setprop("/consumables/fuel/tank[5]/selected", 0);
		setprop("/consumables/fuel/tank[5]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[5]/level-gal_us", 0.0);
		setprop("sim/weight[2]/selected","UB-16 rockets pod");
		setprop("sim/weight[2]/weight-lb",304);
		setprop("/controls/armament/rocketsLeft", 16);
		setprop("/controls/armament/rocketsCount", 16);
		pylons_update();
		});
P3Ctls.addItem(btn_P3_UB16);

# click button P3:PK-3pod
var btn_P3_PK3 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("PK-3")
        .setFixedSize(90, 25);

btn_P3_PK3.listen("clicked", func {
        # add code here to react on click on button.
		print("P3: PK-3 pod");
		setprop("/consumables/fuel/tank[5]/selected", 0);
		setprop("/consumables/fuel/tank[5]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[5]/level-gal_us", 0.0);
		setprop("sim/weight[2]/selected","PK-3 MG pod");
		setprop("sim/weight[2]/weight-lb",280);
		setprop("/controls/armament/PK3Left", 1500);
		setprop("/controls/armament/PK3Count", 1500);
		pylons_update();
		});
P3Ctls.addItem(btn_P3_PK3);

# click button P3:FAB-250
var btn_P3_FAB250 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("FAB-250")
        .setFixedSize(90, 25);

btn_P3_FAB250.listen("clicked", func {
        # add code here to react on click on button.
		print("P3: FAB-250");
		setprop("/consumables/fuel/tank[5]/selected", 0);
		setprop("/consumables/fuel/tank[5]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[5]/level-gal_us", 0.0);
		setprop("sim/weight[2]/selected","FAB-250 bomb");
		setprop("sim/weight[2]/weight-lb",590);
		setprop("controls/armament/station[2]/release",0);
		pylons_update();
		});
P3Ctls.addItem(btn_P3_FAB250);

###################################
###                             ###
###       FuelTank 3-[2]-5      ###
###                             ###
###################################

# click button P3:PTB-150L
var btn_P3_PTB150 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("150L Tank")
        .setFixedSize(90, 25);

btn_P3_PTB150.listen("clicked", func {
        # add code here to react on click on button.
		print("P3: 150L droptank");
		setprop("/sim/weight[2]/selected","150L fuel droptank");
		setprop("sim/weight[2]/weight-lb",278.025);
		setprop("/consumables/fuel/tank[5]/selected", 1);
		setprop("/consumables/fuel/tank[5]/capacity-gal_us", 41.25);
		setprop("/consumables/fuel/tank[5]/level-gal_us", 41.25);
		pylons_update();
		});
P3Ctls.addItem(btn_P3_PTB150);

######################################
#                                    #
#                /-\                 #
#  _____________/\_/\_____________   #
#    |     |    \___/    |    |      #
#   4.R                              #
#   (3)                              #
#                                    #
######################################
############## Pylon 4 ###############
######################################
#                                    #
#        - R-60M                     #
#        - UB-16 rockets pod         #
#        - PK-3 MG pod               #
#        - FAB-250 bomb              #
#        - 150L fuel droptank        #
#                                    #
######################################

# click button P4:none
var btn_P4_empty = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("none")
        .setFixedSize(90, 25);

btn_P4_empty.listen("clicked", func {
        # add code here to react on click on button.
		print("P4: none");
		setprop("sim/weight[3]/selected","none");
		setprop("sim/weight[3]/weight-lb", 0.0);
		setprop("/consumables/fuel/tank[6]/selected", 0);
		setprop("/consumables/fuel/tank[6]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[6]/level-gal_us", 0.0);
		pylons_update();
		});
P4Ctls.addItem(btn_P4_empty);

# click button P3:R-60
var btn_P4_R60 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("R-60M")
        .setFixedSize(90, 25);

btn_P4_R60.listen("clicked", func {
        # add code here to react on click on button.
		print("4: R-60M");
		setprop("/consumables/fuel/tank[6]/selected", 0);
		setprop("/consumables/fuel/tank[6]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[6]/level-gal_us", 0.0);
		setprop("sim/weight[3]/selected","R-60M");
		setprop("sim/weight[3]/weight-lb",96);
		pylons_update();
		});
P4Ctls.addItem(btn_P4_R60);

# click button P3:UB-16
var btn_P4_UB16 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("UB-16")
        .setFixedSize(90, 25);

btn_P4_UB16.listen("clicked", func {
        # add code here to react on click on button.
		print("P4: UB-16");
		setprop("/consumables/fuel/tank[6]/selected", 0);
		setprop("/consumables/fuel/tank[6]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[6]/level-gal_us", 0.0);
		setprop("sim/weight[3]/selected","UB-16 rockets pod");
		setprop("sim/weight[3]/weight-lb",304);
		setprop("/controls/armament/rocketsLeft", 16);
		setprop("/controls/armament/rocketsCount", 16);
		pylons_update();
		});
P4Ctls.addItem(btn_P4_UB16);

# click button P3:PK-3pod
var btn_P4_PK3 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("PK-3")
        .setFixedSize(90, 25);

btn_P4_PK3.listen("clicked", func {
        # add code here to react on click on button.
		print("P4: PK-3 pod");
		setprop("/consumables/fuel/tank[6]/selected", 0);
		setprop("/consumables/fuel/tank[6]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[6]/level-gal_us", 0.0);
		setprop("sim/weight[3]/selected","PK-3 MG pod");
		setprop("sim/weight[3]/weight-lb",280);
		setprop("/controls/armament/PK3Left", 1500);
		setprop("/controls/armament/PK3Count", 1500);
		pylons_update();
		});
P4Ctls.addItem(btn_P4_PK3);

# click button P3:FAB-250
var btn_P4_FAB250 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("FAB-250")
        .setFixedSize(90, 25);

btn_P4_FAB250.listen("clicked", func {
        # add code here to react on click on button.
		print("P4: FAB-250");
		setprop("/consumables/fuel/tank[6]/selected", 0);
		setprop("/consumables/fuel/tank[6]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[6]/level-gal_us", 0.0);
		setprop("sim/weight[3]/selected","FAB-250 bomb");
		setprop("sim/weight[3]/weight-lb",590);
		setprop("controls/armament/station[3]/release",0);
		pylons_update();
		});
P4Ctls.addItem(btn_P4_FAB250);


###################################
###                             ###
###       FuelTank 4-[3]-6      ###
###                             ###
###################################

# click button P4:PTB-150L
var btn_P4_PTB150 = canvas.gui.widgets.Button.new(root, canvas.style, {})
        .setText("150L Tank")
        #.move(300, 300)
        .setFixedSize(90, 25);

btn_P4_PTB150.listen("clicked", func {
        # add code here to react on click on button.
		print("P4: 150L droptank");
		setprop("/sim/weight[3]/selected","150L fuel droptank");
		setprop("sim/weight[3]/weight-lb",278.025);
		setprop("/consumables/fuel/tank[6]/selected", 1);
		setprop("/consumables/fuel/tank[6]/capacity-gal_us", 41.25);
		setprop("/consumables/fuel/tank[6]/level-gal_us", 41.25);
		pylons_update();
		});
P4Ctls.addItem(btn_P4_PTB150);

# spacers
var SpaceFiller=canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
SpaceFiller.setText("")
.setFixedSize(90, 25);

#P4Ctls.addItem(SpaceFiller);

#P3Ctls.addItem(SpaceFiller);

#P2Ctls.addItem(SpaceFiller);
#P2Ctls.addItem(SpaceFiller);

#P1Ctls.addItem(SpaceFiller);
#P1Ctls.addItem(SpaceFiller);

###
P4Ctls.addItem(P4_PTB);
P3Ctls.addItem(P3_PTB);
P2Ctls.addItem(P2_PTB);
P1Ctls.addItem(P1_PTB);
#P1Ctls2.addItem(SpaceFiller);

####info####
var statusbar =canvas.HBoxLayout.new();
mainVBox.addItem(statusbar);

statusbar.addItem(TotalFuelKg);

#statusbar.addItem(P4_PTB);
#statusbar.addItem(P3_PTB);
#statusbar.addItem(P2_PTB);
#statusbar.addItem(P1_PTB);

#var version=canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
#version.setText("FlightGear v" ~ getprop("/sim/version/flightgear"));
#statusbar.addItem(version);

#var AircraftName=canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
#AircraftName.setText("                  Su-25SM3");
#statusbar.addItem(AircraftName);

#var AircraftDeveloper=canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
#AircraftDeveloper.setText("                  Sergei Solyshko, 2021");
#statusbar.addItem(AircraftDeveloper);



}
