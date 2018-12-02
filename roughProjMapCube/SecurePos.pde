PVector securePos(float minPosX, float maxPosX, float minPosY, float maxPosY, float minDist) {
  float tempRandomX = random(minPosX, maxPosX);
  float tempRandomY = random(minPosY, maxPosY);
  boolean regen = false;
  
for(int i=0; i < players.size(); i++){
   Player getPlayer = players.get(i);
   if (dist(tempRandomX, tempRandomY, getPlayer.xpos, getPlayer.ypos) >= minDist) {
  }else {
   regen = true; 
  }
}
  if (regen == false) {
    return new PVector(tempRandomX, tempRandomY);
  } else {
    return securePos(minPosX, maxPosX, minPosY, maxPosY, minDist);
  }
}
