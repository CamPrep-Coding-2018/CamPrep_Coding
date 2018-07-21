// Circle position
float diameter;
Player p1;

Asteroid[] ast;
ArrayList<Bullet> bullets;

void setup() {
  size(800,800);
  
  p1 = new Player();
  bullets = new ArrayList<Bullet>();
  
  ast = new Asteroid[20];
  for (int i = 0; i < 20; i++)
  { ast[i] = new Asteroid(); }
  
  diameter = 25;
  
  values = new float[res][res];
  for(int i = 0; i < res; i++) {
    for(int j = 0; j < res; j++) {
      values[i][j] = random(255);
    }}
  }

int res = 20;

float[][] values;

void draw() {
  // Clear the screen
  background(100);
  
  fill(0,0);
  float w = width/res;
  float h = height/res;
  for (int i = 0; i < res; i++) {
    for (int j = 0; j < res; j++) {
      fill(50, 100, values[i][j], 100);
      stroke(0,0);
      rect(i * w, j * h, w, h);
    }}
  stroke(255,255);  
  
  // === BULLETS ===
  // Keep track of bullets that are off screen
  ArrayList<Bullet> ToDelete = new ArrayList<Bullet>();
  
  // Go through our list of bullets
  for (Bullet b : bullets) {
    b.draw();    // Draw them 
    b.update();  // Move them
    // If a bullet leaves the screen, add it to the list of those to delete
    if (b.isOutOfBounds())
    { ToDelete.add(b); }
  }
    
  // Go through our asteroids
  for (int i = 0; i < 20; i++) {
    // Detect collision with bullets
     for (Bullet b : bullets) {
       if(ast[i].collide(b.pos, 12.5)) {
         // We don't need to remove health from the asteroid, that happens in ast.collide
         ToDelete.add(b); // List our bullet as needing deletion
         // We could also play a sound, or create an explosion, or add points
        }
     }
    // Draw and move our asteroids
    ast[i].draw();
    ast[i].update();
  }
  
  // Delete all those bullets that are either off the screen, or hit an asteroid
  for (Bullet b : ToDelete) {
    bullets.remove(b);
  }
  
  // === PLAYER ===
  // Circle follows mouse
  p1.draw();
}

void keyPressed() {
  // If space pressed, fire bullet
  if (key == ' ')
    bullets.add(p1.fire());
    
  // Register other key presses (see Multi_keys)
  if (key == CODED)
    setCodedKey(keyCode, true);
  else
    setKey(key, true);
}

void keyReleased() {
  // Register key releases (see Multi_keys)
  if (key == CODED)
    setCodedKey(keyCode, false);
  else
    setKey(key, false);
} 
