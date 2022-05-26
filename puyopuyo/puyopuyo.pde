Game game;
int frame ;

void setup(){
  size(1000, 1000) ;
  game = new Game() ;
  frame = 0 ;
}

void draw(){
  game.showGame() ;
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == RIGHT){
      game.mainScreen.next.keytouched = 1 ;
    }
    if(keyCode == LEFT){
      game.mainScreen.next.keytouched = 2 ;
    }
    if(keyCode == DOWN){
      game.mainScreen.next.keytouched = 3 ;
    }
    if(keyCode == UP){
      game.mainScreen.next.keytouched = 4 ;
    }
  }
}
