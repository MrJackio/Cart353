// Cold water particle class

class Ice extends Particle {

  // Variables to let us do angle rotations
  float theta = 0;
  float aVelocity = 0;

  Ice(PVector l) {
    super(l);
    acceleration = new PVector(0, 0.6);
    velocity = new PVector(random(-1,1),random(-0.1,0));
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
    
    lifespan -= 6.0;
  }

  // Override the display method
  void display() {
    rectMode(CENTER);
    fill(160,255,255,lifespan);
    stroke(180,255,255,lifespan);
    strokeWeight(1);
    pushMatrix();
    translate(position.x,position.y);
    rotate(theta);
    triangle(0,0,0,20,6,6);
    popMatrix();
  }
}