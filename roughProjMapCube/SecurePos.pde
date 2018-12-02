PVector securePos(float minPosX, float maxPosX, float minPosY, float maxPosY, float minDist, int iterationCount) {
  float tempRandomX = random(minPosX, maxPosX);
  float tempRandomY = random(minPosY, maxPosY);
  boolean regen = false;
  int counter = iterationCount;
  
  counter++;
  
for(int i=0; i < players.size(); i++){
   Player getPlayer = players.get(i);
   if (dist(tempRandomX, tempRandomY, getPlayer.xpos, getPlayer.ypos) >= minDist) {
  }else {
   regen = true; 
  }
}
if (counter > 500) {
 return new PVector(0,0); 
}
  if (regen == false) {
    return new PVector(tempRandomX, tempRandomY);
  } else{
    return securePos(minPosX, maxPosX, minPosY, maxPosY, minDist, counter);
  }
}

PVector securePos2(float minPosX, float maxPosX, float minPosY, float maxPosY, float minDist, int iterationCount) {
  float tempRandomX = random(minPosX, maxPosX);
  float tempRandomY = random(minPosY, maxPosY);
  boolean regen = false;
  int counter = iterationCount;
  
  counter++;
  
for(int i=0; i < players2.size(); i++){
   Player getPlayer = players2.get(i);
   if (dist(tempRandomX, tempRandomY, getPlayer.xpos, getPlayer.ypos) >= minDist) {
  }else {
   regen = true; 
  }
}
  if (regen == false || counter <= 500) {
    return new PVector(tempRandomX, tempRandomY);
  } else{
    return securePos(minPosX, maxPosX, minPosY, maxPosY, minDist, counter);
  }
}

PVector securePos3(float minPosX, float maxPosX, float minPosY, float maxPosY, float minDist, int iterationCount) {
  float tempRandomX = random(minPosX, maxPosX);
  float tempRandomY = random(minPosY, maxPosY);
  boolean regen = false;
  int counter = iterationCount;
  
  counter++;
  
for(int i=0; i < players3.size(); i++){
   Player getPlayer = players3.get(i);
   if (dist(tempRandomX, tempRandomY, getPlayer.xpos, getPlayer.ypos) >= minDist) {
  }else {
   regen = true; 
  }
}
  if (regen == false || counter <= 500) {
    return new PVector(tempRandomX, tempRandomY);
  } else{
    return securePos(minPosX, maxPosX, minPosY, maxPosY, minDist, counter);
  }
}
