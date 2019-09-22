
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
  
void setup() {
  size(640, 360);
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

void draw() {  
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
  upgradeUP2Cost = (int)Math.pow(10*(upgradeUP2Level+1), 1.5);
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

void mouseClicked(){
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
