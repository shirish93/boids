
boid proto;

float forceLow=0.02;
float forceHigh=0.12;
float speedLow=4;
float speedHigh=13;
boid[] gang;
int numParticles;
void setup(){
  size(1000,700);
  noStroke();
  numParticles=7500;
  gang= new boid[numParticles];
  for (int i=0; i<numParticles; i++){
    gang[i]=new boid(random(width), random(height));
//    gang[i].setMax((random(8)+3), (random(0.07)+0.01) ); 
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
class boid{
 
 private PVector position; 
 private PVector velocity;
 private PVector acceleration;
 private float maxspeed;
 private float maxforce;
  
 boid (float x, float y){
   position= new PVector(x, y);  
   velocity= new PVector(0,0);
   acceleration= new PVector(0,0);
   maxspeed=8;
   maxforce=.075;
 }
 
 void updatePos(){

   velocity.add(acceleration);
   velocity.limit(maxspeed);
   position.add(velocity);
   acceleration.mult(0);
   
 }
 
 void setMax(float speed, float force){
  maxspeed=speed;
  maxforce=force;
  a= map(maxforce, forceLow, forceHigh, 0, 255);
  b= map(maxspeed, speedLow, speedHigh, 0, 255); 
  c= (a+b)/2;
 }
 float a, b, c;
 PVector desiredVelRand(PVector target){
   PVector start= PVector.sub(target, position);
   start.normalize();
   start.mult(40);
   start.x= position.x+start.x+ 40*cos(radians(random(360)));
   start.y= position.y+start.y+40*sin(radians(random(360)));
   start=start.sub(start, position);
   return start;
 }
 
 void goTo(PVector target){

  //  PVector desired= desiredVelRand(target);
      PVector desired=PVector.sub(target,  position);
/*   if (position.x<25){
     desired=new PVector(maxspeed, velocity.y);     
   }*/





 // if (desired==undefined){
   // desired= new PVector(1,1);
 // }
    float d = desired.mag();
   
   desired.normalize();
   
   if (d<100){
     float m = map(d, 0, 100, 0, maxspeed);
     desired.mult(m); 
   }
   else{
     desired.mult(maxspeed);
   }
   PVector steer = PVector.sub(desired, velocity);
   steer.limit(maxforce);
   applyForce(steer);
   
 }
 
 void applyForce(PVector force){
  acceleration.add(force); 
 }
 
 void drawMe(){

   fill(a, b, c, 200);
   float size= map(maxspeed, speedLow, speedHigh, 3, 2);
   ellipse(position.x, position.y, size, size);  
   
 }
  
 void setVelocity(float x, float y){
   velocity.x=x;
   velocity.y=y; 
 }

 void setAcceleration(float x, float y){
  acceleration.x=x;
  acceleration.y=y;  
 } 
  
}

