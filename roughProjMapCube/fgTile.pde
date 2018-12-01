class fgTile extends Tile {

  fgTile(float ixpos, float iypos, float isize, int iside) {
    xpos = ixpos;
    ypos = iypos;
    size = isize;
    side = iside;
    hue = 238;
    brightness = random(24,30);
  }
 
 void chooseSide(PGraphics targetSide) {
    targetSide.colorMode(HSB, 360, 100, 100);
    targetSide.noStroke();
    targetSide.fill(hue, brightness, saturation + tempSaturation);
    targetSide.rect(xpos, ypos, size, size);
    targetSide.stroke(0);
    targetSide.colorMode(RGB);
  }
  
  
}
