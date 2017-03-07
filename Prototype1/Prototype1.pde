// Prototype 1
// Jack of All Games
// Jack Harrison (27363486)
// Rilla Khaled
// March 6, 2017

import de.voidplus.leapmotion.*;
import javax.vecmath.Vector3f;
import bRigid.*;

// ======================================================
// Table of Contents:
// ├─ 1. Callbacks
// ├─ 2. Hand
// ├─ 3. Arms
// ├─ 4. Fingers
// ├─ 5. Bones
// ├─ 6. Tools
// └─ 7. Devices
// ======================================================
boolean cubeC = true;

LeapMotion leap;
BPhysics physics;
BBox box;

public void settings() {
  size(1000, 600, P3D);
}

void setup() {
  background(255);

  frameRate(60);

  leap = new LeapMotion(this);

  Vector3f min = new Vector3f(0, 50, 0);
  Vector3f max = new Vector3f(1000, 480, 100);

  physics = new BPhysics(min, max);

  physics.world.setGravity(new Vector3f(0, 500, 0));
  fill(255,255,0);
  box = new BBox(this, 1, 50, 15, 20);
}


// ======================================================
// 1. Callbacks

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


void draw() {
  background(255);
  // ...
  pointLight(126, 102, 51, 0, 80, 300);
  pointLight(51, 102, 126, 1000, 80, 300);

  //drawing our table
  pushMatrix();
  stroke(0);
  fill(255, 0, 255);
  translate(500, 500, 0);
  box(1000, 10, 200);
  popMatrix();

  //drawing our back wall
  pushMatrix();
  stroke(0);
  fill(255, 50);
  translate(500, 560, -150);
  box(2000, 2000, 10);
  popMatrix();

  int fps = leap.getFrameRate();

  for (Hand hand : leap.getHands ()) {
    // ==================================================
    // 2. Hand

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

    // --------------------------------------------------
    // Drawing
    hand.draw();

    if (frameCount%30==0 && handGrab <= 0.5) {
      Vector3f pos = new Vector3f(handPosition.x, handPosition.y, handPosition.z);
      //reuse the rigidBody of the sphere for performance resons
      //BObject(PApplet p, float mass, BObject body, Vector3f center, boolean inertia)
      BObject r = new BObject(this, 100, box, pos, true);
      //add body to the physics engine
      physics.addBody(r);
    }
    //    println(handGrab);  //print if handGrab strength is needed

    pushMatrix();
    Vector3f posH = new Vector3f(handPosition.x, handPosition.y, handPosition.z);
    BObject h = new BObject(this, 20, box, posH, true);
    //add body to the physics engine
    if (cubeC) {
      physics.addBody(h);
      cubeC = false;
    } else { 
      h.setPosition(handPosition.x, handPosition.y, handPosition.z);
      physics.update();   
      physics.display();
    }
    //sticking a sphere to the center of my hand
    translate(handPosition.x, handPosition.y, handPosition.z);
    fill(0, 255, 255);
    sphere(30);
    popMatrix();

    // println(handPosition);  //print if hand (palm) position is needed
    // ==================================================
    // 3. Arm

    if (hand.hasArm()) {
      Arm     arm              = hand.getArm();
      float   armWidth         = arm.getWidth();
      PVector armWristPos      = arm.getWristPosition();
      PVector armElbowPos      = arm.getElbowPosition();
    }
    // ==================================================
    // 4. Finger

    Finger  fingerThumb        = hand.getThumb();
    // or                        hand.getFinger("thumb");
    // or                        hand.getFinger(0);

    Finger  fingerIndex        = hand.getIndexFinger();
    // or                        hand.getFinger("index");
    // or                        hand.getFinger(1);

    Finger  fingerMiddle       = hand.getMiddleFinger();
    // or                        hand.getFinger("middle");
    // or                        hand.getFinger(2);

    Finger  fingerRing         = hand.getRingFinger();
    // or                        hand.getFinger("ring");
    // or                        hand.getFinger(3);

    Finger  fingerPink         = hand.getPinkyFinger();
    // or                        hand.getFinger("pinky");
    // or                        hand.getFinger(4);


    for (Finger finger : hand.getFingers()) {
      // or              hand.getOutstretchedFingers();
      // or              hand.getOutstretchedFingersByAngle();

      int     fingerId         = finger.getId();
      PVector fingerPosition   = finger.getPosition();
      PVector fingerStabilized = finger.getStabilizedPosition();
      PVector fingerVelocity   = finger.getVelocity();
      PVector fingerDirection  = finger.getDirection();
      float   fingerTime       = finger.getTimeVisible();

      // ------------------------------------------------
      // Drawing

      // Drawing:

      finger.draw();  // Executes drawBones() and drawJoints()
      finger.drawBones();
      finger.drawJoints();

      //Playing spheres on tips of fingers
      pushMatrix();
      stroke(0);
      sphereDetail(6);
      translate(fingerPosition.x, fingerPosition.y, fingerPosition.z);
      fill(0, 255, 255);
      sphere(15);
      popMatrix();

      //Pinch and position test
      pushMatrix();
      stroke(0);
      sphereDetail(6);
      if (fingerPosition.x >= 650 && fingerPosition.x<= 750 && fingerPosition.y >= 400 && fingerPosition.y<= 500 && fingerPosition.z >= 25 && fingerPosition.z<= 75 && handPinch >= 0.8) {
        translate(fingerPosition.x, fingerPosition.y, fingerPosition.z);
        fill(0, 255, 0);
        sphere(30);
      } else {
        translate(700, 450, 50);
        fill(255, 0, 0);
        sphere(30);
      }
      popMatrix();


      // ------------------------------------------------
      // Selection

      switch(finger.getType()) {
      case 0:
        // System.out.println("thumb");
        break;
      case 1:
        // System.out.println("index");
        break;
      case 2:
        // System.out.println("middle");
        break;
      case 3:
        // System.out.println("ring");
        break;
      case 4:
        // System.out.println("pinky");
        break;
      }


      // ================================================
      // 5. Bones
      // --------
      Bone    boneDistal       = finger.getDistalBone();
      // or                      finger.get("distal");
      // or                      finger.getBone(0);

      Bone    boneIntermediate = finger.getIntermediateBone();
      // or                      finger.get("intermediate");
      // or                      finger.getBone(1);

      Bone    boneProximal     = finger.getProximalBone();
      // or                      finger.get("proximal");
      // or                      finger.getBone(2);

      Bone    boneMetacarpal   = finger.getMetacarpalBone();
      // or                      finger.get("metacarpal");
      // or                      finger.getBone(3);

      // ------------------------------------------------
      // Touch emulation

      int     touchZone        = finger.getTouchZone();
      float   touchDistance    = finger.getTouchDistance();

      switch(touchZone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#" + fingerId + "): " + touchDistance);
        break;
      case 1: // Touching
        // println("Touching (#" + fingerId + ")");
        break;
      }
    }


    // ==================================================
    // 6. Tools

    for (Tool tool : hand.getTools()) {
      int     toolId           = tool.getId();
      PVector toolPosition     = tool.getPosition();
      PVector toolStabilized   = tool.getStabilizedPosition();
      PVector toolVelocity     = tool.getVelocity();
      PVector toolDirection    = tool.getDirection();
      float   toolTime         = tool.getTimeVisible();

      // ------------------------------------------------
      // Drawing:
      // tool.draw();

      // ------------------------------------------------
      // Touch emulation

      int     touchZone        = tool.getTouchZone();
      float   touchDistance    = tool.getTouchDistance();

      switch(touchZone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#" + toolId + "): " + touchDistance);
        break;
      case 1: // Touching
        // println("Touching (#" + toolId + ")");
        break;
      }
    }
  }


  // ====================================================
  // 7. Devices

  for (Device device : leap.getDevices()) {
    float deviceHorizontalViewAngle = device.getHorizontalViewAngle();
    float deviceVericalViewAngle = device.getVerticalViewAngle();
    float deviceRange = device.getRange();

    //    println(device.getHorizontalViewAngle());
  }
  //update physics engine every frame
  physics.update();
  // default display of every shape
  physics.display();
}