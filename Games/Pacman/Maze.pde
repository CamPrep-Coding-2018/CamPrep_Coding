class Maze {
  int w, h;
  int res = 30;
  boolean[][] N_Wall;
  boolean[][] E_Wall;
  boolean[][] S_Wall;
  boolean[][] W_Wall;

  Maze(int _w, int _h, int _res) {
    w = _w; 
    h = _h;
    res = _res;
    N_Wall = new boolean[w][h];
    E_Wall = new boolean[w][h];
    S_Wall = new boolean[w][h];
    W_Wall = new boolean[w][h];

    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        N_Wall[i][j] = random(1) < .5;
        S_Wall[i][j] = random(1) < .5;
        E_Wall[i][j] = random(1) < .5;
        W_Wall[i][j] = random(1) < .5;
      }
    }
  }

  void draw() {
    stroke(255, 255);
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        int l_x = res + x * res;
        int r_x = res + (x + 1) * res;
        int t_y = res + y * res;
        int b_y = res + (y + 1) * res;
        if (N_Wall[x][y]) line(l_x, t_y, r_x, t_y);
        if (S_Wall[x][y]) line(l_x, b_y, r_x, b_y);
        if (E_Wall[x][y]) line(r_x, t_y, r_x, b_y);
        if (W_Wall[x][y]) line(l_x, t_y, l_x, b_y);
      }
    }
  }
}
