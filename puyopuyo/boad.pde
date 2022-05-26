class Boad{
  Puyo[][] stock ; //現在のぷよを二次元配列として保存
  int cellLength ;
  PVector upperLeft ;
  Puyopuyo puyos ;
  Boad(){
    cellLength = 50 ;
    upperLeft = new PVector(0, 0) ;
    stock = new Puyo[12][6];
  }

  //ぷよの情報を二次元配列にする
  void updateStock(Puyopuyo pys){
    puyos = pys ;
    stock = new Puyo[12][6] ;
    for(int i = 0; i < stock.length; i++){
      for(int j = 0; j < stock[i].length; j++){
        stock[i][j] = null ;
      }
    }
  }

  //ボードを表示する
  void showBoad(){
    pushMatrix() ;
    translate(width / 2, height / 2) ;
    fill(200) ;
    noStroke() ;
    rect(-cellLength * 3, -cellLength * 6, 300, 600) ;
    noFill() ;
    stroke(255) ;
    strokeWeight(5) ;
    for(int i = 0; i < 6; i++){
      for(int j = 0; j < 12; j++){
        pushMatrix() ;
        translate(-cellLength * 3, -cellLength * 6) ;
        rect(i + cellLength * i, j + cellLength * j, cellLength, cellLength) ;
        popMatrix() ;
      }
    }
    stroke(0) ;
    pushMatrix() ;
    scale(1.1) ;
    rect(-cellLength * 3, -cellLength * 6, 300, 600) ;
    popMatrix() ;
    popMatrix() ;
  }

  Graph makeGraph(){
    for(Puyo p: puyos){
      //ぷよの座標（連続値）から，どのマスにいるか（離散値）を元も
      //stock 配列を作成する
      float xpos = (int) (p.loc.x - (width / 2.0 - 3 * cellLength) - cellLength / 2.0) / cellLength ;
      float ypos = (int) (p.loc.y - (height / 2.0 - 6 * cellLength) - cellLength / 2.0 ) / cellLength ;
      stock[(int) ypos][(int) xpos] = p ;
    }

    int[][] adjMatrix = new int[12 * 6][12 * 6] ;
    for(int i = 0; i < stock.length; i++){
      for(int j = 0; j < stock[i].length; j++){
        int index = i * 6 + j ;
        if(stock[i][j] != null){
          if(j != stock[i].length - 1 && stock[i][j + 1] != null && stock[i][j].c == stock[i][j + 1].c)
            adjMatrix[index][index + 1] = 1 ;
          if(j != 0 && stock[i][j - 1] != null && stock[i][j].c == stock[i][j - 1].c)
            adjMatrix[index][index - 1] = 1 ;
          if(i != stock.length - 1 && stock[i + 1][j] != null && stock[i][j].c == stock[i + 1][j].c)
            adjMatrix[index][index + 6] = 1 ;
          if(i != 0 && stock[i - 1][j] != null && stock[i][j].c == stock[i - 1][j].c)
            adjMatrix[index][index - 6] = 1 ;
        }
      }
    }
    return new Graph(adjMatrix) ;
  }

  ArrayList<Puyopuyo> findChains(){
    ArrayList<Puyopuyo> chains = new ArrayList<Puyopuyo>() ;
    Graph graph = makeGraph() ;
    ArrayList<NodeSet> chainsNode = graph.findConnectedComponents() ;
    for(NodeSet nodes: chainsNode){
      if(nodes == null) continue ;
      Puyopuyo chainBlock = new Puyopuyo() ;
      for(Node node: nodes){
        chainBlock.add(stock[node.index / 6][node.index % 6]) ;
      }
      chains.add(chainBlock) ;
    }
    return chains ;
  }
}
