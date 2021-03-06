// Seashell generator
// ===========================================================


// http://www.mat.uc.pt/~picado/conchas/eng/article.pdf
// http://www.mat.uc.pt/~picado/conchas/exemplosindex.html
// dextral / sinistral

import peasy.*;
import controlP5.*;
import wblut.hemesh.creators.*;
import wblut.core.processing.*;
import wblut.hemesh.core.*;
import processing.opengl.*;

ControlP5 gui;
PeasyCam cam;
HE_Mesh mesh;
WB_Render render;

PVector[] spiral;
PVector[][] shell;

// resolution for each mode
int r0x =  32;  
int r0y = 32;
int r1x = 64;  
int r1y = 64;
int r2x = 256;  
int r2y = 256;
int r3x = 512;  
int r3y = 512;



int mode = 1;    // 0 = live, 1 = normal, 2 = hi-res

String presetsFile = "data/presets.txt";
ArrayList<String> presetParams = new ArrayList<String>();
ArrayList<String> presetTitles = new ArrayList<String>();

void setup() {
  size(displayWidth, displayHeight, OPENGL);
  render = new WB_Render(this);
  loadPresets();
  setupGUI();

  // set up camera
  cam = new PeasyCam(this, 600);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(2500);
  makeMesh();
}

void draw() {
  background(0);    

  cam.beginHUD();
  pushStyle();
  noFill();
  stroke(255, 220);
  //rect(GUI_SPIRAL_X-5, GUI_SPIRAL_Y-4, 165, (GUI_COIL_Y - GUI_SPIRAL_Y + 80));
  //rect(GUI_MODE_X-5, GUI_MODE_Y-4, 265, (GUI_PRESETS_Y - GUI_MODE_Y + 50));
  popStyle();
  gui.draw();
  cam.endHUD(); 

  pushMatrix();
  directionalLight(0, 0, 500, width/2, height/2, 0);
  if      (mode==0) makeMesh(r0x, r0y); 
  if (renderSpine) drawSpine();
  if (renderMesh)  drawMesh();   
  popMatrix();
}

void makeMesh(int n, int m) {
  generateShell(n, m);
  generateMesh(n, m);
}

void makeMesh() {
  if      (mode==0) makeMesh(r0x, r0y); 
  else if (mode==1) makeMesh(r1x, r1y); 
  else if (mode==2) makeMesh(r2x, r2y);
}

void export() {
  String filename = "export/" + gui.get(Textfield.class, "meshName").getText() + ".stl";
  HET_Export.saveToSTL(mesh, sketchPath(filename), 1.0);
}

void export_hi_res() {
  makeMesh(r2x, r2y);
  export();
}