class Player {
  PVector pos;

  Player() {
    pos = new PVector(100, 100);
  }

  void draw() {
    fill(255, 255, 0);
    ellipse(pos.x, pos.y, 20, 20);
  }

  void keyPressed() {
    if (w_key) pos.y -= 10;
    if (s_key) pos.y += 10;
    if (a_key) pos.x -= 10;
    if (d_key) pos.x += 10;
  }
}
