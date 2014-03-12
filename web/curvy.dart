import 'dart:html';
import "player.dart";
import "dart:math";
import 'keyboard_controller.dart';
import "physics_controller.dart";

CanvasElement backgroundCanvas;
CanvasElement playersCanvas;
CanvasRenderingContext2D backgroundCanvasContext;
CanvasRenderingContext2D playersCanvasContext;
KeyboardController keyboardController;
PhysicsController physicsController;
num previousDelta = -1;
List<Player> players = new List();
Player player1;
Player player2;

void main() {
  
  backgroundCanvas = querySelector("#background");
  backgroundCanvas..width = 500
                  ..height = 500;
  
  playersCanvas = querySelector("#players");
  playersCanvas..width = 500
               ..height = 500;
  playersCanvasContext = playersCanvas.context2D;

  backgroundCanvasContext = backgroundCanvas.context2D;
  
  
  keyboardController = new KeyboardController();
  physicsController = new PhysicsController(players, backgroundCanvasContext);
  
//  for(int i = 0; i< 80; i++){
//    for(int j = 0; j< 80; j++){
//    players.add(new Player("#${i*j*100}",new Point(i*5,j*5),2));
//    }
//  }
  
  
  player1 = new Player("#FFFFFF", new Point(playersCanvas.width /2, playersCanvas.height/2), 5);
  player2 = new Player("#FFFF00", new Point(playersCanvas.width /3, playersCanvas.height/3), 5);
  players.add(player1);
  //players.add(player2);
  
  gameLoop(0);
  
  
  
}

void gameLoop(num delta){
  // clear canvas
  playersCanvasContext.clearRect(0, 0, backgroundCanvas.width, backgroundCanvas.height);
  //backgroundCanvasContext.clearRect(0, 0, backgroundCanvas.width, backgroundCanvas.height);
  //showFPS(backgroundCanvasContext, delta - previousDelta);
  previousDelta = delta;
  
  
  num bearing = 5;
  
  if(keyboardController.isKeyPressed(KeyCode.LEFT)){
    player1.changeDirection(-bearing);
    }
  if(keyboardController.isKeyPressed(KeyCode.RIGHT)){
    player1.changeDirection(bearing);
    }
  if(keyboardController.isKeyPressed(KeyCode.A)){
    player2.changeDirection(-bearing);
    }
  if(keyboardController.isKeyPressed(KeyCode.D)){
    player2.changeDirection(bearing);
    }
    
  physicsController.collisionCheck();
  players.forEach((Player player){
      player.draw(playersCanvasContext, backgroundCanvasContext);
    });
  
    
    players.forEach((Player player){
        player.drawTail(backgroundCanvasContext);
      });
  
  
  
  
  
  
  window.animationFrame.then(gameLoop);
}

void showFPS(CanvasRenderingContext2D context, num timeTaken){
  context..fillStyle = "#FFFF00"
         ..font = "20pt Helvetica"
         ..fillText("${(1000 / timeTaken).round()}", backgroundCanvas.width * 0.90, backgroundCanvas.height * 0.05)
         ..fill();
}