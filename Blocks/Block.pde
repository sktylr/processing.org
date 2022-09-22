/*
 * This Object is any block that can be placed on the screen. All blocks have the same
 * size (length and height) and so constants are maintaned in this class body.
 * This class has subclasses which define more specific blocks that carry out specific
 * behaviours. This class contains a draw() and collide(Ball ball) method as these are
 * behaviours that all blocks have. The block are formed by rectangles with slightly
 * chamfered edges.
 */

class Block
{
  private final int LENGTH = 40;
  private final int HEIGHT = LENGTH/4;
  private final int RADIUS_CURVATURE = HEIGHT/2;
  private int x, y;
  private color colour;

  public Block (int x, int y, color colour)
  {
    this.x = x;
    this.y = y;
    this.colour = colour;
  }

  public void draw()
  {
    stroke(colour);
    fill(colour);
    rect(x, y, LENGTH, HEIGHT, RADIUS_CURVATURE);
  }

  public boolean collide(Ball ball)
  {
    if (ball != null)
    {
      if (ball.x() + ball.radius() >= this.x() && ball.x() - ball.radius() < this.x()
        + this.length() && ball.y() + ball.radius() >= this.y() && ball.y() -
        ball.radius() < this.y() + this.height())
      {
        boolean collideOnX = !(ball.x() + ball.radius() < this.x() + this.length()
          && ball.x() - ball.radius() >= this.x());
        this.executeCollision(ball, collideOnX);
        return true;
      }
    }
    return false;
  }

  protected void executeCollision(Ball ball, boolean x)
  {
    if (ball != null)
    {
      ball.reverse(x);
    }
  }

  protected void die()
  {
  }

  public int length()
  {
    return LENGTH;
  }

  public int height()
  {
    return HEIGHT;
  }

  public int radiusCurvature()
  {
    return RADIUS_CURVATURE;
  }

  public int x()
  {
    return x;
  }

  public int y()
  {
    return y;
  }

  public color colour()
  {
    return colour;
  }

  public void x(int x)
  {
    this.x = x;
  }
}
