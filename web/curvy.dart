import 'dart:html';
import "player.dart";
import "dart:math";

Player player;
CanvasElement canvas;
CanvasRenderingContext2D canvasRender;

void main() {
  
  canvas = querySelector("#gameArea");
  window.onKeyDown.listen(handleInput);
  
  canvasRender = canvas.context2D;
  
  
  player = new Player("#FFFFFF", new Point(75, 75), 2);
  
  gameLoop(0);
}

void gameLoop(num delta){
  canvasRender.clearRect(0, 0, canvas.width, canvas.height);
  
  
  player.draw(canvasRender);
  player.move(0.1,0);
  //player.bearing++;
  window.animationFrame.then(gameLoop);
}


void handleInput(KeyboardEvent event) {
  KeyEvent ke = new KeyEvent.wrap(event);
  switch(ke.keyCode){
    case KeyCode.LEFT:
      player.bearing += 10;
      //player.move(1, 1-cos(Utils.degToRad(80)));
      break;
    case KeyCode.RIGHT:
      player.bearing += -10;
      break;
  }
  
  
}
