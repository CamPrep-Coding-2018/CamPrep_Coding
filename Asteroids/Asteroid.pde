class Asteroid{
   PVector pos;
   PVector dim;
   
   PVector spd;
   int life;
   
   Asteroid() {
     pos = new PVector(random(width), random(height));
     dim = new PVector(random(50), random(50));
     spd = new PVector(random(-5, 5), random(-5, 5));
     life = int(random(5));
   }
   
   void draw() {     
     rect(pos.x, pos.y, dim.x, dim.y);
   }
   
   void update() {
     pos.add(spd);
     
     pos.add(width,height);
     pos.x %= width;
     pos.y %= height;
   }
}
