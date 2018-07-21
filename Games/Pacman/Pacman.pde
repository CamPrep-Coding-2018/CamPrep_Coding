Player player;
Ghost[] ghosts;
ArrayList<Pellet> pellets;
Maze maze;

float[][] map;

void setup() {
  size(800, 800);

  int n = 2000;
  map = new float[n][n];
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      map[i][j] = random(255);
    }
  }

  int res = 800 / 12;
  maze = new Maze(10, 10, res);

  player = new Player();

  pellets = new ArrayList<Pellet>();

  ghosts = new Ghost[4];
  for (int i = 0; i < 4; i++)
  { 
    ghosts[i] = new Ghost();
  }
}

int x_pos = 0;
int y_pos = 0;

void draw() {
  background(0);

  int res = width/30;
  for (int i = 0; i < 30; i++) {
    for (int j = 0; j < 30; j++) {
      fill(map[i + x_pos][j + y_pos], 0, 0);  
      rect(res * i, res* j, 30, 30);
    }
  }

  if (w_key && y_pos > 0) y_pos--;
  if (s_key) y_pos++;
  if (d_key) x_pos++;
  if (a_key) x_pos--;

  //maze.draw();

  //for (int i = 0; i < 4; i++) {
  //  ghosts[i].draw();
  //}

  //for (Pellet p : pellets) {
  //  p.draw();
  //}

  // player.draw();
}

void keyPressed() {
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
