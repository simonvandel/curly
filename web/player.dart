library curvy;
import 'drawable.dart';
import 'dart:html';
import 'dart:math';
import "utils/utils.dart";
import 'dart:async';


class PathPoint extends Point {
  num radius;
  PathPoint(Point p, num radius): super(p.x, p.y) {
    this.radius = radius;
  }

}

class Player implements Drawable {
  String color;
  Point p;
  bool hasNoLine = false;
  num radius;
  num bearing = 0;
  num oldBearing = -1;
  num velocity = 2;
  List<PathPoint> path = new List<PathPoint>();
  num dx = 0;
  num dy = 0;

  Player(this.color, this.p, this.radius);

  void changeDirection(num diffDegrees) {
    oldBearing = bearing;
    bearing += diffDegrees;
  }

  void drawTail(CanvasRenderingContext2D tailsContext) {

    this.dx = 0;
    this.dy = 0;

    //setup
    tailsContext
        ..lineJoin = "round"
        ..strokeStyle = color;

    // draw trail
    tailsContext..beginPath();

    path.forEach((PathPoint pp) {
      tailsContext
          ..lineTo(pp.x, pp.y)
          ..lineWidth = pp.radius;
    });

    tailsContext.stroke();
  }


  @override
  void draw(CanvasRenderingContext2D playersContext, CanvasRenderingContext2D
      tailsContext) {
    this.p = calcNewPos();


    if (!hasNoLine) {



      // if direction change was made, add point to list
      if (oldBearing != bearing) {
        path.add(new PathPoint(this.p, this.radius));
      }

      drawTail(tailsContext);





      //color = "#FFFF00"; // reset color back to white, in case it was changed in collision check
    }

//    //setup
//    playersContext
//        ..fillStyle = color
//        ..lineJoin = "round"
//        ..strokeStyle = color;
//
//
//
//    //draw head
//    playersContext
//        ..beginPath()
//        ..arc(p.x, p.y, radius, 0, PI * 2, false)
//        ..closePath()
//        ..fill();
    
    Utils.drawCircle(playersContext, this.p, this.color, this.radius);

    // tegn trail forskudt
    var rad = Utils.degToRad(bearing);

    playersContext
        ..beginPath()
        ..fillStyle = "#00FFFF"
        ..arc(p.x, p.y, radius, rad - PI / 2, rad + PI / 2, false)
        ..fill();

  }


  calcNewPos() {

    var rad = Utils.degToRad(bearing);
    num newX = p.x + cos(rad) * velocity;
    num newY = p.y + sin(rad) * velocity;
    this.dx += (this.p.x - newX).abs();
    this.dy += (this.p.y - newY).abs();
    return new Point(newX, newY);
  }

  noTail(int milliseconds) {
    this.hasNoLine = true;

    new Future.delayed(new Duration(milliseconds: milliseconds), () {
      this.hasNoLine = false;
    });
  }
}
