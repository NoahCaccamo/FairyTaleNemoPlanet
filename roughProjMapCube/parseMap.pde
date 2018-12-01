void setLegend () {
  for (int x=0; x < legend.width; x += 1) {

    int tileColor = legend.get(x, 0);
    switch(x) {
    case 0:
      tileNum = tileColor;
      break;

    case 1:
      waterTileNum = tileColor;
      break;

    case 2:
      crystalTileNum = tileColor;
      break;

    case 3:
      platformTileNum = tileColor;
      break;

    case 4:
      fgTileNum = tileColor;
      break;

    case 5:
      bgTileNum = tileColor;
      break;

    case 6:
      mushroomTileNum = tileColor;
      break;
      
      case 7:
      pitfallTileNum = tileColor;
      break;
    }
  }
}

  void parseMap (PImage map, int side) {
  for (int y=0; y < topSize/tileSize; y += 1) {
    for (int x=0; x < topSize/tileSize; x += 1) {

      int tileColor = map.get(x, y);
      if (tileColor == tileNum) {
        if (side == 1) {
          tiles.add(new Tile(x*tileSize, y*tileSize, tileSize, side));
        }else if (side == 4) {
          secondTiles.add(new Tile(x*tileSize, y*tileSize, tileSize, side));
        }
      } else if (tileColor == waterTileNum) {
        if (side == 1) {
          waterTiles.add(new waterTile(x*tileSize, y*tileSize, tileSize, side));
        }
      } else if (tileColor == platformTileNum) {
        if (side == 2) {
          Ptiles.add(new PlatformTile(x*tileSize, y*tileSize, tileSize, side));
        } else if (side == 3) {
          PtilesSide2.add(new PlatformTile(x*tileSize, y*tileSize, tileSize, side));
        }
      } else if (tileColor == fgTileNum) {
        if (side == 2) {
          fgTiles.add(new fgTile(x*tileSize, y*tileSize, tileSize, side));
        } else if (side == 3) {
          //ADD FGTILES TO SIDE 2
        }
      } else if (tileColor == bgTileNum) {
        if (side == 2) {
          bgTiles.add(new bgTile(x*tileSize, y*tileSize, tileSize, side));
        } else if (side == 3) {
          bgTilesSide2.add(new bgTile(x*tileSize, y*tileSize, tileSize, side));
        }
      } else if (tileColor == crystalTileNum) {
        if (side == 3) {
          crystalTiles.add(new crystalTile(x*tileSize, y*tileSize, tileSize, side));
        }
      } else if (tileColor == mushroomTileNum) {
        if (side == 3) {
          mushroomTiles.add(new mushroomTile(x*tileSize, y*tileSize, tileSize, side));
        }
      }else if (tileColor == pitfallTileNum) {

        pitfallTiles.add(new pitfallTile(x*tileSize, y*tileSize, tileSize, side));
       
      }
    }
  }
  PtilesSide2.add(new PlatformTile(-40, 480, tileSize, side));
  PtilesSide2.add(new PlatformTile(-40, 720, tileSize, side));
}
