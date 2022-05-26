class Game{
  Title titleScreen ;
  Main mainScreen ;
  Result resultScreen ;
  boolean touched ; //mousePressed されたかどうかを入れる変数
  Game(){
    touched = false ;
    titleScreen = new Title() ;
    mainScreen = new Main() ;
    resultScreen = new Result() ;
  }

  //タイトルを表示
  void showTitle(){
    titleScreen.showTitle() ;
  }

  //メインのゲーム画面を表示
  void showMain(){
    mainScreen.show() ;
  }

  void showGame(){
    if(!touched){
      touched = isTouched() ;
      titleScreen.showTitle() ;
    }
    else if(frame != 0 && frameCount > frame + 100){
      resultScreen.show(mainScreen.score.totalScore) ;
    }
    else{
      mainScreen.show() ;
    }
  }

  boolean isTouched(){
    return mousePressed ;
  }
}
