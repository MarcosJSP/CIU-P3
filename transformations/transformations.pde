mySphere star, p1, p1Moon, p2,p3,p4,p5;
PImage background, NKey, HKey, TKey, SpaceKey, ArrowKeys;
boolean [] pressedKey;
boolean stopRotation, paintTraces, paintNames, paintShortCuts;
float cameraXOffset, cameraYOffset;
PFont smallFont, mediumFont, bigFont;

void setup(){
  size(1000,700, P3D);
  star = new mySphere(70,.2);
  
  p3 = new mySphere(5,.45);
  p2 = new mySphere(10,.40);
  p5 = new mySphere(15,.35);
  p4 = new mySphere(17,.3);
  p1 = new mySphere(20,.25);
  
  p1Moon = new mySphere(2,1);
  
  pressedKey = new boolean []{false,false,false,false};
  cameraXOffset = 0; cameraYOffset = 0;
  
  textAlign(CENTER);
  textSize(10);
  
  background = loadImage("./resources/images/b1.png");
  HKey = loadImage("./resources/keys/H.png");
  NKey = loadImage("./resources/keys/N.png");
  TKey = loadImage("./resources/keys/T.png");
  SpaceKey = loadImage("./resources/keys/Space.png");
  ArrowKeys = loadImage("./resources/keys/Arrows.png");
  
  smallFont = createFont("Arial", 10);
  mediumFont = createFont("Arial", 18);
  bigFont = createFont("Arial bold", 50);
  
  stopRotation = false; paintTraces = true; paintNames = false;
}

void draw (){
  if(paintShortCuts){
    background(50);
    paintShortCuts();
  }else{
    stroke(200);
    noFill();
    background(background);
    paintShortCutsText();
    translate(width/2, height/2);
    rotateX(radians(-20));
    rotateX(radians(cameraXOffset));
    rotateY(radians(cameraYOffset));
    scale(0.7);
    if (paintNames) paintText();
    paintPlanets();
    if (paintTraces) paintTraces();
    updateCameraRotation();
  }
  
}

void rotateToCenteredCameraAngle(){
  rotateY(-radians(cameraYOffset));
  rotateX(-radians(cameraXOffset));
  rotateX(-radians(-20));
}

void paintShortCuts(){
  float keySize = 112 / 3;
  float BigKeyWidth = 416 / 3;
  float minXSpace = 30;
  float textSize = 18;
  float Yoffset = height/6;
  
  textFont(bigFont);
  textAlign(CENTER);
  textSize(50);
  text("Short-Cuts", width/2, Yoffset);
  Yoffset += 80;
  
  pushMatrix();
  translate(-(minXSpace+keySize), 0);
  
  textFont(mediumFont);
  textAlign(LEFT);
  textSize(18);
  image(NKey, width/2-(minXSpace+keySize), Yoffset-(textSize+textSize/2), keySize, keySize);
  text("Show/Hide planet name", width/2, Yoffset);
  Yoffset += 60;
  
  image(TKey, width/2-(minXSpace+keySize), Yoffset-(textSize+textSize/2), keySize, keySize);
  text("Show/Hide planet traces", width/2, Yoffset);
  Yoffset += 60;
  
  image(SpaceKey, width/2-(minXSpace+keySize*2), Yoffset-(textSize+textSize/2), keySize*2, keySize);
  text("Stop/Continue planet movement", width/2, Yoffset);
  Yoffset += 70;
  
  image(ArrowKeys, width/2-(minXSpace+BigKeyWidth), Yoffset-(textSize*2+textSize/2), BigKeyWidth, 257/3);
  text("Move camera view arround the planets", width/2, Yoffset);
  Yoffset += 80;
  popMatrix();
  
  textSize(14);
  textAlign(CENTER);
  text("Press any key to get out of the Short-Cuts menu", width/2, height - height/6);
}

void paintText(){
  textFont(smallFont);
  textAlign(CENTER);
  fill(250);
  textSize(15);
  //Main Star
  pushMatrix();
  rotateToCenteredCameraAngle();
  text("Star",0, -(star.getRadious()+10) );
  popMatrix();
  
  textSize(10);
  //Planet 1
  pushMatrix();
  rotateY(radians(p1.getAngle()));
  translate(star.getRadious() + 300, 0);
  rotateY(-radians(p1.getAngle()));
  rotateToCenteredCameraAngle();  
  text("Planet 1",0, -(p1.getRadious()+10) );
  popMatrix();
  
  //Planet 2
  pushMatrix();
  rotateY(radians(p2.getAngle()));
  translate(star.getRadious() + 250, 0);
  rotateY(-radians(p2.getAngle()));
  rotateToCenteredCameraAngle();  
  text("Planet 2",0, -(p2.getRadious()+10) );
  popMatrix();
  
  //Planet 3
  pushMatrix();
  rotateY(radians(p3.getAngle()));
  translate(star.getRadious() + 150, 0);
  rotateY(-radians(p3.getAngle()));
  rotateToCenteredCameraAngle();  
  text("Planet 3",0, -(p3.getRadious()+10) );
  popMatrix();
  
  //Planet 4
  pushMatrix();
  rotateY(radians(p4.getAngle()));
  translate(star.getRadious() + 200, 0);
  rotateY(-radians(p4.getAngle()));
  rotateToCenteredCameraAngle();  
  text("Planet 4",0, -(p4.getRadious()+10) );
  popMatrix();
  
  //Planet 5
  pushMatrix();
  rotateY(radians(p5.getAngle()));
  translate(star.getRadious() + 400, 0);
  rotateY(-radians(p5.getAngle()));
  rotateToCenteredCameraAngle();  
  text("Planet 5",0, -(p5.getRadious()+10) );
  popMatrix();
  
  textSize(9);
  //Planet 1 Moon
  pushMatrix();
  rotateY(radians(p1.getAngle()));
  translate(star.getRadious() + 300, 0);
  rotateX(radians(45));
  rotateY(radians(p1Moon.getAngle()));
  rotateX(radians(95));
  translate(p1.getRadious() + 10, 0);
  rotateX(radians(-95));
  rotateY(radians(-p1Moon.getAngle()));
  rotateX(radians(-45));
  rotateY(radians(-p1.getAngle()));
  rotateToCenteredCameraAngle();  
  text("Moon",0, -(p1Moon.getRadious()+10) );
  popMatrix();
  
  noFill();
}

void paintTraces(){
  //Planet 1 Halo
  pushMatrix();
  rotateY(radians(p1.getAngle())); 
  rotateX(radians(95));
  circle(0,0,(star.getRadious()+300+p1.getRadious()/2)*2);
  popMatrix();
  
  //Planet 1 Moon Trace
  pushMatrix();
  rotateY(radians(p1.getAngle()));
  translate(star.getRadious() + 300, 0);
  rotateX(radians(45));
  rotateY(radians(p1Moon.getAngle()));
  rotateX(radians(95));
  circle(0,0,(p1.getRadious()+ 10+ p1Moon.getRadious()/2)*2);
  popMatrix();
  
  //Planet 2 Halo
  pushMatrix();
  rotateY(radians(p2.getAngle())); 
  rotateX(radians(95));
  circle(0,0,(star.getRadious()+250+p2.getRadious()/2)*2);
  popMatrix();
  
  //Planet 3 Halo
  pushMatrix();
  rotateY(radians(p3.getAngle())); 
  rotateX(radians(95));
  circle(0,0,(star.getRadious()+150+p3.getRadious()/2)*2);
  popMatrix();
  
  //Planet 4 Halo
  pushMatrix();
  rotateY(radians(p4.getAngle())); 
  rotateX(radians(95));
  circle(0,0,(star.getRadious()+200+p4.getRadious()/2)*2);
  popMatrix();
  
  //Planet 5 Halo
  pushMatrix();
  rotateY(radians(p5.getAngle())); 
  rotateX(radians(95));
  circle(0,0,(star.getRadious()+400+p5.getRadious()/2)*2);
  popMatrix();
}

void paintPlanets(){
  //Main Star
  pushMatrix();
  rotateY(radians(star.getAngle()));
  star.paint();
  popMatrix();  
  
  //Planet 1
  pushMatrix();
  rotateY(radians(p1.getAngle()));  
  translate(star.getRadious() + 300, 0);
  p1.paint();  
  popMatrix();
  
  //Planet 1 Moon
  pushMatrix();
  rotateY(radians(p1.getAngle()));
  translate(star.getRadious() + 300, 0);
  rotateX(radians(45));
  rotateY(radians(p1Moon.getAngle()));
  rotateX(radians(95));
  translate(p1.getRadious() + 10, 0);
  p1Moon.paint();
  popMatrix();
  
  //Planet 2
  pushMatrix();
  rotateY(radians(p2.getAngle()));
  translate(star.getRadious() + 250, 0);
  p2.paint();
  popMatrix();
  
  //Planet 3
  pushMatrix();
  rotateY(radians(p3.getAngle()));
  translate(star.getRadious() + 150, 0);
  p3.paint();
  popMatrix();
  
  //Planet 4
  pushMatrix();
  rotateY(radians(p4.getAngle()));
  translate(star.getRadious() + 200, 0);
  p4.paint();
  popMatrix();
  
  //Planet 5
  pushMatrix();
  rotateY(radians(p5.getAngle()));
  translate(star.getRadious() + 400, 0);
  p5.paint();
  popMatrix();
}

void paintShortCutsText(){
  float keySize = 112 / 3;
  float minXSpace = 20;
  float TextSize = 18;
  
  textFont(mediumFont);
  textAlign(LEFT);
  textSize(18);
  image(HKey, 30, 30, keySize, keySize);
  text("Short-cuts", 30+keySize+minXSpace, 30+TextSize+TextSize/3);
}

void updateCameraRotation(){
  float rotateSpeed = 1;
  if (pressedKey[0]) cameraXOffset+=rotateSpeed;
  if (pressedKey[1]) cameraXOffset-=rotateSpeed;
  if (pressedKey[2]) cameraYOffset-=rotateSpeed;
  if (pressedKey[3]) cameraYOffset+=rotateSpeed;
  
  if (cameraXOffset < 0)cameraXOffset=360;
  if (cameraXOffset > 360)cameraXOffset=0;
  if (cameraYOffset < 0)cameraYOffset=360;
  if (cameraYOffset > 360)cameraYOffset=0;
}

void stopPlanetRotation(){
  stopRotation = !stopRotation;
  star.stopRotation(stopRotation);
  p1.stopRotation(stopRotation);
  p2.stopRotation(stopRotation);
  p3.stopRotation(stopRotation);
  p4.stopRotation(stopRotation);
  p5.stopRotation(stopRotation);
  p1Moon.stopRotation(stopRotation);
}

void keyReleased(){
  if (!paintShortCuts) {
    if (keyCode == UP) pressedKey[0] = false;
    if (keyCode == DOWN) pressedKey[1] = false;
    if (keyCode == LEFT) pressedKey[2] = false;
    if (keyCode == RIGHT) pressedKey[3] = false;
  }
}

void keyPressed(){
  if (!paintShortCuts) {
    if (keyCode == UP) pressedKey[0] = true;
    if (keyCode == DOWN) pressedKey[1] = true;
    if (keyCode == LEFT) pressedKey[2] = true;
    if (keyCode == RIGHT) pressedKey[3] = true;
    if (keyCode == 32) stopPlanetRotation(); //SPACE BAR
    if (key == 't' || key == 'T') paintTraces = !paintTraces;
    if (key == 'n' || key == 'N') paintNames = !paintNames;
    if (key == 'h' || key == 'H') paintShortCuts = !paintShortCuts;
  }else{
    paintShortCuts = !paintShortCuts;
  }
  
}
