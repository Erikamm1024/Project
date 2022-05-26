class Result{
  Title t ;
  Result(){
    t = new Title() ;
  }

  void show(int score){
    t.showTitle() ;
    fill(255) ;
    rect(0, 100, 1000, 700) ;
    fill(0) ;
    textSize(100) ;
    text("Your score is...", 100, 200) ;
    textSize(200) ;
    text(score, 100, 600) ;
  }
}
