class Ball {
  float r;    // radius
  color col;  // color
  float x, y; // location
  float mass;
  PVector position;
  PVector velocity;
  PVector acceleration;
  boolean jump = false;

  Ball(float tempR) {
    r = tempR;
    col = color(255);
    x = 0;
    y = 0;
    mass = 1;
    position = new PVector(25, 25);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void setLocation(float tempX, float tempY) {
    x = tempX;
    y = tempY;
  }

  void applyForce(PVector force) {
    PVector forceCopy = force.copy();
    forceCopy.div(mass); 
    acceleration.add(forceCopy);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    fill(col);
    ellipse(position.x, position.y, r, r);
  }

  void goJump() {      
    if (jump==false)
    {
      jump=true;
      velocity.y = -10;
    }
  }

  // A function that returns true or false based on
  // if the catcher intersects a raindrop
  boolean intersect(Drop d) {
    // Calculate distance
    float distance = dist(position.x, position.y, d.position.x, d.position.y); 

    // Compare distance to sum of radii
    if (distance < r + d.r) { 
      return true;
    } else {
      return false;
    }
  }
}