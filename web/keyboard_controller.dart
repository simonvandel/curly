import "dart:html";

class KeyboardController{
  Map<int,bool> pressed = new Map<int,bool>();
  
  KeyboardController(){
    window.onKeyUp.listen(
          (KeyboardEvent e) {
        up(new KeyEvent.wrap(e));
        }
    );
    
    window.onKeyDown.listen(
              (KeyboardEvent e) {
            down(new KeyEvent.wrap(e));
            }
        );
  }
  
  bool isKeyPressed(int keyCode){
    bool state = pressed[keyCode];
    if(state != null){
      return state;
    }else{
      return false;
    }
  }
  
  void up(KeyEvent e){
    pressed[e.keyCode] = false;
  }
  
  void down(KeyEvent e){
    pressed[e.keyCode] = true;
  }
}
