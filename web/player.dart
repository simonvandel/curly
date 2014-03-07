import 'drawable.dart';
import 'dart:html';
import 'dart:math';

class Player implements Drawable{
  String color;
  Point p;
  num radius;
  num bearing = 0;
  
  Player(this.color, this.p, this.radius);
 
  
  @override
  void draw(CanvasRenderingContext2D context) {
    this.p = calcNewPos();
    context..beginPath()
           ..arc(p.x, p.y, radius, 0, PI*2, false)
           ..closePath()
           ..lineWidth = 0.5
           ..fillStyle = color
           ..fill();
  }
  
  
  calcNewPos(){
    var rad = degToRad(bearing);
    return new Point(p.x + cos(rad), p.y + sin(rad));
  }
  
  move(num x, num y) {
    p = new Point(p.x + x, p.y + y);
  }
  
  num degToRad(num deg){
      return deg * (PI / 180);
    }
}