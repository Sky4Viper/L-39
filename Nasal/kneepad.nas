var showKneepadDlg = func{
var (width,height) = (888,1000);
var title = 'L-39ZA Kneepad:';
setprop("/sim/menubar/visibility",0);

# path is relative to $FG_ROOT (base package)
var path0 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-0.png";
var path1 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-1.png";
var path2 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-2.png";
var path3 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-3.png";
var path4 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-4.png";
var path5 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-5.png";
var path6 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-6.png";
var path7 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-7.png";
var path8 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-8.png";
var path9 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-9.png";
var pathM = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-M.png";
var pathM1 = "Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-M1.png";

 
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

var page_button_1 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("1").listen("clicked", func {kneepad_page.setFile(path1); g.hide(); map_root.hide(); map_update_timer.stop();});
var page_button_2 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("2").listen("clicked", func {kneepad_page.setFile(path2); g.hide(); map_root.hide(); map_update_timer.stop();});
var page_button_3 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("3").listen("clicked", func {kneepad_page.setFile(path3); g.hide(); map_root.hide(); map_update_timer.stop();});
var page_button_4 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("4").listen("clicked", func {kneepad_page.setFile(path4); g.hide(); map_root.hide(); map_update_timer.stop();});
var page_button_5 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("5").listen("clicked", func {kneepad_page.setFile(path5); g.hide(); map_root.hide(); map_update_timer.stop();});
var page_button_6 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("6").listen("clicked", func {kneepad_page.setFile(path6); g.hide(); map_root.hide(); map_update_timer.stop();});
var page_button_7 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("7").listen("clicked", func {kneepad_page.setFile(path7); g.hide(); map_root.hide(); map_update_timer.stop();});
var page_button_8 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("8").listen("clicked", func {kneepad_page.setFile(path8); g.hide(); map_root.hide(); map_update_timer.stop();});
var page_button_9 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("9").listen("clicked", func {kneepad_page.setFile(path9); g.hide(); map_root.hide(); map_update_timer.stop();});
var page_button_M = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("M").listen("clicked", func {kneepad_page.setFile(pathM1); g.show(); map_root.show(); map_update_timer.start();});

page_button_1.setSizeHint([40, 32]);
page_button_2.setSizeHint([40, 32]);
page_button_3.setSizeHint([40, 32]);
page_button_4.setSizeHint([40, 32]);
page_button_5.setSizeHint([40, 32]);
page_button_6.setSizeHint([40, 32]);
page_button_7.setSizeHint([40, 32]);
page_button_8.setSizeHint([40, 32]);
page_button_9.setSizeHint([40, 32]);
page_button_M.setSizeHint([40, 32]);

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
