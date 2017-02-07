// Title: Lost@Sea
// Author: Jack Harrison
// Assignment #2
// Febuary 7th, 2017
// Description: A dynamic scene that makes you the ocean, watch clouds form and sea slowly form in front of your eyes, or rather on top of them!

//Recources: Landscape Challenge from reading/lecture, Nature of Code Reading

import processing.video.*;

float cC = 0;
float m;
float zoff;
float cell;
float[][] heights;
Capture video;

int numCols;
int numRows;

PFont vcr;

void setup() {

  size(640, 640, P3D); 
  background(0,240,255);
  zoff = 1000.0;
  cell = 15;
  numCols = 80;
  numRows = 60;
  
  video = new Capture(this, width, height);
  video.start();

  heights = new float[numCols][numRows];
  
  vcr = loadFont("VCR.vlw");
}

// calculateHeights() is based on k, j, and a changing value of zoff
void calculateHeights() {
  
  for (int k = 0; k < numCols; k++) {
    for (int j = 0; j < numRows; j++) {
      // assign z a PERLIN NOISE val based on a mapping of k, a mapping of j, and zoff
      float z = noise(map(k, 0, numCols, 0, 1), map(j, 0, numRows, 0, 1), zoff);
      // in the heights array, store the max and min of the landscape
      heights[k][j] = map(z, 0, 1, -200, 200);
    }
  }
  // change zoff for next time we call draw()
  zoff += 0.004;
}

void draw() {
  
  // Loading our video (live input)
  calculateHeights();  
  video.loadPixels();
  pushMatrix();
  //moving and rotating the "landscape", m moves the landscape slowly down, and mouseY adjusts its relative height
  m = m + 0.075;
  translate(-280, 100 +mouseY/24 + m, -300);
  rotateX(PI/3);
  
  //Drawing the grid-like water surface
  for (int k = 0; k < (numCols-1); k++) { 
    for (int j = 0; j < (numRows-1); j++) { 
      cC = cC + 0.0001;
      stroke(constrain(cC,0,150),255,240);      
      // grab the color from our pixel array
      // k + j*width
      int multiplier = width/numCols;
      int loc = (numCols - k*multiplier - 1) + j*multiplier * numCols;
      loc = constrain(loc, 0, video.pixels.length-1);
      //Changing the color of our landscape to a more blue tint, like water
      color c = video.pixels[loc];
      float blu = blue(c)+100;
      float gre = green(c)+60;
      float conBlu = constrain(blu,0,255);
      float conGre = constrain(gre,0,255);
      color newC =color(red(c),conGre,conBlu);
      fill(newC);
      pushMatrix();
      // translate our point of origin for drawing: jump to where each cell starts
      translate(k * cell, j * cell, 0);
      beginShape(QUADS);
      // 4 vertices, each a point in 3D space, drawing from our heights array
      vertex(0, 0, heights[k][j]);
      vertex(cell, 0, heights[k+1][j]);
      vertex(cell, cell, heights[k+1][j+1]);
      vertex(0, cell, heights[k][j+1]);
      endShape();
      popMatrix();
    }
  }
  popMatrix();
  
  float xloc = randomGaussian();
  float sdX = 480;                // standard deviation for the x
  float meanX = 240;         // mean value (middle of the screen along the x-axis)
  xloc = ( xloc * sdX ) + meanX;  // Scale the GAUSSIAN random number by standard deviation and mean
  float zloc = randomGaussian();
  float sdZ = 300;                //  for the z
  float meanZ = -200;         //  mean value for z-axis
  zloc = ( zloc * sdZ ) + meanZ;
  float yloc = randomGaussian();
  float sdY = 400;                //  for the y
  float meanY = -50;         // mean value for y-axis
  yloc = ( yloc * sdY ) + meanY;
  
  //Drawing sphere's to represent clouds, thicken as time goes by, this is where our randomGaussian() comes into play
  noStroke();
  fill(255,30);
  pushMatrix();
  translate(xloc,yloc,zloc);
  sphere(35);
  popMatrix();
  
  //Font to title the piece
  textFont(vcr);
  fill(120,0,190);
  // m is used to shift the text, making it appear more and more 3D
  text("Lost@Sea", width/2 + 100, 30, (-50)+(m/8));
  fill(255,255,255);  
  text("Lost@Sea", width/2 + 100, 30, (-50)+(m/8));
}