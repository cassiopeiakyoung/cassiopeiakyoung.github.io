import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class CircleClickerModern_Alpha1_0 extends PApplet {


//declaring variables - self explanatory

PImage heartFull, heartEmpty;
PrintWriter highScorePath, upgradePointsPath, upgradesListPath, lastDatePath;

SplashText alpha;
circle circle1;
Screen screen;
//declaring circle, screen, animation objects
int currentTimeInMinutes, offlineUP;

int delay = 2500;

float circleX = 320;
float circleY = 180;
//starting off: circle in middle of screen

int score, highScore, upgradePoints, start, total, magnetLevel, upgradeUPLevel, upgradeUP2Level, sturdyHeartsLevel, ascensionCount, monthTemp, lastDateInt, magnetCost, upgradeUPCost, upgradeUP2Cost, sturdyHeartsCost, heartHeal, numHearts, startingFlag = 0;
int circleSize = 50;
//starting size of circle

String listOfUpgradesPath[];
String CHEATER_PATH = "/GameData/upgrades/CHEATER_CHEATER.txt";

boolean isGolden, click, hardMode, offlineProgress, autoClickerState, autoClickerEnable, CHEATER_CHEATER_PUMPKIN_EATER;
String points;

String brokeMsg = "You're too poor! Play more!";

  
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
  
public void setup() {
  
  background(0);
  noStroke();
  frameRate(60);
  
  alpha = new SplashText("/GameData/ALPHA/ALPHA", 16); 
  
  listOfUpgradesPath = new String[9];
  
  listOfUpgradesPath[0] = "/GameData/upgrades/magnet.txt";
  listOfUpgradesPath[1] = "/GameData/upgrades/upgradeup.txt";
  listOfUpgradesPath[2] = "/GameData/upgrades/upgradeup2.txt";
  listOfUpgradesPath[3] = "/GameData/upgrades/autoclicker.txt";
  listOfUpgradesPath[4] = "/GameData/upgrades/offlineprogress.txt";
  listOfUpgradesPath[5] = "/GameData/upgrades/sturdyhearts.txt";
  listOfUpgradesPath[6] = "/GameData/upgrades/hardmode.txt"; //not really an upgrade
  listOfUpgradesPath[7] = "/GameData/upgrades/CHEATER_CHEATER.txt";
  listOfUpgradesPath[8] = "/GameData/upgrades/ascensions.txt"; //just a counter
  
  //general setup stuff
  
  circle1 = new circle(circleX, circleY);  //creating a new circle object
  screen = new Screen();
  
  //loading number of upgrade points from upgradepoints.txt file
  
  String heartFullPath = "/GameData/heart-full.png";
  String heartEmptyPath = "/GameData/heart-empty.png";
  heartFull = loadImage(heartFullPath, "png");
  heartEmpty = loadImage(heartEmptyPath, "png");
  
  //loading pics of hearts
  
  heartFull.resize(32,0);
  heartEmpty.resize(32,0);
  
//---------------------------------------------------------------------------------------------------------------------------------------

  //extract the upgrades from upgrades folder
  
  try {
    
    String[] cheaterState = loadStrings(CHEATER_PATH);
    String storedCheaterState = String.join("",cheaterState);
    CHEATER_CHEATER_PUMPKIN_EATER = Boolean.parseBoolean(storedCheaterState);
    
    String[] savedMagnetLevel = loadStrings(listOfUpgradesPath[0]);
    String storedMagnetLevel = String.join("",savedMagnetLevel);
    magnetLevel = Integer.parseInt(storedMagnetLevel);
    
    String[] savedUpgradeUPLevel = loadStrings(listOfUpgradesPath[1]);
    String storedUpgradeUPLevel = String.join("",savedUpgradeUPLevel);
    upgradeUPLevel = Integer.parseInt(storedUpgradeUPLevel);
    
    String[] savedUpgradeUP2Level = loadStrings(listOfUpgradesPath[2]);
    String storedUpgradeUP2Level = String.join("",savedUpgradeUP2Level);
    upgradeUP2Level = Integer.parseInt(storedUpgradeUP2Level);
    
    String[] savedAutoClickerState = loadStrings(listOfUpgradesPath[3]);
    String storedAutoClickerState = String.join("",savedAutoClickerState);
    autoClickerState = Boolean.parseBoolean(storedAutoClickerState);
    
    String[] savedOfflineProgress = loadStrings(listOfUpgradesPath[4]);
    String storedOfflineProgress = String.join("",savedOfflineProgress);
    offlineProgress = Boolean.parseBoolean(storedOfflineProgress);
    
    String[] savedSturdyHeartsLevel = loadStrings(listOfUpgradesPath[5]);
    String storedSturdyHeartsLevel = String.join("",savedSturdyHeartsLevel);
    sturdyHeartsLevel = Integer.parseInt(storedSturdyHeartsLevel);
    
    String[] savedHardMode = loadStrings(listOfUpgradesPath[6]);
    String storedHardMode = String.join("",savedHardMode);
    hardMode = Boolean.parseBoolean(storedHardMode);
    
    String[] savedDevMode = loadStrings(listOfUpgradesPath[7]);
    String storedDevMode = String.join("",savedDevMode);
    CHEATER_CHEATER_PUMPKIN_EATER = Boolean.parseBoolean(storedDevMode);
    
    String[] savedAscensions = loadStrings(listOfUpgradesPath[8]);
    String storedAscensions = String.join("",savedAscensions);
    ascensionCount = Integer.parseInt(storedAscensions);
    
  } catch (Exception e) {
    createWriter(CHEATER_PATH);
    for(int i=0; i<listOfUpgradesPath.length; i++){
      createWriter(listOfUpgradesPath[i]);
    }  
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------

  //loading saved number of upgrade points from upgradepoints.txt, else creates file upgradepoints.txt
  try {
    String[] savedPoints = loadStrings("/GameData/upgradepoints.txt");
    String storedPoints = String.join("",savedPoints);
    upgradePoints = Integer.parseInt(storedPoints);
  } catch(Exception e) {  //catch if file doesn't exist
    createWriter("/GameData/upgradepoints.txt");
  }

//---------------------------------------------------------------------------------------------------------------------------------------
  
  //loading saved high score from highscore.txt, else creates file highscore.txt
  try {
    String[] savedScore = loadStrings("/GameData/highscore.txt");
    String storedScore = String.join("",savedScore);
    highScore = Integer.parseInt(storedScore);
    //loading high score from highscore.txt file
  } catch (Exception e) {  
    highScorePath = createWriter("/GameData/highscore.txt");
    highScorePath.println("0");
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
  
  //stores #minutes since last play & compares it to current #minutes

  int temp;
  switch (month()){
      case 1:
        temp = 0;
        break;
      case 2:
        temp = 43830*31;
        break;
      case 3:
        temp = 43830*59;
        break;  
      case 4:
        temp = 43830*90;
        break;
      case 5:
        temp = 43830*120;
        break;
      case 6:
        temp = 43830*151;
        break;
      case 7:
        temp = 43830*181;
        break;
      case 8:
        temp = 43830*212;
        break;
      case 9:
        temp = 43830*243;
        break;
      case 10:
        temp = 43830*273;
        break;
      case 11: 
        temp = 43830*304;
        break;
      case 12:
        temp = 43830*334;
        break;
      default:
        temp = 0;
        break;
  }
  currentTimeInMinutes = (int)(525960*year())+temp+(1440*day())+(60*hour())+(minute());    //A REALLY LONG NUMBER
    
  try {
    String[] savedLastDate = loadStrings("/GameData/lastdate.txt");
    String storedLastDate = String.join("",savedLastDate);
    lastDateInt = Integer.parseInt(storedLastDate);
    
    //loading last date from lastdate.txt file
  } catch (Exception e){
    createWriter("/GameData/lastdate.txt");
    
    String lastDateString = Integer.toString(currentTimeInMinutes);
    String[] newLastDate = lastDateString.split("");
    saveStrings("/GameData/lastdate.txt", newLastDate);
  }
  if(offlineProgress){
    int numMinsSinceLastPlay = currentTimeInMinutes-lastDateInt;
     offlineUP = (int)numMinsSinceLastPlay/3;
    upgradePoints += offlineUP;
  }
  
       
}

//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------

public void draw() {  
  /*
  //sturdy hearts regen calcs
  if(numHearts<3){
    int regenDelay = 15000/(sturdyHeartsLevel+1);
    int time = -1;
    if(millis() > time){
        time = millis() + regenDelay;
        numHearts++;
    }
  }
   */
  //updates the prices of the various upgrades at however many FPS draw() is
  upgradeUPCost = (int)10*(upgradeUPLevel+1);
  upgradeUP2Cost = (int)Math.pow(10*(upgradeUP2Level+1), 1.5f);
  sturdyHeartsCost = (int)50*(sturdyHeartsLevel+1);
  
  //broken stuff to use with dev mode
  if(CHEATER_CHEATER_PUMPKIN_EATER){
    
    if(upgradePoints<Integer.MAX_VALUE){
      upgradePoints = Integer.MAX_VALUE;
    }
      
    magnetLevel = 1;
    upgradeUPLevel = 4;
    upgradeUP2Level = 5;
    autoClickerState = true;
    offlineProgress = true;
    sturdyHeartsLevel = 5;
    
  }
  
  //somewhat self-explanatory - checks value of start at however many FPS draw() is, and changes screen accordingly
  switch(start){
    case 0:
      if(CHEATER_CHEATER_PUMPKIN_EATER){
        screen.CHEATER();
      } else {
        alpha.display(300,-100);
        screen.welcome();
      }
      
      break;
    case 1:
      if(startingFlag == 0){
        startingFlag = 1;
        score = 0;
        total = 0;
      }
      
      screen.startPlaying();
      
      break;
    case 2:
      screen.stopPlaying();
      break;
    case 3:
      screen.openShop1();
      break;
    case 4:
      screen.openShop2();
      break;
    case 5:
      screen.openShop3();
      break;
    case 6:
      screen.purchaseRejected();
      break;
    default:
      screen.welcome();
      break;
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------

public void mouseClicked(){
  switch(start){
    
//---------------------------------------------------------------------------------------------------------------------------------------
    
    case 0:
      start = 1;
      total = 0;
      break;
      
//---------------------------------------------------------------------------------------------------------------------------------------  
      
    case 1:
      
      if ((abs(circleX-mouseX)<(circleSize/2))&&(abs(circleY-mouseY)<(circleSize/2))){
        if (isGolden == true){
          upgradePoints += (upgradeUP2Level+1)*(1+upgradeUPLevel);
          score++;
        } else {
          score++;
        }
        click = true;
        } else if ((mouseX > 460) && (mouseY < 70)){
          start = 2;
        }
      if((autoClickerState)&&(!autoClickerEnable)&&((mouseX>200&&mouseX<440)&&(mouseY>320&&mouseY<345))){
        autoClickerEnable = true;
      } else if((autoClickerState)&&(autoClickerEnable)&&((mouseX>200&&mouseX<440)&&(mouseY>320&&mouseY<345))){
        autoClickerEnable = false;
      }
      break;
      
//---------------------------------------------------------------------------------------------------------------------------------------
      
    case 2:
      if((mouseX>130&&mouseX<190)&&(mouseY>300&&mouseY<325)){
        screen.openShop1();
        start = 3;
      } else if((mouseX>420&&mouseX<540)&&(mouseY>300&&mouseY<325)){
        start = 1;
        score = 0;
        total = 0;
        circleSize = 50;
        delay = 2500;
      } else if((mouseX>295&&mouseX<345)&&(mouseY>300&&mouseY<325)){
        
        // Saves new/recently purchased upgrades to respective file in upgrades folder  
        
        String cheaterState = Boolean.toString(CHEATER_CHEATER_PUMPKIN_EATER);
        String[] newCheaterState = cheaterState.split("");
        saveStrings(CHEATER_PATH, newCheaterState);
        
        String numMagnetLevel = Integer.toString(magnetLevel);
        String[] newMagnetLevel = numMagnetLevel.split("");
        saveStrings(listOfUpgradesPath[0], newMagnetLevel);
        
        String numUpgradeUPLevel = Integer.toString(upgradeUPLevel);
        String[] newUpgradeUPLevel = numUpgradeUPLevel.split("");
        saveStrings(listOfUpgradesPath[1], newUpgradeUPLevel);
        
        String numUpgradeUP2Level = Integer.toString(upgradeUP2Level);
        String[] newUpgradeUP2Level = numUpgradeUP2Level.split("");
        saveStrings(listOfUpgradesPath[2], newUpgradeUP2Level);
        
        String yesAutoClickerState = Boolean.toString(autoClickerState);
        String[] newAutoClickerState = yesAutoClickerState.split("");
        saveStrings(listOfUpgradesPath[3], newAutoClickerState);
        
        String offlineProgressState = Boolean.toString(offlineProgress);
        String[] newOfflineProgressState = offlineProgressState.split("");
        saveStrings(listOfUpgradesPath[4], newOfflineProgressState);
        
        String numSturdyHeartsLevel = Integer.toString(sturdyHeartsLevel);
        String[] newSturdyHeartsLevel = numSturdyHeartsLevel.split("");
        saveStrings(listOfUpgradesPath[5], newSturdyHeartsLevel);
        
        String hardModeState = Boolean.toString(hardMode);
        String[] newHardModeState = hardModeState.split("");
        saveStrings(listOfUpgradesPath[6], newHardModeState);
        
        String devModeState = Boolean.toString(CHEATER_CHEATER_PUMPKIN_EATER);
        String[] newDevModeState = devModeState.split("");
        saveStrings(listOfUpgradesPath[7], newDevModeState);
        
        String numAscensionsCount = Integer.toString(ascensionCount);
        String[] newAscensionsCount = numAscensionsCount.split("");
        saveStrings(listOfUpgradesPath[8], newAscensionsCount);
        
        String lastDateString = Integer.toString(currentTimeInMinutes);
        String[] newLastDate = lastDateString.split("");
        saveStrings("/GameData/lastdate.txt", newLastDate);
        
        exit();
      }
      break;
      
//---------------------------------------------------------------------------------------------------------------------------------------
      
    case 3:
      if((mouseX>530&&mouseX<585)&&(mouseY>310&&mouseY<335)){
        start = 2;
      } else if((mouseX>40&&mouseX<165)&&(mouseY>310&&mouseY<335)){
        start = 4;
      } else if((mouseX>460&&mouseX<620)&&(mouseY>100&&mouseY<140)&&magnetLevel<10){
        if(upgradePoints>=100){
          upgradePoints -= 100;
          magnetLevel = 1;
        } else {
          start = 6;
        }
        //upgradeUP
      } else if((mouseX>460&&mouseX<620)&&(mouseY>170&&mouseY<210)&&upgradeUPLevel<4){
        if(upgradePoints>=upgradeUPCost){
          upgradePoints -= upgradeUPCost;
          upgradeUPLevel++;
        } else {
          start = 6;
        }
        //upgradeUP2
      } else if((mouseX>460&&mouseX<620)&&(mouseY>240&&mouseY<280)&&upgradeUP2Level<5){
        if(upgradePoints>=upgradeUP2Cost){
          upgradePoints -= upgradeUP2Cost;
          upgradeUP2Level++;
        } else {
          start = 6;
        }
      }
      break;
      
//---------------------------------------------------------------------------------------------------------------------------------------
      
    case 4:
      if((mouseX>20&&mouseX<180)&&(mouseY>310&&mouseY<335)){
        start = 3;
      } else if((mouseX>530&&mouseX<585)&&(mouseY>310&&mouseY<335)){
        start = 2;
      } else if((mouseX>200&&mouseX<330)&&(mouseY>310&&mouseY<335)){
        start = 5;
        //autoclicker
      } else if((mouseX>460&&mouseX<620)&&(mouseY>100&&mouseY<140)){
        if((upgradePoints>=10000)&&(!autoClickerState)){
          upgradePoints -= 10000;
          autoClickerState = true;
        } else {
          start = 6;
        }
        //offlineprogress
      } else if((mouseX>460&&mouseX<620)&&(mouseY>170&&mouseY<210)){
        if((upgradePoints>=1000)&&(!offlineProgress)){
          upgradePoints -= 1000;
          offlineProgress = true;
        } else {
          start = 6;
        }
        //sturdyhearts
      } else if((mouseX>460&&mouseX<620)&&(mouseY>240&&mouseY<280)){
        if((upgradePoints>=sturdyHeartsCost)&&(sturdyHeartsLevel<5)){
          upgradePoints -= sturdyHeartsCost;
          sturdyHeartsLevel++;
        } else {
          start = 6;
        }
      }
      break;
      
//---------------------------------------------------------------------------------------------------------------------------------------
      
    case 5:
      if((mouseX>20&&mouseX<180)&&(mouseY>310&&mouseY<335)){
        start = 4;
      } else if((mouseX>530&&mouseX<585)&&(mouseY>310&&mouseY<335)){
        start = 2;
      } else if((mouseX>460&&mouseX<620)&&(mouseY>100&&mouseY<140)){
        if(upgradePoints>=5000){
          upgradePoints -= 5000;
          hardMode = true;
        } else {
          start = 6;
        }
      } else if((mouseX>460&&mouseX<620)&&(mouseY>170&&mouseY<210)){
        if(upgradePoints==-1){
          upgradePoints += 1;
          CHEATER_CHEATER_PUMPKIN_EATER = true;
        } else {
          start = 6;
        }
      /*
      } else if((mouseX>460&&mouseX<620)&&(mouseY>240&&mouseY<280)){
        if(upgradePoints>=10000&&highScore>=1000){
          upgradePoints -= 10000;
          // add actual ascension mechanic here before compiling and uploading to website
          ascensionCount++;
        } else {
          print("Git gud scrub");
        }
      */
      }
      break;
    case 6:
      if(mouseX>290&&mouseX<350&&mouseY>260&&mouseY<290){
        start = 3;
      }
  }
}

//JESUS, this is some UGLY code

class Screen{
  
  //lmao empty constructor class
  Screen(){
  }
  
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------------------------------------------
  //the welcome screen
  public void welcome(){
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

  public void CHEATER(){
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
  
  public void openShop1(){
    
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
  
  public void openShop2(){
    
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
  
  public void openShop3(){
    
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
  
  public void startPlaying(){
    
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
  
  public void stopPlaying(){
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
  
  public void purchaseRejected(){
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
class SplashText{
  PImage[] images;
  int imageCount;
  int frame;
  
  SplashText(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[17];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + i + ".GIF";
      images[i] = loadImage(filename);
    }
    
    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + (imageCount-i) + ".GIF";
      images[i] = loadImage(filename);
    }
    
  }

  public void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    fill(0);
    rect(0,0,width,height);
    image(images[frame], xpos, ypos);
    
  }
  
}
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
  
  public void draw(){
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
  
  public void newPos(){
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
  public void settings() {  size(640, 360); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "CircleClickerModern_Alpha1_0" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
