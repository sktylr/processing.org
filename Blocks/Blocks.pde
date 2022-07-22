/*
 * This project aims to create a game whereby the user controls a block with their cursor
 * with the intention of bouncing a ball back across the screen. The user is aiming at
 * blocks, some of which can be broken, others cannot. The game ends when all blocks
 * are broken or if the ball exits at the base of the screen. Some block release power
 * ups or hindrances when broken
 */

Block test;
Ball testBall;
void settings()
{
  size(600, 800);
}

void setup()
{
  background(50, 50, 50);
  test = new Block(50, 50, 255);
  testBall = new Ball(30, 30, color(123, 214, 190));
}

void draw()
{
  test.draw();
  testBall.draw();
}
