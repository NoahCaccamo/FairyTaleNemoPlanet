class bgTile extends Tile {

  bgTile(){}
  bgTile(float ixpos, float iypos, float isize, int iside) {
    xpos = ixpos;
    ypos = iypos;
    size = isize;
    side = iside;
    hue = 341;
    brightness = random(13,15);
  }
  
    void chooseSide(PGraphics targetSide) {
    targetSide.colorMode(HSB, 360, 100, 100);
    targetSide.noStroke();
    targetSide.fill(hue, brightness, map((saturation + tempSaturation),0,100,0,50));
    targetSide.rect(xpos, ypos, size, size);
    targetSide.stroke(0);
    targetSide.colorMode(RGB);
  }
 
  
  
}
