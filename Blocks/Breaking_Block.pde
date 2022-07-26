/*
 * This class is a sub class of Block and is a type of block that can be broken
 * by the ball. This block is in one of two colours. When struck by a ball of the same
 * colour as the block, the block breaks instantly. When struck by a ball of another
 * colour, the block cracks up to a total of three times before finally breaking.
 */

public class BreakingBlock extends Block
{
  int stage;  // refers to the stage of damage the block has taken (0 == normal, 3 == dead)

  BreakingBlock(int x, int y, color colour)
  {
    super(x, y, colour);
    stage = 0;
  }

  protected void executeCollision(Ball ball, boolean x)
  {
    if (ball != null)
    {
      super.executeCollision(ball, x);
      if (ball.colour() == this.colour())
      {
        this.die();
      } else
      {
        this.crack();
      }
    }
  }

  private void crack()
  {
    if (stage < 2)
    {
      stage++;
    } else this.die();
  }

  protected void die()
  {
    breakingBlocks.remove(this);
  }
}
