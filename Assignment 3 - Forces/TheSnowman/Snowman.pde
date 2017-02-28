class Sman {
  PVector position;
  float r;
  
  Sman(float newR) {
  position = new PVector(700,278);
  r = newR;
  }

  void display(){
    fill(255);
   // ellipse(position.x,position.y,r*2,r);
    ellipse(position.x,265,30,30);
    ellipse(position.x,243,20,20);

  }

}