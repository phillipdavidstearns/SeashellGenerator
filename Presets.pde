void loadPresets() {
  String[] entries = loadStrings(presetsFile);
  for (String entry : entries) {
    String[] s = entry.split(",");
    presetTitles.add(s[50]);
    presetParams.add(entry);
  }
}

void applyPreset(int idx) {
  String pre = presetParams.get(idx);
  String[] s = pre.split(",");

  L = Float.parseFloat(s[0]);
  P = Float.parseFloat(s[1]);
  W1 = Float.parseFloat(s[2]);
  W2 = Float.parseFloat(s[3]);
  N = Float.parseFloat(s[4]);
  
  D = Integer.parseInt(s[5]);
  turns = Float.parseFloat(s[6]);
  
  alpha = Float.parseFloat(s[7]);
  beta = Float.parseFloat(s[8]);
  k = Float.parseFloat(s[9]);
  kxy = Float.parseFloat(s[10]);
  offset_xy = Float.parseFloat(s[11]);
  A = Float.parseFloat(s[12]);
  
  mu = Float.parseFloat(s[13]);
  omega = Float.parseFloat(s[14]);
  phi = Float.parseFloat(s[15]);
  depth_phi = Float.parseFloat(s[16]);
  freq_phi = Float.parseFloat(s[17]);
  depth_omega = Float.parseFloat(s[18]);
  freq_omega = Float.parseFloat(s[19]);
  depth_mu = Float.parseFloat(s[20]);
  freq_mu = Float.parseFloat(s[21]);
  
  a = Float.parseFloat(s[22]);
  b = Float.parseFloat(s[23]);

  ripple_freq = Float.parseFloat(s[26]);
  ripple_depth = Float.parseFloat(s[27]);
  
  L_1 = Float.parseFloat(s[28]);
  P_1 = Float.parseFloat(s[29]);
  W1_1 = Float.parseFloat(s[30]);
  W2_1 = Float.parseFloat(s[31]);
  N_1 = Float.parseFloat(s[32]);
  
  L_2 = Float.parseFloat(s[33]);
  P_2 = Float.parseFloat(s[34]);
  W1_2 = Float.parseFloat(s[35]);
  W2_2 = Float.parseFloat(s[36]);
  N_2 = Float.parseFloat(s[37]);
  
  L_3 = Float.parseFloat(s[38]);
  P_3 = Float.parseFloat(s[39]);
  W1_3 = Float.parseFloat(s[40]);
  W2_3 = Float.parseFloat(s[41]);
  N_3 = Float.parseFloat(s[42]);
  
  L_4 = Float.parseFloat(s[43]);
  P_4 = Float.parseFloat(s[44]);
  W1_4 = Float.parseFloat(s[45]);
  W2_4 = Float.parseFloat(s[46]);
  N_4 = Float.parseFloat(s[47]);
  
  ridge_freq = Float.parseFloat(s[48]);
  ridge_depth = Float.parseFloat(s[49]);

  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}

void save_preset() {
  String newPreset = L+","+P+","+W1+","+W2+","+N+","+D+","+turns+","+alpha+","+beta+","+k+","+kxy+","+offset_xy+","+A+","+mu+","+omega+","+phi+","+depth_phi+","+freq_phi+","+depth_omega+","+freq_omega+","+depth_mu+","+freq_mu+","+a+","+b+","+ripple_freq+","+ripple_depth+","+L_1+","+P_1+","+W1_1+","+W2_1+","+N_1+","+L_2+","+P_2+","+W1_2+","+W2_2+","+N_2+","+L_3+","+P_3+","+W1_3+","+W2_3+","+N_3+","+L_4+","+P_4+","+W1_4+","+W2_4+","+N_4+","+ridge_freq+","+ridge_depth+","+gui.get(Textfield.class,"meshName").getText() ;
  String[] entries = loadStrings(presetsFile);
  String[] newEntries = new String[entries.length+1];
  for (int i=0; i<entries.length; i++) {
    newEntries[i] = entries[i];
  }
  newEntries[entries.length] = newPreset;
  saveStrings(presetsFile, newEntries);
}

void BoatEarMoon() {
  D=1; alpha=radians(83); beta=radians(42); phi=radians(70); mu=radians(10); omega=radians(30); A=25; a=12; b=20; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void HorseConch() {
  D=1; alpha=radians(84); beta=radians(-19); phi=radians(45); mu=radians(1); omega=radians(-2); A=50; a=40; b=14; L=8; P=0; W1=6; W2=27; N=8;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void Turitella() {
  D=1; alpha=radians(88.9); beta=radians(4); phi=radians(55); mu=radians(1); omega=radians(-2); A=22.2; a=1.3; b=1.5; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void Troques() {
  D=1; alpha=radians(84.9); beta=radians(7); phi=radians(-36); mu=radians(1); omega=radians(-2); A=47; a=40; b=19; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void Cone() {
  D=1; alpha=radians(87); beta=radians(7); phi=radians(78); mu=radians(0); omega=radians(0); A=7; a=4.3; b=1; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void PreciousWentleTrap() { 
  D=1; alpha=radians(86); beta=radians(10); phi=radians(-45); mu=radians(5); omega=radians(1); A=90; a=20; b=20; L=14; P=40; W1=180; W2=0.4; N=180;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void NeptuneCarved() { 
  D=1; alpha=radians(87); beta=radians(4); phi=radians(-36); mu=radians(1); omega=radians(-2); A=46; a=6; b=26; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void Ancilla() {
  D=1; alpha=radians(86); beta=radians(7); phi=radians(0); mu=radians(0); omega=radians(0); A=100; a=15; b=35; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void Oliva() {
  D=1; alpha=radians(88); beta=radians(12); phi=radians(78); mu=radians(0); omega=radians(0); A=7; a=6; b=1.5; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void Conch() {
  D=1; alpha=radians(86); beta=radians(11); phi=radians(-22); mu=radians(0); omega=radians(24); A=95; a=20; b=35; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void Barrell() {
  D=1; alpha=radians(82); beta=radians(2); phi=radians(-56); mu=radians(1); omega=radians(10); A=46; a=38; b=45; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void OstrichFoot() { 
  D=1; alpha=radians(86.9); beta=radians(13); phi=radians(40); mu=radians(0); omega=radians(30); A=5; a=1.8; b=1.6; L=0.5; P=-15; W1=5; W2=5; N=26;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void SerpentineConch() { 
  D=1; alpha=radians(83); beta=radians(8); phi=radians(55); mu=radians(10); omega=radians(2); A=180; a=16; b=16; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void Lapa() {
  D=1; alpha=radians(2); beta=radians(90); phi=radians(0); mu=radians(0); omega=radians(-50); A=450; a=600; b=600; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void SnailShell() { 
  D=1; alpha=radians(84); beta=radians(85); phi=radians(20); mu=radians(1); omega=radians(5); A=50; a=25; b=45; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}
void ShellHelmetHungarian() {
  D=1; alpha=radians(43); beta=radians(50); phi=radians(-10); mu=radians(1); omega=radians(-30); A=9; a=8; b=7; L=0; P=0; W1=0; W2=0; N=0;
  if (mode==0) makeMesh(r0x, r0y); else if (mode==1) makeMesh(r1x, r1y); else if (mode==2) makeMesh(r2x, r2y);
}

