class TitlePuyo{
  PVector loc ;
  PVector vel ;
  color c ;
  float r ;
  TitlePuyo(){
    loc = new PVector(random(width), 0) ;
    vel = new PVector(0, random(5, 10)) ;
    r = 10;
    c = setRandom() ;
  }

  color setRandom(){
    color c;
    switch((int) random(5)){
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
    return c ;
  }

  void move(){
    loc.add(vel) ;
  }

  void showPuyo(){
    move() ;
    noFill() ;
    rect(loc.x - r, loc.y - r, 2 * r, 2 * r) ;
    fill(c) ;
    pushStyle() ;
    arc(loc.x, loc.y, r * 2, r * 2, 0, PI) ;
    popStyle() ;
    pushStyle() ;
    arc(loc.x, loc.y, r * 2, r * 2, PI, TWO_PI) ;
    popStyle() ;

    pushStyle() ;
    pushMatrix() ;
    translate(loc.x, loc.y) ;
    noStroke() ;
    fill(c) ;
    ellipse(0, 0, 200, 200) ;
    fill(255) ;
    ellipse(-40, -40, 60, 60) ;
    ellipse(40, -40, 60, 60) ;
    fill(c) ;
    ellipse(-40, -40, 36, 36) ;
    ellipse(40, -40, 36, 36) ;
    popMatrix() ;
    popStyle() ;
  }
}

class TitlePuyos extends ArrayList<TitlePuyo>{
  TitlePuyos(){}
}
