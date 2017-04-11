class Light {

  PVector position;
  int x;
  int r;
  int g;
  int b;

  Light(int newX) {
    x = newX;
    position = new PVector(x, 0, 0);
    r = 0;
    g = 10;
    b = 10;
  }

  void display() {
    pushMatrix();
    ambientLight(200, 200, 200);
    translate(x, -175, -1000);
    fill(100);
    box(20, 30, 20);
    pushMatrix();
    translate(0, 40, 0);
    strokeWeight(1);
    sphereDetail(8);
    fill(r, g, b);
    sphere(40);
    popMatrix();
    popMatrix();
    strokeWeight(2);
  }
}