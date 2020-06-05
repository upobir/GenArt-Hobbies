import java.util.*;

int gridSz = 13;
Cell grid[][];
ArrayList<Arc> tour;

// 0 - up, 1 - right, 2 - down, 3 - left
void setup(){
    size(620, 620);
    colorMode(HSB);
    
    grid = new Cell[gridSz][gridSz];
    float side = width/gridSz;
    for(int i = 0; i<gridSz; i++)
        for(int j = 0; j<gridSz; j++){
            float cx = map(j+0.5, 0, gridSz, 0, width);
            float cy = map(i+0.5, 0, gridSz, 0, height);
            grid[i][j] = new Cell(cx, cy, side);
        }
        
    //setting right left adjacents
    for(int i = 0; i<gridSz; i++)
        for(int j = 0; j<gridSz-1; j++){
            grid[i][j].adjCells[1] = grid[i][j+1];
            grid[i][j+1].adjCells[3] = grid[i][j];
        }
        
    //setting top bottom adjacents
    for(int j = 0; j<gridSz; j++)
        for(int i = 0; i<gridSz-1; i++){
            grid[i][j].adjCells[2] = grid[i+1][j];
            grid[i+1][j].adjCells[0] = grid[i][j];
        }
        
    for(int i = 0; i<gridSz; i++)
        for(int j = 0; j<gridSz; j++){
            grid[i][j].setNodesAndArcs();
        }
        
    tour = new ArrayList<Arc>();
    Node startNode = grid[gridSz/2][gridSz/2].nodes[0];
    eulerTour(startNode);
    
    frameRate(75);
    
}

void draw(){
    background(0);
    boolean lastDone = true;
    for(int i = 0; i<tour.size(); i++){
        Arc arc = tour.get(i);
        lastDone = arc.animateDraw(lastDone);
    }
    
}
    
    
void eulerTour(Node node){
    Stack<Node> stack = new Stack<Node>();
    stack.push(node);
    while(!stack.empty()){
        node = stack.peek();
        for(Arc arc : node.edges){
            if(arc.visited)
                continue;
            arc.drawForward = (arc.v == node);
            arc.visited = true;
            stack.push((arc.u == node)? arc.v : arc.u);
            break;
        }
        if(stack.peek() == node){
            stack.pop();
            if(stack.empty()) continue;
            for(Arc arc : node.edges){
                if(arc.isUnordered(node, stack.peek())){
                    tour.add(arc);
                    break;
                }
            }
        }
    }
    
    
}
