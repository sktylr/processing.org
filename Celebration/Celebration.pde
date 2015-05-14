String MESSAGE = "Happy Birthday Ilir";
ArrayList<Firework> fireworks;
Text text;

class Firework {
  int x;
  int y;
  float size;
  int xDir;
  int yDir;

  Firework(int x, int y, float size, int xDir, int yDir) {
    this.x = x;
    this.y = y;
    this.size = size;
    this.xDir = xDir;
    this.yDir = yDir;
  }

  void draw() {
    fill(random(0, 255), random(0, 255), random(0, 255));
    ellipse(x, y, size, size);
  }

  void move() {
    x = x + xDir;
    y = y + yDir;
    size = size - 0.3;
    if ( size <= 0.0) {
      die();
    }
  }
  void die() {
    fireworks.remove(this);
  }
}

class Text {
  int charCount = 0;
  int moves = 0;
  String message;
  int size;
  Text(String message, int size) {
    this.message = message;
    this.size = size;
  }

  void move() {
    moves++;
    if (moves % 20 == 0) {
      charCount++;
      if (charCount >= message.length()) {
        charCount = message.length();
      }
    }
    println("charCount = " + charCount + " moves = " + moves);
  }

  void draw() {
    textSize(size);
    textAlign(CENTER, CENTER);
    fill(71, 242, 24);
    String addM = message.substring(0, charCount);
    println("AddM = " + addM);
    text(addM, width/2, height/2 - (size/2));
  }
}

void setup() {
  frameRate(60);
  text = new Text(MESSAGE, 50);
  size(800, 600);
  fireworks = new ArrayList<Firework>();
  fill(random(0, 255), random(0, 255), random(0, 255));
}

void draw() {
  background(0);
  text.move();
  for (int i = fireworks.size () - 1; i >=0; i--) {
    Firework firework = fireworks.get(i);
    firework.move();
  }
  for (int i = fireworks.size () - 1; i >=0; i--) {
    Firework firework = fireworks.get(i);
    firework.draw();
  }
  if (random(0, 100) > 95) {
    createFirework();
  }
  text.draw();
}

void createFirework() {
  int posX = int(random(0, 800));
  int posY = int(random(0, 600));
  int fSize = int(random(10, 40));
  fireworks.add(new Firework(posX, posY, fSize, 0, -1)); //up
  fireworks.add(new Firework(posX, posY, fSize, 0, +1)); //down
  fireworks.add(new Firework(posX, posY, fSize, -1, -1)); //top left
  fireworks.add(new Firework(posX, posY, fSize, -1, +1)); //bottom left
  fireworks.add(new Firework(posX, posY, fSize, +1, 0)); //right
  fireworks.add(new Firework(posX, posY, fSize, +1, +1)); //bottom right
  fireworks.add(new Firework(posX, posY, fSize, +1, -1)); //top right
  fireworks.add(new Firework(posX, posY, fSize, -1, 0)); //left
}

