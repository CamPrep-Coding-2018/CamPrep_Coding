class Player {
  // Player position
  PVector pos;
  // Crosshair position
  PVector crosshair;

  // Player life (not yet used)
  int life;

  // Spaceship sprite
  PImage img;

  Player() {
    // Load image and resize it
    img = loadImage("ship.PNG");
    img.resize(40,40);
    
    // Set our starting position in the middle of the screen
    pos = new PVector(width/2, height/2);
    // Initialise the crosshair PVector (the value doesn't matter, but we do need to initialise it)
    crosshair = new PVector(0,0);

    // Life, not yet used
    life = 5;
  }

  void draw() {
    // The crosshair follows the mouse
    crosshair.x = mouseX;
    crosshair.y = mouseY;
    
    // Move according to key presses (see Multi_Keys)
    if (w_key) pos.y-= 5;
    if (s_key) pos.y+= 5;
    if (a_key) pos.x-= 5;
    if (d_key) pos.x+= 5;
    
    // Draw a line from the ship to the crosshair
    strokeWeight(2);
    line(pos.x, pos.y, crosshair.x, crosshair.y);
    
    // Draw the players ship, some rotation needed to align the sprite we're using
    pushMatrix();
    translate(pos.x, pos.y);  // Center on the ship position
    rotate(PVector.sub(crosshair, pos).heading());  // Rotate to face the crosshair
    pushMatrix();
    translate(10, -20);      // Position the sprite correctly 
    rotate(HALF_PI);         // The sprite is facing right instead of up, rotate it
    image(img, 0, 0);
    popMatrix();
    popMatrix();
  }
  
  Bullet fire() {
    // Create  a new bullet at the ships location, facing the crosshair
    
    // Subtracting pos from crosshair gives us a vector pointing in the direction of the crosshair
    // normalize()-ing it makes that vector 1 unit long, so our bullets go the same speed
    PVector bullet_spd = PVector.sub(crosshair, pos).normalize();
    // Create a new bullet just in front of our ship
    Bullet out = new Bullet(pos.add(bullet_spd));
    // Give it a speed
    out.spd = bullet_spd.mult(5);
    return out;
  }

}
