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
  num oldBearing = -1;
  num velocity = 1;
  List<PathPoint> path = new List<PathPoint>();
  num dx = 0;
  num dy = 0;
  
  Player(this.color, this.p, this.radius);
  
  void changeDirection(num diffDegrees){
    oldBearing = bearing;
    bearing += diffDegrees;
  }
  
  void drawTail(CanvasRenderingContext2D tailsContext){
    num test = sqrt(this.dx * this.dx + this.dy * this.dy);
        
        if(test  > this.radius*2 ){
          
         this.dx = 0;
         this.dy = 0;
          
         //setup
         tailsContext
                ..lineJoin = "round"
                ..strokeStyle = color;
         
        // draw trail      
        tailsContext..beginPath();
        
        Iterable test = path.where((PathPoint pp) => pp != path.last);
        
        test.forEach(
            (PathPoint pp) {
                 tailsContext..lineTo(pp.x, pp.y)
                        ..lineWidth = pp.radius;
        } 
        );
        
        tailsContext.stroke();
          
        }
  }
 
  
  @override
  void draw(CanvasRenderingContext2D playersContext, CanvasRenderingContext2D tailsContext) {
    this.p = calcNewPos();
    
// if direction change was made, add point to list
if(oldBearing != bearing){
path.add(new PathPoint(this.p, this.radius));
}
    
    
    
       //setup
       playersContext..fillStyle = color
              ..lineJoin = "round"
              ..strokeStyle = color;
       
       
       
       //draw head
       playersContext..beginPath()
              ..arc(p.x, p.y, radius, 0, PI*2, false)
              ..closePath()
              ..fill();
       
       // tegn trail forskudt
       var rad = degToRad(bearing);
       
       playersContext..beginPath()
                     ..fillStyle = "#00FFFF"
                     //..rect(p.x + radius*cos(rad), p.y + radius*sin(rad), radius/2, radius/2)
                     ..arc(p.x, p.y, radius, rad - PI/2, rad + PI/2, false)
                     ..fill();
       
       
       
       
       
    
    //color = "#FFFF00"; // reset color back to white, in case it was changed in collision check
    

  }
  
  
  calcNewPos(){
    
    var rad = degToRad(bearing);
    num newX = p.x + cos(rad)*velocity;
    num newY = p.y + sin(rad)*velocity;
    this.dx += (this.p.x - newX).abs();
    this.dy += (this.p.y - newY).abs();
    return new Point(newX, newY);
  }
  
 
  
  num degToRad(num deg){
      return deg * (PI / 180);
    }
}