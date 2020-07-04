class ChaosGame{
    int vertices;
    float cx, cy;
    PVector[] points;
    PVector lastPoint;
    int lastVertice;
    float ratio;
    float R;
    color[] colors;
    
    ChaosGame(int vertices, float cx, float cy, float R){
        this.vertices = vertices;
        this.cx = cx;
        this.cy = cy;
        this.R = R;
        points = new PVector[vertices];
        colors = new color[vertices];
        colorMode(HSB, 360, 100, 100);
        
        for(int i = 0; i<vertices; i++){
            float angle = i*TWO_PI/vertices - PI/2.0;
            points[i] = PVector.fromAngle(angle);
            points[i].mult(R);
            colors[i] = color(i*360.0/vertices, 80, 50);
        }
        ratio = 0.5;
    }
    
    void update(){
        if(lastPoint == null){
            lastPoint = new PVector(0.0, 0.0);
            lastVertice = -1;
            return;
        }
        
        int nextVertice;
        do{
            nextVertice = (int) random(vertices);
        }while(!okay(nextVertice));
        
        PVector v1 = PVector.mult(lastPoint, ratio);
        PVector v2 = PVector.mult(points[nextVertice], 1.0-ratio);
        lastPoint = PVector.add(v1, v2);
        lastVertice = nextVertice;
    }
    
    boolean okay(int nextVertice){
        if(lastVertice == -1) return true;
        
        for(int i = 0; i<=vertices/2; i++){
            if(nextVertice == (lastVertice + i) % vertices) return false;
        }
        
        return true;
    }
    
    void draw(){
        pushMatrix();
        translate(cx, cy);
        
        PVector tmp = lastPoint.copy();
        tmp.rotate(-TWO_PI/vertices/2.0);
        
        int c = 0;
        float best = 1000.0;
        for(int i = 0; i<vertices; i++){
            float angle = PVector.angleBetween(tmp, points[i]);
            if(angle < best){
                best = angle;
                c = i;
            }
        }
        
        stroke(colors[c]);
        strokeWeight(2);
        point(lastPoint.x, lastPoint.y);
        
        popMatrix();
    }
}
