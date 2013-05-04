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
  a= map(maxforce, forceLow, forceHigh, 0, 230);
  b= map(maxspeed, speedLow, speedHigh, 0, 230); 
  c= (a+b)/2;
 }
 float a, b, c;
 PVector desiredVelRand(PVector target){
   PVector start= PVector.sub(target, position);
   start.normalize();
   start.mult(50);
   start.x= position.x+start.x+ 40*cos(radians(random(360)));
   start.y= position.y+start.y+40*sin(radians(random(360)));
   start=start.sub(start, position);
   return start;
 }
 
 
 void separate(){
   PVector sum = new PVector();
   int count=0;
   float desiredseparation=20;
   int sizes= gang.length;
   for (int i=0; i<sizes; i++){
     float d = PVector.dist(position, gang[i].getPos());
     if ((d>0) && d<desiredseparation){
       PVector diff= PVector.sub(position, gang[i].getPos());
       diff.normalize();
       sum.add(diff);
       count++; 
     }
   } 
   
   if (count>0){
     sum.div(count);
     sum.setMag(maxspeed);
     PVector steer = PVector.sub(sum, velocity);
     steer.limit(maxforce);
     applyForce(steer);
   }
 }
 
 void goTo(PVector target){

    PVector desired= desiredVelRand(target);
 //   PVector desired=PVector.sub(target,  position);
    float d = desired.mag();
    desired.normalize();
    desired.mult(50);
    /*if (obstructed(desired)){
     desired.mult(.1); 
      
    }*/
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
   
 }
 
 PVector getPos(){
   return position; 
 }
 
 boolean obstructed(PVector desired){
   PVector target = PVector.add(position, desired);
   int longs=gang.length;
   for (int i=0; i<longs; i++){
     PVector finals= PVector.sub(target, gang[i].getPos());
     if (finals.mag()<2){
       return true;
     }
   }
      return false;
   
 }
 
 void applyForce(PVector force){
  acceleration.add(force); 
 }
 
 
 
 void drawMe(){

   float size= map(maxspeed, speedLow, speedHigh, 5, 3.5);
    fill(a, b, c, 180);
  // fill(0,05,0,160);
  // stroke(0);
  // strokeWeight(.2);
   
    ellipse(position.x, position.y, 10, 10);  
   //curveVertex(position.x, position.y);
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
