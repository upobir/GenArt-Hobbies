class Cell{
    float centerX, centerY;
    float side;
    Cell adjCells[];
    Node nodes[];
    color col;
    
    Cell(float centerX, float centerY, float side){
        this.centerX = centerX;
        this.centerY = centerY;
        this.side = side;
        adjCells = new Cell[4];
        nodes = new Node[4];
        col = color(random(255), 196, 140); 
    }
    
    void setNodesAndArcs(){
        for(int dir = 0, dx = 0, dy = -1; dir < 4; dir++, dy = -dy, dx ^= dy, dy ^= dx, dx ^= dy){
            if(nodes[dir] != null) continue;
            nodes[dir] = new Node(centerX+dx*side/2, centerY+dy*side/2);
            if(adjCells[dir] != null){
                adjCells[dir].nodes[dir^2] = nodes[dir];
            }
        }
        
        for(int dir = 0; dir<4; dir++){
            Node u = nodes[dir];
            Node v = nodes[(dir+1)%4];
            Arc arc = new Arc(u, v, this, (dir-1)*HALF_PI);
            u.addArc(arc);
            v.addArc(arc);
        }
    }
}
