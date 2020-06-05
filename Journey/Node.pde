class Node{
    float x, y;
    ArrayList<Arc> edges;
    Node(float x, float y){
        this.x = x;
        this.y = y;
        edges = new ArrayList<Arc>();
    }
    
    void addArc(Arc arc){
        int index = (int) random(edges.size()+1);
        edges.add(index, arc);
    }
}
