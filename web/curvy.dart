import 'dart:html';
import "player.dart";
import "dart:math";
import 'keyboard_controller.dart';

Player player;
CanvasElement canvas;
CanvasRenderingContext2D canvasRender;
KeyboardController keyboardController;

void main() {
  
  canvas = querySelector("#gameArea");
//  window.onKeyDown.listen(handleInput);
//  window.onKeyUp.listen(
//      (KeyboardEvent e) {
//    KeyEvent ke = new KeyEvent.wrap(e);
//    print("up");
//  }
//  );
//  
//  window.onKeyDown.listen(
//        (KeyboardEvent e) {
//      KeyEvent ke = new KeyEvent.wrap(e);
//      print("down");
//    }
//    );
  keyboardController = new KeyboardController();
  
  canvasRender = canvas.context2D;
  
  
  player = new Player("#FFFFFF", new Point(75, 75), 2);
  
  gameLoop(0);
}

void gameLoop(num delta){
  canvasRender.clearRect(0, 0, canvas.width, canvas.height);
  
  
  
  player.draw(canvasRender);
  player.move(0.01,0);
  //print(keyboardController.isKeyPressed(KeyCode.LEFT));
  if(keyboardController.isKeyPressed(KeyCode.LEFT)){
    player.bearing += -2;
  }
  if(keyboardController.isKeyPressed(KeyCode.RIGHT)){
      player.bearing += 2;
    }
  
  print("${player.p.x} ${player.p.y}");
  
  //player.bearing++;
  window.animationFrame.then(gameLoop);
}


void handleInput(KeyboardEvent event) {
  KeyEvent ke = new KeyEvent.wrap(event);
  switch(ke.keyCode){
    case KeyCode.LEFT:
      player.bearing += -90;
      //player.move(1, 1-cos(Utils.degToRad(80)));
      break;
    case KeyCode.RIGHT:
      player.bearing += 90;
      break;
  }
  
  
}

