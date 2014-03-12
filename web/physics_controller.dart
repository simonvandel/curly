import "player.dart";
import "dart:html";
import "utils/utils.dart" show Utils;
import "dart:math";

class PhysicsController{
  List<Player> players;
  CanvasRenderingContext2D context;
  
  PhysicsController(this.players, this.context);
  
  void collisionCheck(){
    num width = context.canvas.width;
    num height = context.canvas.height;
    
    
    
    players.forEach((Player p){
      // check wall
      if(p.p.x - p.radius < 0 || p.p.x + p.radius > width || p.p.y - p.radius < 0 || p.p.y + p.radius > height){
        //  
        //print("collision!!");
        p.color = "#FF0000"; 
      }
      
      var rad = Utils.degToRad(p.bearing);
      
      ImageData imageData = context.getImageData(p.p.x + p.radius*cos(rad), p.p.y + p.radius*sin(rad), p.radius/2, p.radius/2);
      context.putImageData(imageData, 0, 0);
      imageData.data.where((int i) => i != 0).forEach((int i) {
        p.color = "#FF0000";
        }
      );
      
//      p.path.where((PathPoint pp) => (pp.x as num).round() == p.p.x && (pp.y as num).round() == p.p.y)
//        .forEach((PathPoint pp) => print("x:${p.p.x as num} y: ${p.p.y as num}\n px:${pp.x as num} py: ${pp.y as num}"));
      
      PathPoint prev;
      
      
      
      Iterable test = p.path.where((PathPoint pp) => (p.path.last.x  != pp.x) && (p.path.last.y  != pp.y));
      
      for (PathPoint pp in p.path){
        if((p.p.x != p.path.last.x) && (p.p.y != p.path.last.y)){
          if(prev != null && (pp.x.round() != p.p.x.round() && pp.y.round() != p.p.y.round() ) ){
            if(isBetween(prev, pp, p.p)) 
              p.color = "#00FF00";
          }
          prev = pp;
        }
      }
    });
  }
  
  bool isBetween(PathPoint a, PathPoint b, Point c){
    num crossproduct = (c.y - a.y) * (b.x - a.x) - (c.x - a.x) * (b.y - a.y);
    if(crossproduct.abs() < 0.0001) return false;
    
    num dotproduct = (c.x - a.x) * (b.x - a.x) + (c.y - a.y)*(b.y - a.y);
    if (dotproduct < 0) return false;
    
    num squaredlengthba = (b.x - a.x)*(b.x - a.x) + (b.y - a.y)*(b.y - a.y);
    if (dotproduct > squaredlengthba) return false;

    return true;
  }
}