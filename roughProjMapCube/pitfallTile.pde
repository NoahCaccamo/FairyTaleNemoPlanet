class pitfallTile extends Tile {
  boolean falling;
  int fallingCounter;
  pitfallTile(float ixpos, float iypos, float isize, int iside) {
    xpos = ixpos;
    ypos = iypos;
    size = isize;
    side = iside;
    hue = 0;
    brightness = 0;
  }


  void playerFall(Player player) {
    if (player.screen == side && player.canFall == true && distPlayer(player) < 20) {
      player.ypos = -19;
      player.isTop = false;
      player.isSide1 = true;
      player.screen = 2;
      player.canFall = false;
      falling = true;
      colorMode(RGB);
    }
  }

  void chooseSide(PGraphics targetSide, Player player) {
    if (falling == false) {
      targetSide.colorMode(RGB);
      targetSide.noStroke();
      targetSide.fill(0);
      targetSide.rect(xpos, ypos, size, size);
      targetSide.stroke(0);
      targetSide.colorMode(RGB);
    } else {
      fallingCounter += 2;
      targetSide.colorMode(RGB);
      targetSide.rectMode(CENTER);
      switch (player.mode) {
      case 1:
        targetSide.fill(255, 0, 0);
        break;

      case 2:
        targetSide.fill(0, 255, 0);
        break;

      case 3:
        targetSide.fill(0, 0, 255);
        break;
      }
      targetSide.rect(xpos+size/2, ypos+size/2, size - fallingCounter, size - fallingCounter);
      targetSide.stroke(0);
      if (fallingCounter >= 40) {
        fallingCounter = 0;
        falling = false;
      }
      targetSide.rectMode(CORNER);
    }
  }

  void display(Player players) {
    switch(side) {

    case 1:
      chooseSide(top, players);
      break;
    case 2:
      chooseSide(side1, players);
      break;
    case 3:
      chooseSide(side2, players);
      break;
    }
  }
}
