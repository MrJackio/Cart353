class Drop {
  float mass;
  float x, y;   // Variables for location of raindrop
  color c;
  float r;      // Radius of raindrop
  boolean active;
  PVector position;
  PVector velocity;
  PVector acceleration;

  Drop() {
    r = 4;                   // All raindrops are the same size
    x = random(width);       // Start with a random x location
    y = -r*4;                // Start a little above the window
    c = color(255); // Color
    active = true;
    mass = 0.4;
    position = new PVector(random(width), -r*4);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
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

  // Check if it hits the bottom
  boolean reachedBottom() {
    // If we go a little beyond the bottom
    if (y > height + r*4) { 
      return true;
    } else {
      return false;
    }
  }

  // Display the raindrop
  void display() {
    // Display the drop
    fill(c);
    stroke(0,0,255,50);
 //   for (int i = 2; i < r; i++ ) {
      ellipse(position.x, position.y + r*2, r, r);
 //   }
  }

  // If the drop is caught
  void caught() {
    // Stop it from moving by setting speed equal to zero 
    // Set the location to somewhere way off-screen
    position.y = -1000;
    active = false;   
  }
}