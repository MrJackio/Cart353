Border border;
PFont VcrL;
PFont VcrS;
PImage kount;
PImage noise;
boolean blurry = false;
int poster = 85;
int opaci = 0;

float[][] matrix = {{0.06, 0.06, 0.06}, 
  {0.06, 0.45, 0.06}, 
  {0.06, 0.06, 0.06}};

void setup() {
  size(800, 600);
  border = new Border();
  VcrL = loadFont("VCROSDMono-48.vlw");
  VcrS = loadFont("VCROSDMono-24.vlw");
  kount = loadImage("kount.jpg");
  noise = loadImage("noise.jpg");  

  // Border
  border.display();
  border.displayText();
}

void draw() {
  tint(255);
  image(kount, 100, 100);

  if (blurry) {
    int matrixsize = 3;
    loadPixels();
    for (int x = 0; x<600; x++) {
      for (int y = 0; y<400; y++) {
        color c = convolution(x, y, matrix, matrixsize, kount);
        int loc = (x+100) + (y+100)*width;
        pixels[loc] = c;
      }
    }
    updatePixels();
  }

  tint(255, opaci);
  image(noise, 100, 100);
  filter(POSTERIZE, constrain(poster, 2, 85));
}

void keyPressed() {
  if (key == 's') {
    saveFrame("Filtered-######.png");
  }
  if (key == 'b') {
    blurry = true;
  }
  if (keyCode==UP) {
    poster += 4;
  }
  if (keyCode==DOWN) {
    poster -= 3;
  }
  if (keyCode==LEFT) {
    opaci -= 5;
  }
  if (keyCode==RIGHT) {
    opaci += 2;
  }
}

color convolution(int x, int y, float[][] matrix, int matrixsize, PImage kount) {
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;

  for (int i = 0; i < matrixsize; i++) {
    for (int j = 0; j < matrixsize; j++) {
      int xloc = x + i - offset;
      int yloc = y + j - offset;
      int loc = xloc + kount.width * yloc;

      loc = constrain(loc, 0, kount.pixels.length-1);

      rtotal += (red(kount.pixels[loc])*matrix[i][j]);
      gtotal += (green(kount.pixels[loc])*matrix[i][j]);
      btotal += (blue(kount.pixels[loc])*matrix[i][j]);
    }
  }
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  int locF = x + kount.width * y;
  return color(rtotal*1.05, green(kount.pixels[locF]), btotal*0.8);
}