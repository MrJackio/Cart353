class Barrel {

  PVector position;
  int x;
  int z;

  Barrel() {
    position = new PVector(0, 0, z);
  }

  void display(int z, int x) {
    pushMatrix();
    translate(x, 430, z);
    rotateY(PI/5);
    fill(170, 110, 90);
    box(80, 130, 80);
    fill(120);
    translate(0, -53, 0);
    box(83, 10, 83);
    translate(0, 53, 0);
    box(83, 10, 83);
    translate(0, 53, 0);
    box(83, 10, 83);
    popMatrix();
  }
}