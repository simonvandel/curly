import 'dart:html';
import "player.dart";
import "dart:math";
import 'keyboard_controller.dart';
import "physics_controller.dart";
import "powerup.dart" show Powerup;
import 'shrink_powerup.dart';
import 'drawable.dart';

CanvasElement tailsCanvas;
CanvasElement playersCanvas;
CanvasElement powerupCanvas;
CanvasRenderingContext2D tailsCanvasContext;
CanvasRenderingContext2D playersCanvasContext;
CanvasRenderingContext2D powerupCanvasContext;
KeyboardController keyboardController;
PhysicsController physicsController;
num previousDelta = -1;
List<Player> players = new List();
Player player1;
Player player2;

List<Powerup> powerups = new List();
List<Drawable> drawables = new List();

void main() {

  tailsCanvas = querySelector("#tails");
  tailsCanvas
      ..width = 500
      ..height = 500;
  tailsCanvasContext = tailsCanvas.context2D;

  playersCanvas = querySelector("#players");
  playersCanvas
      ..width = 500
      ..height = 500;
  playersCanvasContext = playersCanvas.context2D;
  
  powerupCanvas = querySelector("#powerups");
    powerupCanvas
        ..width = 500
        ..height = 500;
    powerupCanvasContext = powerupCanvas.context2D;


  keyboardController = new KeyboardController();
  physicsController = new PhysicsController(players, powerups, tailsCanvasContext);


  player1 = new Player("#FFFFFF", new Point(playersCanvas.width / 2,
      playersCanvas.height / 2), 5);
  player2 = new Player("#FFFF00", new Point(playersCanvas.width / 3,
      playersCanvas.height / 3), 5);
  players.add(player1);
  //players.add(player2);

  powerups.add(new ShrinkPowerup(new Point(50,50),20));

  //player1.noTail(1500);
  //player2.noTail(1500);
  
  drawables.addAll(players);
  drawables.addAll(powerups);


  gameLoop(0);

  /* TODO:
     - Random player position ved start
     - Powerups - start ved tyk
     - huller i tail
  */
}

void gameLoop(num delta) {
  // clear canvas
  playersCanvasContext.clearRect(0, 0, tailsCanvas.width, tailsCanvas.height);
  powerupCanvasContext.clearRect(0, 0, powerupCanvas.width, powerupCanvas.height);
  tailsCanvasContext.clearRect(0, 0, tailsCanvas.width, tailsCanvas.height);
  //showFPS(backgroundCanvasContext, delta - previousDelta);
  previousDelta = delta;
  
  Random random = new Random();
  
  


  num bearing = 3;

  if (keyboardController.isKeyPressed(KeyCode.LEFT)) {
    player1.changeDirection(-bearing);
  }
  if (keyboardController.isKeyPressed(KeyCode.RIGHT)) {
    player1.changeDirection(bearing);
  }
  if (keyboardController.isKeyPressed(KeyCode.A)) {
    player2.changeDirection(-bearing);
  }
  if (keyboardController.isKeyPressed(KeyCode.D)) {
    player2.changeDirection(bearing);
  }
  

  
  
  powerups.forEach((Powerup powerup){
    powerup.draw(powerupCanvasContext, null);
  });
  
  
  players.forEach((Player player) {
    if(random.nextInt(100) == 0){
        //player.noTail(1000);
      }
    player.draw(playersCanvasContext, tailsCanvasContext);
  });
  
  physicsController.collisionCheck();

  window.animationFrame.then(gameLoop);
}

void showFPS(CanvasRenderingContext2D context, num timeTaken) {
  context
      ..fillStyle = "#FFFF00"
      ..font = "20pt Helvetica"
      ..fillText("${(1000 / timeTaken).round()}", tailsCanvas.width * 0.90,
          tailsCanvas.height * 0.05)
      ..fill();
}
