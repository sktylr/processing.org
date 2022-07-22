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
    int ballX = ball.x();
    int ballY = ball.y();
    int ballRadius = ball.radius();
    if (ballX + ballRadius >= this.x() && ballX - ballRadius < this.x() + this.length())
    {
    }
    else if (x == x) /* FINISH */
    {
    }
    return false;
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
}
