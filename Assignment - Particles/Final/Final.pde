// Scrub Em' Clean //
//By: Jack Harrison
//27363486
//Particles Assignment
//
// Use the knobs to toggle particle emitters, try using multiple
// knobs at once. Day and night will pass by very quickly by moving 
// mouseX position to symbolize how staring at the sink might cause ones
// days to blend together. Fire glows more at night. Don't forget the soap! 
//
//Used Code from: Class Examples, Nature of Code & Learning Processing
//

import processing.video.*;
ParticleSystem ps;
ParticleSystem ss;
Capture video;

//setting up scene, emitters & video
void setup() {
  size(800, 480);
  ps = new ParticleSystem(new PVector(width/2, 272));
  ss = new ParticleSystem(new PVector(108, 212));
  video = new Capture(this, 640, 480);
  video.start();
}

void draw() {
  background(175-(mouseY/10), 240-(mouseY/10), 205 - (mouseY/10));
  noStroke();
  cursor(HAND);
  
  //MIRROR
  //Boarder for the mirror
  fill(150, 110, 80);
  rectMode(CORNER);
  rect(55, -250, 690, 500);

  //Flipping and displaying the "mirror"
  pushMatrix();
  //Day and Night adjusts with mouseX
  tint(255 - mouseY/5, 255 - mouseY/5, 255 - mouseY/10);
  translate(video.width, 0);
  scale(-1, 1); 
  image(video, -80, -250);
  popMatrix();

  //Mirror Glare
  stroke(255);
  strokeWeight(2);
  line(680, 210, 710, 180);
  line(680, 200, 700, 180);

  noStroke();

  //COUNTERTOP
  fill(250 - (mouseY/10), 240- (mouseY/10), 220- (mouseY/10));
  rect(0, 300, 800, 180);

  //SINK
  fill(230);
  rect(175, 320, 450, 300);
  fill(205);
  ellipse(400, 430, 400, 200);
  fill(180);
  ellipse(400, 465, 50, 25);
  fill(20);
  ellipse(400, 469, 50, 25);

  //KNOBS 
  //cold
  fill(205);
  rect(275, 270, 50, 50);
  fill(0, 0, 255);
  ellipse(300, 275, 50, 25);
  fill(230);
  ellipse(300, 270, 50, 25);
  fill(205);
  ellipse(300, 320, 50, 25);

  //hot
  fill(205);
  rect(475, 270, 50, 50);
  fill(255, 0, 0);
  ellipse(500, 275, 50, 25);
  fill(230);
  ellipse(500, 270, 50, 25);
  fill(205);
  ellipse(500, 320, 50, 25);


  //SOAP
  fill(220, 170, 225);
  rect(65, 230, 60, 105);
  fill(250, 205, 250);
  ellipse(95, 230, 60, 30);
  fill(240, 190, 240);
  ellipse(95, 230, 20, 10);
  fill(250, 220, 255);
  ellipse(95, 225, 20, 10);
  fill(220, 170, 225);
  ellipse(95, 335, 60, 30);
  fill(230);
  rectMode(CENTER);
  rect(95, 215, 5, 20);
  rect(102, 205, 20, 5);

  //TAP
  rectMode(CORNER);
  fill(205);
  rect(380, 218, 40, 100);
  ellipse(400, 318, 40, 20);
  fill(230);
  rect(372, 210, 56, 60);
  ellipse(400, 210, 56, 20);
  fill(150);
  ellipse(400, 270, 54, 10);
  fill(20);
  ellipse(400, 268, 54, 10);

  //Calling our two particle emitters
  ps.addParticle();
  ps.run();
  ss.addParticleSoap();
  ss.run();
}

void mousePressed() {
  ps.mousePressedParticle();
}

void captureEvent(Capture video) {
  video.read();
}