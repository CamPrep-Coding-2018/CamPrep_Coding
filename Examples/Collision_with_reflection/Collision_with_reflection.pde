PVector[] blocks;
int[] block_life;
boolean[] block_safe;
PVector block_size;
int num_blocks;
float rad = 20;

int block_rows, block_cols;

PVector ball;
PVector ball_speed;

void setup() {
  size(1200, 600);
  //frameRate(2);

  block_rows = 3;
  block_cols = 8;
  num_blocks = block_rows * block_cols;

  block_size = new PVector(width/(block_cols + 4), height/(block_rows + 4));
  blocks = new PVector[num_blocks];
  block_life = new int[num_blocks];
  block_safe = new boolean[num_blocks];
  for (int i = 0; i < block_rows; i++) {
    for (int j = 0; j < block_cols; j++) {
      blocks[i * block_cols + j] = new PVector(block_size.x * (j + 2), block_size.y * (i + 1));
      block_life[i * block_cols + j] = int(random(3, 6));
      block_safe[i * block_cols + j] = false;
    }
  }

  ball = new PVector(width/2, height - 30);
  ball_speed = new PVector (15, 5);

  PVector p = new PVector(5, 4);
  println("p " + p);
  test(p);
  println("p " + p);
}

void test(PVector o) {
  o.x = -o.x;
}

void draw() {
  background(100);
  ball.add(ball_speed);
  fill(0, 100, 255);
  ellipse(ball.x, ball.y, rad * 2, rad * 2);

  for (int i = 0; i < num_blocks; i++) {
    if (block_life[i] > 0) {
      fill(block_life[i] * 50, 0, 0);
      rect(blocks[i].x, blocks[i].y, block_size.x, block_size.y);

      if (circ_box_reflect(ball, rad, blocks[i], block_size, ball_speed)) {
        block_life[i]--;
        block_safe[i] = true;
      } else {
        block_safe[i] = false;
      }
    }
  }

  // Bounce off the top and bottom walls:
  if (ball.y + rad > height || ball.y - rad < 0) ball_speed.y *= -1;
  // Wrap around the left and right walls:
  if (ball.x > width) ball.x = 0;
  if (ball.x < 0) ball.x = width;
}
