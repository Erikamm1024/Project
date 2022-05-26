class Puyo{
  color c ;
  PVector loc ; //ぷよのいる座標

  Puyo(){
    int colorNum = (int) (random(5)) ;
    switch(colorNum){
      case 0:
        c = #F71616 ;
        break ;
      case 1:
        c = #FAFF08 ;
        break ;
      case 2:
        c = #08FF53 ;
        break ;
      case 3:
        c = #C805FF ;
        break ;
      default:
        c = #08FFFD ;
    }
    loc = new PVector(width / 2.0 - 23, 235) ;
  }

  void drawPuyo(){
    pushStyle() ;
    noStroke() ;
    fill(c) ;
    ellipse(loc.x, loc.y, 50, 50) ;
    fill(255) ;
    ellipse(loc.x - 10, loc.y - 10, 15, 15) ;
    ellipse(loc.x + 10, loc.y - 10, 15, 15) ;
    fill(c) ;
    ellipse(loc.x - 10, loc.y - 10, 9, 9) ;
    ellipse(loc.x + 10, loc.y - 10, 9, 9) ;
    popStyle() ;
  }
}

class Puyopuyo extends ArrayList<Puyo>{
  Puyopuyo(){}

  void showPuyopuyo(){
    //ArrayList 内にあるぷよたちを表示する
    for(Puyo p: this){
      p.drawPuyo() ;
    }
  }

  void deletePuyo(Puyo p){
    //連鎖判定が true なら
    //連鎖して消えるぷよを ArrayList 内から削除する
    remove(p) ;
  }

  //連鎖した後にぷよが最下点に達したかどうかの判定
  void fall(){
    for(Puyo p: this){
      if(p.loc.y != 785){
        float locationY = 785 ;
        for(Puyo pu: this){
          if(p == pu) continue ;
          if(p.loc.x == pu.loc.x && p.loc.y + 50 == pu.loc.y){
            locationY = p.loc.y ;
            continue ;
          }
          if(p.loc.x == pu.loc.x && p.loc.y < pu.loc.y && locationY > pu.loc.y - 50) locationY = pu.loc.y - 50 ;
        }
        p.loc.y = locationY ;
      }
    }
  }

  //next のぷよが最下点に達したら this に追加する
  void addPuyo(Puyo p){
    add(p) ;
  }
}
