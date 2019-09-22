//not going to lie, some of this is copy+pasted from an OOP tutorial I found online

class circle{
  
  float x, y;
  int time;
  
  //constructor class
  circle(float ix, float iy){
    time = -1;
    newPos();
    x = ix;
    y = iy;
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
  
  float drag = 10;
  
  void draw(){
    newPos();
    fill(255);
    
    if(magnetLevel == 0){
      if(isGolden == true){
        fill(255, 204, 51);
        ellipse(x, y, circleSize, circleSize);
      } else {
        ellipse(x, y, circleSize, circleSize);
      }
    } else if (magnetLevel>0){
      float dx = mouseX - x;
      x = x + dx/drag;
  
      float dy = mouseY - y;
      y = y + dy/drag;
      
      if(isGolden == true){
        fill(255, 204, 51);
        ellipse(x, y, circleSize, circleSize);
      } else {
        ellipse(x, y, circleSize, circleSize);
      }
      
    }
    
    circleX = x;
    circleY = y;
    
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
  
  void newPos(){
    if((millis() > time)||(click == true)||(autoClickerEnable)){
      time = millis() + delay;
      x = random(25, 615);
      y = random(95, 305);
      circleX = x;
      circleY = y;
      
      if(delay >= 1500){
        delay -= 50;
      }
      
      if(circleSize >= 10){
        circleSize--;
      }
      
      if(!autoClickerEnable){
        switch ((int)random(10)){
          case 7:
            //woot woot lucky number 7
            //should I use 8? that's the superior lucky number
            isGolden = true;
            break;
          default:
            isGolden = false;
            break;
        }

      }
      
      total++;
      
      if(autoClickerEnable){
        score++;
        isGolden = false;
      }  
      
    }
    
    click = false;
    
  }
}
