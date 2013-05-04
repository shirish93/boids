
boid proto;

float forceLow=.1;
float forceHigh=0.8;
float speedLow=4;
float speedHigh=13;
boid[] gang; 
int numParticles;
void setup(){
  //frameRate(90);
  size(1000,700);
  noStroke();
  numParticles=12000;
  gang= new boid[numParticles];
  float counter=0;
  for (int i=0; i<numParticles; i++){
    gang[i]=new boid(random(width), random(height));
//    gang[i].setMax((random(8)+3), (random(0.07)+0.01) ); 
    counter+=0.01;
    float val= map(noise(counter), 0, 1, forceLow, forceHigh);
      //  gang[i].setMax((random(speedHigh)+speedLow), val ); 
    gang[i].setMax((random(speedHigh)+speedLow), (random(forceHigh)+forceLow) ); 
  }
  background(255);
  fill(0);
}



void draw(){
  background(255);
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
