class crystalTile extends bgTile {

  crystalTile(float ixpos, float iypos, float isize, int iside) {
    xpos = ixpos;
    ypos = iypos;
    size = isize;
    side = iside;
    hue = 185;
    brightness = random(43, 47);
  }

  void chooseSide(PGraphics targetSide) {
    targetSide.colorMode(HSB, 360, 100, 100);
    targetSide.noStroke();
    targetSide.fill(hue, brightness, map((saturation + tempSaturation), 0, 100, 0, 90));
    targetSide.rect(xpos, ypos, size, size);
    targetSide.stroke(0);
    targetSide.colorMode(RGB);
  }
}
