// spiral parameters

//legacy parameters for variabls in preset which have been depricated due to modifications to the math in Shell.pde
float L = 5;
float P = 5;
float W1 = 5;
float W2 = .39;
float N = 9.9;

int D = 1; //varying this stretches and compresses along an axis orthoganal to the "A" parameter
float turns = 6 * TWO_PI;
float alpha = 1.48;
float beta = PI/4;
float k = 1.5; // test variable for rate of growth
float kxy = 1;
float offset_xy = 0; //origin offset
float offset_z = 0;
float A = 0; //legacy length term

// ellipse orientation parameters
float mu = 0; // angle given in radians
float omega = 0; // angle given in radians
float phi = 0; //rotation of elipse about normal axis, angle given in radians
float twist_phi = 0;
float depth_phi = 0;
float freq_phi = 0;
float depth_omega = 0;
float freq_omega = 0;
float depth_mu = 0;
float freq_mu = 0;

// ellipsoid parameters

float a = 20; //elipse radii
float b = 20; //elipse radii
float ripple_freq = 0;
float ripple_depth = 0;

// surface parameters
float L_1 = 15;
float P_1 = 1;
float W1_1 = 1;
float W2_1 = .1;
float N_1 = 7.7;

float L_2 = 15;
float P_2 = 2;
float W1_2 = 1;
float W2_2 = .1;
float N_2 = 6.3;

float L_3 = 15;
float P_3 = 3;
float W1_3 = 1;
float W2_3 = .1;
float N_3 = 5.1;

float L_4 = 15;
float P_4 = 4;
float W1_4 = 1;
float W2_4 = .1;
float N_4 = 4.3;

float ridge_freq = 0;
float ridge_depth = 0;

// render mode
boolean renderSpine = false;
boolean renderMesh = true;

// display options
int GUI_SPIRAL_X = 10;          
int GUI_SPIRAL_Y = 245;
int GUI_ELLIPSE_X = 10;         
int GUI_ELLIPSE_Y = 375;
int GUI_ORIENTATION_X = 10;     
int GUI_ORIENTATION_Y = 445;
int GUI_SURFACE_X = 10;         
int GUI_SURFACE_Y = 515;
int GUI_COIL_X = 10;            
int GUI_COIL_Y = 675;
int GUI_MODE_X = 10;            
int GUI_MODE_Y = 10;
int GUI_UPDATE_X = 150;         
int GUI_UPDATE_Y = 10;
int GUI_WIREFRAME_X = 150;      
int GUI_WIREFRAME_Y = 70;
int GUI_COLORS_X = 10;          
int GUI_COLORS_Y = 100;
int GUI_PRESETS_X = 10;         
int GUI_PRESETS_Y = 180;


void setupGUI() 
{
  gui = new ControlP5(this);
  gui.setAutoDraw(false);
  gui.setFont(createFont("Georgia", 11), 11);

  // labels
  gui.addTextlabel("spiral")       .setText("Spiral") 
    .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y)  
    .setColorValue(0xffffff00) .setFont(createFont("Georgia", 12));
  gui.addTextlabel("ellipseRadii") .setText("Ellipse radii") 
    .setPosition(GUI_ELLIPSE_X, GUI_ELLIPSE_Y) 
    .setColorValue(0xffffff00) .setFont(createFont("Georgia", 12));
  gui.addTextlabel("orientation")  .setText("Orientation") 
    .setPosition(GUI_ORIENTATION_X, GUI_ORIENTATION_Y) 
    .setColorValue(0xffffff00) .setFont(createFont("Georgia", 12));
  gui.addTextlabel("surface")      .setText("Surface") 
    .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y) 
    .setColorValue(0xffffff00) .setFont(createFont("Georgia", 12));
  gui.addTextlabel("coil_")     .setText("Coil") 
    .setPosition(GUI_COIL_X, GUI_COIL_Y) 
    .setColorValue(0xffffff00) .setFont(createFont("Georgia", 12));
  // gui.addTextlabel("presetslabel") .setText("Presets") 
  //     .setPosition(GUI_PRESETS_X, GUI_PRESETS_Y) 
  //     .setColorValue(0xffffff00) .setFont(createFont("Georgia",12));
  gui.addTextlabel("colors") .setText("Color") 
    .setPosition(GUI_COLORS_X, GUI_COLORS_Y) 
    .setColorValue(0xffffff00) .setFont(createFont("Georgia", 12));
  gui.addTextlabel("livemode") .setText("Mode") 
    .setPosition(GUI_MODE_X, GUI_MODE_Y) 
    .setColorValue(0xffffff00);

  // bang to update mesh
  gui.addBang("bang")  .setPosition(GUI_UPDATE_X, GUI_UPDATE_Y)  
    .setSize(40, 40)  .setTriggerEvent(Bang.RELEASE)  .setLabel("update");

  // spiral
  gui.addSlider("turns")   .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+15)        .setRange(0, 10 * TWO_PI)   ;
  gui.addSlider("alpha")   .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+30)        .setRange(0, PI/2)            ;
  gui.addSlider("beta")    .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+45)        .setRange(-PI, PI)        ;
  gui.addSlider("k")       .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+60)        .setRange(0, PI)             ;
  gui.addSlider("kxy")       .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+75)      .setRange(0, PI)           ;
  gui.addSlider("offset_xy")       .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+90)      .setRange(0, 100)             ;
  gui.addSlider("offset_z")       .setPosition(GUI_SPIRAL_X, GUI_SPIRAL_Y+105)      .setRange(0, 10)             ;


  // ellipse radius
  gui.addSlider("a")       .setPosition(GUI_ELLIPSE_X, GUI_ELLIPSE_Y+15)       .setRange(0, 50)      ;
  gui.addSlider("b")       .setPosition(GUI_ELLIPSE_X, GUI_ELLIPSE_Y+30)       .setRange(0, 50)      ;
  gui.addSlider("ripple_freq")       .setPosition(GUI_ELLIPSE_X, GUI_ELLIPSE_Y+45)       .setRange(0, 500)      ;
  gui.addSlider("ripple_depth")       .setPosition(GUI_ELLIPSE_X, GUI_ELLIPSE_Y+60)       .setRange(0, 25)      ;

  // ellipse orientation
  gui.addSlider("mu")      .setPosition(GUI_ORIENTATION_X, GUI_ORIENTATION_Y+15)       .setRange(0, TWO_PI)  ;
  gui.addSlider("omega")   .setPosition(GUI_ORIENTATION_X, GUI_ORIENTATION_Y+30)       .setRange(0, TWO_PI)  ;
  gui.addSlider("phi")     .setPosition(GUI_ORIENTATION_X, GUI_ORIENTATION_Y+45)       .setRange(0, TWO_PI)    ;

  gui.addSlider("twist_phi")     .setPosition(GUI_ORIENTATION_X, GUI_ORIENTATION_Y+60)       .setRange(0, 20)    ;

  //ellipse parameter modulation using sine
  gui.addSlider("depth_phi")     .setPosition(GUI_ORIENTATION_X+150, GUI_ORIENTATION_Y+15)       .setRange(0, 1)    ;
  gui.addSlider("freq_phi")     .setPosition(GUI_ORIENTATION_X+150, GUI_ORIENTATION_Y+30)       .setRange(0, 10)    ;
  gui.addSlider("depth_omega")     .setPosition(GUI_ORIENTATION_X+150, GUI_ORIENTATION_Y+45)       .setRange(0, 1)    ;
  gui.addSlider("freq_omega")     .setPosition(GUI_ORIENTATION_X+150, GUI_ORIENTATION_Y+60)       .setRange(0, 10)    ;
  gui.addSlider("depth_mu")     .setPosition(GUI_ORIENTATION_X+150, GUI_ORIENTATION_Y+75)       .setRange(0, 1)    ;
  gui.addSlider("freq_mu")     .setPosition(GUI_ORIENTATION_X+150, GUI_ORIENTATION_Y+90)       .setRange(0, TWO_PI)    ;


  // surface

  gui.addSlider("ridge_freq")       .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+15)       .setRange(0, 250)       ;
  gui.addSlider("ridge_depth")       .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+30)       .setRange(0, 10)       ;


  gui.addSlider("L_1")       .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+45)       .setRange(0, 20)       ;
  gui.addSlider("P_1")       .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+60)       .setRange(0, TWO_PI)       ;
  gui.addSlider("W1_1")      .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+75)       .setRange(0, 5)      ;
  gui.addSlider("W2_1")      .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+90)       .setRange(0, 10)    ;
  gui.addSlider("N_1")       .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+105)       .setRange(-PI, PI)      ;

  gui.addSlider("L_2")       .setPosition(GUI_SURFACE_X+115, GUI_SURFACE_Y+45)       .setRange(0, 20)       ;
  gui.addSlider("P_2")       .setPosition(GUI_SURFACE_X+115, GUI_SURFACE_Y+60)       .setRange(0, TWO_PI)       ;
  gui.addSlider("W1_2")      .setPosition(GUI_SURFACE_X+115, GUI_SURFACE_Y+75)       .setRange(0, 5)      ;
  gui.addSlider("W2_2")      .setPosition(GUI_SURFACE_X+115, GUI_SURFACE_Y+90)       .setRange(0, 10)    ;
  gui.addSlider("N_2")       .setPosition(GUI_SURFACE_X+115, GUI_SURFACE_Y+105)       .setRange(-PI, PI)      ;

  gui.addSlider("L_3")       .setPosition(GUI_SURFACE_X+230, GUI_SURFACE_Y+45)       .setRange(0, 20)       ;
  gui.addSlider("P_3")       .setPosition(GUI_SURFACE_X+230, GUI_SURFACE_Y+60)       .setRange(0, TWO_PI)       ;
  gui.addSlider("W1_3")      .setPosition(GUI_SURFACE_X+230, GUI_SURFACE_Y+75)       .setRange(0, 5)      ;
  gui.addSlider("W2_3")      .setPosition(GUI_SURFACE_X+230, GUI_SURFACE_Y+90)       .setRange(0, 10)    ;
  gui.addSlider("N_3")       .setPosition(GUI_SURFACE_X+230, GUI_SURFACE_Y+105)       .setRange(-PI, PI)      ;

  gui.addSlider("L_4")       .setPosition(GUI_SURFACE_X+345, GUI_SURFACE_Y+45)       .setRange(0, 20)       ;
  gui.addSlider("P_4")       .setPosition(GUI_SURFACE_X+345, GUI_SURFACE_Y+60)       .setRange(0, TWO_PI)       ;
  gui.addSlider("W1_4")      .setPosition(GUI_SURFACE_X+345, GUI_SURFACE_Y+75)       .setRange(0, 5)      ;
  gui.addSlider("W2_4")      .setPosition(GUI_SURFACE_X+345, GUI_SURFACE_Y+90)       .setRange(0, 10)    ;
  gui.addSlider("N_4")       .setPosition(GUI_SURFACE_X+345, GUI_SURFACE_Y+105)       .setRange(-PI, PI)      ;

  gui.addSlider("N")         .setPosition(GUI_SURFACE_X, GUI_SURFACE_Y+120)       .setRange(0, 30)      ;


  // coil parameter
  gui.addRadioButton("coil")
    .setPosition(GUI_COIL_X, GUI_COIL_Y+15)
    .setSize(20, 20)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setItemsPerRow(1)
    .addItem("dextral", 1)
    .addItem("sinistral", 2);

  // presets
  String[] presetNames = new String[] {
    "BoatEarMoon", "HorseConch", "Turitella", "Troques", "Cone", 
    "PreciousWentleTrap", "NeptuneCarved", "Ancilla", "Oliva", 
    "Conch", "Barrell", "OstrichFoot", "SerpentineConch", "Lapa", 
    "SnailShell", "ShellHelmetHungarian" };

  //DropdownList presets = gui.addDropdownList("list-presets");
  //presets.setPosition(GUI_PRESETS_X, GUI_PRESETS_Y+30);
  //for (int i = 0; i < presetParams.size(); i++)
  //  presets.addItem(presetTitles.get(i), i);
  ////presets.captionLabel().set("presets");
  //presets.setItemHeight(20);
  //presets.setBarHeight(15);
  //presets.setWidth(200);
  ////presets.captionLabel().style().marginTop = 3;
  ////presets.captionLabel().style().marginLeft = 3;
  ////presets.valueLabel().style().marginTop = 3;
  //presets.setColorBackground(color(60));
  //presets.setColorActive(color(255, 128));

  // color picker
  gui.addColorPicker("picker")  
    .setPosition(GUI_COLORS_X, GUI_COLORS_Y+15)
    .setColorValue(color(255, 128, 0, 128));

  // live mode
  gui.addRadioButton("mode")
    .setPosition(GUI_MODE_X, GUI_MODE_Y+15)
    .setSize(20, 20)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setItemsPerRow(1)
    .addItem("live", 0)
    .addItem("normal", 1)
    .addItem("hi-res (slow)", 2);

  // wireframe toggle
  gui.addCheckBox("wire")
    .setPosition(GUI_WIREFRAME_X, GUI_WIREFRAME_Y)
    .setColorForeground(color(120))
    .setColorActive(color(255))
    .setColorLabel(color(255))
    .setSize(30, 30)
    .setItemsPerRow(3)
    .setSpacingColumn(50)
    .setSpacingRow(20)
    .addItem("wireframe", 0);

  // export to STL
  PFont font = createFont("arial", 12);
  gui.addTextfield("meshName")
    .setPosition(width-120, 10)
    .setSize(100, 20)
    .setText("MyShell")
    .setFont(font)
    .setFocus(true)
    .setColor(color(255, 0, 0));

  gui.addBang("export")
    .setPosition(width-120, 60)
    .setSize(40, 40);

  gui.addBang("export_hi_res")
    .setPosition(width-120, 130)
    .setSize(40, 40);

  //gui.addBang("save_preset")
  //  .setPosition(width-120, 200)
  //  .setSize(40, 40);
}

// color picker
void picker(int col) {
  meshFillColor = col;
}

// event triggers preset
void controlEvent(ControlEvent theEvent) {
  if (theEvent.getName().equals("coil")) {
    int choice = (int) theEvent.getValue();
    if (choice==1) {
      D = 1;
      makeMesh();
    } else if (choice==2) {
      D = -1;
      makeMesh();
    }
  } else if (theEvent.getName().equals("mode")) {
    mode = (int) theEvent.getValue();
    if      (mode==0) makeMesh(r0x, r0y); 
    else if (mode==1) makeMesh(r1x, r1y); 
    else if (mode==2) makeMesh(r2x, r2y);
  } else if (theEvent.isGroup()) {
    if (theEvent.getGroup().getName().equals("wire")) {
      if (theEvent.getGroup().getValue() == 0) {
        meshFill = !meshFill;
      }
    } else if (theEvent.getGroup().getName().equals("list-presets")) {
      int idxPreset = (int) theEvent.getGroup().getValue();
      if      (idxPreset== 0) BoatEarMoon();
      else if (idxPreset== 1) HorseConch();
      else if (idxPreset== 2) Turitella();
      else if (idxPreset== 3) Troques();
      else if (idxPreset== 4) Cone();
      else if (idxPreset== 5) PreciousWentleTrap();
      else if (idxPreset== 6) NeptuneCarved();
      else if (idxPreset== 7) Ancilla();
      else if (idxPreset== 8) Oliva();
      else if (idxPreset== 9) Conch();
      else if (idxPreset==10) Barrell();
      else if (idxPreset==11) OstrichFoot();
      else if (idxPreset==12) SerpentineConch();
      else if (idxPreset==13) SerpentineConch();
      else if (idxPreset==14) Lapa();
      else if (idxPreset==15) SnailShell();
      else if (idxPreset==16) ShellHelmetHungarian();
    }
  }
}

void keyPressed() {
  if (key==' ') {
    makeMesh();
  }
}