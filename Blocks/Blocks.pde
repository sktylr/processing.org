/*
 * This project aims to create a game whereby the user controls a block with their cursor
 * with the intention of bouncing a ball back across the screen. The user is aiming at
 * blocks, some of which can be broken, others cannot. The game ends when all blocks
 * are broken or if the ball exits at the base of the screen. Some block release power
 * ups or hindrances when broken
 */

Block test, test2, test3;
ArrayList<Block> breakingBlocks;
Ball testBall;
Paddle user1;
void settings()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup()
{
  background(50, 50, 50);
  test = new Block(0, 170, 255);
  test2 = new Block(0, 370, 255);
  test3 = new Block(0, 255, 255);
  testBall = new Ball(30, 280, color(123, 214, 190), 255);
  user1 = new Paddle(color(123, 214, 190), 255);
  breakingBlocks = new ArrayList<Block>();
  boolean green = false;
  for (int i = 0; i < 15; i++)
  {
    Block block = new BreakingBlock(i * 40, 150, green? color(123, 214, 190) : 255, i);
    breakingBlocks.add(block);
    green = !green;
  }
}

void draw()
{
  background(50);
  testBall.move();
  user1.move();
  //test2.collide(testBall);
  //test3.collide(testBall);
  user1.collide(testBall);
  for (int i = breakingBlocks.size() - 1; i >= 0; i--)
  {
    Block block = breakingBlocks.get(i);
    if (block != null)
    {
      block.collide(testBall);
      block.draw();
    }
  }
  //test2.draw();
  //test3.draw();
  //test.draw();
  testBall.draw();
  user1.draw();
}

void reset()
{
}
