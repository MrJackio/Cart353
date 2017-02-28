// Forces Assignment
//  Feb 28th, 2017
//  By: Jack Harrison, 27363486
//  For CART 353, Rilla Khaled
//
// Description: Complete the Snowman! Move the head to the body! As you play
// you learn more about the game and how to win

Ball ball; 
Sman sman; //(snowman)
Timer timer;        
Drop[] drops;  

int totalDrops = 0; 
float windy = random(-0.02, 0.02);  //Wind is random at start of the game

PVector gravity = new PVector(0, 0.04);
PVector wind = new PVector(windy, 0);
PVector appliedR = new PVector(0.1, 0);
PVector appliedL = new PVector(-0.1, 0);

boolean left = false;
boolean right = false;
boolean up = false;

void setup() {
  size(800, 320);
  ball = new Ball(8); 
  sman = new Sman(10);
  drops = new Drop[1000];    // Create 1000 spots in the array
  timer = new Timer(25);    // Create a timer that goes off every 25 milliseconds
  timer.start();             // Starting the timer
}

void draw() {
  // if size of snowball is too small or too large
  if (ball.position.x >= 699 && ball.position.x <= 701 && ball.r > 20) {
    // write "Big Game Over" & stop game
    String s = "That head is HUGE! Try Again";
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(s, width/2, height/2);
    fill(255);
    ellipse(700, 265, 30, 30);
    ellipse(700, 222, 22, 22);
  } else if (ball.position.x >= 699 && ball.position.x <= 701 && ball.r <= 10) {
    // write "Small Game Over" & stop game
    String s = "That head is TINY! Try Again";
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(s, width/2, height/2);
    fill(255);
    ellipse(700, 265, 30, 30);
    ellipse(700, 230, 8, 8);

    //If size of ball is just right
  } else if (ball.position.x >= 699 && ball.position.x <= 701 && ball.r <= 20) {
    // write "game over" & don't allow anymore play
    String s = "Perfect! You Win!";
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text(s, width/2, height/2);
    fill(255);
    ellipse(700, 265, 30, 30);
    ellipse(700, 228, 12, 12);
  } 

  // if game isnt over we can let player continue
  else {
    background(30, 180, 235);
    fill(252, 252, 247);
    stroke(0);
    rect(-5, 272, 810, 200); //The ground
    sman.display(); 

    //the various instructions
    pushMatrix();
    String s = "Wind:"; //Wind is random with each play, effects only the snow not the ball
    fill(255);
    textSize(14);
    textAlign(CENTER);
    text(s + windy*50, 75, 25);
    text("r = reset", 70, 40);
    text("a/d = left/right", 70, 55);
    text("w = jump", 70, 70);
    fill(210, 210, 255);
    textSize(18);
    text("Complete the Snowman!", width/2, 25);
    popMatrix();

    //Applying gravity to the ball
    if (ball.position.y < 260) {
      ball.applyForce(gravity);
      ball.update();
    } else {
      ball.velocity.y = 0;
    }

    //Applying gravity and Wind to the drops of snow
    for (int i = 0; i < totalDrops; i++ ) {
      if (drops[i].position.y < 330 && drops[i].active == true) {
        drops[i].applyForce(wind);
        drops[i].applyForce(gravity);
        drops[i].update();
      }
      drops[i].display();
      //Adding mass and size to ball whenever hit by snow
      if (ball.intersect(drops[i]) && drops[i].active == true) {
        if (ball.mass < 10) {
          ball.mass = ball.mass + drops[i].mass;
        } 
        if (ball.r < 36) {
          ball.r = ball.r + 0.5;
        }
        drops[i].caught();
      }
    }

    //The keys to be used; w,a,d and r
    if (left == true) {
      ball.applyForce(appliedL);
      ball.update();
    }
    if (right == true) {
      ball.applyForce(appliedR);
      ball.update();
    }
    if (up == true) {
      ball.goJump();
    }
    if (ball.jump ==true) {
      // Moving ball up
      ball.velocity.y +=1;
      // change speed for jump gradually
      ball.position.y +=ball.velocity.y;
      if (ball.position.y >= 260) {
        ball.position.y = 260;
        ball.velocity.y =0;
        ball.jump=false;
      }
    }
    ball.display();
    //   Check the timer
    if (timer.isFinished()) {
      //  // Deal with snow drops
      //  // Initialize one drop
      if (totalDrops < 1000) {
        drops[totalDrops] = new Drop();
        //  // Increment totalDrops
        totalDrops ++ ;
      }
      timer.start();
    }
  }
}

//More on keys
void keyPressed() {
  if (key == 'a') {
    left = true;
  }
  if (key == 'd') {
    right = true;
  }
  if (key == 'w') {
    up = true;
  }
  if (key == 'r') {
    reset();
  }
}
//keyReleased used to make sure controls are smooth
void keyReleased() {
  if (key == 'a') {
    left = false;
    ball.velocity.x = 0;
  }
  if (key == 'd') {
    right = false;
    ball.velocity.x = 0;
  }
  if (key == 'w') {
    up = false;
  }
}
//Function to reset game 
void reset() {
  ball = new Ball(8); // Create the catcher with a radius of 32
  sman = new Sman(10);
  drops = new Drop[1000];    // Create 1000 spots in the array
  timer = new Timer(25);    // Create a timer that goes off every 300 milliseconds
  timer.start(); 
  totalDrops = 0; // Starting the timer
  windy = random(-0.02, 0.02);
  left = false;
  right = false;
  up = false;
}