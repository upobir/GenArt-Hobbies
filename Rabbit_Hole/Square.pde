class Square{
    Square parent;
    PVector points[] = new PVector[]{new PVector(0, 0), new PVector(width-1, 0), new PVector(width-1, height-1), new PVector(0, height-1)};
    color c;
    
    Square(Square parent){
        this.parent = parent;
        c = color(random(255), 180, 180);
    }
    
    Square(Square parent, color c){
        this.parent = parent;
        this.c = c;
    }
    
    void update(float ratio){
        if(parent == null) return;
        for(int i = 0; i<4; i++){
            int j = (i+1)%4;
            points[i] = PVector.add(PVector.mult(parent.points[i], ratio), PVector.mult(parent.points[j], 1.0-ratio));
        }
    }
    
    void draw(){
        fill(c);
        beginShape();
        for(int i = 0; i<4; i++)
            vertex(points[i].x, points[i].y);
        endShape(CLOSE);
    }
}
