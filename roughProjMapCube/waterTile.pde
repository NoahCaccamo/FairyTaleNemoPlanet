class waterTile extends Tile {

  waterTile(float ixpos, float iypos, float isize, int iside) {
    xpos = ixpos;
    ypos = iypos;
    size = isize;
    side = iside;
    hue = 216;
    brightness = random(75,90);
  }
 
  
  
}
