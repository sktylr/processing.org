/*
 * This class is used to control the behaviour of the ball tha the user plays the game
 * with. The ball uses normal Laws of Reflection (i = r) for its motion, meaning it
 * move off the wall at the same angle it hit it at. The aim is for this to enevtually
 * not be the case with the ball's interaction with the user's paddle (which may be in
 * motion). The ball's speed can be influenced be power ups.
 */

class Ball
{
  private int x, y, dy, dx;
  private final int RADIUS = 10;
  private color colour, colour1, colour2;
  private float speed;

  public Ball (int x, int y, color colour1, color colour2)
  {
    this.x = x;
    this.y = y;
    this.colour1 = colour1;
    this.colour2 = colour2;
    this.colour = (random(0, 1) < 0.5? colour1 : colour2);
    speed = 2;
    dx = 1;
    dy = 1;
  }

  public void draw()
  {
    stroke(colour);
    fill(colour);
    ellipse(x, y, RADIUS, RADIUS);
  }

  public void move()
  {
    x += dx * speed;
    y += dy * speed;
    this.wallCollide();
  }

  public void reverse(boolean x)
  {
    if (x)
    {
      dx *= -1;
    } else dy *= -1;
  }

  private void wallCollide()
  {
    if (x - RADIUS <= 0 || x + RADIUS > SCREEN_WIDTH)
    {
      dx *= -1;
    }
    if (y - RADIUS <= 0)
    {
      dy *= -1;
    } else if (y + RADIUS > SCREEN_HEIGHT)
    {
      reset();
    }
  }
  
  /*
   * Method used once a collision between the paddle and the ball takes place
   * The method takes in a boolean parameter to determine if the ball struck the paddle
   * on the left or right hand side, determining which colour the ball changes to
   */
  
  public void paddleCollide(boolean left)
  {
    this.colour = left? colour1 : colour2;
    this.reverse(false);
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

  public color colour()  // returns the current colour being displayed
  {
    return colour;
  }

  public color colour1()
  {
    return colour1;
  }

  public color colour2()
  {
    return colour2();
  }

  public int dy()
  {
    return dy;
  }

  public int dx()
  {
    return dx;
  }
}
