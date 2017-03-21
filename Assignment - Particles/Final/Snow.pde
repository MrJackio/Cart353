// Snow PArticle Class, Extends Particle

class Snow extends Particle {

  // Variables to let us do angle rotations
  float theta = 0;
  float aVelocity = 0;

  Snow(PVector l) {
    super(l);
   acceleration = new PVector(0, 0.02);
   velocity = new PVector(random(-0.2,0.2),random(-0.2,0));
  }

  // Override the update method
  // Override the display method
  void display() {
    pushMatrix();
    stroke(255,lifespan);
    strokeWeight(1);
    fill(255,lifespan);
    ellipse(position.x,position.y,3,3);
    popMatrix();
  }
}