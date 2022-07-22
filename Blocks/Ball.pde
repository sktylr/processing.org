/*
 * This class is used to control the behaviour of the ball tha the user plays the game
 * with. The ball uses normal Laws of Reflection (i = r) for its motion, meaning it
 * move off the wall at the same angle it hit it at. The aim is for this to enevtually
 * not be the case with the ball's interaction with the user's paddle (which may be in
 * motion). The ball's speed can be influenced be power ups.
 */

class Ball
{
  private int x, y;
  private final int RADIUS = 10;
  private color colour;

  public Ball (int x, int y, color colour)
  {
    this.x = x;
    this.y = y;
    this.colour = colour;
  }

  public void draw()
  {
    stroke(colour);
    fill(colour);
    ellipse(x, y, RADIUS, RADIUS);
  }

  public int x()
  {
    return x;
  }

  public int y()
  {
    return y;
  }

  public int radius()
  {
    return RADIUS;
  }

  public color colour()
  {
    return colour;
  }
}
