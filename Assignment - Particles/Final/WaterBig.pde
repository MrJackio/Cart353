
// Particle class for small water particles

class bWater extends Particle {

  // Variables to let us do angle rotations
  float theta = 0;
  float aVelocity = 0;

  bWater(PVector l) {
    super(l);
    acceleration = new PVector(0, 0.05);
    velocity = new PVector(random(-0.2,0.2),random(-0.2,0));
  }

  // Override the update method
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    
    // update angular velocity in accordance with a scaled version of velocity.x
    // note we're not going to do anything with angular acceleration since plain
    // acceleration never changes
    float dir = 1;
    if(velocity.x != 0) {
      // the direction of our spin is related to direction of velocity
      
      // this calculation lets us extract velocity's "sign" (+ or -)
      dir = Math.abs(velocity.x)/velocity.x;
    }
    aVelocity += 0.0005 * dir;
    
    // update angle according to aVelocity
    theta += aVelocity;
    
    lifespan -= 2.0;
  }

  // Override the display method
  void display() {
    pushMatrix();
    rectMode(CENTER);
    fill(10,100,210,lifespan);
    stroke(30,110,220,lifespan);
    strokeWeight(2);
    translate(position.x,position.y);
    rotate(theta);
    ellipse(0,0,20,20);
    popMatrix();
  }
}