var showKneepadDlg = func{
var (width,height) = (888,1000);
var title = 'L-39C Kneepad:';
setprop("/sim/menubar/visibility",0);

# path is relative to $FG_ROOT (base package)
var path0 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-0.png";
var path1 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-1.png";
var path2 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-2.png";
var path3 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-3.png";
var path4 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-4.png";
var path5 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-5.png";
var path6 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-6.png";
var path7 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-7.png";
var path8 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-8.png";
var path9 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-9.png";
var pathP = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-P.png";
var pathM = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-M.png";
var pathM1 = "Aircraft/L-39/gui/dialogs/kneepad/L-39C-Kneepad-M1.png";

 
# create a new window, dimensions are WIDTH x HEIGHT, using the dialog decoration (i.e. titlebar)
var window = canvas.Window.new([width,height],"dialog").set('title',title);
 
# adding a canvas to the new window and setting up background colors/transparency
var myCanvas = window.createCanvas().set("background", canvas.style.getColor("bg_color"));
 
# creating the top-level/root group which will contain all other elements/group
var root = myCanvas.createGroup();

#myCanvas.setColorBackground(0.3, 0.3, 0.3, 1.0);
 
# create a new layout for the dialog:
var mainHBox = canvas.HBoxLayout.new();
# assign the layout to the Canvas

myCanvas.setLayout(mainHBox);

# Space Filler
var VboxLeft = canvas.VBoxLayout.new();
mainHBox.addItem(VboxLeft);

var VboxRight = canvas.VBoxLayout.new(); # Select Page Buttons
mainHBox.addItem(VboxRight);

#########################################

var OnGround = getprop("/gear/gear[0]/wow");

var pylons_update = func{
	Lbl_pyln1.setText("P1: "~getprop("sim/weight/selected"));
	Lbl_pyln2.setText("P2: "~getprop("sim/weight[1]/selected"));

	P1_PTB.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[3]/level-kg")));
	P2_PTB.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[4]/level-kg")));
	TotalFuelKg.setText(sprintf("Total Fuel (kg): %4d", getprop("consumables/fuel/total-fuel-kg")));
	}

######################################
#                                    #
#                /-\                 #
#  _____________/\_/\_____________   #
#    |          \___/         |      #
#   2.R                      1.L     #
#   (1)                      (0)     #
#                                    #
######################################
############ Pylons 1-2 ##############
######################################
#                                    #
#        - R-60M                     #
#        - UB-16 rockets pod         #
#        - PK-3 MG pod               #
#        - FAB-250 bomb              #
#        - 150L fuel droptank        #
#                                    #
######################################

var Load_NONE = func() {
        if (OnGround)
        {
		print("P1-2: clean");
    
		setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);

		setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);

    setprop("sim/weight/selected","none");
    setprop("sim/weight/weight-lb", 0.0);

    setprop("sim/weight[1]/selected","none");
		setprop("sim/weight[1]/weight-lb", 0.0);

		pylons_update();
        }
        else {
            screen.log.write("You must be still on the ground to rearm! ", 1, 0.6, 0.1);
        }
		};

var Load_R60 = func() {
        if (OnGround)
        {
		print("P1-2: R-60M missiles");
    setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);

		setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);

    setprop("sim/weight/selected","R-60M");
		setprop("sim/weight/weight-lb",96);

		setprop("sim/weight[1]/selected","R-60M");
		setprop("sim/weight[1]/weight-lb",96);

		pylons_update();
        }
        else {
            screen.log.write("You must be still on the ground to rearm! ", 1, 0.6, 0.1);
        }
		};

var Load_UB16 = func() {
        if (OnGround)
        {
		print("P1-2: UB-16 rocket pods");

		setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);
		
    setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);
    
    setprop("sim/weight[0]/selected","UB-16 rockets pod");
		setprop("sim/weight[0]/weight-lb",304);

		setprop("sim/weight[1]/selected","UB-16 rockets pod");
		setprop("sim/weight[1]/weight-lb",304);

		setprop("/controls/armament/rocketsLeft1", 16);
		setprop("/controls/armament/rocketsCount1", 16);
		pylons_update();
        }
        else {
            screen.log.write("You must be still on the ground to rearm! ", 1, 0.6, 0.1);
        }
		};

  var Load_PK3 = func() {
        if (OnGround)
        {
		print("P1-2: PK-3 gun pods");

		setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);

    setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);

		setprop("sim/weight[0]/selected","PK-3 MG pod");
		setprop("sim/weight[0]/weight-lb",280);

		setprop("sim/weight[1]/selected","PK-3 MG pod");
		setprop("sim/weight[1]/weight-lb",280);

		setprop("/controls/armament/PK3Left", 1500);
		setprop("/controls/armament/PK3Count", 1500);

		pylons_update();
        }
        else {
            screen.log.write("You must be still on the ground to rearm! ", 1, 0.6, 0.1);
        }
		};

  var Load_FAB250 = func() {
        if (OnGround)
        {
		print("P1-2: FAB-250 bombs");

		setprop("/consumables/fuel/tank[3]/selected", 0);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 0.0);

    setprop("/consumables/fuel/tank[4]/selected", 0);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 0.0);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 0.0);

		setprop("sim/weight[0]/selected","FAB-250 bomb");
		setprop("sim/weight[0]/weight-lb",590);
		setprop("controls/armament/station[0]/release",0);

    setprop("sim/weight[1]/selected","FAB-250 bomb");
		setprop("sim/weight[1]/weight-lb",590);
		setprop("controls/armament/station[1]/release",0);

		pylons_update();
        }
        else {
            screen.log.write("You must be still on the ground to rearm! ", 1, 0.6, 0.1);
        }
		};

  var Load_FT = func() {
        if (OnGround)
        {
		print("P1-2: 150L droptanks");

		setprop("/sim/weight[0]/selected","150L fuel droptank");
		setprop("sim/weight[0]/weight-lb",278.025);

    setprop("/sim/weight[1]/selected","150L fuel droptank");
		setprop("sim/weight[1]/weight-lb",278.025);

		setprop("/consumables/fuel/tank[3]/selected", 1);
		setprop("/consumables/fuel/tank[3]/capacity-gal_us", 41.25);
		setprop("/consumables/fuel/tank[3]/level-gal_us", 41.25);

		setprop("/consumables/fuel/tank[4]/selected", 1);
		setprop("/consumables/fuel/tank[4]/capacity-gal_us", 41.25);
		setprop("/consumables/fuel/tank[4]/level-gal_us", 41.25);

		pylons_update();
        }
        else {
            screen.log.write("You must be still on the ground to rearm! ", 1, 0.6, 0.1);
        }
		};

#########################################

#payload page

var p = window.getCanvas(2).createGroup();

p.hide();

var payload_root = p.getCanvas().createGroup()
.set("z-index", 5);

var P1_PTB = canvas.gui.widgets.Label.new(payload_root, canvas.style, {wordWrap: 1})
	.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[3]/level-kg")))
	.setFixedSize(95, 25);
var P2_PTB = canvas.gui.widgets.Label.new(payload_root, canvas.style, {wordWrap: 1} )
	.setText(sprintf("Fuel (kg): %3d", getprop("consumables/fuel/tank[4]/level-kg")))
	.setFixedSize(95, 25);
var TotalFuelKg = canvas.gui.widgets.Label.new(payload_root, canvas.style, {} )
	.setText(sprintf("Total Fuel (kg): %4d", getprop("consumables/fuel/total-fuel-kg")))
	.setFixedSize(100, 25);

var Lbl_pyln2 = canvas.gui.widgets.Label.new(payload_root, canvas.style, {} )
	.setText("P2:"~getprop("sim/weight[1]/selected"))
	.setFixedSize(100, 25);

var Lbl_pyln1 = canvas.gui.widgets.Label.new(payload_root, canvas.style, {} )
	.setText("P1:"~getprop("sim/weight/selected"))
	.setFixedSize(100, 25);

var pylons_hbox = canvas.HBoxLayout.new();

pylons_hbox.addSpacing(4);
pylons_hbox.addItem(Lbl_pyln2);
pylons_hbox.addSpacing(440);
pylons_hbox.addItem(Lbl_pyln1);
pylons_hbox.addSpacing(30);

var payload_vbox = canvas.VBoxLayout.new();
window.setLayout(payload_vbox);

var statusbar = canvas.HBoxLayout.new();
statusbar.addItem(P2_PTB);
statusbar.addItem(TotalFuelKg);
statusbar.addItem(P1_PTB);

var payload_hbox = canvas.HBoxLayout.new();
payload_vbox.addSpacing(320);
payload_vbox.addItem(pylons_hbox);
payload_vbox.addItem(payload_hbox);
payload_vbox.addItem(statusbar);
payload_vbox.addSpacing(420);

var button_none = canvas.gui.widgets.Button.new(payload_root, canvas.style, {}).setText("none").listen("clicked", func Load_NONE(1));
var button_R60 = canvas.gui.widgets.Button.new(payload_root, canvas.style, {}).setText("R-60M").listen("clicked", func Load_R60());
var button_S5 = canvas.gui.widgets.Button.new(payload_root, canvas.style, {}).setText("UB-16").listen("clicked", func Load_UB16());
var button_PK3 = canvas.gui.widgets.Button.new(payload_root, canvas.style, {}).setText("PK-3").listen("clicked", func Load_PK3());
var button_FAB250 = canvas.gui.widgets.Button.new(payload_root, canvas.style, {}).setText("FAB-250").listen("clicked", func Load_FAB250());
var button_FT = canvas.gui.widgets.Button.new(payload_root, canvas.style, {}).setText("Drop Tank").listen("clicked", func Load_FT(-1));

button_none.setSizeHint([84, 25]);
button_R60.setSizeHint([84, 25]);
button_S5.setSizeHint([84, 25]);
button_PK3.setSizeHint([84, 25]);
button_FAB250.setSizeHint([84, 25]);
button_FT.setSizeHint([84, 25]);

var payload_button_box = canvas.VBoxLayout.new();
payload_button_box.addStretch(1);
payload_button_box.addItem(button_none);
payload_button_box.addItem(button_R60);
payload_button_box.addItem(button_S5);
payload_button_box.addItem(button_PK3);
payload_button_box.addItem(button_FAB250);
payload_button_box.addItem(button_FT);
payload_button_box.addSpacing(20);

payload_hbox.addSpacing(400);
payload_hbox.addItem(payload_button_box);

payload_hbox.addStretch(1);

payload_root.hide();

#########################################

var tile_size = 256;

#var window = canvas.Window.new([width, height],"dialog").set('title', "Tile map demo");
var g = window.getCanvas(1).createGroup();

g.hide();

# Simple user interface (Buttons for zoom and label for displaying it)
var zoom = 10;
var type = "intl";

var map_root = g.getCanvas().createGroup()
.set("z-index", 4);
var map_vbox = canvas.HBoxLayout.new();
window.setLayout(map_vbox);

var button_in = canvas.gui.widgets.Button.new(map_root, canvas.style, {}).setText("+").listen("clicked", func changeZoom(1));
var button_out = canvas.gui.widgets.Button.new(map_root, canvas.style, {}).setText("-").listen("clicked", func changeZoom(-1));
button_in.setSizeHint([32, 32]);
button_out.setSizeHint([32, 32]);

var label_zoom = canvas.gui.widgets.Label.new(map_root, canvas.style, {});
label_zoom.setSizeHint([32, 32]);

var map_button_box = canvas.VBoxLayout.new();
map_button_box.addStretch(1);
map_button_box.addItem(button_in);
#map_button_box.addSpacing(30);
map_button_box.addItem(label_zoom);
map_button_box.addItem(button_out);
map_button_box.addSpacing(60);

map_vbox.addSpacing(115);
map_vbox.addItem(map_button_box);
map_vbox.addStretch(1);

map_root.hide();

var changeZoom = func(d)
{
  zoom = math.max(2, math.min(19, zoom + d));
  label_zoom.setText("Zoom " ~ zoom);
  updateTiles();
}

# http://polymaps.org/docs/
# https://github.com/simplegeo/polymaps
# https://github.com/Leaflet/Leaflet

var maps_base = getprop("/sim/fg-home") ~ '/cache/maps';

# http://otile1.mqcdn.com/tiles/1.0.0/map
# http://otile1.mqcdn.com/tiles/1.0.0/sat
# (also see http://wiki.openstreetmap.org/wiki/Tile_usage_policy)
var makeUrl =
#string.compileTemplate('https://maps.wikimedia.org/osm-{type}/{z}/{x}/{y}.png');
string.compileTemplate('https://b.tile.openstreetmap.org/{z}/{x}/{y}.png');
  #https://maps.wikimedia.org/osm-intl/${z}/${x}/${y}.png
  var makePath =
  string.compileTemplate(maps_base ~ '/osm-{type}/{z}/{x}/{y}.png');
  var num_tiles = [5, 5];

  var center_tile_offset = [
  (num_tiles[0] - 1) / 2,
  (num_tiles[1] - 1) / 2
  ];

MyPosCenter = g.createChild("group")
			.setTranslation(tile_size * center_tile_offset[0] - 1, tile_size * center_tile_offset[1])
      .set("z-index",  1);
      #.setTranslation(width/2,height/2);
# simple aircraft icon at current position/center of the map
selfSymbol = MyPosCenter.createChild("path")
#g.createChild("path")
      .moveTo(-10, 0)
      .horiz(20)
      .move(-10, 14)
      .vert(-22)
      .move(-4, 22)
      .horiz(8)
      .move(-4, -26)
      .vert(-800)

.set("stroke", "red")
.set("stroke-width", 2)
.set("z-index", 2);



##
# initialize the map by setting up
# a grid of raster images  

var tiles = setsize([], num_tiles[0]);
for(var x = 0; x < num_tiles[0]; x += 1)
{
  tiles[x] = setsize([], num_tiles[1]);
  for(var y = 0; y < num_tiles[1]; y += 1)
  tiles[x][y] = g.createChild("image", "map-tile");
}

var kneepad_frame = g.createChild("image", "map_frame")
    .setFile(pathM)
    .setTranslation(0, 0)
    #.setSize(842, 1000);
    .setSize(888, 1000)
    .set("z-index", 3);

var last_tile = [-1,-1];
var last_type = type;

##
# this is the callback that will be regularly called by the timer

# to update the map
var updateTiles = func()
{

  var my_heading = getprop('/orientation/heading-deg');
  MyPosCenter.setRotation(my_heading*D2R);
  # get current position
  var lat = getprop('/position/latitude-deg');
  var lon = getprop('/position/longitude-deg');

  var n = math.pow(2, zoom);
  var offset = [
  n * ((lon + 180) / 360) - center_tile_offset[0],
  (1 - math.ln(math.tan(lat * math.pi/180) + 1 / math.cos(lat * math.pi/180)) / math.pi) / 2 * n - center_tile_offset[1]
  ];
  var tile_index = [int(offset[0]), int(offset[1])];

  var ox = tile_index[0] - offset[0];
  var oy = tile_index[1] - offset[1];

  for(var x = 0; x < num_tiles[0]; x += 1)
  for(var y = 0; y < num_tiles[1]; y += 1)
  tiles[x][y].setTranslation(int((ox + x) * tile_size + 0.5), int((oy + y) * tile_size + 0.5));

  if(    tile_index[0] != last_tile[0]
    or tile_index[1] != last_tile[1]
    or type != last_type )
  {
    for(var x = 0; x < num_tiles[0]; x += 1)
    for(var y = 0; y < num_tiles[1]; y += 1)
    {
      var pos = {
        z: zoom,
        x: int(offset[0] + x),
        y: int(offset[1] + y),
        type: type
      };

      (func {
        var img_path = makePath(pos);
        var tile = tiles[x][y];

        if( io.stat(img_path) == nil )
        { # image not found, save in $FG_HOME
          var img_url = makeUrl(pos);
          #print('requesting ' ~ img_url);
          http.save(img_url, img_path)
          .done(func {print('received image ' ~ img_path); tile.set("src", img_path);})
          .fail(func (r) print('Failed to get image ' ~ img_path ~ ' ' ~ r.status ~ ': ' ~ r.reason));
        }
        else # cached image found, reusing
        {
          #print('loading ' ~ img_path);
          tile.set("src", img_path)
        }
        })();
      }

      last_tile = tile_index;
      last_type = type;
    }
  };

##
# set up a timer that will invoke updateTiles at 2-second intervals
var map_update_timer = maketimer(1, updateTiles);
# actually start the timer
map_update_timer.start();

##
# set up default zoom level
changeZoom(0);

###
# The following lines were recently added and have not yet been tested
# (if in doubt, remove them)
window.del = func()
{
  print("Cleaning up window:", ,"\n");
  map_update_timer.stop();
# explanation for the call() technique at: http://wiki.flightgear.org/Object_oriented_programming_in_Nasal#Making_safer_base-class_calls
call(canvas.Window.del, [], me);
};

#########################################

# create an image child for the texture
var kneepad_page = root.createChild("image")
    .setFile(path0)
    .setTranslation(0, 0)
    .setSize(888, 1000);

var ui_root = window.getCanvas().createGroup();
var hbox = canvas.HBoxLayout.new();
window.setLayout(hbox);

var page_button_1 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("1").listen("clicked", func {kneepad_page.setFile(path1); g.hide(); map_root.hide(); map_update_timer.stop(); p.hide(); payload_root.hide();});
var page_button_2 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("2").listen("clicked", func {kneepad_page.setFile(path2); g.hide(); map_root.hide(); map_update_timer.stop(); p.hide(); payload_root.hide();});
var page_button_3 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("3").listen("clicked", func {kneepad_page.setFile(path3); g.hide(); map_root.hide(); map_update_timer.stop(); p.hide(); payload_root.hide();});
var page_button_4 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("4").listen("clicked", func {kneepad_page.setFile(path4); g.hide(); map_root.hide(); map_update_timer.stop(); p.hide(); payload_root.hide();});
var page_button_5 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("5").listen("clicked", func {kneepad_page.setFile(path5); g.hide(); map_root.hide(); map_update_timer.stop(); p.hide(); payload_root.hide();});
var page_button_6 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("6").listen("clicked", func {kneepad_page.setFile(path6); g.hide(); map_root.hide(); map_update_timer.stop(); p.hide(); payload_root.hide();});
var page_button_7 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("7").listen("clicked", func {kneepad_page.setFile(path7); g.hide(); map_root.hide(); map_update_timer.stop(); p.hide(); payload_root.hide();});
var page_button_8 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("8").listen("clicked", func {kneepad_page.setFile(path8); g.hide(); map_root.hide(); map_update_timer.stop(); p.hide(); payload_root.hide();});
var page_button_9 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("9").listen("clicked", func {kneepad_page.setFile(path9); g.hide(); map_root.hide(); map_update_timer.stop(); p.hide(); payload_root.hide();});
var page_button_P = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("P").listen("clicked", func {kneepad_page.setFile(pathP); g.hide(); map_root.hide(); map_update_timer.stop(); p.show(); payload_root.show();});
var page_button_M = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("M").listen("clicked", func {kneepad_page.setFile(pathM1); g.show(); map_root.show(); map_update_timer.start(); p.hide(); payload_root.hide();});

page_button_1.setSizeHint([40, 29]);
page_button_2.setSizeHint([40, 29]);
page_button_3.setSizeHint([40, 29]);
page_button_4.setSizeHint([40, 29]);
page_button_5.setSizeHint([40, 29]);
page_button_6.setSizeHint([40, 29]);
page_button_7.setSizeHint([40, 29]);
page_button_8.setSizeHint([40, 29]);
page_button_9.setSizeHint([40, 29]);
page_button_P.setSizeHint([40, 29]);
page_button_M.setSizeHint([40, 29]);

#var label_zoom = canvas.gui.widgets.Label.new(ui_root, canvas.style, {});

var button_box = canvas.VBoxLayout.new();
button_box.addSpacing(23);
button_box.addItem(page_button_1);
button_box.addItem(page_button_2);
button_box.addItem(page_button_3);
button_box.addItem(page_button_4);
button_box.addItem(page_button_5);
button_box.addItem(page_button_6);
button_box.addItem(page_button_7);
button_box.addItem(page_button_8);
button_box.addItem(page_button_9);
button_box.addItem(page_button_P);
button_box.addItem(page_button_M);
button_box.addSpacing(23);

hbox.addStretch(1);
hbox.addItem(button_box);
hbox.addSpacing(6);
#hbox.addStretch(1);

#var AircraftDeveloper=canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
#AircraftDeveloper.setText("                  Sergei Solyshko, 2023");
#statusbar.addItem(AircraftDeveloper);

}
