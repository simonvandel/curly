library test;
import 'dart:math';
import 'dart:html';


class Utils{
  static num degToRad(num deg){
    return deg * (PI / 180);
  }
  static num distance(Point A, Point B){
    return sqrt(pow((B.x-A.x),2) + pow((B.y-A.y),2));
  }
  static void drawCircle(CanvasRenderingContext2D context, Point p, String color, num radius){
    //setup
  context
      ..fillStyle = color
      ..lineJoin = "round"
      ..strokeStyle = color;



  //draw head
  context
      ..beginPath()
      ..arc(p.x, p.y, radius, 0, PI * 2, false)
      ..closePath()
      ..fill();
  }
}