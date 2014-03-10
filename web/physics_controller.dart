import "player.dart";
import "dart:html";
import "utils/utils.dart";
import "dart:math";

class PhysicsController{
  List<Player> players;
  CanvasRenderingContext2D context;
  
  PhysicsController(this.players, this.context);
  
  void collisionCheck(){
    num width = context.canvas.width;
    num height = context.canvas.height;
    
    
    players.forEach((Player p){
      if(p.p.x - p.radius < 0 || p.p.x + p.radius > width || p.p.y - p.radius < 0 || p.p.y + p.radius > height){
        //  
        //print("collision!!");
        p.color = "#FF0000";
      }
      
      ImageData imageData = context.getImageData(p.p.x, p.p.y - p.radius, p.radius, p.radius*2);
      //context.putImageData(imageData, 10, 10);
//      imageData.data.where((int i) => i != 0).forEach((int i) {
//        print(i);
//        }
      //);
      
    });
  }
}