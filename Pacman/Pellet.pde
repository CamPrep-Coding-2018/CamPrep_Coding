class Pellet {
  PVector pos;

  Pellet() {
  }

  void draw() {
    fill(255);
    ellipse(pos.x, pos.y, 3, 3);
  }
}
