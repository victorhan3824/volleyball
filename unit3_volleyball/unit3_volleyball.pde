//volleyball
import fisica.*;

//pallete
color blue   = color(29, 178, 242);
color brown  = color(166, 120, 24);
color green  = color(74, 163, 57);
color red    = color(224, 80, 61);
color yellow = color(242, 215, 16);

//fisica
FWorld world;

//keyboard
boolean wKey, aKey, sKey, dKey, upKey, downKey, leftKey, rightKey;

//bodies
FCircle ball;
FBox leftP, rightP;
FBox leftG, rightG; //ground

//========================================================
void setup() {
  size(800, 600); 
  makeWorld();
  initalizeBodies();
  makeBodies();
}

void makeWorld() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 560);
  world.setEdges(); //put edge around the world
}

void initalizeBodies() {
  leftP = new FBox(50, 50); //initialize player
  rightP = new FBox(50, 50);  
  
  leftG = new FBox(400,30);
  rightG = new FBox(400,30);
}

void makeBodies() { //adding all bodies
  makeBall();
  makeBoxes(leftP, blue, 100, 500, false);
  makeBoxes(rightP, red, 700, 500, false);
  makeBoxes(leftG, blue, 200, 575, true);
  makeBoxes(rightG, red, 600, 575, true);
}

//=========================================================
void makeBall() { //adding the ball
  ball = new FCircle(20);
  ball.setPosition(random(width), -5);

  //set visuals
  ball.setStroke(0);
  ball.setStrokeWeight(2);
  ball.setFillColor(color(255,255,255,200));

  //set physical properties
  ball.setDensity(1);
  ball.setFriction(1);
  ball.setRestitution(1);

  //add to world
  world.add(ball);
}

void makeBoxes(FBox p, color c, float X, float Y, boolean s) { //adding all the box bodies
  //initalize position
  p.setPosition(X, Y);
  
  //set visuals
  p.setStroke(0);
  p.setStrokeWeight(2);
  p.setFillColor(c); 
  
  //set physical properties
  p.setDensity(20);
  p.setFriction(0);
  p.setStatic(s);
  world.add(p);  
}

//========================================================
void draw() {
  background(0);
  world.draw();
  world.step();
  handleInput();
}

void handleInput() {
  float leftVX = leftP.getVelocityX();
  float leftVY = leftP.getVelocityY();
  
  float rightVX = rightP.getVelocityX();
  float rightVY = rightP.getVelocityY();
  
  if (aKey) leftP.setVelocity(-300, leftVY);
  if (dKey) leftP.setVelocity(300, leftVY);
  if (wKey) leftP.setVelocity(leftVX, -300);
  if (sKey) leftP.setVelocity(leftVX, 300);
  
  if (leftKey) rightP.setVelocity(-300, rightVY);
  if (rightKey) rightP.setVelocity(300, rightVY);
  if (upKey) rightP.setVelocity(rightVX, -300);
  if (downKey) rightP.setVelocity(rightVX, 300);
}
