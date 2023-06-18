var showKneepadDlg = func{
var createButton = func(root, label, clickAction) {
var button = canvas.gui.widgets.Button.new(root, canvas.style, {} )
    .setText(label);
	button.listen("clicked", clickAction );
	return button;
}

var (width,height) = (826,1000);
var title = 'L-39ZA Kneepad:';
setprop("/sim/menubar/visibility",0);
 
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

#var bgimage = root.createChild("image")
     #.setFile("Aircraft/L-39ZA/gui/dialogs/kneepad/L-39-Kneepad-9.png")
	 #.setTranslation(100, 10)
     #.setSize(826,1000);

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
# create an image child for the texture
var kneepad_page = root.createChild("image")
    .setFile(path0)
    .setTranslation(0, 0)
    .setSize(826, 1000);

#var Vbox1 = canvas.VBoxLayout.new(); # Buttons
#mainHBox.addItem(Vbox1);

var LeftSpaceFiller = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
	LeftSpaceFiller.setText("")
	.setFixedSize(755,1000);

VboxLeft.addItem(LeftSpaceFiller);

var TopSpaceFiller = canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
	TopSpaceFiller.setText("")
	.setFixedSize(40,20);

VboxRight.addItem(TopSpaceFiller);

var Buttons=[
[
'1',
'2',
'3',
'4',
'5',
'6',
'7',
'8',
'9',
],
];
 
# Buttons to change pages

var page_btn_1 = canvas.gui.widgets.Button.new(root, canvas.style, {})
		.setFixedSize(48, 98)
        .setText("1");
	page_btn_1.listen("clicked", func {kneepad_page.setFile(path1);});
VboxRight.addItem(page_btn_1);

var page_btn_2 = canvas.gui.widgets.Button.new(root, canvas.style, {})
		.setFixedSize(48, 98)
        .setText("2");
	page_btn_2.listen("clicked", func {kneepad_page.setFile(path2);});
VboxRight.addItem(page_btn_2);

var page_btn_3 = canvas.gui.widgets.Button.new(root, canvas.style, {})
		.setFixedSize(48, 98)
        .setText("3");
	page_btn_3.listen("clicked", func {kneepad_page.setFile(path3);});
VboxRight.addItem(page_btn_3);

var page_btn_4 = canvas.gui.widgets.Button.new(root, canvas.style, {})
		.setFixedSize(48, 98)
        .setText("4");
	page_btn_4.listen("clicked", func {kneepad_page.setFile(path4);});
VboxRight.addItem(page_btn_4);

var page_btn_5 = canvas.gui.widgets.Button.new(root, canvas.style, {})
		.setFixedSize(48, 98)
        .setText("5");
	page_btn_5.listen("clicked", func {kneepad_page.setFile(path5);});
VboxRight.addItem(page_btn_5);

var page_btn_6 = canvas.gui.widgets.Button.new(root, canvas.style, {})
		.setFixedSize(48, 98)
        .setText("6");
	page_btn_6.listen("clicked", func {kneepad_page.setFile(path6);});
VboxRight.addItem(page_btn_6);

var page_btn_7 = canvas.gui.widgets.Button.new(root, canvas.style, {})
		.setFixedSize(48, 98)
        .setText("7");
	page_btn_7.listen("clicked", func {kneepad_page.setFile(path7);});
VboxRight.addItem(page_btn_7);

var page_btn_8 = canvas.gui.widgets.Button.new(root, canvas.style, {})
		.setFixedSize(48, 98)
        .setText("8");
	page_btn_8.listen("clicked", func {kneepad_page.setFile(path8);});
VboxRight.addItem(page_btn_8);

var page_btn_9 = canvas.gui.widgets.Button.new(root, canvas.style, {})
		.setFixedSize(48, 98)
        .setText("9");
	page_btn_9.listen("clicked", func {kneepad_page.setFile(path9);});
VboxRight.addItem(page_btn_9);


VboxRight.addItem(TopSpaceFiller);

#var AircraftDeveloper=canvas.gui.widgets.Label.new(root, canvas.style, {wordWrap: 0});
#AircraftDeveloper.setText("                  Sergei Solyshko, 2023");
#statusbar.addItem(AircraftDeveloper);

}
