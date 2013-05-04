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

   // PVector desired= desiredVelRand(target);
    PVector desired=PVector.sub(target,  position);
    float d = desired.mag();
    desired.normalize();
    desired.mult(50);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
   
 }
 
 void applyForce(PVector force){
  acceleration.add(force); 
 }
 
 void drawMe(){

   fill(a, b, c, 140);
   float size= map(maxspeed, speedLow, speedHigh, 3.2, 2);
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
