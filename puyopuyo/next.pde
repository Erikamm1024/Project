class Next extends ArrayList<Puyo>{
  int keytouched ; //どのキーボードを押したかを入れる変数
  int locNum; //ぷよを回転させる時に使用するカウンタ

  //初期状態の時点で next のぷよは 6 つ生成されているため，コンストラクタに入れる
  Next(){
    for(int i = 0; i < 6; i++){
      //0個目，1個目のぷよは上から落ちてくる
      add(new Puyo()) ;
      if(i == 1) get(1).loc.y = get(0).loc.y + 50 ;
      //2 〜　5 個目のぷよは Next の枠内で待機
      if(i >= 2) {
        get(i).loc.x = 800 ;
        if(i <= 3) get(i).loc.y = 100 + 60 * i ;
        else get(i).loc.y = 125 + 60 * i ;
      }
    }
    keytouched = 0 ;
    locNum = 0 ;
  }
  void showNext(){
    //次に落ちてくるぷよを表示
    fill(0) ;
    textSize(40) ;
    text("Next", 700, 150) ;
    fill(255) ;
    rect(700, 170, 200, 300) ;
    for(int i = 0; i < 6; i++){
      get(i).drawPuyo() ;
    }
  }
  void makeNewNext(){//次に落ちてくるぷよを乱数で生成し，自身に加える
    for(int i = 0; i < 2; i++){
      Puyo p = new Puyo() ;
      p.loc.x = 800 ;
      p.loc.y = 125 + 60 * (i + 4) ;
      add(p) ;
    }
  }

  void update(Puyopuyo pp){
    if(frameCount % 30 == 0){
      if(!isFall(pp)){
        for(int i = 0; i < 2; i++) get(i).loc.y += 25 ;//下へ
      }
      else{
        for(int i = 0; i < 2; i++) pp.addPuyo(remove(0)) ;
        makeNewNext() ;
        get(0).loc = new PVector(width / 2.0 - 23, 235) ;
        get(1).loc = new PVector(width / 2.0 - 23, get(0).loc.y + 50) ;
        get(2).loc.y -= 145 ;
        get(3).loc.y -= 145 ;
        locNum = 0 ;
      }
    }
  }

  boolean isFall(Puyopuyo pp){
    //もし他のぷよの上に落ちきったら true
    for(Puyo p: pp){
      if(p.loc.x == get(0).loc.x || p.loc.x == get(1).loc.x){
        if(p.loc.y - 50 == get(0).loc.y || p.loc.y - 50 == get(1).loc.y){
          float locationY = 785 ;
          if(p.loc.x == get(1).loc.x){
            for(Puyo pu: pp){
              if(get(0).loc.x == pu.loc.x && locationY > pu.loc.y - 50) locationY = pu.loc.y - 50 ;
            }
            if(get(0).loc.x == get(1).loc.x && get(0).loc.y < get(1).loc.y) locationY = get(1).loc.y - 50 ;
            get(0).loc.y = locationY ;
          }
          locationY = 785 ;
          if(p.loc.x == get(0).loc.x){
            for(Puyo pu: pp){
              if(p.loc.x == get(0).loc.x){
                if(get(1).loc.x == pu.loc.x && locationY > pu.loc.y - 50) locationY = pu.loc.y - 50 ;
              }
            }
            if(get(0).loc.x == get(1).loc.x && get(0).loc.y > get(1).loc.y) locationY = get(0).loc.y - 50 ;
            get(1).loc.y = locationY ;
          }
          return true ;
        }
      }
    }
    //Boad の最下点に達したら true
    if(get(0).loc.y >= 770 || get(1).loc.y >= 770) return true ;
    return false ;
  }

  //Boad の上部に達したかどうかを判定する
  boolean isFull(Puyopuyo pp){
    if(isFall(pp) && get(0).loc.y == 235) return true ;
    else return false ;
  }

  //キーボード操作
  void key(Puyopuyo pp){
    boolean b = true ;
    if(keytouched == 1){
      for(Puyo p: pp){
        if((get(0).loc.y + 25 >= p.loc.y || get(1).loc.y + 25 >= p.loc.y) && (get(0).loc.x + 50 >= p.loc.x || get(1).loc.x + 50 >= p.loc.x)){
          b = false ;
          break ;
        }
      }
      if(b && get(0).loc.x < 625 && get(1).loc.x < 625){
        for(int i = 0;i < 2; i++){
          get(i).loc.x += 50 ;//右へ
        }
      }
      keytouched = 0 ;
    }
    if(keytouched == 2){
      for(Puyo p: pp){
        if((get(0).loc.y + 25 >= p.loc.y || get(1).loc.y + 25 >= p.loc.y) && (get(0).loc.x - 50 <= p.loc.x || get(1).loc.x - 50 <= p.loc.x)){
          b = false ;
          break ;
        }
      }
      if(b && get(0).loc.x > 425 && get(1).loc.x > 425){
        for(int i = 0; i < 2; i++){
          get(i).loc.x -= 50 ;//左へ
        }
      }
      keytouched = 0 ;
    }
    if(keytouched == 3){
      if(!isFall(pp)){
        for(int i = 0; i < 2; i++){
          get(i).loc.y += 25 ;
        }
      }
      keytouched = 0 ;
    }
    if(keytouched == 4){//回転
      switch(locNum % 4){
        //上から右
        case 0:
         if(get(0).loc.x + 50 <= 650){
           get(0).loc.x += 50 ;
           get(0).loc.y += 50 ;
           locNum++ ;
         }
         break ;
         //右から下
         case 1:
          get(0).loc.x -= 50 ;
          get(0).loc.y += 50 ;
          locNum++ ;
          break ;
          //下から左
          case 2:
           if(get(0).loc.x - 50 >= 350){
             get(0).loc.x -= 50 ;
             get(0).loc.y -= 50 ;
             locNum++ ;
           }
           break ;
           //左から上
           case 3:
            get(0).loc.x += 50 ;
            get(0).loc.y -= 50 ;
            locNum++ ;
            break ;
      }
      keytouched = 0 ;
    }
  }
}
