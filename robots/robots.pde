int instructionsBX;
int instructionsBY;
int hitNum = 0;
int score = 0;
int NUM_LIVES = 5;
int lives = 0;
int numRobots = 0;
int screenWidth = 800;
int screenHeight = 600;
int maxRobot = 5;
int areaBorder = 20;
int maxBullets = 4;
int areaWidth = screenWidth - areaBorder * 2;
int areaHeight = screenHeight - areaBorder * 2;
int textFill = 190;
int robotsPast = 0;
String highScore[];
int oldScore = 0;
boolean gameRunning = true;
int startTime;
int endTime;
int scoreX;
int scoreY;
int toHighScoreX;
int toHighScoreY;
int instructionsAX;
int instructionsAY;
int livesX;
int livesY;
int bulletsLeftX;
int bulletsLeftY;
int robotsOnScreenX;
int robotsOnScreenY;
int robotsPastX;
int robotsPastY;
int timeX;
int timeY;
int takeAwayNum = 37;
boolean newHighScore = false;



Shooter shooter;
ArrayList<Robot> robots;
ArrayList<Bullet> bullets;

//class to make things move
class MovingObject {
  String name;
  color colour;
  int posX;
  int posY;
  int width;
  int height;

  MovingObject(color c, int x, int y, int w, int h) {
    colour =c;
    posX = x;
    posY = y;
    width = w;
    height = h;
    setName("?");
    // println("MovingObject " + this);
  }

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  String
    toString() {
    return "[" + getName() + ": x= " + posX + " " + "Y = " + posY + " w = " + width + " h = " + height + "]";
  }

  void draw() {

    fill(colour);
    rect(posX + areaBorder, posY + areaBorder, width, height);
  }


  //to make the things move
  boolean move() {
    return true;
  }

  //to see has anything collided with another thing (part 1)
  boolean colDetect(MovingObject other) {
    return   
      isInside(other.posX, other.posY)
      || isInside(other.posX+other.width, other.posY) 
        || isInside(other.posX, other.posY + other.height) 
          || isInside(other.posX+other.width, other.posY +other.height);
  }


  //to see has anything collided with another thing (part 1)
  boolean isInside(int x, int y) {
    if (x >= this.posX && x <= (this.posX + this.width)) {
      //println("Testing " + this + " with " + x + ", " + y + " => yes x");

      if (y >= this.posY && y <= (this.posY + this.height)) {
        //println("Testing " + this + " with " + x + ", " + y + " => yes");

        return true;
      }
    }
    //println("Testing " + this + " with " + x + ", " + y + " => no");
    return false;
  }
}


//a class to create multiple robots
class Robot extends MovingObject {
  int speed = 1;
  int direction;
  Robot(color c, int x, int size) {
    super(c, x, 0, size, size);
    changeDir();
  }


  //to change direction randomly
  void changeDir() { 
    if (score >= (250 * 12)) {
      takeAwayNum = 43;
      direction = int(random(-3, 3));
    } else direction = 0;
  }

  //what to do when the robot is hit
  void hit() {
    score = score + (takeAwayNum - this.width) * 10;
    hitNum = hitNum + 1; 
    maxRobot = maxRobot + 1;
    if (maxRobot >= 25) {
      maxRobot = 25;
    }
    maxBullets = maxBullets + 1;
    if (maxBullets >= 25) {
      maxBullets = 25;
    } 
    die();
  }


  //to kill the robots :)
  void die() {
    robots.remove(this);
  }


  //to check if the robot should change direction
  boolean shouldChangeDir() {
    if (score >= (250*8)) {
      if (random(0, 100) < 2) {
        takeAwayNum = 40;
        return true;
      }
    }

    return false;
  }

  //to check if the robot should move
  boolean move() {
    if (shouldChangeDir() == true) {
      changeDir();
    }
    posX = posX + direction;
    if (posX < 0) {
      posX = 0;
      direction = direction * -1;
    }
    if ((posX + width) > areaWidth) {
      posX = areaWidth - width;
      direction = direction * -1;
    }
    posY = posY + speed;
    if (score >= (250 * 12)) {
      speed = int(random(1, 3)); 
      if (score >= (250 * 5)) {
        speed = int(random(1, 2));
      }
    }   
    return posY + height < areaHeight;
  }
}


//a class to create the shooter
class Shooter extends MovingObject {
  static final int w = 75;
  static final int h = 20;

  Shooter(color c) {
    super(c, areaWidth / 2 - w / 2, areaHeight - h, w, h);
  }

  //to make the shooter move left
  void moveLeft() {
    posX = posX - 10;
    if (posX < (0 - width/2)) {
      posX = (0 - width/2);
    }
  }


  //to make the shooter right
  void moveRight() {
    posX = posX + 10;
    if ((posX + (width/2)) > areaWidth) {
      posX = areaWidth - width/2;
    }
  }

  //when the robot hits the shooter
  void hit(Robot robot) {
    // println("Hit by robot " + robot);
    robot.die();
    lives = lives - 1;
    // println("Lives = " + lives + ", Score = " + score);
  }
  //to make the shooter shoot
  void shoot() {
    if (bullets.size() < maxBullets) { 
      Bullet bullet = new Bullet(posX + (width/2), posY);
      bullets.add(bullet);
    }
    if (lives <= 0) {
      gameOver();
    }
  }
}


//a class to create bullets
class Bullet extends MovingObject {
  static final int w = 10;
  static final int h = 20;



  Bullet(int posX, int posY) {
    super(color(244, 255, 15), posX - (w/2), posY - h, w, h);
  }
  //to kill the bullet
  void die() {
    bullets.remove(this);
  }
  //to move the bullet(s)
  boolean move() {
    posY = posY - 5;
    if (posY <= 0) {
      return false;
    } else {
      return true;
    }
  }
}




//main setup
void setup() {
  initialize();
}

//to display the seconds
int currentSeconds() {
  return  millis() / 1000;
}

void draw() {
  if (gameRunning == true) {
    /*println("scorex " + scoreX + " scorey " + scoreY);
     println("livesX " + livesX + " livesY " + livesY);
     println("instructionsAX " + instructionsAX + " instructionsAY " + instructionsAY);
     println("bulletsLeftX " + bulletsLeftX + " bulletsLeftY " + bulletsLeftY);
     println("robotsOnScreenX " + robotsOnScreenX + " robotsOnScreenY " + robotsOnScreenY);
     println("robotsPastX " + robotsPastX + " robotsPastY " + robotsPastY);
     println("timeX " + timeX + " timeY " + timeY);
     println("toHighScoreX " + toHighScoreX + " toHighScoreY " + toHighScoreY);
     //    println("TAKE AWAY NUM = " + takeAwayNum);
     */    //displaying in-game stats.
    startup();
    //moving shooter, robots, bullets and killing 
    shooter.move();
    for (int i = robots.size () - 1; i >=0; i--) {
      Robot robot = robots.get(i);
      if (!robot.move()) {
        robot.die();
        robotsPast = robotsPast + 1;
      }
    }
    for (int i = bullets.size () - 1; i >=0; i--) {
      Bullet bullet = bullets.get(i);
      if (!bullet.move()) {
        bullets.remove(i);
      }
    }

    //robot shooter collision detection
    for (int i = robots.size () - 1; i >=0; i--) {
      Robot robot = robots.get(i);
      if (robot.colDetect(shooter) || shooter.colDetect(robot)) {
        shooter.hit(robot);
      }
    }

    //robot bullet collision detection
    for (int i = robots.size () - 1; i >=0; i--) {
      Robot robot = robots.get(i);
      for (int bI = bullets.size () - 1; bI >=0; bI--) {
        Bullet bullet = bullets.get(bI);
        if (robot.colDetect(bullet) || bullet.colDetect(robot)) {
          robot.hit();
          bullet.die();
        }
      }
    }

    //shooter creation
    shooter.draw();
    if (createNewRobot()) {
      int size = randomInt(15, 35);
      Robot robot = new Robot(randomColour(), randomInt(0, areaWidth - size), size);
      numRobots = numRobots + 1;
      robot.setName("robot " + numRobots);
      robots.add(robot);
    }
    for (Robot robot : robots) {
      robot.draw();
    }
    for (Bullet bullet : bullets) {
      bullet.draw();
    }
    //game over
    if (lives <= 0) {
      gameOver();
    }

    noStroke();
    blocker(0, (screenHeight - areaBorder) - 100);
    blocker(screenWidth - areaBorder, (screenHeight - areaBorder) - 100);
  } else {

    if (keyPressed) {
      println("key pressed " + key);
      if (key == 'r' || key == 'R') {
        initialize();
        startup();
      }
    }
    showScore();
  }
}

color randomColour() {
  return color(random(100, 255), random(100, 255), random(100, 255));
}

boolean createNewRobot() {
  if (random(0, 100) > 98) {
    return robots.size() < maxRobot;
    //return true;
  } else {
    return false;
  }
}

int randomInt(int start, int end) {
  return int(random(start, end));
}

void keyPressed() { 
  if (key == 'p' || key == 'P') {
    if (looping) noLoop();
    else loop();
  }  
  if (key == 's' || key == 'S') {
    exit();
  }
  if (key == CODED) {
    if (keyCode == LEFT) {
      shooter.moveLeft();
    }
    if (keyCode == RIGHT) {
      shooter.moveRight();
    }
    if (keyCode == UP) {
      shooter.shoot();
    }
  }
}

//this is the area that the game is played on
void gameArea(int x, int y, int w, int h) {
  fill(0);
  rect(x, y, w, h);
}

//thing that goes on top of the shooter or bullet so that you can't see all of it
void blocker(int x, int y) {
  fill(255);
  rect(x, y, 20, screenHeight - (areaBorder * 2));
}
//when the game has been lost
void gameOver() {
  saveHighscore();
  gameRunning = false;
  endTime = currentSeconds();
  //  println("game over at " + endTime);
} 
//this is the screen at the end of the game
void showScore() {
  textSize(32);
  fill(255);
  rect(0, 0, screenWidth, screenHeight);
  textAlign(CENTER, CENTER);
  fill(204, 102, 0);
  text("GAME OVER!", (screenWidth/2), (screenHeight/2) - 70);
  text("You had a score of " + score, (screenWidth/2), (screenHeight/2) - 35);
  if (robotsPast == 1) {
    text(robotsPast + " robot got past you", (screenWidth/2), screenHeight/2);
  }
  if (robotsPast != 1) {
    text(robotsPast + " robots got past you", (screenWidth/2), screenHeight/2);
  }
  text("You shot " + hitNum + " robots", (screenWidth/2), (screenHeight/2) + 35);
  textSize(32);
  text("You lasted for " + (endTime - startTime) + " seconds", screenWidth/2, (screenHeight/2) + 70);
  text("Your highscore is " + oldScore, screenWidth/2, (screenHeight/2) + 105);
  if (newHighScore == true) {
    text("Well done! You got a new highscore!", screenWidth/2, (screenHeight/2) + 140);
    text("Press 'r' to play again", screenWidth/2, (screenHeight/2) + 175);
  }
  if (newHighScore == false) {
    text("Press 'r' to play again", screenWidth/2, (screenHeight/2) + 140);
  }
}
//this is to save the highscore
void saveHighscore() {
  if (score > oldScore) {  //if the score is greater than the old highscore
    newHighScore = true;
    oldScore = score;  //the old highscore becomes the score. It will keep updating itself
    String newScore[] = {
      ""+score
    };
    saveStrings("robots_score.txt", newScore); //this saves the highscore even if it didn't change
  } else newHighScore = false;
  println("Score = " + score + " OldScore = " + oldScore + " newHighScore = " + newHighScore);
}

void loadHighscore() { //this is a function that loads the highscore, so we can output it at the end
  highScore = loadStrings("robots_score.txt"); //this loads the highscore
  if (highScore != null && highScore.length > 0) {
    oldScore = Integer.parseInt(highScore[0]);
    //   println("oldScore = " + oldScore);
  }
}

//setup 1

void initialize() {
  takeAwayNum = 37;
  newHighScore = false;
  maxBullets = 4;
  maxRobot = 5;
  score = 0;
  scoreX = 10;
  scoreY = 15;
  toHighScoreX =  (screenWidth/2) + 100;
  toHighScoreY = screenHeight - 5;
  instructionsAX = 120;
  instructionsAY = 15;
  instructionsBX = (screenWidth/2) - 60;
  instructionsBY = screenHeight - 5;
  livesX = screenWidth - 100;
  livesY = 15;
  robotsPast = 0;
  bulletsLeftX = 20;
  bulletsLeftY = screenHeight - 5;
  robotsOnScreenX = screenWidth - 150;
  robotsOnScreenY = screenHeight - 5;
  robotsPastX = (screenWidth/4);
  robotsPastY = screenHeight - 5;
  timeX = (screenWidth/6) - 10;
  timeY = screenHeight - 5;
  robots = new ArrayList<Robot>();
  bullets = new ArrayList<Bullet>();
  color colour = randomColour();
  colour = color(255, 0, 0);
  shooter = new Shooter(colour);
  shooter.setName("shooter");
  size(screenWidth, screenHeight);
  fill(0, 255, 0);
  frameRate(60);
  loadHighscore();
  gameRunning = true;
  lives = NUM_LIVES;
  startTime = currentSeconds();
  //  println("init at " + startTime);
}


//setup 2
void startup() {
  textSize(12.5);
  textAlign(LEFT);
  background(255);
  fill(0, textFill, 0);
  text("Score : " + nf(score, 6), scoreX, scoreY);
  fill(textFill, 0, 0);
  text("Lives : " + lives, livesX, livesY);
  fill(0, 0, textFill);
  text("Left arrow key and Right arrow key = move. Up arrow key = shoot. 'P' to pause/unpause", instructionsAX, instructionsAY);
  text("Press 'S' to quit", instructionsBX, instructionsBY);
  fill(textFill - 25, textFill - 25, 0);
  text("Bullets left : " + (maxBullets - bullets.size()), bulletsLeftX, bulletsLeftY);
  fill(0, textFill, textFill);
  text("Robots on-screen : " + robots.size(), robotsOnScreenX, robotsOnScreenY);
  fill(textFill, 0, textFill);
  text("Robots past = " + robotsPast, robotsPastX, robotsPastY);
  fill(textFill/2, 0, textFill/2);
  text("Time : " + nf(currentSeconds() - startTime, 3), timeX, timeY);
  fill(textFill/4, textFill/4, textFill/4);
  text("To highscore : " + nf(oldScore - score, 6), toHighScoreX, toHighScoreY);
  gameArea(areaBorder, areaBorder, areaWidth, areaHeight);
  println("scorex " + scoreX + " scorey " + scoreY);
  println("livesX " + livesX + " livesY " + livesY);
  println("instructionsAX " + instructionsAX + " instructionsAY " + instructionsAY);
  println("bulletsLeftX " + bulletsLeftX + " bulletsLeftY " + bulletsLeftY);
  println("robotsOnScreenX " + robotsOnScreenX + " robotsOnScreenY " + robotsOnScreenY);
  println("robotsPastX " + robotsPastX + " robotsPastY " + robotsPastY);
  println("timeX " + timeX + " timeY " + timeY);
  println("toHighScoreX " + toHighScoreX + " toHighScoreY " + toHighScoreY);
}

