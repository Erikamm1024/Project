class Graph{
  NodeSet nodes ;
  EdgeSet edges ;
  Graph(int[][] adjMatrix){
    nodes = new NodeSet(adjMatrix.length) ;
    edges = new EdgeSet(adjMatrix, nodes) ;
    for(Edge e: edges){
      if(e.minus != null && e.plus != null) setOutgoing() ;
    }
  }

  void setOutgoing(){
    for(Edge e: edges){
      Node u = e.minus ;
      Node v = e.plus ;
      u.setOutgoing(v) ;
      v.setOutgoing(u) ;
    }
  }

  ArrayList<NodeSet> findConnectedComponents(){
    ArrayList<NodeSet> chains = new ArrayList<NodeSet> () ;
    for(Node v: nodes) v.mark = false ;
    for(Node node: nodes){
      if(!node.mark) chains.add(DFS(node)) ;
    }
    return chains ;
  }

  NodeSet DFS(Node node){
    Node u = node ;
    u.mark = true ;
    NodeSet connectedComponent = new NodeSet() ;
    NodeSet stack = new NodeSet() ;
    connectedComponent.add(u) ;
    stack.add(u) ;
    while(!stack.isEmpty()){
      u = stack.get(stack.size() - 1) ;
      stack.remove(u) ;
      for(Node v: u.outgoing){
        if(v.mark) continue ;
        v.mark = true ;
        connectedComponent.add(v) ;
        stack.add(v) ;
      }
    }
    if(connectedComponent.size() < 4) return null ;
    else return connectedComponent ;
  }
}
