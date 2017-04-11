// ======================================================//
//           JACK OF ALL GAMES: SHOOTOUT                 //
// ======================================================//
// 
//  Jack Harrison
//  27363486
//  Rilla Khaled
//  April 11/2017
//  Final Prototype
//

import ddf.minim.*;
import de.voidplus.leapmotion.*;

// ======================================================
// Table of Contents:
// ├─ 1. Variables
// ├─ 2. Setup
// ├─ 3. Leap Motion Setup
// ├─ 4. Draw 
// ├── a) Models & IF
// ├── b) Leap motion
// ├─ 5. IF statements
// └─ 6. Classes
// ======================================================

// 1. Variables
Minim minim;
AudioPlayer song;
Cowboy cowboy;
Cowboy cowboy2;
Bullet bullet;
Bullet bullet2;
Button buttonP1;
Button buttonP2;
Light lightP1;
Light lightP2;
Barrel barrel;
LeapMotion leap;
PFont nash;
PShader toon;
boolean gunShot;
boolean gunShot2;
boolean hitP1;
boolean hitP2;
float gun = 0;
int boost = 0;
float xPosR = 0;
float xPosL = 0;
int livesP1 = 3;
int livesP2 = 3;
ArrayList<Finger> fingersFound;

// ======================================================
// 2. Setup

void setup() {
  size(1200, 800, P3D);
  background(255);
  smooth();
  // setting up objects, sounds and fonts
  cowboy = new Cowboy(width/3-50, 0);
  cowboy2 = new Cowboy(2*width/3+50, PI);
  bullet = new Bullet(width/3-50);
  bullet2 = new Bullet(2*width/3+50);
  buttonP1 = new Button(350);
  buttonP2 = new Button(750);
  lightP1 = new Light(0);
  lightP2 = new Light(2*width/2);
  barrel = new Barrel();
  //
  leap = new LeapMotion(this);
  minim = new Minim(this);
  //
  nash = loadFont("Nashville48.vlw");
  //
  song = minim.loadFile("mysong.wav");
  song.play();
  //
  fingersFound = new ArrayList<Finger>();
}

// ======================================================
// 3. Leap Motion Setup

void leapOnInit() {
  // println("Leap Motion Init");
}
void leapOnConnect() {
  // println("Leap Motion Connect");
}
void leapOnFrame() {
  // println("Leap Motion Frame");
}
void leapOnDisconnect() {
  // println("Leap Motion Disconnect");
}
void leapOnExit() {
  // println("Leap Motion Exit");
}

// ======================================================
// 4. Draw (Models + more Leap setup)
// b) Models & IF
void draw() {
  //various setup (lights, stroke, window shine)
  background(250);
  ambientLight(180, 180, 200);
  directionalLight(200, 150, 150, 1, 1, 1);
  directionalLight(150, 200, 150, -1, -1, 1);
  directionalLight(120, 120, 100, -1, 0, 0);
  strokeWeight(3);
  stroke(255);
  line(70, 230, 0, 170, 130, 0);
  line(70, 200, 0, 140, 130, 0);
  noStroke();

  //Used to reset the game if needed.
  if (keyPressed) {
    lightP1.r = 10;
    lightP2.r = 10;
    lightP1.g = 10;
    lightP2.g = 10;
    livesP2 = 3;
    livesP1 = 3;
  }

  //Building (Green)
  pushMatrix();
  fill(105, 150, 115);
  translate(1675, 257, -1500);
  box(50, 500, 1000);
  translate(-30, -280, 0);
  fill(110);
  box(80, 60, 1100);
  translate(-10, 100, 0);
  fill(165, 135, 115);
  box(20, 100, 400);
  fill(40, 185, 115);
  translate(5, 310, 40);
  box(10, 200, 60);
  translate(0, 0, -80);
  box(10, 200, 60);
  fill(0);
  translate(10, -10, 40);
  box(10, 240, 120);
  fill(110);
  translate(-15, 120, 0);
  box(25, 25, 140);
  popMatrix();

  //Building (Brown)
  pushMatrix();
  fill(190, 70, 25);
  translate(-475, 257, -1889);
  box(50, 500, 2150);
  translate(45, -250, 0);
  fill(150, 100, 80);
  box(20, 250, 600);
  translate(-20, 400, 0);
  fill(10);
  box(10, 300, 100);
  translate(5, -15, 0);
  fill(150, 100, 80);
  box(15, 90, 100);
  fill(10);
  translate(-5, -100, -700);
  box(10, 170, 190);
  translate(0, 0, 1300);
  box(10, 170, 190);
  fill(150, 100, 80);
  translate(10, 75, 0);
  box(15, 20, 200);
  translate(0, 0, -1300);
  box(15, 20, 200);
  popMatrix();

  //Ground
  pushMatrix();
  directionalLight(130, 240, 35, 0, 1, 0);
  fill(245, 220, 180);
  translate(width/2, 870, -1889);
  box(2300, 720, 2500);
  popMatrix();

  //Rails
  pushMatrix();
  fill(90);
  translate(width/3-205, 475, -1189);
  box(30, 10, 1840);
  translate(0, -5, 0);
  box(10, 5, 1840);
  translate(810, 0, 0);
  box(10, 5, 1840);
  translate(0, 5, 0);
  box(30, 10, 1840);
  popMatrix();

  //LeftWall
  pushMatrix();
  fill(60, 120, 210);
  translate(-525, 157, -1889);
  box(50, 700, 2500);
  popMatrix();

  //RightWall
  pushMatrix();
  fill(60, 120, 210);
  translate(1725, 157, -1889);
  box(50, 700, 2500);
  popMatrix();

  //Roof
  pushMatrix();
  fill(60, 120, 210);
  translate(width/2, -280, -1889);
  box(2300, 170, 2500);
  popMatrix();

  //ShootOut Sign
  pushMatrix();
  fill(60, 120, 210);
  translate(width/2, 135, -3289);
  box(2400, 750, 50);
  popMatrix();

  //ButtonPanel
  pushMatrix();
  translate(600, 610, 0);
  rotateX(-PI/4);
  fill(180, 140, 200);
  box(1000, 70, 240);
  popMatrix();

  //Cover (WoodPlanks)
  pushMatrix();
  fill(160, 100, 70);
  translate(width/2, 610, -600);
  box(2300, 200, 30);
  translate(0, 210, 0);
  box(2300, 200, 30);
  translate(0, 210, 0);
  box(2300, 200, 30);
  translate(1105, -862, 0);
  box(50, 700, 30);
  translate(-2210, 0, 0);
  box(50, 700, 30);
  translate(1105, -450, 0);
  box(2300, 200, 30);
  translate(0, 0, 30);
  fill(120, 80, 50);
  box(500, 200, 30);
  popMatrix();

  // Statements to prevent player from going forward or back too far
  if (cowboy.position.z < -700) {
    cowboy.position.z = -699;
    bullet.location.z = -699;
    cowboy.velocity.z = 0;
    bullet.velocity.z = 0;
  } 
  if (cowboy.position.z >100) {
    cowboy.position.z = 99;
    bullet.location.z = 99;
    cowboy.velocity.z = 0;
    bullet.velocity.z = 0;
  } 

  //Same statements for PLAYER 2
  if (cowboy2.position.z >100) {
    cowboy2.position.z = 99;
    bullet2.location.z = 99;
    cowboy2.velocity.z = 0;
    bullet2.velocity.z = 0;
  } 
  if (cowboy2.position.z < -700) {
    cowboy2.position.z = -699;
    bullet2.location.z = -699;
    cowboy2.velocity.z = 0;
    bullet2.velocity.z = 0;
  } 

  //Displaying all the objects
  barrel.display(-600, width/3+50);
  barrel.display(-1900, width*2/3+100);
  lightP1.display();
  lightP2.display();
  buttonP1.display();
  buttonP2.display(); 
  pushMatrix();
  cowboy.display(225, 185, 50, 230, 40, 25, 10);
  cowboy.update();
  popMatrix();
  pushMatrix(); 
  cowboy2.display(155, 30, 30, 10, 190, 140, 85);
  cowboy2.update();
  popMatrix();
  pushMatrix(); 
  bullet.display();
  bullet.update();
  popMatrix(); 
  pushMatrix(); 
  bullet2.display();
  bullet2.update();
  popMatrix();
  //Double checking that the stroke is off
  noStroke();

  //Displaying our title
  pushMatrix();
  textMode(MODEL);
  fill(0);
  textFont(nash, 48);
  text("Shoot Out", width/2-80, 60, 0);
  popMatrix();
  textFont(nash, 12);

  // ==================================================
  // b) Leap Motion (taken from example)

  int fps = leap.getFrameRate();
  fingersFound = new ArrayList<Finger>();

  for (Hand hand : leap.getHands ()) {
    int     handId             = hand.getId();
    PVector handPosition       = hand.getPosition();
    PVector handStabilized     = hand.getStabilizedPosition();
    PVector handDirection      = hand.getDirection();
    PVector handDynamics       = hand.getDynamics();
    float   handRoll           = hand.getRoll();
    float   handPitch          = hand.getPitch();
    float   handYaw            = hand.getYaw();
    boolean handIsLeft         = hand.isLeft();
    boolean handIsRight        = hand.isRight();
    float   handGrab           = hand.getGrabStrength();
    float   handPinch          = hand.getPinchStrength();
    float   handTime           = hand.getTimeVisible();
    PVector spherePosition     = hand.getSpherePosition();
    float   sphereRadius       = hand.getSphereRadius();

    if (hand.hasArm()) {
      Arm     arm              = hand.getArm();
      float   armWidth         = arm.getWidth();
      PVector armWristPos      = arm.getWristPosition();
      PVector armElbowPos      = arm.getElbowPosition();
    }

    Finger  fingerThumb        = hand.getThumb();
    Finger  fingerIndex        = hand.getIndexFinger();
    Finger  fingerMiddle       = hand.getMiddleFinger();
    Finger  fingerRing         = hand.getRingFinger();
    Finger  fingerPink         = hand.getPinkyFinger();

    if (fingerIndex!=null) {
      fingersFound.add(fingerIndex);
    }

    for (Finger finger : hand.getFingers()) {

      int     fingerId         = finger.getId();
      PVector fingerPosition   = finger.getPosition();
      PVector fingerStabilized = finger.getStabilizedPosition();
      PVector fingerVelocity   = finger.getVelocity();
      PVector fingerDirection  = finger.getDirection();
      float   fingerTime       = finger.getTimeVisible();

      switch(finger.getType()) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
        break;
      }

      Bone    boneDistal       = finger.getDistalBone();
      Bone    boneIntermediate = finger.getIntermediateBone();
      Bone    boneProximal     = finger.getProximalBone();
      Bone    boneMetacarpal   = finger.getMetacarpalBone();

      int     touchZone        = finger.getTouchZone();
      float   touchDistance    = finger.getTouchDistance();

      switch(touchZone) {
      case -1: 
        break;
      case 0: 
        break;
      case 1: 
        break;
      }
    }
  }

  // ==================================================
  // 2. IF statements
  // This is where most of the "magic" happens

  boolean p1Pressed =false;
  boolean b1Pressed =false;
  boolean s1Pressed = false;
  boolean p2Pressed =false;
  boolean b2Pressed =false;
  boolean s2Pressed = false;



  for (int i = 0; i<fingersFound.size(); i++) {
    println(fingersFound.size());
    fingersFound.get(i).draw(1);

    //PLAYER 1     
    //Player ones buttons are not being pushed


    // Move forward
    if (fingersFound.get(i).getPosition().x > 340 && fingersFound.get(i).getPosition().x < 410 && fingersFound.get(i).getPosition().y > 520 && fingersFound.get(i).getPosition().y < 600 && fingersFound.get(i).getPosition().z > 25 && fingersFound.get(i).getPosition().z < 80) {
      println("doot");
      boost = 255;
      cowboy.velocity.z = 2;
      if (gunShot == false) {
        bullet.location.z = cowboy.position.z;
        bullet.velocity.z = 2;
      }
      buttonP1.pD = 20;
      p1Pressed =true;
    }
    // Move backward
    else if (fingersFound.get(i).getPosition().x > 210 && fingersFound.get(i).getPosition().x < 290 && fingersFound.get(i).getPosition().y > 520 && fingersFound.get(i).getPosition().y < 600 && fingersFound.get(i).getPosition().z > 25 && fingersFound.get(i).getPosition().z < 80) {
      println("boot");
      boost = 255;
      cowboy.velocity.z = -2;
      if (gunShot == false) {
        bullet.location.z = cowboy.position.z;
        bullet.velocity.z = -2;
      }
      buttonP1.pU = 20;
      b1Pressed =true;
    } 

    //stopping player and resetting buttons
    if (b1Pressed ==false && p1Pressed ==false) {
      cowboy.velocity.z = 0;
    } 
    if (b1Pressed ==false) {
      println("up");
      bullet.velocity.z = 0;
      buttonP1.pU = 0;
    } 
    if (p1Pressed ==false) {
      bullet.velocity.z = 0;
      buttonP1.pD = 0;
    }

    //shoot
    if (fingersFound.get(i).getPosition().x > 460 && fingersFound.get(i).getPosition().x < 560 && fingersFound.get(i).getPosition().y > 520 && fingersFound.get(i).getPosition().y < 600 && fingersFound.get(i).getPosition().z > 25 && fingersFound.get(i).getPosition().z < 80) {
      println("groot");
      boost = 255;
      gunShot = true;
      buttonP1.pS = 20;
      s1Pressed = true;
    } 
    if (s1Pressed ==false) {
      println("shotup");
      buttonP1.pS = 0;
    } 
    if (gunShot) {
      bullet.velocity.x = 10;
      bullet.velocity.z = 0;
    } 
    if (bullet.location.x > 1200) {
      gunShot = false;
      bullet.velocity.x = 0;
      bullet.location.x = width/3-50;
      bullet.location.z = cowboy.position.z;
      bullet.velocity.z = cowboy.velocity.z;
    } else {
      bullet.location.z = cowboy.position.z;
      bullet.velocity.z = cowboy.velocity.z;
    }


    //PLAYER 2

    if (fingersFound.get(i).getPosition().x > 740 && fingersFound.get(i).getPosition().x < 810 && fingersFound.get(i).getPosition().y > 520 && fingersFound.get(i).getPosition().y < 600 && fingersFound.get(i).getPosition().z > 25 && fingersFound.get(i).getPosition().z < 80) {
      println("doot");
      boost = 255;
      cowboy2.velocity.z = 2;
      if (gunShot2 == false) {
        bullet2.location.z = cowboy2.position.z;
        bullet2.velocity.z = 2;
      }
      buttonP2.pD = 20;
      p2Pressed = true;
    } else if (fingersFound.get(i).getPosition().x > 610 && fingersFound.get(i).getPosition().x < 680 && fingersFound.get(i).getPosition().y > 520 && fingersFound.get(i).getPosition().y < 600 && fingersFound.get(i).getPosition().z > 25 && fingersFound.get(i).getPosition().z < 80) {
      println("boot");
      boost = 255;
      cowboy2.velocity.z = -2;
      if (gunShot2 == false) {
        bullet2.location.z = cowboy2.position.z;
        bullet2.velocity.z = -2;
      }
      buttonP2.pU = 20;
      b2Pressed = true;
    } 

    if (b2Pressed ==false && p2Pressed ==false)
    {
      cowboy2.velocity.z = 0;
    }
    if (b2Pressed ==false) {
      println("up");
      bullet2.velocity.z = 0;
      buttonP2.pU = 0;
    }
    if (p2Pressed ==false) {
      bullet2.velocity.z = 0;
      buttonP2.pD = 0;
    }


    if (fingersFound.get(i).getPosition().x > 850 && fingersFound.get(i).getPosition().x < 950 && fingersFound.get(i).getPosition().y > 520 && fingersFound.get(i).getPosition().y < 600 && fingersFound.get(i).getPosition().z > 25 && fingersFound.get(i).getPosition().z < 80) {
      println("groot");
      boost = 255;
      gunShot2 = true;
      buttonP2.pS = 20;
      s2Pressed = true;
    } 
    if (s2Pressed ==false) {
      println("shot2up");
      buttonP2.pS = 0;
    }
    if (gunShot2) {
      bullet2.velocity.x = -10;
      bullet2.velocity.z = 0;
    } 
    if (bullet2.location.x < 0) {
      gunShot2 = false;
      bullet2.velocity.x = 0;
      bullet2.location.x = width/3*2+50;
      ;
      bullet2.location.z = cowboy2.position.z;
      bullet2.velocity.z = cowboy2.velocity.z;
    } else {
      bullet2.location.z = cowboy2.position.z;
      bullet2.velocity.z = cowboy2.velocity.z;
    }

    //DEATHS
    if (bullet2.location.x > (cowboy.position.x - 30) && bullet2.location.x < (cowboy.position.x +30) && bullet2.location.z > (cowboy.position.z -30) && bullet2.location.z < (cowboy.position.z + 30)) {
      println("PLAYER ONE HIT");
      livesP1 = livesP1 - 1;
      bullet2.velocity.x = 0;
      bullet2.location.x = width*2/3+50;
      bullet2.location.z = cowboy2.position.z;
      bullet2.velocity.z = cowboy2.velocity.z;
      gunShot2 = false;
      println("P1Lives" + livesP1);
      lightP1.r = 255;
    } else {
      lightP1.r = lightP1.r - 5;
    }

    if (bullet.location.x > (cowboy2.position.x - 30) && bullet.location.x < (cowboy2.position.x +30) && bullet.location.z > (cowboy2.position.z -30) && bullet.location.z < (cowboy2.position.z + 30)) {
      println("PLAYER TWO HIT");
      livesP2 = livesP2 - 1;
      bullet.velocity.x = 0;
      bullet.location.x = (width/3)-50;
      bullet.location.z = cowboy.position.z;
      bullet.velocity.z = cowboy.velocity.z;
      gunShot = false;
      println("P2Lives" + livesP2);
      lightP2.r = 255;
    } else {
      lightP2.r = lightP2.r - 5;
    }

    if (livesP2 <= 0) {
      println("PLAYER 2 DEAD");
      lightP2.r = 255;
      lightP1.r = 10;
      lightP1.g = 255;
    }
    if (livesP1 <= 0) {
      println("PLAYER 1 DEAD");
      lightP1.r = 255;
      lightP2.r = 10;
      lightP2.g = 255;
    }
  }
}