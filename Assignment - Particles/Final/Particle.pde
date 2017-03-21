// Simple Particle, Used to control all particles

class Particle {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector iceVelocity;
  PVector iceAcceleration;
  float lifespan;

  Particle(PVector l) {
    position = l.get();
    lifespan = 300.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 2.0;
  }

  // Method to display
  void display() {
  }
  
  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}