
boid proto;

float forceLow=.03;
float forceHigh=.09;
float speedLow=2;
float speedHigh=3;
boid[] gang; 
HashMap lookup;

int numParticles;
void setup(){
  //frameRate(90);
  size(1400,700);
  noStroke();
  numParticles=500;
  gang= new boid[numParticles];
  float counter=0;
  for (int i=0; i<numParticles; i++){
    gang[i]=new boid(random(width), random(height));
//    gang[i].setMax((random(8)+3), (random(0.07)+0.01) ); 
    gang[i].setMax((random(speedHigh)+speedLow), (random(forceHigh)+forceLow) ); 
  }
  background(255);
  fill(0);
  chase=new PVector(mouseX, mouseY);
}

PVector chase;



void draw(){
 // background(255);
//  background(128, 128, 128, .2);
  fill(255, 255, 255, 140);
  beginShape();
  rect(0,0, width, height);
    gang[0].updatePos();
    gang[0].drawMe();
    chase.x=mouseX;
    chase.y=mouseY;
    
    gang[0].goTo(chase);
  for (int i=1; i<numParticles; i++){
    gang[i].updatePos();
    gang[i].drawMe();
    gang[i].separate();
    //chase.x=mouseX;
    //chase.y=mouseY;
   // gang[i].goTo(gang[i-1].getPos()); 
    gang[i].goTo(chase);
  }
 
  
 
}

void mouseMoved(){
    for (int i=0; i<numParticles; i++){
//      gang[i].goTo(new PVector(mouseX, mouseY)); 
  }
}
void mouseClicked(){
// proto.goTo(mouseX, mouseY); 
  
}
