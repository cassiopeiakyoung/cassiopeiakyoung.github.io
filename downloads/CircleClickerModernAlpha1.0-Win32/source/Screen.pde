
//JESUS, this is some UGLY code

class Screen{
  
  //lmao empty constructor class
  Screen(){
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
  //the welcome screen
  void welcome(){
    textSize(32);
    fill(0, 102, 153);
    textAlign(CENTER,CENTER);
    text("Welcome to Circle Clicker Modern!", width/2, 40);
    textSize(16);
    text("Instructions:", width/2, 120);
    text("Click the circle as many times as possible for points! That's it!", width/2, 140);
    text("Sometimes golden circles will appear.", width/2, 160);
    text("They award special Upgrade Points as well as regular points!", width/2, 180);
    text("The circle moves around randomly. As you play, it will shrink and move faster!", width/2, 200);
    text("If you miss the circle three times, that's game over!", width/2, 220);
    if(offlineProgress){
      text("Since the last time you were here, you earned " + offlineUP + " points from Offline Progress!", width/2,240);
    }
    textSize(32);
    text("Click anywhere to begin!",width/2,280);
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------

  void CHEATER(){
    textSize(32);
    fill(0, 102, 153);
    textAlign(CENTER,CENTER);
    text("Welcome to Circle Clicker Modern!", width/2, 40);
    textSize(16);
    text("YOU ARE A CHEATER", width/2, 180);
    text("Click anywhere to begin!",width/2,280);
  }

//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
  
  //opening shop screen 1
  
  void openShop1(){
    
    //top header, general setup
    
    fill(0);
    rect(0,0,width,height);
    textSize(24);
    fill(0,102,153);
    textAlign(CENTER, CENTER);
    text("The Item/Upgrade Shop", width/2, 25);
    textSize(16);
    text("Here you can spend your hard-earned upgrade points (UP) to buy items ", width/2, 60);
    text("or upgrade your existing ones!", width/2, 75);
    textAlign(LEFT, CENTER);
    textSize(24);
    
    text("Magnet", 20, 100);
    text("Upgrade UP", 20, 170);
    text("Upgrade UP", 20, 240);textSize(16);text("2", 155, 230);
    
  //descriptions
    //desc for "Magnet" item
    textSize(16);
    text("Draws circles towards your cursor! Pretty handy when", 20, 130);
    text("the circles get smaller and you have to click faster.", 20, 145);
    //desc for "Upgrade UP" item
    text("Upgrades the Golden Circles to give you one more", 20, 200);
    text("UP per level!", 20, 215);
    //desc for "Upgrade UP2" item
    text("Upgrades the \" Upgrade UP \" item to double the UP", 20, 270);
    text("it gives you each level! Very broken. Very expensive.", 20, 285);
    
  //levels & costs
    textSize(12);
    //level & cost for Magnet
    text("Level: " + magnetLevel, 330, 100);  //max level will be 1
    switch(magnetLevel){
      case 1:
        text("Max level reached!", 330, 113);
        break;
      default:
        text("Cost: 100 Points", 330, 113);
        break;
    }
    
    //level & cost for UpgradeUPLevel
    text("Level: " + upgradeUPLevel, 330, 170);  //max level will be 4 (max of 5pts/upgrade point)  
    switch(upgradeUPLevel){
      case 4:
        text("Max level reached!", 330, 183);
        break;
      default:
        text("Cost: " + upgradeUPCost + " Points", 330, 183);
        break;
    }
    
    //level and cost for UpgradeUPLevel2
    text("Level: " + upgradeUP2Level, 330, 240);  //max level will be 5 (max of 5*2*2*2*2*2 or 160 UP per golden circle)
    switch(upgradeUP2Level){
      case 5:
        text("Max level reached!", 330,253);
        break;
      default:
        text("Cost: " + upgradeUP2Cost + " Points", 330, 253);
        break;
    }

    //note: cost for this will end up being something like 2500 points for L5...might want to consider rebalancing
    
  //Buy/upgrade buttons
    textSize(16);
    fill(255);
    rect(460, 100, 160, 40);
    rect(460, 170, 160, 40);
    rect(460, 240, 160, 40);
    //Buy/Upgrade button for "Magnet" item
    
    fill(0);
    textAlign(CENTER,CENTER);
    switch(magnetLevel){
      case 0:
        text("Buy", 540, 115);
        break;
      case 1:
        text("Can't Upgrade!",540,115);
        break;
      default:
        text("Upgrade", 540, 115);
        break;
    }
    
    //buy/upgrade button for "Upgrade UP" item
    switch(upgradeUPLevel){
      case 0:
        text("Buy", 540, 185);
        break;
      case 4:
        text("Can't Upgrade!",540,185);
        break;
      default:
        text("Upgrade", 540, 185);
        break;
    }
    
    //buy/upgrade button for "Upgrade UP2" item
    switch(upgradeUP2Level){
      case 0:
        text("Buy", 540, 255);
        break;
      case 5:
        text("Can't Upgrade!",540,255);
        break;
      default:
        text("Upgrade", 540, 255);
        break;
    }
    
   
    textSize(24);
    fill(0, 105, 153);
    text("Exit", 560, 320);
    text("Next Page", 100, 320);

  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
  
  void openShop2(){
    
    //general shop header
    
    fill(0);
    rect(0,0,width,height);  //clearing prev screen yeah yeah you've seen this a million times
    
    textSize(24);
    fill(0,102,153);
    textAlign(CENTER, CENTER);
    text("The Item/Upgrade Shop", width/2, 25);  //headers
    textSize(16);
    text("Here you can spend your hard-earned upgrade points (UP) to buy items ", width/2, 60);
    text("or upgrade your existing ones!", width/2, 75);
    textAlign(LEFT, CENTER);
    textSize(24);
    
  //headers for the items

    text("Auto Clicker", 20, 100);
    text("Offline Progress", 20, 170);
    text("Sturdy Hearts", 20, 240);

  //descriptions
    //desc for "Auto Clicker" item
    textSize(16);
    text("Clicks circles for you, but you can only get regular", 20, 130);
    text("circles when it's on. No golden circles for you!", 20, 145);
    //desc for "Offline Progress" item
    text("Allows you to gain UP without playing at a very slow", 20, 200);
    text("rate!", 20, 215);
    //desc for "Sturdy Hearts" item
    text("Hearts have a chance to not disappear upon a missed", 20, 270);
    text("circle and missed hearts will slowly heal!", 20, 285);
    
  //levels & costs
    textSize(12);
    //level & cost for Auto Clicker
    if(autoClickerState){
      text("Bought!", 330, 100);  //max level will be 1 
    } else {
      text("Not Bought", 330, 100);
    } 
    text("Cost: 10,000 Points", 330, 113);
    
    //level & cost for Offline Progress
    if(offlineProgress){
      text("Bought!", 330, 170);  //max level will be 1 (gives 1UP/3minutes)
    } else {
      text("Not Bought", 330, 170);
    }
    text("Cost: 1,000 Points", 330, 183);
    
    //level and cost for Sturdy Hearts
    text("Level: " + sturdyHeartsLevel, 330, 240);  //max level will be 5 (max 1heart/3s)
    switch(sturdyHeartsLevel){
      case 5:
        text("Max level reached!", 330, 253);
        break;
      default:
        text("Cost: " + sturdyHeartsCost + " Points", 330, 253);
        break;
    }

    
  //Buy/upgrade buttons
    textSize(16);
    //Buy/Upgrade button for "Auto Clicker" item
    fill(255);
    rect(460, 100, 160, 40);
    fill(0);
    textAlign(CENTER,CENTER);
    
    if(autoClickerState){
      text("Can't Upgrade!",540,115);
    } else {
      text("Buy", 540, 115);
    }

    //buy/upgrade button for "Offline Progress" item
    fill(255);
    rect(460, 170, 160, 40);
    fill(0);   
    if(!offlineProgress){
      text("Buy", 540, 185);
    } else {
      text("Can't Upgrade!", 540, 185);
    }
    
    //buy/upgrade button for "Sturdy Hearts" item
    fill(255);
    rect(460, 240, 160, 40);
    fill(0);
    switch(sturdyHeartsLevel){
      case 0:
        text("Buy", 540, 255);
        break;
      case 5:
        text("Can't Upgrade!",540,255);
        break;
      default:
        text("Upgrade", 540, 255);
        break;
    }
    
    textSize(24);
    fill(0, 105, 153);
    text("Exit", 560, 320);
    text("Previous Page", 100, 320);
    text("Next Page", 260, 320);
    
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
  
  void openShop3(){
    
    fill(0);
    rect(0,0,width,height);  //clearing prev screen yeah yeah you've seen this a million times
    
    //headers! for the shop info screen stuff
    
    textSize(24);
    fill(0,102,153);
    textAlign(CENTER, CENTER);
    text("The Item/Upgrade Shop", width/2, 25);  //headers
    textSize(16);
    text("Here you can spend your hard-earned upgrade points (UP) to buy items ", width/2, 60);
    text("or upgrade your existing ones!", width/2, 75);
    textAlign(LEFT, CENTER);
    textSize(24);
    
  //headers for the items
  
    text("Hard Mode", 20, 100);
    text("Dev Mode", 20, 170);
    /*
    text("ASCEND", 20, 240);
    */
      
  //descriptions
    //desc for "Hard Mode" item
    textSize(16);
    text("You've got to be a real sadist to click this one.", 20, 130);
    //desc for "Dev Mode" item
    if(!CHEATER_CHEATER_PUMPKIN_EATER){
      text("Unlimited power. Good luck getting it.", 20, 200);
    } else {
      text("Cheaters never prosper.",20,200);
    }
    /*
    //desc for "ASCEND" item
    text("Don't even bother trying to click this until your", 20, 270);
    text("high score is at least 1,000.", 20, 285);
    */
    
  //levels & costs
    textSize(12);
    //level & cost for Hard Mode
    text("Hard Mode: " + hardMode, 330, 100);  //max level will be 1
    text("Cost: 5,000 Points", 330, 113);
    //level & cost for Dev Mode
    text("Dev Mode: " + CHEATER_CHEATER_PUMPKIN_EATER, 330, 170);  //max level will be 1
    text("Cost: -1 Points", 330, 183);
    //cost for ASCEND
    /*
    text("Cost: 10,000 Points", 330, 253);
    */
  //Buy/upgrade buttons
    textSize(16);
    //Buy/Upgrade button for "Hard Mode" item
    fill(255);
    rect(460, 100, 160, 40);
    fill(0);
    textAlign(CENTER,CENTER);
    if(!hardMode){
      text("Buy", 540, 115);
    } else {
      text("HARD MODE", 540, 115);
    }
    //buy/upgrade button for "Dev Mode" item
    fill(255);
    rect(460, 170, 160, 40);
    fill(0);
    if(CHEATER_CHEATER_PUMPKIN_EATER){
      text("Can't Upgrade!", 540, 185);
    } else {
      text("Buy", 540, 185);
    }
    //buy/upgrade button for "Ascend" item
    /*
    fill(255);
    rect(460, 240, 160, 40);
    fill(0);
    text("ASCEND", 540, 255);
    */
    
    textSize(24);
    fill(0, 105, 153);
    text("Exit", 560, 320);
    text("Previous Page", 100, 320);
    
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
  
  void startPlaying(){
    
    //clearing previous sceen
    fill(0);
    rect(0,0,width,height);
    
    //THE HOLY CIRCLE HAS BEEN DRAWN
    fill(255);
    circle1.draw();
    
    //Misc stats stuff
    textAlign(LEFT, TOP);
    textSize(32);
    fill(0, 102, 153);
    text("Score: " + score, 20, 20); 
    text("End Game", 460, 20);
    if(autoClickerState){
      if(!autoClickerEnable){
        textAlign(CENTER,BOTTOM);
        textSize(24);
        text("Enable Auto Clicker", width/2, 350);
      } else if(autoClickerEnable){
        textAlign(CENTER,BOTTOM);
        textSize(24);
        text("Disable Auto Clicker", width/2, 350);
      }
    }
    
    int time = -1;
    if((millis() > time)||(click == true)||(autoClickerEnable)){
      
      time = millis() + delay;
      numHearts = 3-(total-score);
      
      switch (numHearts){
        case 3:
          image(heartFull, width/2-76, 20);
          image(heartFull, width/2-16, 20);
          image(heartFull, width/2+44, 20);
          break;
        case 2:
          image(heartFull, width/2-76, 20);
          image(heartFull, width/2-16, 20);
          image(heartEmpty, width/2+44, 20);
          break;
        case 1:
          image(heartFull, width/2-76, 20);
          image(heartEmpty, width/2-16, 20);
          image(heartEmpty, width/2+44, 20);
          break;
        case 0:
          image(heartEmpty, width/2-76, 20);
          image(heartEmpty, width/2-16, 20);
          image(heartEmpty, width/2+44, 20);
          start = 2;
          break;
        default:
          image(heartFull, width/2-76, 20);
          image(heartFull, width/2-16, 20);
          image(heartFull, width/2+44, 20);
          break;
      }
    }

  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
  
  void stopPlaying(){
  //for all those freaks who have "jobs" and "school" and "need to eat" and for some reason can't just play forever  
  //also for n00bs who lose all their hearts
    
    //clearing screen - you've seen this a million times
    fill(0);
    rect(0,0,width,height);
    
    //game over & showing what your score was
    fill(0, 102, 153);
    textAlign(CENTER,CENTER);
    text("Game Over!", width/2, 40);
    text("Your score was: " + score, width/2, 80);
    
    String numUpgradePoints = Integer.toString(upgradePoints);
    String[] newNumUP = numUpgradePoints.split("");
    saveStrings("/GameData/upgradepoints.txt", newNumUP);
    
    
    if(score > highScore){
      text("That's a new high score!", width/2, 140);
      text("Congratulations!", width/2, 180);
      String points = Integer.toString(score);
      String[] newHigh = points.split("");
      saveStrings("/GameData/highscore.txt", newHigh);
    } else {
      text("High score: " + highScore, width/2, 140);
    }
    
    textSize(24);
    text("You have " + upgradePoints + " upgrade points.", width/2, 240);
    text("You can spend them or keep playing." , width/2, 270);
    text("Shop", width/4, 310);
    text("Quit", width/2, 310);
    text("Play Again", 3*width/4, 310);
    
  }

//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
  
  void purchaseRejected(){
  //for when you don't have enough UP and your purchase gets rejected
    
    //clearing screen again
    fill(0);
    rect(0,0,width,height);
    
    textSize(32);
    fill(0,102,153);
    text("WHAT ARE YOU DOING", width/2, 120);
    text("Exit", width/2, 270);
    textSize(24);
    text("You don't have enough UP! You need to play more!" , width/2, 160);
    
  }
  
}
