class Ghost {
  PVector pos;

  Ghost() {
    pos = new PVector(5, 5);
  }

  void draw() {
    fill(255, 0, 0);
    rect(pos.x, pos.y, 20, 20);
  }
}
