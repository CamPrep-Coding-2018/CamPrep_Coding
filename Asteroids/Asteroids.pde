// Circle position
PVector circle;
float diameter;

PVector dims;

PVector[] targets;

Asteroid ast;

void setup() {
  size(500,500);
  
  ast = new Asteroid();
  
  // Initialise circle position
  circle = new PVector(50,50);
  diameter = 50;
  
  // Initialise target position/dimension
  dims = new PVector(50,30);
  
  targets = new PVector[5];
  for (int i = 0; i < 5; i++)
  {
    targets[i] = new PVector(random(width), random(height));
  }
}

void draw() {
  // Clear the screen
  background(100);
  
  ast.draw();
  ast.update();
  
  // Circle follows mouse
  circle.x = mouseX;
  circle.y = mouseY;
  
  // Draw target
  fill(100, 100);
  
  ellipse(circle.x, circle.y, diameter, diameter);
  
  for (int i = 0; i < 5; i++) {
    if (circ_box_collide(circle, diameter/2, targets[i], dims))
    { fill(0, 255, 0, 100); }
    else
    { fill(128, 50 * i, 100); }
    rect(targets[i].x, targets[i].y, dims.x, dims.y);
  }
}
