class Tile {
  float xpos, ypos, size;
  float saturation, maxSaturation, tempSaturation;
  float hue;
  float brightness;
  int flowerChance = int(random (1, 50));
  int side;
  boolean canFade;

  Tile() {
  }
  Tile(float ixpos, float iypos, float isize, int iside) {
    xpos = ixpos;
    ypos = iypos;
    size = isize;
    side = iside;
    hue = 138;
    brightness = random (70, 81);
    if (flowerChance == 4) {
      hue = 385; 
      brightness = 100;
    } else if (flowerChance == 5) {
      hue = 55;
      brightness = 100;
    }
  }
  

  void chooseSide(PGraphics targetSide) {
    targetSide.colorMode(HSB, 360, 100, 100);
    targetSide.noStroke();
    targetSide.fill(hue, saturation + tempSaturation, brightness);
    targetSide.rect(xpos, ypos, size, size);
    targetSide.stroke(0);
    targetSide.colorMode(RGB);
  }

  void display() {
    switch(side) {

    case 1:
      chooseSide(top);
      break;
    case 2:
      chooseSide(side1);
      break;
    case 3:
      chooseSide(side2);
      break;
    case 4:
      chooseSide(secondTop);
      break;
    }

    if (frameCount % 2 == 0 && saturation+tempSaturation > 0 && canFade == true) {
      tempSaturation --;
    }
  }

  //void display(PGraphics targetSide) {

  //  targetSide.colorMode(HSB, 360, 100, 100);
  //  targetSide.noStroke();
  //  targetSide.fill(hue, saturation + tempSaturation, brightness);
  //  targetSide.rect(xpos, ypos, size, size);
  //  targetSide.stroke(0);
  //  targetSide.colorMode(RGB);

  //  if (frameCount % 2 == 0 && saturation+tempSaturation > 0 && canFade == true) {
  //    tempSaturation --;
  //  }
  //}

  void proximityColor(Player player) {
    if (player.screen == side) {
      maxSaturation = map(distPlayer(player), 125, 0, 0, 100);
      if (side == 3) {
        maxSaturation = map(distPlayer(player), 400, 0, 0, 100);
      }
      if (maxSaturation > 100) {
        maxSaturation = 100;
      } else if (maxSaturation < 0) {
        maxSaturation = 0;
      }
      float valueAdd =  map(distPlayer(player), 0, 125, 2, 0);
      if (side == 3) {
        valueAdd = map(distPlayer(player), 0, 400, 2, 0);
      }
      if (valueAdd > 0) {
        canFade = false;
        if (saturation+tempSaturation < 100 && saturation+tempSaturation < maxSaturation && player.mode == 1) {
          tempSaturation += valueAdd;
        } else if (valueAdd > 0 && saturation < 100 && player.mode == 2) {
          saturation += valueAdd; 
          canFade = true;
        } else if (player.mode == 3) {
          saturation --;
          canFade = true;
        }
      } else {
        canFade = true;
      }
    }

    if (saturation > 100) {
      saturation = 100;
    } else if (saturation <0) {
      saturation = 0;
    }
    if (tempSaturation > 100) {
      tempSaturation = 100;
    } else if (tempSaturation <0) {
      tempSaturation = 0;
    }
  }

  float distPlayer(Player p) {
    return dist(p.xpos, p.ypos, xpos, ypos);
  }

  //  public float updateTile(int size) {
  //    float completion = 0;
  //    proximityColor();
  //    display();
  //    completion += saturation;
  //    completion /= size;
  //    return completion;
  //  }
}
