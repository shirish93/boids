
boid proto;

float forceLow=.3;
float forceHigh=0.9;
float speedLow=4;
float speedHigh=12;
boid[] gang; 
HashMap lookup;

int numParticles;
void setup(){
  //frameRate(90);
  size(1000,700);
  noStroke();
  lookup = new HashMap();
  numParticles=10000;
  gang= new boid[numParticles];
  float counter=0;
  for (int i=0; i<numParticles; i++){
    gang[i]=new boid(random(width), random(height));
//    gang[i].setMax((random(8)+3), (random(0.07)+0.01) ); 
    gang[i].setMax((random(speedHigh)+speedLow), (random(forceHigh)+forceLow) ); 
  }
  background(255);
  fill(0);
}



void draw(){
 // background(255);
//  background(128, 128, 128, .2);
  fill(255, 255, 255, 140);
  rect(0,0, width, height);
  for (int i=0; i<numParticles; i++){
    gang[i].updatePos();
    gang[i].drawMe();
    gang[i].goTo(new PVector(mouseX, mouseY)); 
    
  }
 
}

void mouseMoved(){
    for (int i=0; i<numParticles; i++){
      gang[i].goTo(new PVector(mouseX, mouseY)); 
  }
}
void mouseClicked(){
// proto.goTo(mouseX, mouseY); 
  
}
