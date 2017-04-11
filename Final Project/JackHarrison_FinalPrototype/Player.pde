class Cowboy {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  int x;
  float a;
  int skinR;  
  int skinG;
  int skinB;
  int topR;
  int topG;
  int topB;
  int hatC;

  Cowboy(int newX, float newA) {
    a = newA;
    x = newX;
    position = new PVector(x, 400, 0);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    topspeed = 10;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    position.add(velocity);
  }

  void display(int topR, int topG, int topB, int hatC, int skinR, int skinG, int skinB) {
    //    shader(toon);
    pushMatrix();
    strokeWeight(1);
    //   directionalLight(204, 204, 204, -position.x, -position.y, -1);
    translate(position.x, position.y, position.z);
    fill(topR, topG, topB);
    rotateY(a);
    box(8, 35, 18);

    pushMatrix();
    //      noStroke();
    fill(skinR, skinG, skinB);
    translate(0, -27, 0);
    rotateY(a);
    box(10, 15, 15);
    popMatrix();

    pushMatrix();
    //      noStroke();
    fill(10);
    translate(5, -29, 5);
    rotateY(a);
    box(2, 2, 2);
    popMatrix();

    pushMatrix();
    //      noStroke();
    fill(skinR);
    translate(5, -29, -5);
    rotateY(a);
    box(2, 2, 2);
    popMatrix();

    pushMatrix();
    //  noStroke();
    fill(hatC);
    translate(0, -34, 0);
    rotateY(a);
    box(20, 2, 25);
    popMatrix();

    pushMatrix();
    //      noStroke();
    fill(hatC);
    translate(0, -40, 0);
    rotateY(a);
    box(10, 10, 13);
    popMatrix();

    //pants
    pushMatrix();
    //    strokeWeight(1);
    translate(0, 25, 6);
    rotateY(a);
    fill(50, 80, 165);
    box(8, 25, 5);
    popMatrix();

    //hand
    pushMatrix();
    //    strokeWeight(1);
    translate(24, -11, 9);
    rotateY(a);
    fill(skinR, skinG, skinB);
    box(5, 5, 5);
    popMatrix();

    pushMatrix();
    //    strokeWeight(1);
    translate(28, -16, 9);
    rotateY(a);
    fill(50);
    box(10, 5, 5);
    popMatrix();

    pushMatrix();
    //    strokeWeight(1);
    translate(11, -11, 9);
    rotateY(a);
    fill(topR, topG, topB);
    box(20, 5, 5);
    popMatrix();

    pushMatrix();
    //    strokeWeight(1);
    translate(3, -8, -11);
    rotateY(a);
    fill(topR, topG, topB);
    box(5, 20, 5);
    popMatrix();

    pushMatrix();
    translate(0, 25, -6);
    rotateY(a);
    fill(50, 80, 165);
    box(8, 25, 5);
    popMatrix();

    pushMatrix();
    translate(3, 40, -6);
    rotateY(a);
    fill(50);
    box(15, 5, 5);
    popMatrix();

    pushMatrix();
    translate(3, 40, 6);
    rotateY(a);
    fill(50);
    box(15, 5, 5);
    popMatrix();

    pushMatrix();
    translate(0, 10, 0);
    rotateY(a);
    fill(50, 80, 165);
    box(9, 15, 19);
    popMatrix();
    popMatrix();
  }

  void moveCowboy() {
  }
}