// Circle position
PVector circle;
float diameter;

// Target rectangle position and dimension
PVector target;
PVector dims;

void setup() {
  size(500,500);
  
  // Initialise circle position
  circle = new PVector(50,50);
  diameter = 50;
  
  // Initialise target position/dimension
  target = new PVector(100,100);
  dims = new PVector(50,30);
}

void draw() {
  // Clear the screen
  background(100);
  
  // Circle follows mouse
  circle.x = mouseX;
  circle.y = mouseY;
  
  // Draw target
  fill(100, 100);
  rect(target.x, target.y, dims.x, dims.y);
  
  if (false) {
    fill(255, 0, 0, 100);
  }
  else {
    fill(100,100);
  }
  ellipse(circle.x, circle.y, diameter, diameter);
}
