circle circle1;
int circleX = 320;
int circleY = 180;
int score, highScore;
int circleSize = 50;
int start = 0;
String defaultHighScore = "0";
String[] savedScore;

void setup() {
  size(640, 360);
  background(0);
  noStroke();
  frameRate(60);
  circle1 = new circle(circleX, circleY);
  File f = dataFile("highscore.txt");
  boolean exist = f.isFile();
  if(!exist){
    String[] defaultScore = defaultHighScore.split("");
    saveStrings("highscore.txt", defaultScore);
  }
  savedScore = loadStrings("highscore.txt");
  String storedScore = String.join("",savedScore);
  highScore = Integer.parseInt(storedScore);
}

void draw() {
  
  String points = Integer.toString(score);
  String hiscore = Integer.toString(highScore);
  
  if(start == 0){
    textSize(32);
    fill(0, 102, 153);
    textAlign(CENTER,CENTER);
    text("Welcome to Circle Clicker!", width/2, 40);
    textSize(16);
    text("Instructions:", width/2, 120);
    text("Click the circle as many times as possible for points! That's it!", width/2, 140);
    textSize(32);
    text("Click anywhere to begin!",width/2,220);
    
  } else if(start == 1){
  
    fill(0);
    rect(0,0,width,height);
  
    fill(255);
    circle1.draw();
    
    textAlign(LEFT, TOP);
    fill(0, 102, 153);
    text("Score: " + points, 20, 20); 
    text("End Game", 460, 20);
  } else if(start == 2){
    fill(0);
    rect(0,0,width,height);
    fill(0, 102, 153);
    textAlign(CENTER,CENTER);
    text("Game Over!", width/2, 40);
    text("Your score was: " + points, width/2, 80);
    if(score>highScore){
      text("That's a new high score!", width/2, 160);
      text("Congratulations!", width/2, 200);
      String[] highestScore = points.split("");
      saveStrings("highscore.txt", highestScore);
    } else {
      text("High score: " + hiscore, width/2, 160);
    }
  }
}

void mouseClicked(){
  if(start == 0){
    start = 1;
  } else if ((abs(circleX-mouseX)<(circleSize/2))&&(abs(circleY-mouseY)<(circleSize/2))){
    score++;
  } else if ((mouseX > 460) && (mouseY < 70)){
    start = 2;
  }
}


class circle{
  int x, y;
  int time;
  int delay = 2000;
  circle(int ix, int iy){
    time = -1;
    newPos();
    x = ix;
    y = iy;
  }
  
  void draw(){
    newPos();
    ellipse(x, y, circleSize, circleSize);
  }
  
  void newPos(){
    if(millis() > time){
      time = millis() + delay;
      x = (int)random(25, 615);
      y = (int)random(95, 335);
      circleX = x;
      circleY = y;
      if(delay >= 1000){
        delay -= 50;
      }
      if(circleSize >= 10){
        circleSize--;
      }
    }
  }
}
