class Border{
  //properties
  int x = 50;
  int w = 700;
  int h = 500;
  int sW = 100;
  color b = color(0,0,255);
  color t = color(255);
  
  Border(){
  }
  
  void display(){
  noFill();
  strokeWeight(sW);
  stroke(b);
  rect(x, x, w, h);
  }
  
  void displayText(){
  fill(t);
  textFont(VcrL, 48);
  text("Washed Out", 270, 60);
  fill(255, 255, 0);
  textFont(VcrS, 24);
  text("Filtering Application", 264, 85);
  fill(t);
  textFont(VcrS, 18);
  text("COLORCOUNT:UP/DOWN", 50, 560);
  text("NOISE:LEFT/RIGHT", 590, 560);
  text("BLUR: 'B'", 430, 560);
  text("SAVE: 'S'", 300, 560);
  }
}