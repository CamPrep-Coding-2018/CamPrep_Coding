class Bullet {
   // Position and speed
   PVector pos;
   PVector spd;
   
   Bullet(PVector p) {
     // Copy the starting position
     pos = p.copy();
     // Set a random angle (this is over-written elsewhere if needed);
     spd = PVector.fromAngle(random(TWO_PI));
     spd.mult(5);
   }
   
   void draw() {
     // Draw the bullet, just a green circle for now
     fill(0, 0, 255);
     ellipse(pos.x, pos.y, 5, 5);
   }
   
   void update() {
     // Move the bullet
     pos.add(spd);
   }
   
   boolean isOutOfBounds() {
     // Check if bullet has left screen
     return pos.x >= width || pos.x <= 0 || pos.y >= height || pos.y <= 0;
   }
}
