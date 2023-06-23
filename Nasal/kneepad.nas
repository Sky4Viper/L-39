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

#var (width,height) = (768,512);
var tile_size = 256;

#var window = canvas.Window.new([width, height],"dialog").set('title', "Tile map demo");
var g = window.getCanvas(1).createGroup();

g.hide();


# Simple user interface (Buttons for zoom and label for displaying it)
var zoom = 10;
var type = "intl";

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
string.compileTemplate('https://maps.wikimedia.org/osm-{type}/{z}/{x}/{y}.png');
  #https://maps.wikimedia.org/osm-intl/${z}/${x}/${y}.png
  var makePath =
  string.compileTemplate(maps_base ~ '/osm-{type}/{z}/{x}/{y}.png');
  var num_tiles = [5, 5];

  var center_tile_offset = [
  (num_tiles[0] - 1) / 2,
  (num_tiles[1] - 1) / 2
  ];

# simple aircraft icon at current position/center of the map
g.createChild("path")
.moveTo( tile_size * center_tile_offset[0] - 1,
  tile_size * center_tile_offset[1] )
#.horiz(20)
#.move(-10,-10)
#.vert(20)

			#.horiz(2)
			#.move(-1, -1)
			#.vert(2)
      #.move(0, 7)
      #.line(-8, -16)
      #.horiz(16)
      #.line(-8, 16)
      #.vert(5)
      #.move(0, -21)
      #.vert(-5)
      #.move(-2, 2)
      #.horiz(4)

      .horiz(20)
      .move(-10, 14)
      .vert(-22)
      .move(-4, 22)
      .horiz(8)




.set("stroke", "red")
.set("stroke-width", 2)
.set("z-index", 1);


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
    .setSize(891, 1000);

var last_tile = [-1,-1];
var last_type = type;

##
# this is the callback that will be regularly called by the timer
# to update the map
var updateTiles = func()
{
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
          print('requesting ' ~ img_url);
          http.save(img_url, img_path)
          .done(func {print('received image ' ~ img_path); tile.set("src", img_path);})
          .fail(func (r) print('Failed to get image ' ~ img_path ~ ' ' ~ r.status ~ ': ' ~ r.reason));
        }
        else # cached image found, reusing
        {
          print('loading ' ~ img_path);
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
var update_timer = maketimer(2, updateTiles);
# actually start the timer
update_timer.start();

#########################################

#var bgimage = root.createChild("image")
     #.setFile("Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-9.png")
	 #.setTranslation(100, 10)
     #.setSize(826,1000);

# create an image child for the texture
var kneepad_page = root.createChild("image")
    .setFile(path0)
    .setTranslation(0, 0)
    .setSize(891, 1000);

var ui_root = window.getCanvas().createGroup();
var hbox = canvas.HBoxLayout.new();
#.setTranslation(30, 30);
window.setLayout(hbox);


var page_button_1 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("1").listen("clicked", func {kneepad_page.setFile(path1); g.hide();});
var page_button_2 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("2").listen("clicked", func {kneepad_page.setFile(path2); g.hide();});
var page_button_3 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("3").listen("clicked", func {kneepad_page.setFile(path3); g.hide();});
var page_button_4 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("4").listen("clicked", func {kneepad_page.setFile(path4); g.hide();});
var page_button_5 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("5").listen("clicked", func {kneepad_page.setFile(path5); g.hide();});
var page_button_6 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("6").listen("clicked", func {kneepad_page.setFile(path6); g.hide();});
var page_button_7 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("7").listen("clicked", func {kneepad_page.setFile(path7); g.hide();});
var page_button_8 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("8").listen("clicked", func {kneepad_page.setFile(path8); g.hide();});
var page_button_9 = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("9").listen("clicked", func {kneepad_page.setFile(path9); g.hide();});
var page_button_M = canvas.gui.widgets.Button.new(ui_root, canvas.style, {}).setText("M").listen("clicked", func {g.show();});

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
button_box.addSpacing(20);
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
button_box.addSpacing(20);

hbox.addStretch(1);
hbox.addItem(button_box);
hbox.addSpacing(4);
#hbox.addStretch(1);

var changePage = func()
{
  kneepad_page.setFile(path9);
  g.hide();
};



#var AircraftDeveloper=canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
#AircraftDeveloper.setText("                  Sergei Solyshko, 2023");
#statusbar.addItem(AircraftDeveloper);

}
