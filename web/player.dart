import 'drawable.dart';
import 'dart:html';
import 'dart:math';


class PathPoint extends Point{
  num radius;
  PathPoint(Point p, num radius) : super(p.x, p.y){
    this.radius = radius;
  }
  
}

class Player implements Drawable{
  String color;
  Point p;
  bool hasNoLine = false;
  num radius;
  num bearing = 0;
  num velocity = 2;
  List<PathPoint> path = new List<PathPoint>();
  
  Player(this.color, this.p, this.radius);
 
  
  @override
  void draw(CanvasRenderingContext2D playersContext, CanvasRenderingContext2D tailsContext) {
    //tailsContext.clearRect(0, 0, 500, 500);
// calc new position
    //playersContext.clearRect(p.x, p.y, this.radius, this.radius);
    this.p = calcNewPos();
    
 //setup
         playersContext..fillStyle = color
                ..lineJoin = "round"
                ..strokeStyle = color;
         
 //draw head
         playersContext..beginPath()
                ..arc(p.x, p.y, radius, 0, PI*2, false)
                ..fill();
         
         
         
         tailsContext..fillStyle = color
                         ..lineJoin = "round"
                         ..strokeStyle = color
                         ..beginPath()..arc(p.x, p.y, radius, 0, PI*2, false)
                                      ..fill();
    
    color = "#FFFFFF"; // reset color back to white, in case it was changed in collision check

//    // calc new position
//    this.p = calcNewPos();
//    Random r = new Random(new DateTime.now().millisecond);
//    
//    hasNoLine = r.nextInt(100) >= 80 ? true: false;
//    
//    // setup
//         context..fillStyle = color
//                ..lineJoin = "round"
//                ..strokeStyle = color;
//                
//         // draw trail      
//         context.beginPath();
//         path.forEach(
//             (PathPoint pp) {
//                  context..lineTo(pp.x, pp.y)
//                         ..lineWidth = pp.radius;
//         } 
//         );
//         context.stroke();
//         
//         // draw head
//         context..beginPath()
//                ..arc(p.x, p.y, radius, 0, PI*2, false)
//                ..fill();
//    
//    
//    if(!hasNoLine){
//      
//    
//
//    path.add(new PathPoint(this.p,this.radius));
//      
//      
//     
//      
//
//    }else{
//      
//    }
  }
  
  
  calcNewPos(){
    var rad = degToRad(bearing);
    return new Point(p.x + cos(rad)*velocity, p.y + sin(rad)*velocity);
  }
  
 
  
  num degToRad(num deg){
      return deg * (PI / 180);
    }
}