boolean[][] grid; //<>// //<>//

int w, h;
float s;

void setup() {
  size(800, 800);
  w = 30;
  h = 30;

  s = width / (w+2);

  grid = new boolean[w][h];
  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      grid[i][j] = random(1) < .3;
    }
  }

  int num_cells = w * h;
  steps = new int[num_cells][num_cells];
  indices = new int[num_cells][num_cells];

  visited = new ArrayList<Integer>();
  distance = new ArrayList<Integer>();
  to_visit = new ArrayList<Integer>();
  to_visit_dist = new ArrayList<Integer>();
  temp_distance = new int[num_cells];
  for (int i = 0; i < num_cells; i++) {
    temp_distance[i] = 100000;
  }
  temp_distance[0] = 0;

  source_ind = 0;
  target_ind = int(floor(random(num_cells)));

  source = ind2sub(source_ind);
  target = ind2sub(target_ind);

  source_x = int(source.x); 
  source_y = int(source.y);
  target_x = int(target.x); 
  target_y = int(target.y);

  grid[source_x][source_y] = false;
  grid[target_x][target_y] = false;
  to_visit.add(source_x);
  to_visit_dist.add(0);

  dists_to_draw = PathFind(source_ind, target_ind);
  path = FindPath(dists_to_draw, source_ind, target_ind);
}

PVector source, target;
int source_ind, target_ind;
int[] dists_to_draw;
int[] path;


ArrayList<Integer> visited;
ArrayList<Integer> distance;
ArrayList<Integer> to_visit;
ArrayList<Integer> to_visit_dist;

int[] temp_distance;

int source_x, source_y;
int target_x, target_y;

int sub2ind(int x, int y) {
  return x + w * y;
}

PVector ind2sub(int i) {
  return new PVector(i % w, floor(i / w));
}

void draw() {
  background(100);

  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      if (grid[i][j]) fill(255, 0, 0);
      else            fill(255, 255, 255);

      rect((i+1) * s, (j + 1) * s, s, s);
    }
  }

  fill(0, 255, 0);
  rect((source_x + 1) * s, (source_y + 1) * s, s, s);
  fill(0, 0, 255);
  rect((target_x + 1) * s, (target_y + 1) * s, s, s);

  PVector ns = ind2sub(next_site);
  fill(255, 255, 0);
  rect(int(ns.x + 1) * s, (int(ns.y + 1) * s), s, s);

  textAlign(CENTER, CENTER);
  fill(0);
  for (int i = 0; i < to_visit.size(); i++) {
    PVector p = ind2sub(to_visit.get(i));
    text(to_visit_dist.get(i), (p.x + 1.5) * s, (p.y + 1.5) * s);
  }

  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      text(dists_to_draw[sub2ind(x, y)], (x + 1.5) * s, (y + 1.5) * s);
    }
  }


  target = new PVector(floor((mouseX / s) - 1), floor((mouseY / s) - 1));
  target_ind = sub2ind(int(target.x), int(target.y));
  //target_ind = int(floor(random(num_cells)));
  //PVector target = ind2sub(target_ind);

  if (target.x >= 0 && target.y >= 0 && target.x < w && target.y < h 
      && target_ind >= 0 && target_ind < w * h
      && !grid[int(target.x)][int(target.y)]) {
    source_x = int(source.x); 
    source_y = int(source.y);
    target_x = int(target.x); 
    target_y = int(target.y);

    grid[source_x][source_y] = false;
    //grid[target_x][target_y] = false;
    to_visit.add(source_x);
    to_visit_dist.add(0);

    dists_to_draw = PathFind(source_ind, target_ind);
    path = FindPath(dists_to_draw, source_ind, target_ind);
  }

  for (int i = 0; i < path.length; i++) {
    PVector p = ind2sub(path[i]);
    fill(0, 255, 0, 100);
    rect((p.x+1) * s, (p.y + 1) * s, s, s);
  }

  for (int i = 0; i < visited.size(); i++) {
    PVector p = ind2sub(visited.get(i));
    fill(0, 255, 255, distance.get(i) * 5);
    rect((p.x + 1) * s, (p.y + 1) * s, s, s);
  }

  //pathFindStep();
  //if ((frame++ % 100) == 0)
  //{ pathFindStep(); }
}
int frame = 0;

int[][] steps;
int[][] indices;

int next_site = 0;

void pathFindStep() {
  int smallest = 1000000;
  next_site = 0;
  int index = 0;
  for (int i = 0; i < to_visit.size(); i++) {
    if (to_visit_dist.get(i) < smallest) {
      if (!visited.contains(to_visit.get(i))) {
        smallest = to_visit_dist.get(i);
        next_site = to_visit.get(i);
        index = i;
      }
    }
  }

  PVector ns = ind2sub(next_site);
  int x = int(ns.x); 
  int y = int(ns.y);
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      if (!(i == 0 && j == 0) && !(i != 0 && j!= 0)) {
        int nx = x + i;
        int ny = y + j;
        if (!(nx < 0 || nx >= w || ny < 0 || ny >= h)) {
          if (!grid[nx][ny]) {
            if (!visited.contains(next_site)) {
              int n_ind = sub2ind(nx, ny);
              if (smallest + 1 < temp_distance[n_ind]) {
                temp_distance[n_ind] = smallest+1;
                to_visit.add(n_ind);
                to_visit_dist.add(smallest + 1);
              }
            }
          }
        }
      }
    }
  }

  //to_visit.remove(next_site);
  //to_visit_dist.remove(smallest);
  visited.add(next_site);
  distance.add(smallest);
}

int[] PathFind(int source, int target) {
  int[] dists = new int[w * h];
  boolean[] have_visited = new boolean[w * h];

  for (int i = 0; i < w * h; i++) {
    dists[i] = 100000;
    have_visited[i] = false;
  }

  dists[source] = 0;

  int next_index = 0;
  while (isValid(target) && !have_visited[target]) {
    int smallest = 1000000;
    for (int i = 0; i < w * h; i++) {
      if (dists[i] < smallest && !have_visited[i]) {
        smallest = dists[i];
        next_index = i;
      }
    }

    have_visited[next_index] = true;

    int n_i = 0;
    if (next_index % w > 0) {
      n_i = next_index - 1;
      if (isValid(n_i) && dists[n_i] > smallest + 1) dists[n_i] = smallest + 1;
    }
    if (next_index % w < (w - 1)) {
      n_i = next_index + 1;
      if (isValid(n_i) && dists[n_i] > smallest + 1) dists[n_i] = smallest + 1;
    }
    n_i = next_index - w;
    if (isValid(n_i) && dists[n_i] > smallest + 1) dists[n_i] = smallest + 1;
    n_i = next_index + w;
    if (isValid(n_i) && dists[n_i] > smallest + 1) dists[n_i] = smallest + 1;
  }

  return dists;
}

int[] FindPath(int[] dists, int source, int target) {
  int[] out = new int[dists[target]];

  int index = target;
  out[dists[target]-1] = target;
  for (int i = dists[target] - 1; i >= 0; i--) {
    if ((target % w > 0) && dists[index - 1] == i) {
      out[i] = index - 1;
      index = index - 1;
    } else if ((target % w < (w-1)) && dists[index+1] == i) {
      out[i] = index + 1;
      index++;
    } else if ((target >= w) && dists[index - w] == i) {
      out[i] = index - w;
      index -= w;
    } else if ((target < ((h - 1) * w)) && dists[index + w] == i) {
      out[i] = index + w;
      index+= w;
    }
  }

  return out;
}

boolean isValid(int i) {
  PVector xy = ind2sub(i);
  int x = int(xy.x); 
  int y = int(xy.y);
  return (!((x < 0) || (y < 0) || (x >= w) || (y >= h) || grid[x][y]));
}
