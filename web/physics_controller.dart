import "player.dart";
import "powerup.dart";
import "dart:html";
import "utils/utils.dart" show Utils;
import "dart:math";

class PhysicsController {
  List<Player> players;
  List<Powerup> powerups;
  CanvasRenderingContext2D context;

  num _width;
  num _height;

  PhysicsController(this.players, this.powerups, this.context) {
    _width = context.canvas.width;
    _height = context.canvas.height;
  }

  bool wallCollision(Player p) {
    return p.p.x - p.radius < 0 || p.p.x + p.radius > _width || p.p.y - p.radius
        < 0 || p.p.y + p.radius > _height;
  }

  bool playerCollision(Player p) {
    var rad = Utils.degToRad(p.bearing);

    ImageData imageData = context.getImageData(p.p.x + p.radius * cos(rad),
        p.p.y + p.radius * sin(rad), p.radius / 2, p.radius / 2);
    context.putImageData(imageData, 10, 10);

    
    num pixelCollision = 0;
    
    for(int i = 0; i < imageData.data.length; i++){
      // only take red pixel
      if(i % 4 != 0) continue;
      
      if (imageData.data.elementAt(i) != 0) pixelCollision++;
    }
    // have a error margin of 1 pixel: only conclude collision when more than 1 pixel is marked
    return pixelCollision > 1;
  }

  void collisionCheck() {
    players.forEach((Player p) {
      if (wallCollision(p)) p.color = "#FF0000";
      if (playerCollision(p)) p.color = "#FF0000";
      
      Powerup powerup = powerupCollision(p);
      if (powerup != null) powerup.effect(p);
    });
  }
  
  Powerup powerupCollision(Player p) {
    for(Powerup powerup in powerups){
      if (Utils.distance(p.p, powerup.p) < powerup.radius){
        powerups.remove(powerup);
        return powerup;
      }
    }
    return null;
  }

}
