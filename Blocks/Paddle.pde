/*
 * This class is used for the creation of an instance of Paddle - the paddle that
 * the user uses to control the ball. This paddle is in the shape of a chamfered
 * rectangle and has two colours - these colours determine the colour the ball changes
 * to when returned. The paddle is controlled by the user using their cursor and has
 * a fixed y value. The size is variable and can be adjusted by power ups.
 */

class Paddle
{
  int x, width, height;
  color leftColour, rightColour;
  private static final int Y = SCREEN_HEIGHT - 50;

  Paddle(color leftColour, color rightColour)
  {
    this.width = 80;
    this.x = int(random(0, SCREEN_WIDTH - this.width()));
    this.height = 16;
    this.leftColour = leftColour;
    this. rightColour = rightColour;
  }

  public void draw()
  {
    stroke(this.leftColour());
    fill(this.leftColour());
    rect(this.x(), this.y(), this.width()/2, this.height(), 5);
    stroke(this.rightColour());
    fill(this.rightColour());
    rect(this.x() + this.width()/2, this.y(), this.width()/2, this.height(), 5);
  }

  public void move()
  {
    if (mouseX >= this.width()/2)
    {
      if (mouseX < SCREEN_WIDTH - this.width()/2)
      {
        x = mouseX - this.width()/2;
      } else x = SCREEN_WIDTH - this.width();
    } else x = 0;
  }

  public boolean collide(Ball ball)
  {
    if (ball != null)
    {
      if (ball.x() + ball.radius() >= this.x() && ball.x() - ball.radius() < this.x()
        + this.width())
      {
        if (ball.y() + ball.radius() >= this.y())
        {
          ball.paddleCollide(ball.x() < this.x() + this.width()/2);
        }
      }
    }
    return false;
  }

  public int x()
  {
    return x;
  }

  public int y()
  {
    return Y;
  }

  public int width()
  {
    return width;
  }

  public int height()
  {
    return height;
  }

  public color leftColour()
  {
    return leftColour;
  }

  public color rightColour()
  {
    return rightColour;
  }
}
