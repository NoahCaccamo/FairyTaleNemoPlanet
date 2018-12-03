//RTA 320
//Noah Caccamo
//Inspired by works by artist Tyler Tran
import deadpixel.keystone.*; //54 lines per 1080
import java.awt.geom.*;
import java.awt.*;

Keystone ks;
CornerPinSurface surface1, surface2, surface3, surface4, surface5, surface6;

StringList entries, entries2;

boolean listFull = false;
boolean mishonCompree = false;

int goal = 74;
float progressColor;
String text1="";

String part1 = "Marlin and his wife are treading on the balcony of their mansion overlooking the open ocean.\n\nMarlin: It’s beautiful\nWife: yup\n\nThey see an island of trash coming their way\n\nMarlin: runnnnn!!!!!!!!!!!!!!!!!!!!\nWife: we’ve got to save the kids!\nMarlin: no, we’ve got no time!\n\nMarlin’s wife sprints down into the catacombs where the eggs rest \n\nWife: intense coughing as trash fills nursery\nMarlin: nooooooo\n";
String part2 = "Some time later….\n\nMarlin wakes up.  His only surviving son, Nemo, is yelling at him.\nNemo: Dad, we have to go!\nMarlin: Why?\nNemo: The water is getting warmer! It’s getting hard for me to breathe!\nMarlin: We gotta go then!\n\nThey look outside to see whole schools of fish fleeing the area.  They follow.";
String part3 = "Nemo: Daddy, is it true that some species can only have female babies because the water is too hot?\nMarlin: No, I haven’t.\nNemo: They are in danger because they don’t have enough population.\nMarlin: nice\nNemo: Yeah, the water is too warm for male offspring";
String part4 = "They continue on, and see Crabs with corroding shells\n\nCrab: owwwww\nMarlin: Is there anything we can do?\nCrab: no, I’m crippled forever because of the rising acidity levels owwwww\nMarlin: I’m so sorry. There must be something we can do about this.";
String part5 = "Marlin and Nemo pass by a familiar park. Garbage swirls around the ocean now.\n\nNemo: This place looks dead\nMarlin: Yep, it’s not as magical as it used to be.\nNemo: I remember I went here on my first day of school….\nMarlin: Me too.\nNemo: Is it ever going to get better?\nMarlin: Maybe….\n";
String part6 = "Later, they encounter a group of unfamiliar fish\n\nNemo: What tf is that???!!!!\nMarlin: I don’t know, RUNNNNN\n\nThe unfamiliar fish terrorizes some unsuspecting fish, but our heros get to safety. Another fish follows them\n\nDory: Hi, I’m Dory, I have short term memory loss.\nMarlin: Hey. We are trying to find a new home.\nDory: Hi, I’m Dory.";
String part7 = "After some time swimming. The water seems to be getting clearer.\n\nDory: Just keep swimming, x3\nMarlin: Dory that’s enough…\nNemo: Look, there is less garbage over there!\nMarlin: Wow! I’ve never seen so much blue in the whole ocean before.";
String part8 = "Nets come and swoop some garbage out of the water\n\nDory: Hurray!\nMarlin: All the garbage is leaving!\n\nThe water is much cleaner now, but more is yet to be done.";
String part9 = "Marlin:  It looks like we are nearing the end of our journey…\nNemo: are we?\nMarlin: Yes Nemo\nDory: Look, over the horizon!\n\nThey swim towards a cliff, they hear indistinct chatter nearby\n\nMarlin: Wow, look at this place!\nNemo: There’s so many people!\nDory: It looks beautiful!  The coral is colourful, the water is blue!\n\nMarlin: This is the perfect place for us…\n\nMarlin, Nemo, and Dory, for the rest of their lives, shared the stories of the\n great pollution with the school of fish they belonged to...\n\nTo learn about how you can prevent fish like Marlin from being affected by\n Global Warming, you can follow @SaveNemoMarlin for tips on how to reduce your carbon footprint, and save the ocean!";

PFont monoSpaced;
float totalHeightTXT, totalHeightTXT2;

float entryNum;

int sc1X = 1920;
int sc2X = 1280;
int sc1Y = 1080;
int sc2Y = 1024;

int scX = sc1X + sc2X;
int scY = sc1Y + sc2Y;

int firstLoop = -1, lastLoop = -1;
int startLoopCheck = 4000;
boolean initialRewind;
int posA;

PGraphics top, side1, side2, compScreen, txtScreen1, txtScreen2;
PImage topMap, side1Map, side2Map, legend, secondTopMap, secondSide1Map, secondSide2Map;
int tileNum, waterTileNum, platformTileNum, fgTileNum, bgTileNum, crystalTileNum, mushroomTileNum, pitfallTileNum;

boolean debug = true;

ArrayList<pitfallTile> pitfallTiles = new ArrayList<pitfallTile>();

//planet 1
ArrayList<Tile> tiles = new ArrayList<Tile>();
ArrayList<waterTile> waterTiles = new ArrayList<waterTile>();
ArrayList<PlatformTile> Ptiles = new ArrayList<PlatformTile>();
ArrayList<PlatformTile> PtilesSide2 = new ArrayList<PlatformTile>();
ArrayList<fgTile> fgTiles = new ArrayList<fgTile>();
ArrayList<bgTile> bgTiles = new ArrayList<bgTile>();
ArrayList<bgTile> bgTilesSide2 = new ArrayList<bgTile>();
ArrayList<crystalTile> crystalTiles = new ArrayList<crystalTile>();
ArrayList<mushroomTile> mushroomTiles = new ArrayList<mushroomTile>();

//planet 2
ArrayList<Tile> secondTiles = new ArrayList<Tile>();

ArrayList<Player> players = new ArrayList<Player>();
ArrayList<Player> players2 = new ArrayList<Player>();
ArrayList<Player> players3 = new ArrayList<Player>();

Player p1; 

int topSize = 800;
int sideSize = 800;
int tileSize = 40;
float basicTopCompletion, waterTopCompletion, platformSide1Completion, bgSide1Completion, fgSide1Completion, crystalSide2Completion, mushroomSide2Completion, platformSide2Completion, bgSide2Completion;

float secondTopCompletion;

////////////////////////////



//text box stuff
ArrayList <String> messages = new ArrayList <String>();
boolean sent = false;
String prompt = "What do you want the environment to be like?";





//1020
void settings() {
  fullScreen(P3D);
}

void setup() {
  //fullScreen(P3D);
  surface.setSize(3200, 1080);
  // size(3200, 1020, P3D);
  rectMode(CENTER);

  entries = new StringList();
  entries2 = new StringList();

  monoSpaced = createFont("Courier", 20);

  topMap = loadImage("tPlanet.png");
  side1Map = loadImage("side1Map.png");
  side2Map = loadImage("side2Map.png");
  legend = loadImage("tileLegend.png");


  setLegend();
  parseMap(topMap, 1);
  parseMap(side1Map, 2);
  parseMap(side2Map, 3);
  ks = new Keystone(this);
  surface1 = ks.createCornerPinSurface(topSize, topSize, 20);
  surface2 = ks.createCornerPinSurface(sideSize, sideSize, 20);
  surface3 = ks.createCornerPinSurface(sideSize, sideSize, 20);

  surface4 = ks.createCornerPinSurface(1920, 1080, 20);
  surface5 = ks.createCornerPinSurface(600, 1080, 20);
  surface6 = ks.createCornerPinSurface(600, 1080, 20);


  top = createGraphics(topSize, topSize, P3D);
  top.rectMode(CENTER);
  side1 = createGraphics(sideSize, sideSize, P3D);
  side1.rectMode(CENTER);
  side2 = createGraphics(sideSize, sideSize, P3D);
  side2.rectMode(CENTER);
  compScreen = createGraphics(1920, 1080, P3D);
  txtScreen1 = createGraphics(600, 1080, P3D);
  txtScreen2 = createGraphics(600, 1080, P3D);

  //p1 = new Player(40, 1, 1, 5, 1);
  // players.add(new Player(40, 1, 1, 5, 1));
}





void draw() {

  if (frameCount == 1) frame.setLocation(0, 0);

  //p1.canLeft = true;
  //p1.canRight = true;
  background(0);
  //p1.move();

  clear();
  /////////////TOP DRAW/////////////////////////////////////
  top.beginDraw();
  top.background(0);

  //Update Top Tiles
  updateTiles(0);

  //Update Top Water Tiles
  updateTiles(1);

  //update pitfall tiles
  updateTiles(10);

  //p1.display();
  top.endDraw();
  surface1.render(top);
  ////////////////////SIDE 1 DRAW//////////////////////////////////////////
  side1.beginDraw();
  side1.background(0);



  //update bg tiles
  updateTiles(2);

  //Update Platform Tiles
  updateTiles(3);

  //p1.display();

  //foreground update
  updateTiles(4);

  side1.endDraw();
  surface2.render(side1);
  //////////////////////////SIDE 2 DRAW////////////////////////////////////////
  side2.beginDraw();
  side2.background(0);

  //update BG Tiles
  updateTiles(7);

  //update Platform Tiles
  updateTiles(6);

  //p1.display();

  //update crystal tiles
  updateTiles(5);

  //update Mushroom Tiles
  updateTiles(8);

  side2.endDraw();
  surface3.render(side2);
  ///////////////////Comp Screen DRAW//////////////////////////
  compScreen.beginDraw();

  println(entries.size(), entries2.size(), goal, progressColor);
  compScreen.background(lerpColor(#0A392A, #3498DB, progressColor));
  compScreen.textSize(60);
  compScreen.textAlign(CENTER);
  compScreen.text("What is something you can change in your life to help combat climate change?", compScreen.width/2, compScreen.height/2 - 400, compScreen.width/2, 400);
  compScreen.textAlign(LEFT);
  compScreen.textSize(40);
  compScreen.text(text1, compScreen.width/2, compScreen.height/2, compScreen.width/2, compScreen.height);
  compScreen.textSize(20);

  String selectedPart = "";
  int progress = entries.size() + entries2.size();

  if (progress > 0 && progress <= goal/9) {
    selectedPart = part1;
    progressColor = 0;
  } else if (progress > goal/9 && progress <= (goal/9*2)) {
    selectedPart = part2;
    progressColor = 0.1;
  } else if (progress > (goal/9*2) && progress <= (goal/9*3)) {
    selectedPart = part3;
    progressColor = 0.3;
  } else if (progress > (goal/9*3) && progress <= (goal/9*4)) {
    selectedPart = part4;
    progressColor = 0.4;
  } else if (progress > (goal/9*4) && progress <= (goal/9*5)) {
    selectedPart = part5;
    progressColor = 0.5;
  } else if (progress > (goal/9*5) && progress <= (goal/9*6)) {
    selectedPart = part6;
    progressColor = 0.6;
  } else if (progress > (goal/9*6) && progress <= (goal/9*7)) {
    selectedPart = part7;
    progressColor = 0.7;
  } else if (progress > (goal/9*7) && progress <= (goal/9*8)) {
    selectedPart = part8;
    progressColor = 0.8;
  } else if (progress > (goal/9*8)) {
    selectedPart = part9;
    progressColor = 1;
  }

  compScreen.text(selectedPart, 10, 200);

  compScreen.endDraw();
  surface4.render(compScreen);
  ////////////////TXT 1 SCREEN DRAW ///////////////////////////////
  txtScreen1.beginDraw();
  txtScreen1.background(0);
  txtScreen1.textSize(20);
  txtScreen1.textFont(monoSpaced);
  //txtScreen1.textAlign(LEFT,TOP);
  txtScreen1.rectMode(CORNER);
  totalHeightTXT = 0;

  for (int i=0; i < entries.size(); i++) {
    float tempWidth = 0;
    float tempHeight = 0;
    int counter = 0;
    String getEntry = entries.get(i);

    float fakeTempWidth = textWidth(getEntry);
    if (textWidth(getEntry) > txtScreen1.width) {
      do {
        counter++;
        fakeTempWidth = textWidth(getEntry) / counter;
        tempHeight = 40 * counter;
      } while (fakeTempWidth > txtScreen1.width);
    } else {
      tempWidth = textWidth(getEntry);
      tempHeight = 40;
    }

    totalHeightTXT += tempHeight;
    txtScreen1.fill(100);
    // txtScreen1.rect(0, (20*i), tempWidth, tempHeight);
    txtScreen1.fill(255);
    txtScreen1.text(getEntry, 0, 20*i, txtScreen1.width, tempHeight+ 20);
  }

  txtScreen1.endDraw();
  surface5.render(txtScreen1);

  ////////////////////
  txtScreen2.beginDraw();
  txtScreen2.background(0);
  txtScreen2.textSize(20);
  txtScreen2.textFont(monoSpaced);
  //txtScreen1.textAlign(LEFT,TOP);
  txtScreen2.rectMode(CORNER);
  totalHeightTXT2 = 0;

  for (int i=0; i < entries2.size(); i++) {
    float tempWidth = 0;
    float tempHeight = 0;
    int counter = 0;
    String getEntry = entries2.get(i);

    float fakeTempWidth = textWidth(getEntry);
    if (textWidth(getEntry) > txtScreen2.width) {
      do {
        counter++;
        fakeTempWidth = textWidth(getEntry) / counter;
        tempHeight = 40 * counter;
      } while (fakeTempWidth > txtScreen2.width);
    } else {
      tempWidth = textWidth(getEntry);
      tempHeight = 40;
    }

    totalHeightTXT2 += tempHeight;
    txtScreen2.fill(100);
    // txtScreen1.rect(0, (20*i), tempWidth, tempHeight);
    txtScreen2.fill(255);
    txtScreen2.text(getEntry, 0, 20*i, txtScreen1.width, tempHeight+ 20);
  }

  txtScreen2.endDraw();
  surface6.render(txtScreen2);

  /////////////////////////////////////
  entryNum = (entries.size() + entries2.size()) * 2 ;  //ADJUST VALUES HERE

  if (int(entryNum) > players.size() + players2.size() + players3.size()) {
    int sideChosen = (int) random(1, 4);
    PVector tempVec = new PVector (0, 0);
    PVector compVec = new PVector(0, 0);
    //println(sideChosen);

    if (sideChosen == 1) {
      tempVec = securePos(0, 800, 0, 800, 100, 0);
      if (tempVec == compVec) {
        sideChosen = 2;
      }
      if (sideChosen == 1) {
        players.add(new Player(40, tempVec.x, tempVec.y, 0, sideChosen));
      }
    }
    if (sideChosen == 2) {
      tempVec = securePos2(0, 800, 0, 800, 100, 0);
      if (tempVec == compVec) {
        sideChosen = 3;
      }
      if (sideChosen == 2) {
        players2.add(new Player(40, tempVec.x, tempVec.y, 0, sideChosen));
      }
    }
    if (sideChosen == 3) {
      tempVec = securePos3(20, 780, 20, 780, 100, 0);
      players3.add(new Player(40, tempVec.x, tempVec.y, 0, sideChosen));
    }
  }

  if (entries.size() >= 51) {
    listFull = true;
  }
  if (entries.size() + entries2.size() >= goal) {
    mishonCompree = true;
  }

  //println(entries.size(), entries2.size(), players.size()
}










void keyPressed() { //add new person on key press 
  if (key != DELETE && key != BACKSPACE && key != ENTER && keyCode != SHIFT && key != TAB) {
    text1+=key;
  } else if (key == ENTER && text1.length()>0) {
    if (text1.length() <=49) {
      if (listFull == false) {
        entries.append(text1);
      } else {
        entries2.append(text1);
      }
    } else {
      String tempText = "";
      for (int i=0; i < text1.length(); i++) {
        tempText += text1.charAt(i);
        if (tempText.length() > 40 && tempText.length() < 49) {
          if (text1.charAt(i) == ' ' || text1.charAt(i) == '.' || text1.charAt(i) == '!' || text1.charAt(i) == '?') {
            if (listFull == false) {
              entries.append(tempText);
            } else {
              entries2.append(tempText);
            }
            tempText = "";
          }
        }
        if (tempText.length() == 49) {
          if (listFull == false) {
            entries.append(tempText);
          } else {
            entries2.append(tempText);
          }
          tempText = "";
        }
      }
      if (tempText.length() > 0) {
        if (listFull == false) {
          entries.append(tempText);
        } else {
          entries2.append(tempText);
        }
        tempText = "";
      }
      //entries.append("/n");
    }
    text1 = ("");
    if (listFull == false) {
      entries.append(" ");
    } else {
      entries2.append(" ");
    }
  } else if (key == BACKSPACE) {
    if (text1.length() > 0) {
      text1 = text1.substring (  0, text1.length()-1  );
    }
  }



  switch(key) {
  case '8':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case '9':
    // loads the saved layout
    ks.load();
    break;

  case '0':
    // saves the layout
    ks.save();
    break;
  }
}



void updateTiles(int selectedArray) {
  switch (selectedArray) {
  case 0: //WORKS
    basicTopCompletion = 0;
    for (int i=0; i < tiles.size(); i++) {
      Tile getTile = tiles.get(i);
      for (int p=0; p < players.size(); p++) {
        Player getPlayer = players.get(p);
        getTile.proximityColor(getPlayer);
      }
      if (mishonCompree == true) {
        getTile.saturation = 100;
      }
      getTile.display();
      basicTopCompletion += getTile.saturation;
    }
    basicTopCompletion /= tiles.size();
    break;

  case 1: //WORKS
    waterTopCompletion = 0;
    for (int i=0; i < waterTiles.size(); i++) {
      waterTile getTile = waterTiles.get(i);
      for (int p=0; p < players.size(); p++) {
        Player getPlayer = players.get(p);
        getTile.proximityColor(getPlayer);
      }
      if (mishonCompree == true) {
        getTile.saturation = 100;
      }
      getTile.display();
      waterTopCompletion += getTile.saturation;
    }
    waterTopCompletion /= waterTiles.size();
    break;

  case 2: //WORKS
    bgSide1Completion = 0;
    for (int i=0; i < bgTiles.size(); i++) {
      bgTile getTile = bgTiles.get(i);
      for (int p=0; p < players2.size(); p++) {
        Player getPlayer = players2.get(p);
        getTile.proximityColor(getPlayer);
      }
      if (mishonCompree == true) {
        getTile.saturation = 100;
      }
      getTile.display();
      bgSide1Completion += getTile.saturation;
    }
    bgSide1Completion /= bgTiles.size();
    break;

  case 3: //WORKS
    platformSide1Completion = 0;
    for (int i=0; i < Ptiles.size(); i++) {
      PlatformTile getTile = Ptiles.get(i);
      for (int p=0; p < players2.size(); p++) {
        Player getPlayer = players2.get(p);
        getTile.proximityColor(getPlayer);
      }
      if (mishonCompree == true) {
        getTile.saturation = 100;
      }
      getTile.display();
      // getTile.playerCollision();
      platformSide1Completion += getTile.saturation;
    }
    platformSide1Completion /= Ptiles.size();
    break;

  case 4:
    fgSide1Completion = 0;
    for (int i=0; i < fgTiles.size(); i++) {
      fgTile getTile = fgTiles.get(i);
      for (int p=0; p < players.size(); p++) {
        Player getPlayer = players.get(p);
        getTile.proximityColor(getPlayer);
      }
      getTile.display();
      fgSide1Completion += getTile.saturation;
    }
    fgSide1Completion /= fgTiles.size();
    break;

  case 5:
    crystalSide2Completion = 0;
    for (int i=0; i < crystalTiles.size(); i++) {
      crystalTile getTile = crystalTiles.get(i);
      for (int p=0; p < players.size(); p++) {
        Player getPlayer = players.get(p);
        getTile.proximityColor(getPlayer);
      }
      getTile.display();
      crystalSide2Completion += getTile.saturation;
    }
    crystalSide2Completion /= crystalTiles.size();
    break;

  case 6:  // WORKS
    platformSide2Completion = 0;
    for (int i=0; i < PtilesSide2.size(); i++) {
      PlatformTile getTile = PtilesSide2.get(i);
      for (int p=0; p < players3.size(); p++) {
        Player getPlayer = players3.get(p);
        getTile.proximityColor(getPlayer);
      }
      if (mishonCompree == true) {
        getTile.saturation = 100;
      }
      getTile.display();
      //   getTile.playerCollision();
      platformSide2Completion += getTile.saturation;
    }
    platformSide2Completion /= PtilesSide2.size();
    break;

  case 7: // WORKS
    bgSide2Completion = 0;
    for (int i=0; i < bgTilesSide2.size(); i++) {
      bgTile getTile = bgTilesSide2.get(i);
      for (int p=0; p < players3.size(); p++) {
        Player getPlayer = players3.get(p);
        getTile.proximityColor(getPlayer);
      }
      if (mishonCompree == true) {
        getTile.saturation = 100;
      }
      getTile.display();
      bgSide2Completion += getTile.saturation;
    }
    bgSide2Completion /= bgTilesSide2.size();
    break;

  case 8:
    mushroomSide2Completion = 0;
    for (int i=0; i < mushroomTiles.size(); i++) {
      mushroomTile getTile = mushroomTiles.get(i);
      for (int p=0; p < players.size(); p++) {
        Player getPlayer = players.get(p);
        getTile.proximityColor(getPlayer);
      }
      getTile.display();
      mushroomSide2Completion += getTile.saturation;
    }
    mushroomSide2Completion /= mushroomTiles.size();
    break;

  case 9:
    secondTopCompletion = 0;
    for (int i=0; i < secondTiles.size(); i++) {
      Tile getTile = secondTiles.get(i);
      for (int p=0; p < players.size(); p++) {
        Player getPlayer = players.get(p);
        getTile.proximityColor(getPlayer);
      }
      getTile.display();
      secondTopCompletion += getTile.saturation;
    }
    secondTopCompletion /= tiles.size();
    break;

  case 10:
    for (int i=0; i < pitfallTiles.size(); i++) {
      pitfallTile getTile = pitfallTiles.get(i);
      getTile.display(p1);
      getTile.playerFall(p1);
    }
    break;
  }
}
