class Bullet {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  float lifetime;
  int x;

  Bullet(int newX) {
    x = newX;
    location = new PVector(x, 385, 0);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    topspeed = 10;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127);
    translate(location.x, location.y, location.z);
    sphere(2);
  }
}