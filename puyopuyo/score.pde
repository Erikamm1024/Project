class Score{
  int totalScore ;
  int[] rensa = {0, 8, 16, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 480, 512} ;
  int[] renketsu = {0, 0, 0, 0, 2, 3, 4, 5, 6, 7, 10} ;//11 個からは連結ボーナスは 10 固定
  int[] irokazu = {0, 3, 6, 12, 24} ;
  int[] cb = {0, 0, 0, 0} ;
  Score(){
    totalScore = 0 ;
  }

  void calculateScore(ArrayList<Puyopuyo> pp){
    calculateBonus(pp) ;
    int subscore = cb[0] + cb[1] + cb[2] ;
    if(cb[0] + cb[1] + cb[2] == 0) subscore = 1 ;
    totalScore += cb[3] * subscore * 10 ;
    for(int i = 0; i < 4; i++){
      cb[i] = 0 ;
    }
  }

  void showScore(ArrayList<Puyopuyo> pp){
    //スコアを表示する
    calculateScore(pp) ;
    pushMatrix() ;
    fill(255) ;
    rect(680, 715, 200, 100) ;
    fill(0) ;
    translate(width / 2, height / 2) ;
    textSize(40) ;
    text("Score", 50 * 4, 50 * 6 - 100) ;
    textSize(50) ;
    text(totalScore, 50 * 4, 50 * 6) ;
    popMatrix() ;
  }

  void calculateBonus(ArrayList<Puyopuyo> pp){
    if(pp.size() != 0){
      ArrayList<Puyopuyo> chain = new ArrayList<Puyopuyo> () ;
      chain = (ArrayList<Puyopuyo>) pp.clone() ;
      int deleteSum = 0 ;
      //連鎖
      cb[0] += rensa[chain.size()] ;
      //連結
      for(int i = 0; i < chain.size() ; i++){
        if(chain.get(i).size() < 11){
          cb[1] += renketsu[chain.get(i).size()] ;
          deleteSum += chain.get(i).size() ;
        }
      }
      //色数
      color[] cc = new color[chain.size()] ;
      for(int i = 0; i < chain.size(); i++){
        cc[i] = chain.get(i).get(0).c ;
      }
      int count = 0 ;
      for(int i = 0; i < cc.length; i++){
        for(int j = 0; j < cc.length; j++){
          if(i == j) continue ;
          else if(cc[i] != cc[j]) count++ ;
        }
      }
      cb[2] = irokazu[count] ;
      //消した数
      cb[3] += deleteSum ;
    }
  }
  //得点計算は 1 連鎖ごとに行われ，
  //消したぷよの個数 * (連鎖ボーナス + 連結ボーナス + 色数ボーナス) * 10
  //で求める．
  //ただし，例外として (連鎖ボーナス + 連結ボーナス + 色数ボーナス) の値が 0 の時は 1 とする．
  //(つまり 0 点になるような連鎖はない)
}
