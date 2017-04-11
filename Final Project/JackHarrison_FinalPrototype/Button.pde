class Button {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  int x;
  int pU;
  int pD;
  int pS;

  Button(int newX) {
    x = newX;
    position = new PVector(x, 0, 0);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    topspeed = 10;
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(topspeed);
    position.add(velocity);
  }

  void display() {
    //Button 1
    pushMatrix();
    translate(x, 535, 60);
    pushMatrix();
    rotateY(PI);
    pushMatrix();
    rotateX(PI/4);
    translate(60, pU, -50);
    fill(30, 180, 80);
    beginShape();  
    vertex(0, 0, 0);
    vertex(40*2, 0, 0);
    vertex(20*2, 0, 34.6*2);
    vertex(0, 0, 0);
    endShape();
    beginShape();  
    vertex(20*2, 0, 34.60*2);
    vertex(20*2, 30*2, 34.60*2);
    vertex(0, 30*2, 0);
    vertex(0, 0, 0);
    endShape();
    beginShape();  
    vertex(0, 0, 0);
    vertex(0, 30*2, 0);
    vertex(40*2, 30*2, 0);
    vertex(40*2, 0, 0);
    endShape();  
    beginShape();  
    vertex(40*2, 30*2, 0); 
    vertex(40*2, 0, 0);
    vertex(20*2, 0, 34.60*2);
    vertex(20*2, 30*2, 34.60*2);
    endShape(); 
    beginShape();  
    vertex(0, 30*2, 0);
    vertex(40*2, 30*2, 0);
    vertex(20*2, 30*2, 34.6*2);
    vertex(0, 30*2, 0);
    endShape();  
    popMatrix();
    popMatrix();
    popMatrix();
    //Button 2 
    pushMatrix();
    translate(x-80, 570, 95);
    pushMatrix();
    //  rotateY(PI/2);
    pushMatrix();
    rotateX(-PI/4);
    translate(65, pD, -60);
    fill(30, 180, 80);
    beginShape();  
    vertex(0, 0, 0);
    vertex(40*2, 0, 0);
    vertex(20*2, 0, 34.6*2);
    vertex(0, 0, 0);
    endShape();
    beginShape();  
    vertex(20*2, 0, 34.60*2);
    vertex(20*2, 30*2, 34.60*2);
    vertex(0, 30*2, 0);
    vertex(0, 0, 0);
    endShape();
    beginShape();  
    vertex(0, 0, 0);
    vertex(0, 30*2, 0);
    vertex(40*2, 30*2, 0);
    vertex(40*2, 0, 0);
    endShape();  
    beginShape();  
    vertex(40*2, 30*2, 0); 
    vertex(40*2, 0, 0);
    vertex(20*2, 0, 34.60*2);
    vertex(20*2, 30*2, 34.60*2);
    endShape(); 
    beginShape();  
    vertex(0, 30*2, 0);
    vertex(40*2, 30*2, 0);
    vertex(20*2, 30*2, 34.6*2);
    vertex(0, 30*2, 0);
    endShape();  
    popMatrix();
    popMatrix();
    popMatrix();
    //button 3 (shoot)
    pushMatrix();
    fill(220, 25, 50);
    translate(x+120, 560, 45);
    rotateX(-PI/4);
    translate(40, pS, 25);
    translate(0, 0, 0);
    box(50*2, 30*2, 50*2);
    popMatrix();
  }
}