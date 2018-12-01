import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import deadpixel.keystone.*;
import java.awt.geom.*;
import java.awt.*;

Keystone ks;
CornerPinSurface surface1, surface2, surface3, surface4, surface5, surface6;

Minim minim;
AudioPlayer pa, pb, pc, pd, pe, pf, pg, ph, pi, pj, pk, pl, pm, pn, po, pp, pq, pr, ps, pt, pu, pv, pw, px, py, pz, pz1, pz2;
int firstLoop = -1, lastLoop = -1;
int startLoopCheck = 4000;
boolean initialRewind;
int posA;

PGraphics top, side1, side2, secondTop, secondSide1, secondSide2;
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

Player p1; 

int topSize = 800;
int sideSize = 800;
int tileSize = 40;
float basicTopCompletion, waterTopCompletion, platformSide1Completion, bgSide1Completion, fgSide1Completion, crystalSide2Completion, mushroomSide2Completion, platformSide2Completion, bgSide2Completion;

float secondTopCompletion;
void setup() {
  fullScreen(P3D);
  //size(800, 600, P3D);
  rectMode(CENTER);

  minim = new Minim(this);

  startThreads();

  topMap = loadImage("tPlanet.png");
  side1Map = loadImage("side1Map.png");
  side2Map = loadImage("side2Map.png");
  legend = loadImage("tileLegend.png");
  secondTopMap = loadImage("tPlanet.png");

  setLegend();
  parseMap(topMap, 1);
  parseMap(side1Map, 2);
  parseMap(side2Map, 3);
  parseMap(secondTopMap, 4);
  ks = new Keystone(this);
  surface1 = ks.createCornerPinSurface(topSize, topSize, 20);
  surface2 = ks.createCornerPinSurface(sideSize, sideSize, 20);
  surface3 = ks.createCornerPinSurface(sideSize, sideSize, 20);
  surface4 = ks.createCornerPinSurface(sideSize, sideSize, 20);

  top = createGraphics(topSize, topSize, P3D);
  top.rectMode(CENTER);
  side1 = createGraphics(sideSize, sideSize, P3D);
  side1.rectMode(CENTER);
  side2 = createGraphics(sideSize, sideSize, P3D);
  side2.rectMode(CENTER);
  secondTop = createGraphics(topSize, topSize, P3D);
  secondTop.rectMode(CENTER);

  p1 = new Player(40, 1, 1, 5, 1);
}

void draw() {
  p1.canLeft = true;
  p1.canRight = true;
  background(0);
  p1.move();


  /////////////TOP DRAW/////////////////////////////////////
  top.beginDraw();
  top.background(0);

  //Update Top Tiles
  updateTiles(0);

  //Update Top Water Tiles
  updateTiles(1);
  
  //update pitfall tiles
  updateTiles(10);

  p1.display();
  top.endDraw();
  surface1.render(top);
  ////////////////////SIDE 1 DRAW//////////////////////////////////////////
  side1.beginDraw();
  side1.background(0);



  //update bg tiles
  updateTiles(2);

  //Update Platform Tiles
  updateTiles(3);

  p1.display();

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

  p1.display();

  //update crystal tiles
  updateTiles(5);

  //update Mushroom Tiles
  updateTiles(8);

  side2.endDraw();
  surface3.render(side2);
  ///////////////////SECOND TOP DRAW//////////////////////////
  secondTop.beginDraw();
  secondTop.background(0);

  //Update Top Tiles
  updateTiles(9);


  p1.display();
  secondTop.endDraw();
  surface4.render(secondTop);

  if (millis() > startLoopCheck) {
    // forceRewind();
    rewindAll();
    musicProgression();
  }
}

void keyPressed() { //add new person on key press  

  p1.keysCheckP();


  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // and moved
    ks.toggleCalibration();
    break;

  case 'l':
    // loads the saved layout
    ks.load();
    break;

  case 'k':
    // saves the layout
    ks.save();
    break;

  case ' ':
    //jump
    if (p1.isTop == false) {
      p1.vertA = 15;
    }
    break;
  case 'q':
    p1.toggleMode2();
    break;
  case 'e':
    p1.toggleMode3();
    break;
  case 'h':
    posA = pa.position();
    syncSongs();
    break;
  }
}

void keyReleased() {
  p1.keysCheckR();
}

void updateTiles(int selectedArray) {
  switch (selectedArray) {
  case 0:
    basicTopCompletion = 0;
    for (int i=0; i < tiles.size(); i++) {
      Tile getTile = tiles.get(i);
      getTile.proximityColor(p1);
      getTile.display();
      basicTopCompletion += getTile.saturation;
    }
    basicTopCompletion /= tiles.size();
    break;

  case 1:
    waterTopCompletion = 0;
    for (int i=0; i < waterTiles.size(); i++) {
      waterTile getTile = waterTiles.get(i);
      getTile.proximityColor(p1);
      getTile.display();
      waterTopCompletion += getTile.saturation;
    }
    waterTopCompletion /= waterTiles.size();
    break;

  case 2:
    bgSide1Completion = 0;
    for (int i=0; i < bgTiles.size(); i++) {
      bgTile getTile = bgTiles.get(i);
      getTile.proximityColor(p1);
      getTile.display();
      bgSide1Completion += getTile.saturation;
    }
    bgSide1Completion /= bgTiles.size();
    break;

  case 3:
    platformSide1Completion = 0;
    for (int i=0; i < Ptiles.size(); i++) {
      PlatformTile getTile = Ptiles.get(i);
      getTile.proximityColor(p1);
      getTile.display();
      getTile.playerCollision();
      platformSide1Completion += getTile.saturation;
    }
    platformSide1Completion /= Ptiles.size();
    break;

  case 4:
    fgSide1Completion = 0;
    for (int i=0; i < fgTiles.size(); i++) {
      fgTile getTile = fgTiles.get(i);
      getTile.proximityColor(p1);
      getTile.display();
      fgSide1Completion += getTile.saturation;
    }
    fgSide1Completion /= fgTiles.size();
    break;

  case 5:
    crystalSide2Completion = 0;
    for (int i=0; i < crystalTiles.size(); i++) {
      crystalTile getTile = crystalTiles.get(i);
      getTile.proximityColor(p1);
      getTile.display();
      crystalSide2Completion += getTile.saturation;
    }
    crystalSide2Completion /= crystalTiles.size();
    break;

  case 6:
    platformSide2Completion = 0;
    for (int i=0; i < PtilesSide2.size(); i++) {
      PlatformTile getTile = PtilesSide2.get(i);
      getTile.proximityColor(p1);
      getTile.display();
      getTile.playerCollision();
      platformSide2Completion += getTile.saturation;
    }
    platformSide2Completion /= PtilesSide2.size();
    break;

  case 7:
    bgSide2Completion = 0;
    for (int i=0; i < bgTilesSide2.size(); i++) {
      bgTile getTile = bgTilesSide2.get(i);
      getTile.proximityColor(p1);
      getTile.display();
      bgSide2Completion += getTile.saturation;
    }
    bgSide2Completion /= bgTilesSide2.size();
    break;

  case 8:
    mushroomSide2Completion = 0;
    for (int i=0; i < mushroomTiles.size(); i++) {
      mushroomTile getTile = mushroomTiles.get(i);
      getTile.proximityColor(p1);
      getTile.display();
      mushroomSide2Completion += getTile.saturation;
    }
    mushroomSide2Completion /= mushroomTiles.size();
    break;

  case 9:
    secondTopCompletion = 0;
    for (int i=0; i < secondTiles.size(); i++) {
      Tile getTile = secondTiles.get(i);
      getTile.proximityColor(p1);
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
