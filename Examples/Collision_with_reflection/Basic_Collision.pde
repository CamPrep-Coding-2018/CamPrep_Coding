// Set to true in order to draw the closest point, and line between that and the circle
boolean COLLISION_DEBUG = false;

boolean circ_box_reflect(PVector circ, float rad, PVector box, PVector dim, PVector speed) {
  // Find the closest point inside the rectangle, to the circle
  float closestX = clamp(circ.x, box.x, box.x + dim.x);
  float closestY = clamp(circ.y, box.y, box.y + dim.y);
  
  if (COLLISION_DEBUG)
    ellipse(closestX, closestY, 5, 5);
  
  // Find the distance between the circles center and this closest point
  float distanceX = circ.x - closestX;
  float distanceY = circ.y - closestY;
  
  if (COLLISION_DEBUG)
    line(closestX, closestY, circ.x, circ.y);

  // If this distance is less than the circles radius, the circle and box overlap
  float distanceSquared = (distanceX * distanceX) + (distanceY * distanceY);  // Note that we use distance squared
  boolean out = distanceSquared < (rad * rad);
  
  if (out) {
    // The line from the closest point to our center is our reflection normal
    PVector normal = new PVector(distanceX, distanceY).normalize();
    // Reflect the speed around this normal vector
    PVector newSpeed = PVector.sub(speed, PVector.mult(PVector.mult(normal, PVector.dot(normal,speed)),2));
    speed.x = newSpeed.x;
    speed.y = newSpeed.y;
    
    // Place the circle at the collision boundary (prevent overlap)
    circ = PVector.add(circ, speed);
  }
  
  return out;
}

float clamp(float value, float min, float max) {
  value = value > max ? max : value;
  value = value < min ? min : value;
  return value;  
}
