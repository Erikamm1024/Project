class Main{
  Back back ;
  Boad boad ;
  Next next ;
  Score score ;
  Puyopuyo pp ;
  Main(){
    back = new Back() ;
    boad = new Boad() ;
    next = new Next() ;
    score = new Score() ;
    pp = new Puyopuyo() ;
  }

  void show(){
    //背景を表示
    back.showBack() ;

    //ボードを表示
    boad.showBoad() ;

    //Next を表示
    next.showNext() ;

    //ぷよたちを表示
    pp.showPuyopuyo() ;
    if(next.keytouched != 0) next.key(pp) ;
    if(next.isFull(pp)){
      if(frame == 0) frame = frameCount ;
      showGameOver() ;
    }
    else{
      next.update(pp) ;
    }
    boad.updateStock(pp) ;

    //スコアを表示
    score.showScore(boad.findChains()) ;
    for(Puyopuyo p: boad.findChains()){
      for(Puyo pu: p){
        pp.deletePuyo(pu) ;
      }
    }
    pp.fall() ;
  }

  void showGameOver(){
    pushMatrix() ;
    translate(200, 400) ;
    fill(255, 0, 0) ;
    stroke(255) ;
    rect(0, 0 , 600, 200) ;
    fill(255) ;
    textSize(100) ;
    text("Game Over", 35, 125) ;
    popMatrix() ;
  }
}
